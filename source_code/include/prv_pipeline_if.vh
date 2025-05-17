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
*   Filename:     prv_pipeline_if.vh
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 08/24/2016
*   Description:  Interface connecting the priv block to the pipeline.
*/

`ifndef PRV_PIPELINE_IF_VH
`define PRV_PIPELINE_IF_VH

`include "component_selection_defines.vh"

interface prv_pipeline_if();
  import machine_mode_types_1_13_pkg::*;
  import rv32i_types_pkg::*;
  import pma_types_1_13_pkg::*;

  // exception signals
  logic fault_insn, mal_insn, illegal_insn, fault_l, mal_l, fault_s, mal_s,
        breakpoint, env, fault_insn_page, fault_load_page, fault_store_page, mret, sret, wfi;

  // tlb miss signals
  logic itlb_miss, dtlb_miss;

  // from ex_mem reg to tlb, will cause comb loop if this value is not used
  logic ex_mem_ren, ex_mem_wen;

  // interrupt signals
  logic timer_int, soft_int, ext_int;

  // exception / interrupt control
  word_t epc, priv_pc, badaddr;
  logic insert_pc, intr, pipe_clear;
  word_t [3:0] xtvec, xepc_r;

  // csr rw
  logic       swap, clr, set, read_only;
  logic       invalid_priv_isn, valid_write;
  csr_addr_t  csr_addr;
  word_t      rdata, wdata;

  // tlb signals
  // go directly to iTLB, go to ex stage into pipeline for dTLB
  satp_t satp;
  mstatus_t mstatus;
  priv_level_t curr_privilege_level;
  word_t fence_va;
  logic [ASID_LENGTH-1:0] fence_asid;

  // performance signals
  logic wb_enable, instr;
  logic icache_miss, dcache_miss;

  // RISC-MGMT
  logic ex_rmgmt;
  logic [$clog2(`NUM_EXTENSIONS)-1:0] ex_rmgmt_cause;

  // Memory protection signals
  logic iren, dwen, dren;
  logic [RAM_ADDR_SIZE-1:0] iaddr, daddr, ipaddr, dpaddr;
  pma_accwidth_t d_acc_width, i_acc_width;
  logic prot_fault_s, prot_fault_l, prot_fault_i;
  logic ex_mem_stall;

  modport hazard (
    input priv_pc, insert_pc, intr, prot_fault_s, prot_fault_l, prot_fault_i,
    output pipe_clear, mret, sret, epc, fault_insn, mal_insn,
            illegal_insn, fault_l, mal_l, fault_s, mal_s,
            breakpoint, env, fault_insn_page, fault_load_page, fault_store_page,
            wfi, badaddr, wb_enable, ex_rmgmt, ex_rmgmt_cause, ex_mem_stall
  );

  modport pipe (
    output swap, clr, set, read_only, wdata, csr_addr, valid_write, instr, dren, dwen, daddr, d_acc_width, fence_va, fence_asid, ex_mem_ren, ex_mem_wen,
    input  rdata, invalid_priv_isn, fault_insn_page, fault_load_page, fault_store_page, dtlb_miss, mstatus, curr_privilege_level
  );

  modport fetch (
    input prot_fault_i, itlb_miss,
    output iren, iaddr, i_acc_width
  );

  modport cache (
    input satp, mstatus, curr_privilege_level, fence_va, fence_asid, ex_mem_ren, ex_mem_wen,
    output fault_insn_page, fault_load_page, fault_store_page, itlb_miss, dtlb_miss, ipaddr, dpaddr
  );

  modport priv_block (
    input pipe_clear, mret, sret, epc, fault_insn, mal_insn,
          illegal_insn, fault_l, mal_l, fault_s, mal_s,
          breakpoint, env, fault_insn_page, fault_load_page, fault_store_page,
          badaddr, swap, clr, set, read_only, wfi,
          wdata, csr_addr, valid_write, wb_enable, instr,
          icache_miss, dcache_miss,
          ex_rmgmt, ex_rmgmt_cause,
          daddr, iaddr, ipaddr, dpaddr, dren, dwen, iren,
          d_acc_width, i_acc_width, ex_mem_stall,
    output priv_pc, insert_pc, intr, rdata, invalid_priv_isn,
            prot_fault_s, prot_fault_l, prot_fault_i,
            satp, mstatus, curr_privilege_level
  );

endinterface

`endif //PRV_PIPELINE_IF_VH
