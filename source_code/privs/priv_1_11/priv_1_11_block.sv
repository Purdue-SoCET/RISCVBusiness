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
*   Filename:     priv_1_11_block.sv
*
*   Created by:   Jacob R. Stevens
*   Email:        steven69@purdue.edu
*   Date Created: 08/13/2019
*   Description:  Top level block for the priv logic version 1.11
*/

`include "prv_pipeline_if.vh"
`include "priv_1_11_internal_if.vh"
`include "core_interrupt_if.vh"

module priv_1_11_block (
    input logic CLK,
    nRST,
    prv_pipeline_if.priv_block prv_pipe_if,
    core_interrupt_if.core interrupt_if
    /*input logic plic_ext_int,
  input logic clint_soft_int,
  input logic clint_clear_soft_int,
  input logic clint_timer_int,
  input logic clint_clear_timer_int*/
);
    import machine_mode_types_1_11_pkg::*;

    priv_1_11_internal_if prv_intern_if ();


    priv_1_11_csr_rfile csr_rfile_i (
        .*,
        .prv_intern_if(prv_intern_if)
    );
    priv_1_11_control prv_control_i (
        .*,
        .prv_intern_if(prv_intern_if)
    );
    priv_1_11_pipeline_control pipeline_control_i (
        .*,
        .prv_intern_if(prv_intern_if)
    );

    // Disable interrupts that will not be used
    assign prv_intern_if.timer_int_u       = 1'b0;
    assign prv_intern_if.timer_int_s       = 1'b0;
    assign prv_intern_if.timer_int_m       = interrupt_if.timer_int;
    assign prv_intern_if.soft_int_u        = 1'b0;
    assign prv_intern_if.soft_int_s        = 1'b0;
    assign prv_intern_if.soft_int_m        = interrupt_if.soft_int;
    assign prv_intern_if.ext_int_u         = 1'b0;
    assign prv_intern_if.ext_int_s         = 1'b0;
    assign prv_intern_if.ext_int_m         = interrupt_if.ext_int;
    assign prv_intern_if.reserved_0        = 1'b0;
    assign prv_intern_if.reserved_1        = 1'b0;
    assign prv_intern_if.reserved_2        = 1'b0;

    // Disable clear interrupts that will not be used
    assign prv_intern_if.clear_timer_int_u = 1'b0;
    assign prv_intern_if.clear_timer_int_s = 1'b0;
    assign prv_intern_if.clear_timer_int_m = interrupt_if.timer_int_clear;
    assign prv_intern_if.clear_soft_int_u  = 1'b0;
    assign prv_intern_if.clear_soft_int_s  = 1'b0;
    assign prv_intern_if.clear_soft_int_m  = interrupt_if.soft_int_clear;
    assign prv_intern_if.clear_ext_int_u   = 1'b0;
    assign prv_intern_if.clear_ext_int_s   = 1'b0;
    assign prv_intern_if.clear_ext_int_m   = interrupt_if.ext_int_clear;


    // from pipeline to the priv unit
    assign prv_intern_if.pipe_clear        = prv_pipe_if.pipe_clear;
    assign prv_intern_if.mret              = prv_pipe_if.ret;
    assign prv_intern_if.epc               = prv_pipe_if.epc;
    assign prv_intern_if.fault_insn_access = prv_pipe_if.fault_insn;
    assign prv_intern_if.mal_insn          = prv_pipe_if.mal_insn;
    assign prv_intern_if.illegal_insn      = prv_pipe_if.illegal_insn;
    assign prv_intern_if.fault_l           = prv_pipe_if.fault_l;
    assign prv_intern_if.mal_l             = prv_pipe_if.mal_l;
    assign prv_intern_if.fault_s           = prv_pipe_if.fault_s;
    assign prv_intern_if.mal_s             = prv_pipe_if.mal_s;
    assign prv_intern_if.breakpoint        = prv_pipe_if.breakpoint;
    assign prv_intern_if.env_m             = prv_pipe_if.env_m;
    assign prv_intern_if.env_s             = 1'b0;
    assign prv_intern_if.env_u             = 1'b0;
    assign prv_intern_if.fault_insn_page   = 1'b0;
    assign prv_intern_if.fault_load_page   = 1'b0;
    assign prv_intern_if.fault_store_page  = 1'b0;
    assign prv_intern_if.mtval             = prv_pipe_if.badaddr;
    assign prv_intern_if.swap              = prv_pipe_if.swap;
    assign prv_intern_if.clr               = prv_pipe_if.clr;
    assign prv_intern_if.set               = prv_pipe_if.set;
    assign prv_intern_if.wdata             = prv_pipe_if.wdata;
    assign prv_intern_if.addr              = prv_pipe_if.addr;
    assign prv_intern_if.valid_write       = prv_pipe_if.valid_write;
    assign prv_intern_if.instr_retired     = prv_pipe_if.wb_enable & prv_pipe_if.instr;

    assign prv_intern_if.ex_rmgmt          = prv_pipe_if.ex_rmgmt;
    assign prv_intern_if.ex_rmgmt_cause    = prv_pipe_if.ex_rmgmt_cause;

    // from priv unit to pipeline
    assign prv_pipe_if.priv_pc             = prv_intern_if.priv_pc;
    assign prv_pipe_if.insert_pc           = prv_intern_if.insert_pc;
    assign prv_pipe_if.intr                = prv_intern_if.intr;
    assign prv_pipe_if.rdata               = prv_intern_if.rdata;
    assign prv_pipe_if.invalid_csr         = prv_intern_if.invalid_csr;

endmodule
