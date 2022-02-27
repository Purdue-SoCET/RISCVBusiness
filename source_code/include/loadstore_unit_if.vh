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
*   Filename:     loadstore_unit_if.vh
*
*   Created by:   Owen Prince
*   Email:        oprince@purdue.edu
*   Date Created: 02/19/2022
*   Description:  Interface for load-store unit
*/
`ifndef LOADSTORE_UNIT_IF_VH
`define LOADSTORE_UNIT_IF_VH

interface loadstore_unit_if();

  import rv32i_types_pkg::*;

  logic [31:0] port_a;
  logic [31:0] port_b;
  logic [31:0] store_data;
  logic [31:0] pc;
  logic [31:0] wdata_ls;
  logic [4:0] reg_rd;
  logic [4:0] reg_rd_ls;
  logic dren;
  logic dren_ls;
  logic dwen;
  logic dwen_ls;
  logic wen;
  logic wen_ls;
  load_t load_type;
  opcode_t opcode;
  opcode_t opcode_ls;

  modport execute (
    input port_a, port_b, store_data, pc, load_type, dren, 
           dwen, wen, reg_rd, opcode,
    output wdata_ls, wen_ls, reg_rd_ls, dren_ls, dwen_ls, opcode_ls
  );

endinterface

`endif //LOADSTORE_UNIT_IF_VH