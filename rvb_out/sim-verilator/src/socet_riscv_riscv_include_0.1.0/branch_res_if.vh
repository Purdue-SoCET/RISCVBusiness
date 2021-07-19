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
*   Filename:     include/branch_res_if.vh
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 06/14/2016
*   Description:  Interface for the branch resolution module 
*/

`ifndef BRANCH_RES_IF_VH
`define BRANCH_RES_IF_VH

interface branch_res_if();

  import rv32i_types_pkg::*;

  word_t rs1_data, rs2_data, pc, branch_addr;
  logic [12:0] imm_sb;
  branch_t branch_type;
  logic branch_taken;
  
  modport bres (
    input rs1_data, rs2_data, pc, imm_sb, branch_type,
    output branch_addr, branch_taken
  );

endinterface

`endif //BRANCH_RES_IF_VH
