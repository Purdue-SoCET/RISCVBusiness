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
*   Filename:     rv32m_pkg.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 02/07/2017
*   Description:  Types for the Bitmanipulation standard extension
*/

`ifndef RV32B_PKG_SV
`define RV32B_PKG_SV

package rv32b_pkg;

    parameter int OP_W = 7;
    parameter MAJOR_OP_1 = 7'b011_0011;
    parameter MAJOR_OP_2 = 7'b011_1011;
    parameter MAJOR_OP_3 = 7'b001_0011;
    parameter MAJOR_OP_4 = 7'b001_1011;
    
    
    typedef struct packed {
        logic [6:0] opcode_minor;
        logic [4:0] rs2;
        logic [4:0] rs1;
        logic [2:0] funct;
        logic [4:0] rd;
        logic [6:0] opcode_major;
    } rv32b_insn_t;

    /*
    // Equivalent to ALUOP for integer, decode operation locally to the FU
    // This should be direct-cast of the funct3 field of insn
    typedef enum logic [2:0] {
        MUL     = 3'b000,
        MULH    = 3'b001,
        MULHSU  = 3'b010,
        MULHU   = 3'b011,
        DIV     = 3'b100,
        DIVU    = 3'b101,
        REM     = 3'b110,
        REMU    = 3'b111
    } rv32m_op_t;
    

    // RV32B decoder: output
    typedef struct packed {
        logic select;
        rv32m_op_t op;
    } rv32m_decode_t;
    */

endpackage

`endif  //RV32B_PKG_SV
