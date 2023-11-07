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
*   Filename:     load_store_controller.sv
*
*   Created by:   Maxwell Michalec
*   Email:        michalem@purdue.edu
*   Date Created: 11/02/2023
*   Description:  Load-Store Controller with Queue
*/

module load_store_controller
(
    input logic CLK,
    input logic nRST,
    load_store_controller_if.lsc lsc_if,
    generic_bus_if.cpu dgen_bus_if,
    cache_control_if.pipeline cc_if
);

    import rv32i_types_pkg::*;
    import pma_types_1_12_pkg::*;
    import stage3_types_pkg::ex_mem_t;

    localparam QUEUE_LEN = 4;

    ex_mem_t [QUEUE_LEN-1:0] ld_st_queue;
    ex_mem_t current_instr;
    logic [$clog2(QUEUE_LEN):0] queue_count;

    word_t store_swapped;
    word_t dload_ext;
    logic mal_addr;
    logic [1:0] byte_offset;
    logic [3:0] byte_en, byte_en_temp, byte_en_standard;

    // fix this block
    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) begin
            ld_st_queue <= {QUEUE_LEN{ex_mem_t'('0)}};
            queue_count <= '0;
        end else if (~lsc_if.ex_mem_stall) begin
            if (lsc_if.ex_mem_reg.dren || lsc_if.ex_mem_reg.dwen) begin
                ld_st_queue[queue_count] <= lsc_if.ex_mem_reg;
                queue_count <= (~dgen_bus_if.busy) ? queue_count : queue_count + 1;
            end else begin
                ld_st_queue[queue_count] <= ex_mem_t'('0);
                queue_count <= (queue_count != 0) ? queue_count - 1 : '0;
            end
        end
    end

    assign current_instr = (queue_count == 0) ? lsc_if.ex_mem_reg : ld_st_queue[0];
    assign lsc_if.queue_full = (queue_count == QUEUE_LEN);
    assign lsc_if.queue_rd_m = (queue_count == 0) ? {5'b0, 5'b0, 5'b0, current_instr.rd_m}
                                                  : {ld_st_queue[3].rd_m, ld_st_queue[2].rd_m, ld_st_queue[1].rd_m, ld_st_queue[0].rd_m};

    // TODO: RISC-MGMT
    assign dgen_bus_if.ren = current_instr.dren && !lsc_if.suppress_data;
    assign dgen_bus_if.wen = current_instr.dwen && !lsc_if.suppress_data;
    assign dgen_bus_if.byte_en = byte_en;
    assign dgen_bus_if.addr = current_instr.port_out;
    assign byte_offset = current_instr.port_out[1:0];

    // TODO: RISC-MGMT
    assign byte_en_temp = byte_en_standard;

    // Address alignment
    always_comb begin
        if (byte_en == 4'hf) mal_addr = (dgen_bus_if.addr[1:0] != 2'b00);
        else if (byte_en == 4'h3 || byte_en == 4'hc) begin
            mal_addr = (dgen_bus_if.addr[1:0] == 2'b01 || dgen_bus_if.addr[1:0] == 2'b11);
        end else mal_addr = 1'b0;
    end

    endian_swapper store_swap(
        .word_in(current_instr.rs2_data),
        .word_out(store_swapped)
    );

    dmem_extender dmem_ext(
        .dmem_in(dgen_bus_if.rdata),
        .load_type(current_instr.load_type),
        .byte_en(byte_en),
        .ext_out(dload_ext)
    );

    always_comb begin : LOAD_TYPE
        case (current_instr.load_type)
            LB, LBU: begin
                case (byte_offset)
                    2'b00:   byte_en_standard = 4'b0001;
                    2'b01:   byte_en_standard = 4'b0010;
                    2'b10:   byte_en_standard = 4'b0100;
                    2'b11:   byte_en_standard = 4'b1000;
                    default: byte_en_standard = 4'b0000;
                endcase
            end

            LH, LHU: begin
                case (byte_offset)
                    2'b00:   byte_en_standard = 4'b0011;
                    2'b10:   byte_en_standard = 4'b1100;
                    default: byte_en_standard = 4'b0000;
                endcase
            end

            LW: begin
                byte_en_standard = 4'b1111;
            end

            default: byte_en_standard = 4'b0000;
        endcase
    end : LOAD_TYPE

    // TODO: RISC-MGMT
    always_comb begin : STORE_TYPE
        case(current_instr.load_type)
            LB: dgen_bus_if.wdata = {4{current_instr.rs2_data[7:0]}};
            LH: dgen_bus_if.wdata = {2{current_instr.rs2_data[15:0]}};
            LW: dgen_bus_if.wdata = current_instr.rs2_data;
            default: dgen_bus_if.wdata = '0;
        endcase
    end : STORE_TYPE

    // Endianness
    generate
        if(BUS_ENDIANNESS == "big") begin : g_data_bus_be
            assign byte_en = byte_en_temp;
        end else if(BUS_ENDIANNESS == "little") begin : g_data_bus_le
            assign byte_en = current_instr.dren ? byte_en_temp
                                                    : {byte_en_temp[0], byte_en_temp[1],
                                                       byte_en_temp[2], byte_en_temp[3]};
        end
    endgenerate


    /******************
    * Cache management
    *******************/
    logic ifence_pulse;
    logic iflushed_next;
    logic dflushed_next;
    logic iflush_done_reg, dflush_done_reg;

    always_ff @(posedge CLK, negedge nRST) begin
        if(!nRST) begin
            lsc_if.ifence_reg <= 1'b0;
            lsc_if.iflushed <= 1'b1;
            lsc_if.dflushed <= 1'b1;
        end else begin
            lsc_if.ifence_reg <= current_instr.ifence;
            lsc_if.iflushed <= iflushed_next;
            lsc_if.dflushed <= dflushed_next;
        end
    end

    assign ifence_pulse  = current_instr.ifence & ~lsc_if.ifence_reg;
    assign cc_if.icache_flush = ifence_pulse;
    assign cc_if.dcache_flush = ifence_pulse;
    // holds iflushed/dflushed high when done, resets to 0 on a pulse
    always_comb begin
        iflushed_next = lsc_if.iflushed;
        dflushed_next = lsc_if.dflushed;
        if (ifence_pulse) begin
            iflushed_next = 0;
            dflushed_next = 0;
        end
        if (cc_if.iflush_done)
            iflushed_next = 1;
        if (cc_if.dflush_done)
            dflushed_next = 1;
    end

endmodule
