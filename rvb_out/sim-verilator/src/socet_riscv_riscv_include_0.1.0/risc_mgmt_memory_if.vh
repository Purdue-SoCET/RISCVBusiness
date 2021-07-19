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
*   Filename:     risc_mgmt_memory_if.vh
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 02/08/2017
*   Description:  Interface between RISC-MGMT and the memory stage of an
*                 extension.
*/

`ifndef RISC_MGMT_MEMORY_IF_VH
`define RISC_MGMT_MEMORY_IF_VH

interface risc_mgmt_memory_if ();
  import rv32i_types_pkg::*;

  //general memory stage signals
  logic exception, busy, reg_w;
  word_t reg_wdata;

  //memory signals
  logic mem_ren, mem_wen, mem_busy;
  logic [3:0] mem_byte_en;
  word_t mem_addr, mem_load, mem_store;

  modport rmgmt (
    input exception, busy, reg_w, reg_wdata, 
    mem_ren, mem_wen, mem_addr, mem_store,
    mem_byte_en,
    output mem_load, mem_busy
  );

  modport ext (
    input mem_load, mem_busy,
    output exception, busy, reg_w, reg_wdata, 
    mem_ren, mem_wen, mem_addr, mem_store,
    mem_byte_en
  ); 

endinterface

`endif // RISC_MGMT_MEMORY_IF_VH
