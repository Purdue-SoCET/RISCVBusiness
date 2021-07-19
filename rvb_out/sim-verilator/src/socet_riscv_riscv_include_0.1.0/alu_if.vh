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
*   Filename:     include/alu_if.vh
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 06/12/2016
*   Description:  Interface for the alu 
*/

`ifndef ALU_IF_VH 
`define ALU_IF_VH

interface alu_if();

  import alu_types_pkg::*;
  import rv32i_types_pkg::word_t;

  aluop_t aluop;
  word_t  port_a, port_b, port_out;
  
  modport alu (
    input aluop, port_a, port_b,
    output port_out
  );

endinterface

`endif //ALU_IF_VH
