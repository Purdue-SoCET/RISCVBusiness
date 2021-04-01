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
  import machine_mode_types_1_11_pkg::*;

  logic dwen, dren, j_sel, branch, jump, ex_pc_sel, imm_shamt_sel, halt, wen, ifence, wfi;
  aluop_t alu_op;
  logic [1:0] alu_a_sel, alu_b_sel;
  logic [2:0] w_sel;
  logic [4:0] shamt;
  logic [11:0] imm_I, imm_S;
  logic [20:0] imm_UJ;
  logic [12:0] imm_SB;
  word_t instr, imm_U;
  load_t load_type;
  branch_t branch_type;
  opcode_t opcode; 

  // Privilege control signals
  logic fault_insn, illegal_insn, ret_insn, breakpoint, ecall_insn;
  logic csr_swap, csr_set, csr_clr, csr_imm, csr_rw_valid;
  csr_addr_t csr_addr;
  logic [4:0] zimm;

  modport control_unit(
    input instr, 
    output dwen, dren, j_sel, branch, jump, ex_pc_sel, alu_a_sel,
    alu_b_sel, w_sel, load_type, branch_type, shamt,
    imm_I, imm_S, imm_SB, imm_UJ, imm_U, imm_shamt_sel, alu_op, 
    opcode, halt, wen, fault_insn, illegal_insn, ret_insn, breakpoint, 
    ecall_insn, csr_swap, csr_set, csr_clr, csr_imm, csr_rw_valid,
    csr_addr, zimm, ifence, wfi
  );

endinterface
`endif

