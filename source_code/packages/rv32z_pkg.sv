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
*   Filename:     rv32z_pkg.sv
*
*   Created by:   Ananya Srivastava
*   Email:        srivas95@purdue.edu
*   Date Created: 04/18/2024
*   Description:  Zibcom extension supporting Flush instruction
*/

package rv32z_pkg;


    typedef struct packed {
        logic [6:0] opcode_minor;
        logic [4:0] rs2;
        logic [2:0] cbo;
        logic [4:0] rs1;
        logic [2:0] funct;
        logic [4:0] rd;
        logic [6:0] opcode_major;
    } rv32z_insn_t;

    typedef enum logic {
        FLUSH = 7'b0001111
    } rv32z_op_t;


    typedef struct packed {
        logic select;
        rv32z_op_t op;
    } rv32z_decode_t;


endpackage
