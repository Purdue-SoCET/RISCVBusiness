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
*   Filename:     rv32v_mem_coalescer_if.vh
*
*   Created by:   Maxwell Michalec
*   Email:        michalem@purdue.edu
*   Date Created: 01/30/2024
*   Description:  Interface for memory access serializer
*/

`ifndef RV32V_MEM_SERIALIZER_IF_VH
`define RV32V_MEM_SERIALIZER_IF_VH

interface rv32v_mem_serializer_if;

    import rv32i_types_pkg::*;
    import rv32v_types_pkg::*;

    // Global latch signals
    // logic vmemop;
    logic vmemdwen, vmemdren;
    logic [4:0] vuop_num;
    logic vindexed;
    word_t base, stride;
    vsew_t veew;

    // Per-lane latch signals
    logic [NUM_LANES-1:0] vlane_mask;  // 1 -> unmasked, 0 -> masked
    word_t [NUM_LANES-1:0] vlane_addr;
    word_t [NUM_LANES-1:0] vlane_store_data;

    // LSC control signals
    logic vmemdwen_lsc, vmemdren_lsc;
    word_t vaddr_lsc, vdata_store_lsc;
    word_t [NUM_LANES-1:0] vaddr_wide_lsc;
    logic vcurr_lane;
    logic [NUM_LANES-1:0] ven_lanes;
    load_t vload_type;
    logic lsc_ready;

    // segmented load/store signals 
    logic strided; 
    logic unit_strided; 
    logic vnew_seg; 
    logic vseg_op; 

    modport serial (
        input vmemdwen, vmemdren, vuop_num, vindexed, base, stride, veew, vlane_mask, vlane_addr, vlane_store_data, lsc_ready,
              strided, unit_strided, vnew_seg, vseg_op,
        output vmemdwen_lsc, vmemdren_lsc, vaddr_lsc, vaddr_wide_lsc, vdata_store_lsc, vcurr_lane, ven_lanes, vload_type
    );

endinterface

`endif //RV32V_MEM_SERIALIZER_IF_VH
