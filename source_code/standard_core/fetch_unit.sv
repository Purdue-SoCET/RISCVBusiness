/*
*   Copyright 2025 Purdue University
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
*   Filename:     fetch_unit.sv
*
*   Created by:   Cole Nelson
*   Email:        jskubic@purdue.edu
*   Date Created: 10/10/2025
*   Description:  Fetches instructions & reports errors
*/
`include "component_selection_defines.vh"

module fetch_unit #(
    parameter int RVC_ENABLED = 0
)(
    input CLK,
    input nRST,
    input ireq,
    input pc_redirect,
    input [31:0] pc,
    output logic insn_ready,
    output logic insn_compressed,
    output logic insn_fault,
    output logic mal_addr,
    output logic [31:0] insn_out,
    output logic [31:0] insn_addr,
    generic_bus_if.cpu igen_bus_if
);

    generate
        if(RVC_ENABLED) begin : g_rvc_fetchbuffer
            fetch_buffer FB(
                .CLK,
                .nRST,
                .ren(ireq),
                .invalidate(pc_redirect),
                .pc(pc),
                .insn_valid(insn_ready),
                .insn_compressed,
                .insn_out(insn_out),
                .icache(igen_bus_if)
            );

            assign insn_addr = igen_bus_if.addr;
            assign mal_addr = 1'b0;
            assign insn_addr = igen_bus_if.addr;
        end else begin
            assign igen_bus_if.ren = ireq;
            assign igen_bus_if.byte_en = 4'hF;
            assign igen_bus_if.wen = 1'b0;
            assign igen_bus_if.wdata = '0;
            assign igen_bus_if.addr = pc;
            assign insn_ready = ireq && !igen_bus_if.busy;
            assign insn_out = igen_bus_if.rdata;
            assign insn_addr = igen_bus_if.addr;
            assign mal_addr = igen_bus_if.addr[1:0] != 2'b00;
            assign insn_compressed = 1'b0;
        end
    endgenerate

endmodule
