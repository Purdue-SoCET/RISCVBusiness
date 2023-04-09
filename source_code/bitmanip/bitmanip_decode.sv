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
*   Filename:     bitmanip_decode.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 02/07/2017
*   Description:  Decoding for bitmanipulation extension
*/
module bitmanip_decode (
    input [31:0] insn,
    output logic claim,
    //output rv32m_pkg::rv32m_decode_t rv32m_control
);

    import bitmanip_pkg::*;

    bitmanip_insn_t insn_split;
    
    assign insn_split = bitmanip_insn_t'(insn);
    /*
    assign claim = (insn_split.opcode_major == RV32M_OPCODE)
                    && (insn_split.opcode_minor == RV32M_OPCODE_MINOR);
    */
    assign claim = valid_major_op_1 || valid_major_op_2 || valid_major_op_3 || valid_major_op_4;
    //assign rv32m_control.select = claim;
    //assign rv32m_control.op = rv32m_op_t'(insn_split.funct);

    ///////////////////////////////////////////////////
    // Decoding valid MAJOR_OP_1 type of instructions
    ///////////////////////////////////////////////////
    always_comb begin//{
    case ({insn_split.opcode_minor,insn_split.opcode_major})
    {7'b001_0000,MAJOR_OP_1} : valid_major_op_1 = 1'b1;
    {7'b010_0000,MAJOR_OP_1} : valid_major_op_1 = 1'b1;
    {7'b000_0101,MAJOR_OP_1} : valid_major_op_1 = 1'b1;
    {7'b011_0000,MAJOR_OP_1} : valid_major_op_1 = 1'b1;
    {7'b000_0100,MAJOR_OP_1} : valid_major_op_1 = 1'b1;
    {7'b011_0100,MAJOR_OP_1} : valid_major_op_1 = 1'b1;
    {7'b001_0100,MAJOR_OP_1} : valid_major_op_1 = 1'b1;
    {7'b010_0100,MAJOR_OP_1} : valid_major_op_1 = 1'b1;
    default                  : valid_major_op_1 = 1'b0;
    endcase
    end //}
    
    ///////////////////////////////////////////////////
    // Decoding valid MAJOR_OP_2 type of instructions
    ///////////////////////////////////////////////////
    always_comb begin//{
    case ({insn_split.opcode_minor,insn_split.opcode_major})
    {7'b000_0100,MAJOR_OP_2} : valid_major_op_2 = 1'b1;
    {7'b001_0000,MAJOR_OP_2} : valid_major_op_2 = 1'b1;
    {7'b011_0000,MAJOR_OP_2} : valid_major_op_2 = 1'b1;
    default                  : valid_major_op_2 = 1'b0;
    endcase
    end //}

    ///////////////////////////////////////////////////
    // Decoding valid MAJOR_OP_3 type of instructions
    ///////////////////////////////////////////////////
    always_comb begin//{
    case ({insn_split.opcode_minor,insn_split.opcode_major})
    {7'b011_0000,MAJOR_OP_3} : valid_major_op_3 = 1'b1;
    {7'b001_0100,MAJOR_OP_3} : valid_major_op_3 = 1'b1;
    {7'b011_0100,MAJOR_OP_3} : valid_major_op_3 = 1'b1;
    {7'b011_0101,MAJOR_OP_3} : valid_major_op_3 = 1'b1;
    {7'b010_0100,MAJOR_OP_3} : valid_major_op_3 = 1'b1;
    default                  : valid_major_op_3 = 1'b0;
    endcase
    end //}

    ///////////////////////////////////////////////////
    // Decoding valid MAJOR_OP_4 type of instructions
    ///////////////////////////////////////////////////
    always_comb begin//{
    case ({insn_split.opcode_minor,insn_split.opcode_major})
    {7'b011_0000,MAJOR_OP_4} : valid_major_op_4 = 1'b1;
    {7'b001_0100,MAJOR_OP_4} : valid_major_op_4 = 1'b1;
    {7'b011_0100,MAJOR_OP_4} : valid_major_op_4 = 1'b1;
    {7'b011_0101,MAJOR_OP_4} : valid_major_op_4 = 1'b1;
    {7'b010_0100,MAJOR_OP_4} : valid_major_op_4 = 1'b1;
    default                  : valid_major_op_4 = 1'b0;
    endcase
    end //}
    
    assign valid_major_op_4 = (insn_split.opcode_major==MAJOR_OP_4) && (insn_split.opcode_minor[6:1]==6'b000010||insn_split.opcode_minor==7'b011_0000);

endmodule
