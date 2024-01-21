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
*   Filename:     stage3_hazard_unit_if.vh
*
*   Created by:   Jacob R. Stevens
*   Email:        steven69@purdue.edu
*   Date Created: 06/15/2016
*   Description:  Interface for the hazard unit of the two stage pipeline
*/

`ifndef STAGE3_HAZARD_UNIT_IF_VH
`define STAGE3_HAZARD_UNIT_IF_VH

interface stage3_hazard_unit_if();

  import rv32i_types_pkg::word_t;

  // Pipeline status signals (inputs)
  logic [4:0] rs1_e, rs2_e, rd_m;
  logic reg_write, csr_read;
  logic i_mem_busy, d_mem_busy, dren, dwen, ret, suppress_data;
  logic jump, branch, fence_stall;
  logic mispredict, halt;
  word_t pc_f, pc_e, pc_m;
  logic valid_e, valid_m; // f always valid since it's the PC
  logic ifence;
  logic ex_busy;

  // Control (outputs)
  logic pc_en, npc_sel;
  logic if_ex_flush, ex_mem_flush;
  logic if_ex_stall, ex_mem_stall;
  logic iren, suppress_iren;
  logic rollback; // signal for rolling back fetched instructions after instruction in mem stage, for certain CSR and ifence instructions

  // xTVEC Insertion
  word_t priv_pc;
  logic insert_priv_pc;

  //Pipeline Exceptions (inputs)
  logic fault_insn, mal_insn, illegal_insn, fault_l, mal_l, fault_s, mal_s,
        breakpoint, env, wfi;
  word_t badaddr;

  // Pipeline Tokens
  logic token_ex;
  logic token_mem;

  // RV32C
  logic rv32c_ready;

  modport hazard_unit (
    input   rs1_e, rs2_e, rd_m,
            reg_write, csr_read,
            i_mem_busy, d_mem_busy, dren, dwen, ret,
            jump, branch, fence_stall, mispredict, halt, pc_f, pc_e, pc_m,
            fault_insn, mal_insn, illegal_insn, fault_l, mal_l, fault_s, mal_s, breakpoint, env, wfi,
            badaddr, ifence,
            token_ex, token_mem, rv32c_ready,
            valid_e, valid_m, ex_busy,
    output  pc_en, npc_sel,
            if_ex_flush, ex_mem_flush,
            if_ex_stall, ex_mem_stall,
            priv_pc, insert_priv_pc, iren, suppress_iren, suppress_data, rollback
  );

  modport fetch (
    input   pc_en, npc_sel, if_ex_stall, if_ex_flush, priv_pc, insert_priv_pc, iren, suppress_iren, rollback,
    output  i_mem_busy, rv32c_ready, pc_f
  );

  modport execute (
    input  ex_mem_stall, ex_mem_flush, npc_sel,
    output rs1_e, rs2_e, token_ex, pc_e, valid_e, ex_busy
  );

  modport mem (
    input   ex_mem_stall, ex_mem_flush, suppress_data,
    output  rd_m, reg_write, csr_read,
            d_mem_busy, dren, dwen, ret,
            jump, branch, fence_stall, mispredict, halt, pc_m, valid_m,
            fault_insn, mal_insn, illegal_insn, fault_l, mal_l, fault_s, mal_s, breakpoint, env,
            badaddr, ifence, wfi,
            token_mem
  );

 endinterface

`endif
