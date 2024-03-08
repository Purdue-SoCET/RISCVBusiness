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
*   Filename:     stage4_mem_stage_if.vh
*
*   Created by:   Maxwell Michalec
*   Email:        michalem@purdue.edu
*   Date Created: 01/30/2024
*   Description:  Interface for memory stage for rv32v pipeline
*/

`ifndef STAGE4_MEM_STAGE_IF
`define STAGE4_MEM_STAGE_IF

interface stage4_mem_stage_if;

    import rv32i_types_pkg::*;
    import rv32v_types_pkg::*;

    word_t pc4; // For flush in case of fence_i, CSR, etc.

    // Scalar
    logic reg_write;
    regsel_t rd_m;
    ex_mem_t ex_mem_reg;
    word_t brj_addr;
    word_t reg_wdata;

    // Vector
    vexmem_t vexmem;
    vwb_t vwb;
    logic[3:0] vmskset_fwd_bits; 

    modport fetch (
        input brj_addr, pc4
    );

    modport ex (
        input reg_wdata, reg_write, rd_m, vwb, vmskset_fwd_bits, 
        output ex_mem_reg, vexmem
    );

    modport mem (
        input ex_mem_reg, vexmem,
        output brj_addr, reg_wdata, reg_write, rd_m, pc4, vwb, vmskset_fwd_bits
    );

endinterface

`endif //STAGE4_MEM_STAGE_IF
