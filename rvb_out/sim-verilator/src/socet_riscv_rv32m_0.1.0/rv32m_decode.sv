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
module rv32m_decode (
    input [31:0] insn,
    output logic claim,
    output rv32m_pkg::rv32m_decode_t rv32m_control
);

    import rv32m_pkg::*;

    rv32m_insn_t insn_split;
    
    assign insn_split = rv32m_insn_t'(insn);
    assign claim = (insn_split.opcode_major == RV32M_OPCODE)
                    && (insn_split.opcode_minor == RV32M_OPCODE_MINOR);

    assign rv32m_control.select = claim;
    assign rv32m_control.op = rv32m_op_t'(insn_split.funct);

endmodule
