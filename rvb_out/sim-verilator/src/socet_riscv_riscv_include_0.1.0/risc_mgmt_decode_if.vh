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
*   Filename:     risc_mgmt_decode_if.vh
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 02/08/2017
*   Description:  Interface between RISC-MGMT and the decode stage of an
*                 extension. 
*/

`ifndef RISC_MGMT_DECODE_IF_VH
`define RISC_MGMT_DECODE_IF_VH

interface risc_mgmt_decode_if ();
  import rv32i_types_pkg::*; 
 
  logic insn_claim, mem_to_reg;
  logic [4:0] rsel_s_0, rsel_s_1, rsel_d;
  word_t insn;

  modport rmgmt (
    input insn_claim, mem_to_reg,
    rsel_s_0, rsel_s_1, rsel_d,
    output insn
  );

  modport ext (
    input insn,
    output insn_claim, mem_to_reg, 
    rsel_s_0, rsel_s_1, rsel_d
  );

endinterface

`endif //RISC_MGMT_DECODE_IF_VH
