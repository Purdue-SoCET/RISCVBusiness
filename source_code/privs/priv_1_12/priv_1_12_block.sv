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
*   Filename:     priv_1_12_block.sv
*
*   Created by:   Hadi Ahmed
*   Email:        ahmed138@purdue.edu
*   Date Created: 03/27/2022
*   Description:  Top level block for the privileged unit, v1.12
*/

`include "prv_pipeline_if.vh"
`include "priv_1_12_internal_if.vh"
`include "core_interrupt_if.vh"

module priv_1_12_block (
    input logic CLK, nRST,
    prv_pipeline_if.priv_block prv_pipe_if,
    core_interrupt_if.core interrupt_if
);

    import machine_mode_types_1_12_pkg::*;

    priv_1_12_internal_if prv_intern_if();

    priv_1_12_csr csr (.CLK(CLK), .nRST(nRST), .prv_intern_if(prv_intern_if));

    priv_level_t curr_priv;

    assign prv_intern_if.curr_priv = M_MODE; // TODO make this changeable
    assign prv_intern_if.inst_ret = prv_pipe_if.wb_enable & prv_pipe_if.instr;
    assign prv_intern_if.csr_addr = prv_pipe_if.maddr;
    assign prv_intern_if.csr_write = prv_pipe_if.swap;
    assign prv_intern_if.csr_clear = prv_pipe_if.clr;
    assign prv_intern_if.csr_set = prv_pipe_if.set;
    assign prv_intern_if.new_csr_val = prv_pipe_if.wdata;
    assign prv_pipe_if.rdata = prv_intern_if.old_csr_val;
    assign prv_pipe_if.invalid_csr = prv_intern_if.invalid_csr;

endmodule
