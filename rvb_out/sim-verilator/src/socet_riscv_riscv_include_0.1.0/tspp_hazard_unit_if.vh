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
*   Filename:     tspp_hazard_unit_if.vh
*
*   Created by:   Jacob R. Stevens
*   Email:        steven69@purdue.edu
*   Date Created: 06/15/2016
*   Description:  Interface for the hazard unit of the two stage pipeline 
*/

`ifndef TSPP_HAZARD_UNIT_IF_VH
`define TSPP_HAZARD_UNIT_IF_VH
interface tspp_hazard_unit_if();

  import rv32i_types_pkg::word_t;
  logic pc_en, npc_sel, i_mem_busy, d_mem_busy, dren, dwen, iren,ret;
  logic branch_taken, prediction, jump, branch, if_ex_stall, fence_stall;
  logic if_ex_flush, mispredict, halt;
  word_t pc; 

  //Pipeline Exceptions
  logic fault_insn, mal_insn, illegal_insn, fault_l, mal_l, fault_s, mal_s,
        breakpoint, env;
  word_t epc_f, epc_e, badaddr_f, badaddr_e;

  // TVEC Insertion
  word_t priv_pc;
  logic insert_priv_pc;

  // Pipeline Tokens 
  logic token_ex;

  // RV32C
  logic rv32c_ready;

  modport hazard_unit (
    input i_mem_busy, d_mem_busy, dren, dwen, jump,
          branch, mispredict, halt, pc,fault_insn, mal_insn, 
          illegal_insn, fault_l, 
          mal_l, fault_s, mal_s, breakpoint, env, ret,
          epc_f, epc_e, badaddr_f, badaddr_e, token_ex, fence_stall, rv32c_ready,
    output pc_en, npc_sel, if_ex_stall, if_ex_flush, priv_pc, insert_priv_pc, iren
  );

  modport fetch (
    input pc_en, npc_sel, if_ex_stall, if_ex_flush, priv_pc, insert_priv_pc, iren,
    output i_mem_busy, fault_insn, mal_insn, epc_f, badaddr_f, rv32c_ready
  );

  modport execute (
    input if_ex_stall, npc_sel,
    output d_mem_busy, dren, dwen, jump, branch, mispredict, halt,
    illegal_insn, fault_l, mal_l, fault_s, mal_s, breakpoint, env, ret, epc_e,
    badaddr_e, token_ex, fence_stall
  );
 
endinterface
`endif
