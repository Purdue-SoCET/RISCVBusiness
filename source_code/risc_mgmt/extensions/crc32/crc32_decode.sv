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
*   Filename:     crc32_decode.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 02/07/2017
*   Description:  Decode stage for the crc32 ISA extension.
*/

`include "risc_mgmt_decode_if.vh"

module crc32_decode (
    input logic CLK,
    nRST,
    //risc mgmt connection
    risc_mgmt_decode_if.ext dif,
    //stage to stage connection
    output crc32_pkg::decode_execute_t idex
);

    import rv32i_types_pkg::*;

    parameter OPCODE = 7'b000_1011;

    rtype_t insn_rtype;
    logic [9:0] funct10;

    // prevent this extension from accessing core
    assign dif.insn_claim = (dif.insn[6:0] == OPCODE);
    assign dif.mem_to_reg = 1'b0;

    // Decoding rtype
    assign insn_rtype     = rtype_t'(dif.insn);
    assign funct10        = {insn_rtype.funct7, insn_rtype.funct3};

    // Assigning RMGMT-Decode IF
    assign dif.rsel_s_0   = insn_rtype.rs1;
    assign dif.rsel_s_1   = insn_rtype.rs2;
    assign dif.rsel_d     = insn_rtype.rd;

    // Assigning CRC Decode-Execute IF
    assign idex.reset     = (funct10 == 10'h0) && dif.insn_claim;
    assign idex.new_byte  = (funct10 == 10'h1) && dif.insn_claim;

endmodule
