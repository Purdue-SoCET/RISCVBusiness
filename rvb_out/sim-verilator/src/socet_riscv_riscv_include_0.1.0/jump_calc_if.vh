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
*   Filename:     jump_calc_if.vh
*
*   Created by:   Jacob R. Stevens
*   Email:        steven69@purdue.edu
*   Date Created: 06/17/2016
*   Description:  Interface for the jump address calculation block 
*/

`ifndef JUMP_CALC_IF_VH
`define JUMP_CALC_IF_VH

interface jump_calc_if();
  import rv32i_types_pkg::word_t;

  word_t base, offset, jal_addr, jalr_addr;

  modport jump_calc (
    input base, offset,
    output jal_addr, jalr_addr
  );

endinterface

`endif 
