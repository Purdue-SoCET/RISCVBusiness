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
*   Filename:     risc_mgmt_execute_if.vh
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 02/08/2017
*   Description:  Interface between RISC-MGMT and the execute stage of an
*                 extension. 
*/

`ifndef RISC_MGMT_EXECUTE_IF_VH
`define RISC_MGMT_EXECUTE_IF_VH

interface risc_mgmt_execute_if ();
  import rv32i_types_pkg::*;

  //general execute stage signals
  logic start, exception, busy, reg_w;
  word_t rdata_s_0, rdata_s_1, reg_wdata;

  //branch/jump signals
  logic branch_jump;
  word_t br_j_addr;
  word_t pc;

  modport rmgmt (
    input exception, busy, reg_w, reg_wdata, branch_jump, br_j_addr,
    output rdata_s_0, rdata_s_1, pc, start
  );

  modport ext (    
    input rdata_s_0, rdata_s_1, pc, start,
    output exception, busy, reg_w, reg_wdata, branch_jump, br_j_addr
  );  

endinterface

`endif //RISC_MGMT_EXECUTE_IF_VH
