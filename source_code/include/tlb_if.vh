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
*   Filename:     include/tlb_if.vh
*
*   Created by:   William Cunningham
*   Email:        wrcunnin@purdue.edu
*   Date Created: 11/04/2024
*   Description:  Interface for the tlb 
*/

`ifndef TLB_IF_VH 
`define TLB_IF_VH

interface tlb_if();

  import rv32i_types_pkg::*;
  import priv_isa_types_pkg::*;

  // from priv block
  satp_t satp;
  priv_level_t curr_privilege_level;

  // to hazard unit
  logic fault;
  
  modport tlb (
    input satp, curr_privilege_level,
    output fault
  );

  modport cpu (
    input fault, satp, curr_privilege_level
  );

endinterface

`endif //TLB_IF_VH