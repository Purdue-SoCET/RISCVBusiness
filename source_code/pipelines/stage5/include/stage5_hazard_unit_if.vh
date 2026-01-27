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
*   Filename:     stage5_hazard_unit_if.vh
*
*   Created by:   William Cunningham
*   Email:        wrcunnin@purdue.edu
*   Date Created: 01/26/2026
*   Description:  Interface for the hazard unit of the Five Stage Pipeline
*/

`ifndef STAGE5_HAZARD_UNIT_IF_VH
`define STAGE5_HAZARD_UNIT_IF_VH

interface stage5_hazard_unit_if();

  import rv32i_types_pkg::word_t;

  // Pipeline status signals (inputs)
  logic [4:0] rs1_d, rs2_d, rs1_e, rs2_e, rd_e, rd_m;
  logic cannot_forward_e, cannot_forward_m;
  logic reg_write_m, csr_read;
  logic i_mem_busy, d_mem_busy, dren, dwen, reserve, mret, sret, suppress_data;
  logic jump, branch, fence_stall;
  logic update_predictor, mispredict, halt;
  word_t pc_f, pc_d, pc_e, pc_m;
  logic valid_d, valid_e, valid_m, valid_w; // f always valid since it's the PC
  logic ifence, sfence;
  logic ex_busy;

  // Control (outputs)
  logic pc_en, npc_sel;
  logic if_dc_flush, dc_ex_flush, ex_mem_flush;
  logic if_dc_stall, dc_ex_stall, ex_mem_stall;
  logic iren, suppress_iren;
  logic rollback; // signal for rolling back fetched instructions after instruction in mem stage, for certain CSR and ifence instructions
  logic mem_use_stall;

  // xTVEC Insertion
  word_t priv_pc;
  logic insert_priv_pc;

  //Pipeline Exceptions (inputs)
  logic fault_insn, mal_insn, illegal_insn, fault_l, mal_l, fault_s, mal_s,
        breakpoint, env, wfi, fault_load_page, fault_store_page, fault_insn_page;
  word_t fault_addr, fault_addr_fetch;

  // Pipeline Tokens
  logic token_ex;
  logic token_mem;

  modport hazard_unit (
    input   rs1_d, rs2_d, rs1_e, rs2_e, rd_e, rd_m,
            cannot_forward_e, cannot_forward_m,
            reg_write_m, csr_read,
            i_mem_busy, d_mem_busy, dren, dwen, reserve, mret, sret,
            jump, branch, fence_stall, update_predictor, mispredict, halt, pc_f, pc_e, pc_m,
            fault_insn, mal_insn, illegal_insn, fault_l, mal_l, fault_s, mal_s, breakpoint, env, wfi,
            fault_addr, ifence, sfence, fault_load_page, fault_store_page, fault_insn_page,
            token_ex, token_mem,
            valid_e, valid_m, ex_busy,
    output  pc_en, npc_sel,
            if_dc_flush, dc_ex_flush, ex_mem_flush,
            if_dc_stall, dc_ex_stall, ex_mem_stall,
            priv_pc, insert_priv_pc, iren, suppress_iren, suppress_data, rollback,
            mem_use_stall
  );

  modport fetch (
    input   pc_en, npc_sel, if_dc_stall, if_dc_flush, priv_pc, insert_priv_pc, iren, suppress_iren, rollback,
    output  i_mem_busy, pc_f, fault_addr_fetch
  );

  modport decode (
    input dc_ex_stall, dc_ex_flush, mem_use_stall,
    output rs1_d, rs2_d, pc_d, valid_d
  );

  modport execute (
    input  ex_mem_stall, ex_mem_flush, npc_sel,
    output token_ex, rs1_e, rs2_e, rd_e, pc_e, valid_e, ex_busy, cannot_forward_e
  );

  modport mem (
    input   ex_mem_stall, ex_mem_flush, suppress_data, fault_addr_fetch,
    output  rd_m, reg_write_m, csr_read,
            d_mem_busy, dren, dwen, reserve, mret, sret,
            jump, branch, fence_stall, update_predictor, mispredict, halt, pc_m, valid_m,
            fault_insn, mal_insn, illegal_insn, fault_l, mal_l, fault_s, mal_s, breakpoint, env,
            fault_addr, ifence, sfence, wfi, fault_load_page, fault_store_page, fault_insn_page,
            token_mem, cannot_forward_m
  );

endinterface

`endif
