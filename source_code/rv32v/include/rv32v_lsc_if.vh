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
    word_t addr, store_data, dload_ext;
    // logic [3:0] byte_en;
    load_t load_type;
    logic ifence, fence_stall;

    modport lsc (
        input wen, ren, addr, store_data, load_type, ifence,
        output dload_ext, fence_stall
    );

endinterface

`endif //RV32V_LSC_IF
