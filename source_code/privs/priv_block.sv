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
*   Filename:     priv_block.sv
*
*   Created by:   William Cunningham
*   Email:        wrcunnin@purdue.edu
*   Date Created: 09/26/2024
*   Description:  Top level block for the privileged unit, v1.13
*/

`include "prv_pipeline_if.vh"
`include "priv_internal_if.vh"
`include "core_interrupt_if.vh"
`include "priv_ext_if.vh"

module priv_block #(
    parameter HART_ID
) (
    input logic CLK, nRST,
    input logic [63:0] mtime,
    prv_pipeline_if.priv_block prv_pipe_if,
    core_interrupt_if.core interrupt_if
);

    import priv_isa_types_pkg::*;

    priv_internal_if prv_intern_if();
    priv_ext_if priv_ext_pma_if();
    priv_ext_if priv_ext_pmp_if();

    priv_csr #(.HART_ID(HART_ID)) csr (.CLK(CLK), .nRST(nRST), .mtime(mtime), .prv_intern_if(prv_intern_if), .priv_ext_pma_if(priv_ext_pma_if), .priv_ext_pmp_if(priv_ext_pmp_if));
    priv_int_ex_handler int_ex_handler (.CLK(CLK), .nRST(nRST), .prv_intern_if(prv_intern_if));
    priv_pipe_control pipe_ctrl (.prv_intern_if(prv_intern_if));
    priv_pma pma (.CLK(CLK), .nRST(nRST), .prv_intern_if(prv_intern_if), .priv_ext_if(priv_ext_pma_if));
    priv_pmp pmp (.CLK(CLK), .nRST(nRST), .prv_intern_if(prv_intern_if), .priv_ext_if(priv_ext_pmp_if));
    priv_mode mode (.CLK(CLK), .nRST(nRST), .prv_intern_if(prv_intern_if));

    // assign hpm counter increments (csr mapping: mhpmcounter3..31 / hpmcounter3..31)

    // Cache group: 3-6
    // 3: I$ misses, 4: D$ misses
    assign prv_intern_if.hpm_inc[3]  = prv_pipe_if.icache_miss; // I$ miss
    assign prv_intern_if.hpm_inc[4]  = prv_pipe_if.dcache_miss; // D$ miss

    // 5-6: I$/D$ hits
    assign prv_intern_if.hpm_inc[5]  = prv_pipe_if.icache_hit; // I$ hit
    assign prv_intern_if.hpm_inc[6]  = prv_pipe_if.dcache_hit; // D$ hit

    // 7-8: iTLB/dTLB misses
    assign prv_intern_if.hpm_inc[7]  = prv_pipe_if.itlb_miss; // iTLB miss
    assign prv_intern_if.hpm_inc[8]  = prv_pipe_if.dtlb_miss; // dTLB miss
    
    // 9-10: iTLB/dTLB hits
    assign prv_intern_if.hpm_inc[9]  = 1'b0; // iTLB hit (TODO)
    assign prv_intern_if.hpm_inc[10] = 1'b0; // dTLB hit (TODO)

    // 11-12: page walker: miss/hit/fault, number of page walks
    assign prv_intern_if.hpm_inc[11] = 1'b0; // page walker miss/fault (TODO)
    assign prv_intern_if.hpm_inc[12] = 1'b0; // Page walk count (TODO)

    // 13-15: core stalls (fetch, execute, mem). We only have ex/mem stall exposed; others TODO
    assign prv_intern_if.hpm_inc[13] = 1'b0; // Fetch stall cycles (TODO)
    assign prv_intern_if.hpm_inc[14] = 1'b0; // Execute stall cycles (TODO)
    assign prv_intern_if.hpm_inc[15] = prv_pipe_if.ex_mem_stall; // mem stage stall
    
    // 16-18: D$ snoops: total, hits, misses (TODO)
    assign prv_intern_if.hpm_inc[16] = 1'b0; // D$ snoops (TODO)
    assign prv_intern_if.hpm_inc[17] = 1'b0; // D$ snoop hits (TODO)
    assign prv_intern_if.hpm_inc[18] = 1'b0; // D$ snoop misses (TODO)

    // 19-20: branch: mispredicts and predictions (TODO)
    assign prv_intern_if.hpm_inc[19] = 1'b0; // branch mispredict (TODO)
    assign prv_intern_if.hpm_inc[20] = 1'b0; // branch predictions (TODO)

    // 21-31: currently for future expansion
    assign prv_intern_if.hpm_inc[21] = prv_pipe_if.bus_busy; // bus busy cycles
    assign prv_intern_if.hpm_inc[22] = 1'b0;
    assign prv_intern_if.hpm_inc[23] = 1'b0;
    assign prv_intern_if.hpm_inc[24] = 1'b0;
    assign prv_intern_if.hpm_inc[25] = 1'b0;
    assign prv_intern_if.hpm_inc[26] = 1'b0;
    assign prv_intern_if.hpm_inc[27] = 1'b0;
    assign prv_intern_if.hpm_inc[28] = 1'b0;
    assign prv_intern_if.hpm_inc[29] = 1'b0;
    assign prv_intern_if.hpm_inc[30] = 1'b0;
    assign prv_intern_if.hpm_inc[31] = 1'b0;
    assign prv_intern_if.inst_ret = prv_pipe_if.wb_enable & prv_pipe_if.instr;
    assign prv_intern_if.csr_addr = prv_pipe_if.csr_addr;
    assign prv_intern_if.csr_write = prv_pipe_if.swap;
    assign prv_intern_if.csr_clear = prv_pipe_if.clr;
    assign prv_intern_if.csr_set = prv_pipe_if.set;
    assign prv_intern_if.csr_read_only = prv_pipe_if.read_only;
    assign prv_intern_if.new_csr_val = prv_pipe_if.wdata;
    assign prv_pipe_if.rdata = prv_intern_if.old_csr_val;
    assign prv_pipe_if.invalid_priv_isn = prv_intern_if.invalid_csr | (prv_pipe_if.mret & !prv_intern_if.isMMode) 
                                            | (prv_pipe_if.sret & !prv_intern_if.isMMode & !prv_intern_if.isSMode & (SUPERVISOR == "enabled"))
                                            | (prv_pipe_if.wfi & prv_intern_if.isUMode & (prv_intern_if.curr_mstatus.tw));

    // Disable interrupts that will not be used
    assign prv_intern_if.timer_int_u = 1'b0;
    assign prv_intern_if.timer_int_s = interrupt_if.timer_int[HART_ID] && prv_intern_if.isSMode;
    assign prv_intern_if.timer_int_m = interrupt_if.timer_int[HART_ID] && prv_intern_if.isMMode;
    assign prv_intern_if.soft_int_u = 1'b0;
    assign prv_intern_if.soft_int_s = interrupt_if.soft_int[HART_ID] && prv_intern_if.isSMode;
    assign prv_intern_if.soft_int_m = interrupt_if.soft_int[HART_ID] && prv_intern_if.isMMode;
    assign prv_intern_if.ext_int_u = 1'b0;
    assign prv_intern_if.ext_int_s = interrupt_if.ext_int && prv_intern_if.isSMode;
    assign prv_intern_if.ext_int_m = interrupt_if.ext_int && prv_intern_if.isMMode;

    // Disable clear interrupts that will not be used
    assign prv_intern_if.clear_timer_int_u = 1'b0;
    assign prv_intern_if.clear_timer_int_s = interrupt_if.timer_int_clear[HART_ID] && prv_intern_if.isSMode; // find references, are these needed for s-mode?
    assign prv_intern_if.clear_timer_int_m = interrupt_if.timer_int_clear[HART_ID] && prv_intern_if.isMMode;
    assign prv_intern_if.clear_soft_int_u = 1'b0;
    assign prv_intern_if.clear_soft_int_s = interrupt_if.soft_int_clear[HART_ID] && prv_intern_if.isSMode; // find references, are these needed for s-mode?
    assign prv_intern_if.clear_soft_int_m = interrupt_if.soft_int_clear[HART_ID] && prv_intern_if.isMMode;
    assign prv_intern_if.clear_ext_int_u = 1'b0;
    assign prv_intern_if.clear_ext_int_s = interrupt_if.ext_int_clear && prv_intern_if.isSMode; // find references, are these needed for s-mode?
    assign prv_intern_if.clear_ext_int_m = interrupt_if.ext_int_clear && prv_intern_if.isMMode;

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
    assign prv_intern_if.env_m             = prv_pipe_if.env && prv_intern_if.isMMode;
    assign prv_intern_if.env_s             = prv_pipe_if.env && prv_intern_if.isSMode;
    assign prv_intern_if.env_u             = prv_pipe_if.env && prv_intern_if.isUMode;
    assign prv_intern_if.fault_insn_page   = prv_pipe_if.fault_insn_page;
    assign prv_intern_if.fault_load_page   = prv_pipe_if.fault_load_page;
    assign prv_intern_if.fault_store_page  = prv_pipe_if.fault_store_page;
    assign prv_intern_if.curr_mtval        = prv_pipe_if.badaddr;
    assign prv_intern_if.curr_stval        = prv_pipe_if.badaddr;
    assign prv_intern_if.valid_write       = prv_pipe_if.valid_write;
    assign prv_intern_if.mret              = prv_pipe_if.mret & prv_intern_if.isMMode;
    assign prv_intern_if.sret              = prv_pipe_if.sret & (prv_intern_if.isSMode | prv_intern_if.isMMode) && (SUPERVISOR == "enabled");
    assign prv_intern_if.ex_mem_stall      = prv_pipe_if.ex_mem_stall;

    // from priv unit to pipeline
    assign prv_pipe_if.priv_pc   = prv_intern_if.priv_pc;
    assign prv_pipe_if.insert_pc = prv_intern_if.insert_pc;
    assign prv_pipe_if.intr      = prv_intern_if.intr;
    assign prv_pipe_if.satp      = prv_intern_if.curr_satp;
    assign prv_pipe_if.mstatus   = prv_intern_if.curr_mstatus;
    assign prv_pipe_if.curr_privilege_level = prv_intern_if.curr_privilege_level;

    // Memory protection signals
    assign prv_intern_if.daddr = prv_pipe_if.dpaddr;
    assign prv_intern_if.iaddr = prv_pipe_if.ipaddr;
    assign prv_intern_if.d_acc_width = prv_pipe_if.d_acc_width;
    assign prv_intern_if.i_acc_width = prv_pipe_if.i_acc_width;
    assign prv_intern_if.ren = prv_pipe_if.dren;
    assign prv_intern_if.wen = prv_pipe_if.dwen;
    assign prv_intern_if.xen = prv_pipe_if.iren;
    assign prv_pipe_if.prot_fault_i = prv_intern_if.pma_i_fault | prv_intern_if.pmp_i_fault;
    assign prv_pipe_if.prot_fault_l = prv_intern_if.pma_l_fault | prv_intern_if.pmp_l_fault;
    assign prv_pipe_if.prot_fault_s = prv_intern_if.pma_s_fault | prv_intern_if.pmp_s_fault;

endmodule
