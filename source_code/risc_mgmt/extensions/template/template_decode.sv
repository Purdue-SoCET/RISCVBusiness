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
*   Filename:     template_decode.sv
*
*   Created by:   <author>
*   Email:        <author email>
*   Date Created: <date>
*   Description:  This extension is the Template for creating rytpe custom
*                 instructions.
*/

`include "risc_mgmt_decode_if.vh"

module template_decode (
    input logic CLK,
    nRST,
    //risc mgmt connection
    risc_mgmt_decode_if.ext dif,
    //stage to stage connection
    output template_pkg::decode_execute_t idex
);

    import rv32i_types_pkg::*;

    parameter OPCODE = 7'b000_1011;

    rtype_t insn_rtype;
    logic [9:0] funct10;

    // prevent this extension from accessing core
    assign dif.insn_claim = 1'b0;  // (dif.insn[6:0] == OPCODE);
    assign funct10 = {insn_rtype.funct7, insn_rtype.funct3};
    assign dif.mem_to_reg = 1'b0;

endmodule
