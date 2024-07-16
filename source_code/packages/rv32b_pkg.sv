/*
*   Copyright 2024 Purdue University
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
*   Created by:   Cole Nelson 
*   Email:        nelso345@purdue.edu
*   Date Created: 04/04/2024
*   Description:  Types for the Bitmanipulation standard extension
*/

package rv32b_pkg;


    typedef struct packed {
        logic [6:0] opcode_minor;
        logic [4:0] rs2;
        logic [4:0] rs1;
        logic [2:0] funct;
        logic [4:0] rd;
        logic [6:0] opcode_major;
    } rv32b_insn_t;

    typedef enum logic [4:0] {
        // Zba
        SH1ADD,
        SH2ADD,
        SH3ADD,
        // Zbb
        ANDN,
        ORN,
        XNOR,
        CLZ,
        CTZ,
        CPOP,
        MAX,
        MAXU,
        MIN,
        MINU,
        SEXTB,
        SEXTH,
        ZEXTH,
        ROL,
        ROR,
        ORC,
        REV8,
        // Zbs
        BCLR,
        BEXT,
        BINV,
        BSET
    } rv32b_op_t /*verilator public*/;

    typedef struct packed {
        logic select;
        rv32b_op_t op;
    } rv32b_decode_t;


endpackage
