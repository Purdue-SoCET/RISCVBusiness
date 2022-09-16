/*
*   Copyright 2016 Purdue University
*
*   Licensed under the Apache License, Version 2.0 (the "License");
*   you may not use this file except in compliance with the License.
*   You may obtain a copy of the License at
*
*       http://www.apache.org/licenses/LICENSE-2.0
*
*   Unless required by applicable law or agreed to in writing, software
*   distributed under the License is distributed on an "AS IS" BASIS,
*   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*   See the License for the specific language governing permissions and
*   limitations under the License.
*
*
*   Filename:     ram_sim_model.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 04/27/2017
*   Description:  SRAM model.  This is NOT SYNTHESIZABLE but allows this
*                 project to run independent of tools in simulation.
*/

module ram_sim_model #(
    parameter LAT = 0,  // ram latency
    parameter ENDIANNESS = "little",
    parameter N_BYTES = 4,
    parameter DEPTH = 8192,
    parameter MEM_INIT_FILE = "meminit.hex",
    parameter MEM_DEFAULT = 32'h0000_0000,
    parameter ADDR_BITS = $clog2(DEPTH),
    parameter COUNT_BITS = $clog2(LAT) + 1,
    parameter N_BITS = N_BYTES * 8
) (
    input logic CLK,
    nRST,
    input logic [N_BITS-1:0] wdata_in,
    input logic [ADDR_BITS-1:0] addr_in,
    input logic [N_BYTES-1:0] byte_en_in,
    input logic wen_in,
    ren_in,
    output logic [N_BITS-1:0] rdata_out,
    output logic busy_out
);


    // Memory as associative array to try and save space at runtime
    logic [N_BITS-1:0] memory [*];

    // Variables for file IO
    integer fptr;
    logic [ADDR_BITS-1:0] faddr;
    logic [7:0] line_type;
    logic [31:0] fdata;
    logic [1:0] t0, t1;

    // RAM signals
    logic [COUNT_BITS-1:0] counter;
    logic [ADDR_BITS-1:0] addr, addr_r, addr_ram;
    logic ren, ren_r, ren_ram;
    logic wen, wen_r, wen_ram;
    logic [N_BYTES-1:0] byte_en;
    logic [N_BITS-1:0] rdata, wdata, wdata_r, wdata_ram, mask;
    logic input_diff;
    logic access;
    string line;
    int res;

    genvar i;

    // Load in meminit
    initial begin
        if (MEM_INIT_FILE != "") begin
            fptr = $fopen(MEM_INIT_FILE, "r");
            if (!fptr) begin
                $info("Warning: Couldn't open memory init file %s", MEM_INIT_FILE);
            end else begin
                while (!$feof(
                    fptr
                )) begin
                    res = $fgets(line, fptr);
                    res = $sscanf(line, ":%2h%4h%2h%8h%2h", t0, faddr, line_type, fdata, t1);
                    if (line_type == 8'h00) begin  //data
                        memory[faddr] = fdata;
                        //$info("Loading %0h into addr %0h", fdata, faddr);
                    end
                end
                $fclose(fptr);
            end
        end
    end

    /*
  *
  * Begin steady state ram functionality
  *
  */

    // Changes for bus endianness
    generate
        if (ENDIANNESS == "big") begin
            // swap endianness
            endian_swapper #(
                .N_BYTES(N_BYTES)
            ) write_swap (
                .word_in (wdata_in),
                .word_out(wdata)
            );
            endian_swapper #(
                .N_BYTES(N_BYTES)
            ) read_swap (
                .word_in (rdata),
                .word_out(rdata_out)
            );

            // swap byte enables
            for (i = 0; i < N_BYTES / 2; i++) begin
                assign byte_en[N_BYTES-1-i] = byte_en_in[i];
                assign byte_en[i]           = byte_en_in[N_BYTES-1-i];
            end
            if (N_BYTES % 2) assign byte_en[N_BYTES/2] = byte_en_in[N_BYTES/2];

        end else if (ENDIANNESS == "little") begin
            assign wdata = wdata_in;
            assign byte_en = byte_en_in;
            assign rdata_out = rdata;
        end
    endgenerate

    generate
        for (i = 0; i < N_BYTES; i++) assign mask[i*8+:8] = {8{byte_en[i]}};
    endgenerate

    always begin
        @(posedge CLK);
        if (access && wen_ram) begin
            if (memory.exists(addr_ram))
                memory[addr_ram] = (wdata_ram & mask) | (memory[addr_ram] & ~mask);
            else memory[addr_ram] = wdata_ram & mask;
        end
    end

    assign addr = addr_in[ADDR_BITS-1:0];
    assign ren  = ren_in;
    assign wen  = wen_in;

    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) begin
            addr_r  <= '0;
            ren_r   <= '0;
            wen_r   <= '0;
            wdata_r <= '0;
        end else begin
            addr_r  <= addr;
            ren_r   <= ren;
            wen_r   <= wen;
            wdata_r <= wdata;
        end
    end

    assign input_diff = (addr_r !== addr) || (ren_r !== ren) ||
                      (wen_r !== wen) || (wdata_r !== wdata);

    // mux inputs to ram
    assign addr_ram = input_diff ? addr : addr_r;
    assign ren_ram = input_diff ? ren : ren_r;
    assign wen_ram = input_diff ? wen : wen_r;
    assign wdata_ram = input_diff ? wdata : wdata_r;

    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) counter <= '0;
        else if (input_diff) counter <= '0;
        if (counter != LAT) counter <= counter + 1;
    end

    assign access = (counter == LAT) && !input_diff;

    assign rdata = (^addr_ram !== 1'bx) && memory.exists(addr_ram) ? memory[addr_ram] : MEM_DEFAULT;
    assign busy_out = ~access;

endmodule
