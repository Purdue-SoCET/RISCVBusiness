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
*   Filename:     risc_mgmt_if.vh
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 02/10/2017
*   Description:  Interface between RISC-MGMT and the standard core.  The
*   modports are designed to work with a two stage pipeline.  If a deeper
*   pipeline is implemented, a modport should be created for each pipeline
*   stage. 
*/

`ifndef RISC_MGMT_IF_VH
`define RISC_MGMT_IF_VH

`include "component_selection_defines.vh"

interface risc_mgmt_if ();

  import rv32i_types_pkg::*;
  import alu_types_pkg::*;

  word_t insn;

  // register signals
  logic req_reg_r;
  logic req_reg_w;
  logic[4:0] rsel_s_0;
  logic[4:0] rsel_s_1;
  logic[4:0] rsel_d;
  word_t rdata_s_0, rdata_s_1;
  logic reg_w;
  word_t reg_wdata;

  // ALU signals
  logic req_alu;
  word_t alu_data_0, alu_data_1, alu_res;
  aluop_t alu_op;

  // Branch Jump signals
  logic req_br_j;
  logic branch_jump;
  word_t br_j_addr;

  // Memory signals
  logic req_mem;
  word_t mem_addr, mem_store, mem_load;
  logic mem_ren, mem_wen, mem_busy;

  // hazard signals
  logic decode_bubble;
  logic execute_stall;
  logic memory_stall;
  logic active_insn; 

  // exception signals
  logic exception;
  logic [`NUM_EXTENSIONS-1:0] ex_cause;

  modport ts_rmgmt (
    output req_reg_r, req_reg_w, rsel_s_0, rsel_s_1, 
      rsel_d, reg_w, reg_wdata, req_alu, 
      alu_data_0, alu_data_1, alu_op, req_br_j, branch_jump, 
      br_j_addr, req_mem, mem_addr, mem_store, mem_ren, 
      mem_wen, decode_bubble, execute_stall, memory_stall, 
      active_insn, exception, ex_cause,
    input rdata_s_0, rdata_s_1, alu_res, mem_load, mem_busy, insn 
  );

  modport ts_pipe (
    output rdata_s_0, rdata_s_1, alu_res, mem_load, mem_busy, insn,
    input req_reg_r, req_reg_w, rsel_s_0, rsel_s_1, 
      rsel_d, reg_w, reg_wdata, req_alu, 
      alu_data_0, alu_data_1, alu_op, req_br_j, branch_jump, 
      br_j_addr, req_mem, mem_addr, mem_store, mem_ren, 
      mem_wen, decode_bubble, execute_stall, memory_stall, 
      active_insn, exception, ex_cause
  );

endinterface

`endif //RISC_MGMT_IF_VH
