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

`ifndef STAGE4_HAZARD_UNIT_IF_VH
`define STAGE4_HAZARD_UNIT_IF_VH

interface stage4_hazard_unit_if();

  import rv32i_types_pkg::word_t;
  import rv32i_types_pkg::regsel_t;

  // Pipeline status signals (inputs)
  regsel_t rs1_e, rs2_e;
  regsel_t rd_m;
  logic reg_write, csr_read;
  logic i_mem_busy, d_mem_busy, dren, dwen, ret, suppress_data;
  logic jump, branch, fence_stall;
  logic mispredict, halt;
  word_t pc_f, pc_e, pc_m;
  logic valid_e, valid_m; // f always valid since it's the PC
  logic ifence;
  logic ex_busy;
  logic serializer_stall;

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

  // decode stage 
  logic stall_decode, flush_decode; 
  word_t pc_decode; 
  logic valid_decode; 
  logic vsetvl_dec; 
  logic queue_wen; 

  // queue 
  logic flush_queue; 
  logic stall_queue; 
  logic is_queue_full; 

  
  // RVV execute signals
  logic vsetvl_ex; 
  logic vbusy;
  logic vvalid_e;
  logic [6:0] velem_num_e;

  // vector unit hazard tracking signals
  regsel_t vs1, vs2, vd; 
  logic vs1_used, vs2_used; 
  logic vregwen; 
  logic ex_mask_en;
  logic vvalid_m;
  logic [6:0] velem_num_m;
  logic vuop_last;
  logic vmask_calc_stall; 

  modport hazard_unit (
    input   rs1_e, rs2_e, rd_m,
            reg_write, csr_read,
            i_mem_busy, d_mem_busy, dren, dwen, ret,
            jump, branch, fence_stall, mispredict, halt, pc_f, pc_e, pc_m,
            fault_insn, mal_insn, illegal_insn, fault_l, mal_l, fault_s, mal_s, breakpoint, env, wfi,
            badaddr, ifence,
            token_ex, token_mem, rv32c_ready,
            valid_e, valid_m, ex_busy, serializer_stall,

            is_queue_full, pc_decode, valid_decode,
            vsetvl_dec, vsetvl_ex, queue_wen, vbusy,

            vregwen, vs1, vs2, vd, vs1_used, vs2_used, ex_mask_en, vvalid_e, vvalid_m, velem_num_e, velem_num_m,
            vuop_last,


    output  pc_en, npc_sel,
            if_ex_flush, ex_mem_flush,
            if_ex_stall, ex_mem_stall,
            priv_pc, insert_priv_pc, iren, suppress_iren, suppress_data, rollback, 

            stall_queue, flush_queue, 
            stall_decode, flush_decode,

            vmask_calc_stall

  );

  modport fetch (
    input   pc_en, npc_sel, if_ex_stall, if_ex_flush, priv_pc, insert_priv_pc, iren, suppress_iren, rollback,
    output  i_mem_busy, rv32c_ready, pc_f
  );

  modport decode  (
    input stall_decode, flush_decode, is_queue_full, 
    output pc_decode, valid_decode, vsetvl_dec, queue_wen, vbusy
  ); 

  modport queue (
    input flush_queue, stall_queue,
    output is_queue_full
  ); 

  modport execute (
    input  ex_mem_stall, ex_mem_flush, npc_sel, flush_queue, vmask_calc_stall, 
    output rs1_e, rs2_e, token_ex, pc_e, valid_e, ex_busy, vsetvl_ex,
           vs1, vs2, vs1_used, vs2_used, ex_mask_en, vvalid_e, velem_num_e
  );

  modport mem (
    input   ex_mem_stall, ex_mem_flush, suppress_data,
    output  rd_m, reg_write, csr_read,
            d_mem_busy, dren, dwen, ret,
            jump, branch, fence_stall, mispredict, halt, pc_m, valid_m,
            fault_insn, mal_insn, illegal_insn, fault_l, mal_l, fault_s, mal_s, breakpoint, env,
            badaddr, ifence, wfi,
            token_mem, serializer_stall,
            vd, vregwen, vvalid_m, velem_num_m, vuop_last
  );

 endinterface

`endif