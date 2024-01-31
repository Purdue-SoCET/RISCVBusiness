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
*   Filename:     src/rv32i_reg_file.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 06/14/2016
*   Description:   Integer Register File.  Register 0 will always output 0.
*/

`include "rv32i_reg_file_if.vh"

module rv32i_reg_file (
    input CLK,
    nRST,
    rv32i_reg_file_if.rf rf_if
);
    import rv32i_types_pkg::*;

    localparam int NUM_REGS = 32;
    parameter logic [31:0] NUM_HARTS = 1;

    word_t [NUM_HARTS - 1 : 0][NUM_REGS-1:0] registers; // updated to generate n registers per register (ex: 2 harts means 2 register 1's)

    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) begin
            registers <= '0;
        end else if (rf_if.wen[rfif.hart_id] && rf_if.rd[rfif.hart_id]) begin
            registers[rfif.hart_id][rf_if.rd] <= rf_if.w_data[rfif.hart_id];
        end
    end

    assign rf_if.rs1_data[rfif.hart_id] = registers[rfif.hart_id][rf_if.rs1];
endmodule
