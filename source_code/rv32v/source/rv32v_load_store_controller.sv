/*
*   Copyright 2023 Purdue University
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
*   Filename:     rv32v_load_store_controller.sv
*
*   Created by:   Maxwell Michalec
*   Email:        michalem@purdue.edu
*   Date Created: 01/30/2024
*   Description:  Load-store controller for RV32V core
*/

`include "rv32v_types_pkg.vh"
`include "rv32v_lsc_if.vh"
`include "generic_bus_if.vh"
`include "cache_control_if.vh"

module rv32v_load_store_controller (
    input logic CLK,
    input logic nRST,
    rv32v_lsc_if.lsc lsc_if,
    generic_bus_if.cpu dgen_bus_if,
    cache_control_if.pipeline cc_if
);

    import rv32i_types_pkg::*;

    word_t store_swapped;
    word_t dload_ext;
    logic mal_addr;
    logic [1:0] byte_offset;
    logic [3:0] byte_en, byte_en_temp, byte_en_standard;

    assign dgen_bus_if.ren = lsc_if.ren;
    assign dgen_bus_if.wen = lsc_if.wen;
    // assign dgen_bus_if.byte_en = lsc_if.byte_en;
    assign dgen_bus_if.byte_en = byte_en;
    assign dgen_bus_if.addr = lsc_if.addr;
    assign byte_offset = lsc_if.addr[1:0];
    assign lsc_if.dload_ext = dload_ext;
    assign lsc_if.lsc_ready = ~dgen_bus_if.busy;

    assign byte_en_temp = byte_en_standard;

    // Address alignment
    always_comb begin
        if (byte_en == 4'hf) mal_addr = (dgen_bus_if.addr[1:0] != 2'b00);
        else if (byte_en == 4'h3 || byte_en == 4'hc) begin
            mal_addr = (dgen_bus_if.addr[1:0] == 2'b01 || dgen_bus_if.addr[1:0] == 2'b11);
        end else mal_addr = 1'b0;
    end

    endian_swapper store_swap (
        .word_in(lsc_if.store_data),
        .word_out(store_swapped)
    );

    dmem_extender dmem_ext (
        .dmem_in(dgen_bus_if.rdata),
        .load_type(lsc_if.load_type),
        .byte_en(byte_en),
        .ext_out(dload_ext)
    );

    always_comb begin : LOAD_TYPE
        case (lsc_if.load_type)
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

    always_comb begin : STORE_TYPE
        case (lsc_if.load_type)
            LB: dgen_bus_if.wdata = {4{lsc_if.store_data[7:0]}};
            LH: dgen_bus_if.wdata = {2{lsc_if.store_data[15:0]}};
            LW: dgen_bus_if.wdata = lsc_if.store_data;
            default: dgen_bus_if.wdata = '0;
        endcase
    end : STORE_TYPE

    // Endianness
    generate
        if(BUS_ENDIANNESS == "big") begin : g_data_bus_be
            assign byte_en = byte_en_temp;
        end else if(BUS_ENDIANNESS == "little") begin : g_data_bus_le
            assign byte_en = lsc_if.ren ? byte_en_temp
                                        : {byte_en_temp[0], byte_en_temp[1],
                                           byte_en_temp[2], byte_en_temp[3]};
        end
    endgenerate

    /******************
    * Cache management
    *******************/
    logic ifence_reg;
    logic ifence_pulse;
    logic iflushed, iflushed_next;
    logic dflushed, dflushed_next;
    logic iflush_done_reg, dflush_done_reg;

    always_ff @(posedge CLK, negedge nRST) begin
        if(!nRST) begin
            ifence_reg <= 1'b0;
            iflushed <= 1'b1;
            dflushed <= 1'b1;
        end else begin
            ifence_reg <= lsc_if.ifence;
            iflushed <= iflushed_next;
            dflushed <= dflushed_next;
        end
    end

    assign ifence_pulse  = lsc_if.ifence & ~ifence_reg;
    assign cc_if.icache_flush = ifence_pulse;
    assign cc_if.dcache_flush = ifence_pulse;
    // holds iflushed/dflushed high when done, resets to 0 on a pulse
    always_comb begin
        iflushed_next = iflushed;
        dflushed_next = dflushed;
        if (ifence_pulse) begin
            iflushed_next = 0;
            dflushed_next = 0;
        end
        if (cc_if.iflush_done)
            iflushed_next = 1;
        if (cc_if.dflush_done)
            dflushed_next = 1;
    end

    assign lsc_if.fence_stall = ifence_reg && !(iflushed && dflushed);

endmodule // rv32v_load_store_controller
