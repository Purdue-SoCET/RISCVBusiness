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
*   Filename:     tspp_fetch_execute_if.vh
*   
*   Created by:   Jacob R. Stevens	
*   Email:        steven69@purdue.edu
*   Date Created: 06/01/2016
*   Description:  Interface between the fetch and execute pipeline stages
*/

`ifndef PIPE5_FETCH2_DECODE_IF_VH
`define PIPE5_FETCH2_DECODE_IF_VH

interface pipe5_fetch2_decode_if;
  import rv32i_types_pkg::*;
 
  logic         token;
  word_t        pc;
  word_t        pc4;
  word_t        instr;
  logic         mal_insn;
  logic         fault_insn;
  logic         prediction;
  logic [2:0]   frm_csr;

  modport fetch(
    output  pc, token, pc4, instr, prediction,
            mal_insn, fault_insn, frm_csr
  );

  modport decode(
    input    pc, token, pc4, instr, prediction,
             mal_insn, fault_insn, frm_csr
  );

endinterface
`endif
