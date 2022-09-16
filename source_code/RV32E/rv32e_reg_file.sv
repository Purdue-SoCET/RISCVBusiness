/*
*   Copyright 2021 Purdue University
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
*   Filename:     rv32e_reg_file.sv
*
*   Created by:   Jiahao Xu
*   Email:        xu1392@purdue.edu
*   Date Created: 2/26/2021
*   Description:  Implenmentation of RV32E register file.
*/
`include "rv32i_reg_file_if.vh"

module rv32e_reg_file (
    input CLK,
    nRST,
    rv32i_reg_file_if rf_if
);
    import rv32i_types_pkg::*;
    localparam NUM_REGS = 16;

    // input:
    // rf_if.wen:    write enable.
    // rf_if.w_data [31:0]: the word to write.
    // rf_if.rd  [4:0]: the register that need to write.
    // rf_if.rs1 [4:0]: the address of read reg 1.
    // rf_if.rs2 [4:0]: the address of read reg 2.
    // output
    // rf_if.rs1_data [31:0]: the read data of rs1
    // rf_if.rs2_data [31:0]: the read data of rs2


    word_t [NUM_REGS-1 : 0] registers;

    always_ff @(posedge CLK, negedge nRST) begin : RV32E_REG_FILE_FF
        if (~nRST) begin
            registers <= '0;
        end  // check if the rd is valid.
        else if (rf_if.wen && (|rf_if.rd) && ~rf_if.rd[4]) begin
            // if (WEN && rd!=0 && rd<16) write.
            registers[rf_if.rd] <= rf_if.w_data;
        end else begin
            // else keep the current register file unchanged.
            registers <= registers;
        end
    end
    // dispose the MSB of the select line since this register file
    // has only 16 registers.
    // the select line should be in [0,15]
    // if invalid rs, return 0.
    assign rf_if.rs1_data = rf_if.rs1[4] ? 0 : registers[rf_if.rs1];
    assign rf_if.rs2_data = rf_if.rs2[4] ? 0 : registers[rf_if.rs2];
endmodule
