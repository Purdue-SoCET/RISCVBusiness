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
*   Filename:     load_store_controller_if.vh
*
*   Created by:   Maxwell Michalec
*   Email:        michalem@purdue.edu
*   Date Created: 11/02/2023
*   Description:  Interface for Load-Store Controller
*/

`ifndef LOAD_STORE_CONTROLLER_IF
`define LOAD_STORE_CONTROLLER_IF

interface load_store_controller_if;

    import rv32i_types_pkg::*;
    import stage3_types_pkg::ex_mem_t;

    localparam QUEUE_LEN = 4;

    ex_mem_t current_instr;
    logic queue_full, mal_addr;
    logic [4:0] [QUEUE_LEN-1:0] queue_rd_m;
    word_t dload_ext;
    logic ifence_reg, iflushed, dflushed;
    // from hazard unit
    logic ex_mem_stall, suppress_data;
    // from ex_mem latch
    ex_mem_t ex_mem_reg;

    modport lsc (
        input  ex_mem_stall, suppress_data, ex_mem_reg,
        output current_instr, queue_full, mal_addr, queue_rd_m, dload_ext, ifence_reg, iflushed, dflushed
    );

endinterface

`endif
