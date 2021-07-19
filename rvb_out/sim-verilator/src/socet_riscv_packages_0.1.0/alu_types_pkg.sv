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
*   Filename:     alu_types_pkg.sv
*
*   Created by:   Jacob R. Stevens
*   Email:        steven69@purdue.edu
*   Date Created: 06/01/2016
*   Description:  Package containing types used in the alu
*/
`ifndef ALU_TYPES_PKG_SV
`define ALU_TYPES_PKG_SV

package alu_types_pkg;

    typedef enum logic [3:0] {
        ALU_SLL  = 4'b0000,
        ALU_SRL  = 4'b0001,
        ALU_SRA  = 4'b0010,
        ALU_ADD  = 4'b0011,
        ALU_SUB  = 4'b0100,
        ALU_AND  = 4'b0101,
        ALU_OR   = 4'b0110,
        ALU_XOR  = 4'b0111,
        ALU_SLT  = 4'b1000,
        ALU_SLTU = 4'b1001
    } aluop_t;

endpackage
`endif
