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
`include "priv_ext_if.vh"

module priv_1_12_block (
    input logic CLK, nRST,
    input logic [63:0] mtime,
    prv_pipeline_if.priv_block prv_pipe_if,
    core_interrupt_if.core interrupt_if
);

    import machine_mode_types_1_12_pkg::*;

    priv_1_12_internal_if prv_intern_if();
    priv_ext_if priv_ext_pma_if();
    priv_ext_if priv_ext_pmp_if();
    `ifdef RV32V_SUPPORTED
        priv_ext_if priv_ext_v_if();
    `endif // RV32V_SUPPORTED

    priv_1_12_csr csr (.CLK(CLK), .nRST(nRST), .mtime(mtime), .prv_intern_if(prv_intern_if), .priv_ext_pma_if(priv_ext_pma_if), .priv_ext_pmp_if(priv_ext_pmp_if)
                        `ifdef RV32V_SUPPORTED
                        , .priv_ext_v_if(priv_ext_v_if)
                        `endif // RV32V_SUPPORTED
                      );
    priv_1_12_int_ex_handler int_ex_handler (.CLK(CLK), .nRST(nRST), .prv_intern_if(prv_intern_if));
    priv_1_12_pipe_control pipe_ctrl (.prv_intern_if(prv_intern_if));
    priv_1_12_pma pma (.CLK(CLK), .nRST(nRST), .prv_intern_if(prv_intern_if), .priv_ext_if(priv_ext_pma_if));
    priv_1_12_pmp pmp (.CLK(CLK), .nRST(nRST), .prv_intern_if(prv_intern_if), .priv_ext_if(priv_ext_pmp_if));
    priv_1_12_mode mode (.CLK(CLK), .nRST(nRST), .prv_intern_if(prv_intern_if));
    `ifdef RV32V_SUPPORTED
      priv_1_12_vector vector (.CLK(CLK), .nRST(nRST), .prv_intern_if(prv_intern_if), .priv_ext_if(priv_ext_v_if));
    `endif // RV32V_SUPPORTED

    // Assign CSR values
    assign prv_intern_if.inst_ret = prv_pipe_if.wb_enable & prv_pipe_if.instr;
    assign prv_intern_if.csr_addr = prv_pipe_if.csr_addr;
    assign prv_intern_if.csr_write = prv_pipe_if.swap;
    assign prv_intern_if.csr_clear = prv_pipe_if.clr;
    assign prv_intern_if.csr_set = prv_pipe_if.set;
    assign prv_intern_if.csr_read_only = prv_pipe_if.read_only;
    assign prv_intern_if.new_csr_val = prv_pipe_if.wdata;
    assign prv_pipe_if.rdata = prv_intern_if.old_csr_val;
    assign prv_pipe_if.invalid_priv_isn = prv_intern_if.invalid_csr | (prv_pipe_if.ret & (prv_intern_if.curr_privilege_level != M_MODE)) 
                                            | (prv_pipe_if.wfi & (prv_intern_if.curr_privilege_level == U_MODE) & (prv_intern_if.curr_mstatus.tw));

    // Disable interrupts that will not be used
    assign prv_intern_if.timer_int_u = 1'b0;
    assign prv_intern_if.timer_int_s = 1'b0;
    assign prv_intern_if.timer_int_m = interrupt_if.timer_int;
    assign prv_intern_if.soft_int_u = 1'b0;
    assign prv_intern_if.soft_int_s = 1'b0;
    assign prv_intern_if.soft_int_m = interrupt_if.soft_int;
    assign prv_intern_if.ext_int_u = 1'b0;
    assign prv_intern_if.ext_int_s = 1'b0;
    assign prv_intern_if.ext_int_m = interrupt_if.ext_int;

    // Disable clear interrupts that will not be used
    assign prv_intern_if.clear_timer_int_u = 1'b0;
    assign prv_intern_if.clear_timer_int_s = 1'b0;
    assign prv_intern_if.clear_timer_int_m = interrupt_if.timer_int_clear;
    assign prv_intern_if.clear_soft_int_u = 1'b0;
    assign prv_intern_if.clear_soft_int_s = 1'b0;
    assign prv_intern_if.clear_soft_int_m = interrupt_if.soft_int_clear;
    assign prv_intern_if.clear_ext_int_u = 1'b0;
    assign prv_intern_if.clear_ext_int_s = 1'b0;
    assign prv_intern_if.clear_ext_int_m = interrupt_if.ext_int_clear;

    // from pipeline to the priv unit
    assign prv_intern_if.pipe_clear        = prv_pipe_if.pipe_clear;
    assign prv_intern_if.epc               = prv_pipe_if.epc;
    assign prv_intern_if.fault_insn_access = prv_pipe_if.fault_insn;
    assign prv_intern_if.mal_insn          = prv_pipe_if.mal_insn;
    assign prv_intern_if.illegal_insn      = prv_pipe_if.illegal_insn;
    assign prv_intern_if.fault_l           = prv_pipe_if.fault_l;
    assign prv_intern_if.mal_l             = prv_pipe_if.mal_l;
    assign prv_intern_if.fault_s           = prv_pipe_if.fault_s;
    assign prv_intern_if.mal_s             = prv_pipe_if.mal_s;
    assign prv_intern_if.breakpoint        = prv_pipe_if.breakpoint;
    assign prv_intern_if.env_m             = prv_pipe_if.env && (prv_intern_if.curr_privilege_level == M_MODE);
    assign prv_intern_if.env_s             = 1'b0;
    assign prv_intern_if.env_u             = prv_pipe_if.env && (prv_intern_if.curr_privilege_level == U_MODE);
    assign prv_intern_if.fault_insn_page   = 1'b0;
    assign prv_intern_if.fault_load_page   = 1'b0;
    assign prv_intern_if.fault_store_page  = 1'b0;
    assign prv_intern_if.curr_mtval        = prv_pipe_if.badaddr;
    assign prv_intern_if.valid_write       = prv_pipe_if.valid_write;
    assign prv_intern_if.mret              = prv_pipe_if.ret & (prv_intern_if.curr_privilege_level == M_MODE);
    assign prv_intern_if.sret              = 1'b0;
    `ifdef RV32V_SUPPORTED
        assign prv_intern_if.vsetvl = prv_pipe_if.vsetvl;
        assign prv_pipe_if.vl = prv_intern_if.vl;
        assign prv_pipe_if.vtype = prv_intern_if.vtype;
        assign prv_pipe_if.vstart = prv_intern_if.vstart;
    `endif // RV32V_SUPPORTED

    // RISC-MGMT?
    //  not sure what these are for, part of priv 1.11
    assign prv_intern_if.ex_rmgmt = prv_pipe_if.ex_rmgmt;
    assign prv_intern_if.ex_rmgmt_cause = prv_pipe_if.ex_rmgmt_cause;

    // from priv unit to pipeline
    assign prv_pipe_if.priv_pc     = prv_intern_if.priv_pc;
    assign prv_pipe_if.insert_pc   = prv_intern_if.insert_pc;
    assign prv_pipe_if.intr        = prv_intern_if.intr;

    // Memory protection signals
    assign prv_intern_if.daddr = prv_pipe_if.daddr;
    assign prv_intern_if.iaddr = prv_pipe_if.iaddr;
    assign prv_intern_if.d_acc_width = prv_pipe_if.d_acc_width;
    assign prv_intern_if.i_acc_width = prv_pipe_if.i_acc_width;
    assign prv_intern_if.ren = prv_pipe_if.dren;
    assign prv_intern_if.wen = prv_pipe_if.dwen;
    assign prv_intern_if.xen = prv_pipe_if.iren;
    assign prv_pipe_if.prot_fault_i = prv_intern_if.pma_i_fault | prv_intern_if.pmp_i_fault;
    assign prv_pipe_if.prot_fault_l = prv_intern_if.pma_l_fault | prv_intern_if.pmp_l_fault;
    assign prv_pipe_if.prot_fault_s = prv_intern_if.pma_s_fault | prv_intern_if.pmp_s_fault;

endmodule
