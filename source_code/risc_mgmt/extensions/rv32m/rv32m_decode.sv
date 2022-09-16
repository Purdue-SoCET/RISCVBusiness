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
*   Filename:     rv32m_decode.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 02/07/2017
*   Description:  Decoding for standard multiply extension
*/

`include "risc_mgmt_decode_if.vh"

module rv32m_decode (
    input logic CLK,
    nRST,
    //risc mgmt connection
    risc_mgmt_decode_if.ext dif,
    //stage to stage connection
    output rv32m_pkg::decode_execute_t idex
);

    import rv32m_pkg::*;

    parameter OPCODE = RV32M_OPCODE;

    rv32m_insn_t insn;

    assign dif.mem_to_reg = 1'b0;

    assign insn = rv32m_insn_t'(dif.insn);

    assign dif.insn_claim = (insn.opcode_major == OPCODE) && (insn.opcode_minor == RV32M_OPCODE_MINOR);
    assign dif.rsel_s_0 = insn.rs1;
    assign dif.rsel_s_1 = insn.rs2;
    assign dif.rsel_d = insn.rd;

    // decode funct
    assign idex.start = dif.insn_claim;
    assign idex.mul = ~insn.funct[2];
    assign idex.div = insn.funct[2:1] == 2'b10;
    assign idex.rem = insn.funct[2:1] == 2'b11;

    assign idex.usign_usign = (insn.funct == 3'b011) || (insn.funct == 3'b101)
                            || (insn.funct == 3'b111);
    assign idex.sign_sign   = (insn.funct == 3'b001) || (insn.funct == 3'b100)
                            || (insn.funct == 3'b110) || (insn.funct == 3'b000);
    assign idex.sign_usign = insn.funct == 3'b010;

    assign idex.lower_word = ~(|insn.funct[1:0]);  // only valid for mul

endmodule
