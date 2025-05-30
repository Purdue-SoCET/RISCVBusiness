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
*   Filename:     control_unit_if.vh
*
*   Created by:   Jacob R. Stevens
*   Email:        steven69@purdue.edu
*   Date Created: 06/07/2016
*   Description:  Interface between the control unit and various parts of
*                 the two stage pipeline
*/

`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

interface control_unit_if;
  import alu_types_pkg::*;
  import rv32i_types_pkg::*;
  import machine_mode_types_1_13_pkg::*;
  import rv32a_pkg::*;
  import rv32m_pkg::*;
  import rv32b_pkg::*;
  import rv32zc_pkg::*;

  logic dwen, dren, j_sel, branch, jump, ex_pc_sel, imm_shamt_sel, halt, wen, ifence, sfence, wfi;
  aluop_t alu_op;
  logic [1:0] alu_a_sel, alu_b_sel;
  w_sel_t w_sel;
  logic [4:0] shamt;
  logic [4:0] rd;
  logic [11:0] imm_I, imm_S;
  logic [20:0] imm_UJ;
  logic [12:0] imm_SB;
  word_t instr, imm_U;
  load_t load_type;
  branch_t branch_type;
  opcode_t opcode;
  logic reserve, exclusive; // Used for reservation set management

  // Privilege control signals
  logic fault_insn, illegal_insn, mret_insn, sret_insn, breakpoint, ecall_insn, fence;
  logic csr_swap, csr_set, csr_clr, csr_imm, csr_rw_valid;
  csr_addr_t csr_addr;
  logic [4:0] zimm;

  // Extension control signals
  rv32m_decode_t rv32m_control;
  rv32b_decode_t rv32b_control;
  rv32a_decode_t rv32a_control;
  rv32zc_decode_t rv32zc_control;

  modport control_unit(
    input instr,
    output dwen, dren, j_sel, branch, jump, ex_pc_sel, alu_a_sel,
    alu_b_sel, w_sel, load_type, branch_type, shamt,
    imm_I, imm_S, imm_SB, imm_UJ, imm_U, imm_shamt_sel, alu_op,
    opcode, halt, wen, fault_insn, illegal_insn, mret_insn, sret_insn, breakpoint,
    ecall_insn, fence, csr_swap, csr_set, csr_clr, csr_imm, csr_rw_valid,
    csr_addr, zimm, ifence, sfence, wfi, rd, rv32m_control, rv32a_control,
    rv32b_control, rv32zc_control, reserve, exclusive
  );
endinterface
`endif
