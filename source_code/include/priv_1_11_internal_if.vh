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
*   Filename:     priv_1_11_internal_if.vh
*
*   Created by:   Jacob R. Stevens
*   Email:        steven69@purdue.edu
*   Date Created: 08/13/2019
*   Description:  Interface for components within the privilege block 
*/

`ifndef PRIV_1_11_INTERNAL_IF_VH
`define PRIV_1_11_INTERNAL_IF_VH

`include "component_selection_defines.vh"

interface priv_1_11_internal_if; // also labeled as prv_intern_if in most modules
  import machine_mode_types_1_11_pkg::*;
  import rv32i_types_pkg::*;

  // Machine registers are being ruptured (activated) to denote when to change the value of this register for hardware
  logic mip_rup, mtval_rup, mcause_rup, mepc_rup, mstatus_rup;
  logic intr; // denote whether an exception or interrupt register
  logic pipe_clear; // e_ex_stage is where you check what type of hazard unit instruction you are receiving. Simply, checking whether or not the pipeline is clear of any hazards
  logic mret, sret, uret; //returns after handling a trap instruction


  // sources for interrupts
  logic timer_int_u, timer_int_s, timer_int_m;
  logic soft_int_u, soft_int_s, soft_int_m;
  logic ext_int_u, ext_int_s, ext_int_m;
  logic reserved_0, reserved_1, reserved_2;

  // signals to clear the pending interrupt
  logic clear_timer_int_u, clear_timer_int_s, clear_timer_int_m;
  logic clear_soft_int_u, clear_soft_int_s, clear_soft_int_m;
  logic clear_ext_int_u, clear_ext_int_s, clear_ext_int_m;


  // sources for exceptions
  logic mal_insn, fault_insn_access, illegal_insn, breakpoint, fault_l, mal_l, fault_s, mal_s; 
  logic env_u, env_s, env_m, fault_insn_page, fault_load_page, fault_store_page;

  logic insert_pc; // inform pipeline that the pc will need to be changed. either when an instruction is a ret instruction, or pipeline is clear and a proper instruction
  logic swap, clr, set; // activated for CSR Assembly instructions


  logic valid_write, invalid_csr; // valid write occurs with an r type instruction that does not have any pipeline stalls; invalid_csr
  logic instr_retired; // instruction is done (retired) when there is a write back enable and there is a proper instruction

  // RISC-MGMT 
  logic ex_rmgmt;
  logic [$clog2(`NUM_EXTENSIONS)-1:0] ex_rmgmt_cause;

  word_t epc; // pc of the instruction prior to the exception 
  word_t priv_pc; // pc that would need to be changed for pipeline
  word_t wdata, rdata;
  word_t mtval;

  mip_t       mip, mip_next;
  mtval_t     mtval_next;
  mcause_t    mcause, mcause_next;
  mepc_t      mepc, mepc_next; // holds pc of interrupted instruction
  mstatus_t   mstatus, mstatus_next;

  mtvec_t     mtvec;
  mie_t       mie;

  csr_addr_t addr; // 12-bit address for CSR instructions

  modport csr (
    input mip_rup, mtval_rup, mcause_rup, mepc_rup, mstatus_rup,
      mip_next, mtval_next, mcause_next, mepc_next, mstatus_next,
      swap, clr, set, wdata, addr, valid_write, instr_retired, 
    output mtvec, mepc, mie, mip, mcause, mstatus,
      rdata, invalid_csr
  );

  modport prv_control (
    output mip_rup, mtval_rup, mcause_rup, mepc_rup, mstatus_rup,
      mip_next, mcause_next, mepc_next, mstatus_next, mtval_next, intr, 
    input mepc, mie, mip, mcause, mstatus, clear_timer_int_m, clear_ext_int_m, clear_soft_int_m, 
      clear_timer_int_u, clear_ext_int_u, clear_soft_int_u, clear_timer_int_s, clear_ext_int_s, 
      clear_soft_int_s, pipe_clear, mret, epc, fault_insn_access, mal_insn, illegal_insn, fault_l, 
      mal_l, fault_s, mal_s, breakpoint, env_m, env_s, env_u, fault_insn_page, fault_load_page, 
      fault_store_page, timer_int_u, timer_int_s, timer_int_m, soft_int_u, soft_int_s, soft_int_m, 
      ext_int_u, ext_int_s, ext_int_m, mtval, ex_rmgmt, ex_rmgmt_cause
  );

  modport pipe_ctrl (
    input intr, mret, pipe_clear, mtvec, mcause, mepc,
    output insert_pc, priv_pc
  );

  modport tb (
    output ext_int_m, clear_ext_int_m
  );

endinterface
`endif // PRIV_1_11_INTERNAL_IF_VH
