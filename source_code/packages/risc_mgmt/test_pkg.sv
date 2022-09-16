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
*   Filename:     template_pkg.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 02/07/2017
*   Description:  ISA extension used for the RISC-MGMT testbench
*/

`ifndef TEST_PKG_SV
`define TEST_PKG_SV

package test_pkg;

    // Interface between the decode and execute stage
    // This must be named "decode_execute_t"
    typedef struct packed {
        logic rtype;
        logic rtype_stall;
        logic br_j;
        logic mem_lw;
        logic mem_sw;
        logic exception;
        logic nop;
        logic [8:0] imm;
    } decode_execute_t;

    // Interface between the execute and memory stage
    // This must be named "execute_memory_t"
    typedef struct packed {
        logic mem_lw;
        logic mem_sw;
        logic nop;
        logic exception;
        logic [31:0] mem_addr;
        logic [31:0] mem_store;
    } execute_memory_t;

    typedef enum logic [3:0] {
        RTYPE,
        RTYPE_STALL_5,
        BR_J,
        MEM_LOAD,
        MEM_STORE,
        EXCEPTION,
        NOP
    } test_funct_t;

    typedef struct packed {
        logic [5:0]  imm;
        test_funct_t funct;
        logic [4:0]  rs_d;
        logic [4:0]  rs_0;
        logic [4:0]  rs_1;
        logic [6:0]  opcode;
    } test_insn_t;

endpackage

`endif  //TEST_PKG_SV
