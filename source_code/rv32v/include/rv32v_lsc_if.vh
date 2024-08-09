/*
*   Copyright 2023 Purdue University
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
*   Filename:     rv32v_lsc_if.vh
*
*   Created by:   Maxwell Michalec
*   Email:        michalem@purdue.edu
*   Date Created: 01/30/2024
*   Description:  Interface for load-store controller for RV32V core
*/

`ifndef RV32V_LSC_IF
`define RV32V_LSC_IF

interface rv32v_lsc_if;

    import rv32i_types_pkg::*;
    import rv32v_types_pkg::*;

    // Mux scalar vs vector before load-store controller
    logic wen, ren;
    logic [NUM_LANES-1:0] ven_lanes;

    word_t addr, store_data, dload_ext;
    word_t [NUM_LANES-1:0] addr_wide, dload_ext_wide;
    word_t [DCACHE_BLOCK_SIZE-1:0] store_data_wide;
    logic [((DCACHE_BLOCK_SIZE*WORD_SIZE)-1):0] store_en_wide;

    load_t load_type;
    logic ifence, fence_stall, mal_addr, wide_vstore;
    logic reserve, exclusive;
    logic lsc_ready;

    modport lsc (
        input wen, ren, addr, addr_wide, store_data, store_data_wide, store_en_wide, wide_vstore, load_type, ifence, ven_lanes, reserve, exclusive,
        output dload_ext, dload_ext_wide, fence_stall, mal_addr, lsc_ready
    );

endinterface

`endif //RV32V_LSC_IF
