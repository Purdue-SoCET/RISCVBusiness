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
*   Description:  Types for the RV32M standard extension
*/

`ifndef RV32M_PKG_SV
`define RV32M_PKG_SV

package rv32m_pkg;

    localparam logic [6:0] RV32M_OPCODE = 7'b0110011;
    localparam logic [6:0] RV32M_OPCODE_MINOR = 7'b0000001;

    typedef struct packed {
        logic [6:0] opcode_minor;
        logic [4:0] rs2;
        logic [4:0] rs1;
        logic [2:0] funct;
        logic [4:0] rd;
        logic [6:0] opcode_major;
    } rv32m_insn_t;

    // Interface between the decode and execute stage
    // This must be named "decode_execute_t"
    typedef struct packed {
        logic mul;
        logic div;
        logic rem;
        logic usign_usign;
        logic sign_sign;
        logic sign_usign;
        logic lower_word;
        logic start;
    } decode_execute_t;

    // Interface between the execute and memory stage
    // This must be named "execute_memory_t"
    typedef struct packed {logic signal;} execute_memory_t;



endpackage

`endif  //RV32M_PKG_SV
