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
*   Filename:     pipe5_execute_commit_if.vh
*
*   Created by:   Owen Prince
*   Email:        oprince@purdue.edu
*   Date Created: 02/24/2022
*   Description:  Interface for execute-commit latch
*/

`ifndef PIPE5_EXECUTE_COMMIT_IF_VH
`define PIPE5_EXECUTE_COMMIT_IF_VH

interface pipe5_execute_commit_if();

  import rv32i_types_pkg::*;

  logic halt_instr;
  logic csr_instr;
  logic instr_30;
  logic wen_au;
  logic wen_mu;
  logic wen_du;
  logic wen_ls;
  logic busy_au;
  logic busy_mu;
  logic busy_du;
  logic busy_ls;
  logic dren;
  logic mal_addr;
  logic dwen;
  logic breakpoint;
  logic ecall_insn;
  logic ret_insn;
  logic illegal_insn;
  logic invalid_csr;
  logic mal_insn;
  logic fault_insn;
  logic token;
  logic intr_seen;
  logic jump_instr;
  logic branch_instr;
  logic jump_addr;
  logic br_resolved_addr;
  logic prediction;
  logic branch_taken;
  logic [11:0] funct12;
  logic [11:0] imm_I;
  logic [11:0] imm_S;
  logic [12:0] imm_SB;
  logic [2:0] w_sel;
  logic [2:0] funct3;
  logic [4:0] rs1;
  logic [4:0] rs2;
  logic [4:0] reg_rd_au;
  logic [4:0] reg_rd_mu;
  logic [4:0] reg_rd_du;
  logic [4:0] reg_rd_ls;
  opcode_t opcode;
  word_t csr_rdata;
  word_t imm_UJ_ext;
  word_t imm_U;
  word_t instr;
  word_t wdata_au;
  word_t wdata_mu;
  word_t wdata_du;
  word_t wdata_ls;
  word_t memory_addr;
  word_t pc;
  word_t br_resolved_addr;

  modport execute (
    output halt_instr, csr_instr, instr_30, wen_au, wen_mu, wen_du, 
           wen_ls, busy_au, busy_mu, busy_du, busy_ls, dren, 
           mal_addr, dwen, breakpoint, ecall_insn, ret_insn, illegal_insn, 
           invalid_csr, mal_insn, fault_insn, token, intr_seen, jump_instr, 
           branch_instr, jump_addr, br_resolved_addr, branch_instr, prediction, branch_taken, 
           funct12, imm_I, imm_S, imm_SB, w_sel, funct3, 
           rs1, rs2, reg_rd_au, reg_rd_mu, reg_rd_du, reg_rd_ls, 
           opcode, csr_rdata, imm_UJ_ext, imm_U, instr, wdata_au, 
           wdata_mu, wdata_du, wdata_ls, memory_addr, pc, br_resolved_addr
  );

  modport commit (
    input halt_instr, csr_instr, instr_30, wen_au, wen_mu, wen_du, 
           wen_ls, busy_au, busy_mu, busy_du, busy_ls, dren, 
           mal_addr, dwen, breakpoint, ecall_insn, ret_insn, illegal_insn, 
           invalid_csr, mal_insn, fault_insn, token, intr_seen, jump_instr, 
           branch_instr, jump_addr, br_resolved_addr, branch_instr, prediction, branch_taken, 
           funct12, imm_I, imm_S, imm_SB, w_sel, funct3, 
           rs1, rs2, reg_rd_au, reg_rd_mu, reg_rd_du, reg_rd_ls, 
           opcode, csr_rdata, imm_UJ_ext, imm_U, instr, wdata_au, 
           wdata_mu, wdata_du, wdata_ls, memory_addr, pc, br_resolved_addr
  );

endinterface

`endif //PIPE5_EXECUTE_COMMIT_IF_VH