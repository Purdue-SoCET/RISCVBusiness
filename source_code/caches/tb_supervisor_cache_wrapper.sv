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
*   Filename:     tb_supervisor_cache.sv
*
*   Created by:   William Cunningham
*   Email:        wrcunnin@purdue.edu
*   Date Created: 02/17/2025
*   Description:  Testbench for the full separate cache structure I/D VIPT + TLB + PW
*
*                 Test cases include:
*                 - 
*/

`include "component_selection_defines.vh"
`include "generic_bus_if.vh"
`include "prv_pipeline_if.vh"
`include "address_translation_if.vh"
`include "generic_bus_if.vh"
`include "bus_ctrl_if.vh"

import rv32i_types_pkg::*;
import priv_isa_types_pkg::*;

`timescale 1ns/10ps

module supervisor_cache_wrapper(
  input logic CLK, nRST,
  generic_bus_if icache_proc_gen_bus_if,
  generic_bus_if dcache_proc_gen_bus_if,
  prv_pipeline_if prv_pipe_if,
  cache_control_if control_if,
  generic_bus_if out_gen_bus_if
);

  logic abort_bus, fence, fence_done, tlb_miss;
  logic fault_load_page, fault_store_page, fault_insn_page;

  // test signals
  generic_bus_if #(.BLOCK_SIZE(2)) icache_mem_gen_bus_if();
  generic_bus_if #(.BLOCK_SIZE(2)) dcache_mem_gen_bus_if();

  front_side_bus_if front_side_bus [1:0] ();
  back_side_bus_if #(.CPUS(2)) bus_ctrl_if(
      .front_side(front_side_bus)
  );

  // modules
  separate_caches CACHES (
    .CLK(CLK),
    .nRST(nRST),
    .icache_mem_gen_bus_if(icache_mem_gen_bus_if),
    .dcache_mem_gen_bus_if(dcache_mem_gen_bus_if),
    .icache_proc_gen_bus_if(icache_proc_gen_bus_if),
    .dcache_proc_gen_bus_if(dcache_proc_gen_bus_if),
    .control_if(control_if),
    .prv_pipe_if(prv_pipe_if),
    .dcache_bus_ctrl_if(front_side_bus[1]),
    .icache_bus_ctrl_if(front_side_bus[0]),
    .abort_bus(abort_bus),
    .icache_miss(prv_pipe_if.icache_miss),
    .dcache_miss(prv_pipe_if.dcache_miss)
  );

  assign bus_ctrl_if.ccabort = abort_bus;
  assign bus_ctrl_if.l2load = out_gen_bus_if.rdata;
  assign bus_ctrl_if.l2state = out_gen_bus_if.busy ? L2_BUSY : L2_ACCESS;
  assign bus_ctrl_if.l2error = out_gen_bus_if.error;

  memory_controller #(
    .NUM_HARTS(1)
  ) MC (
    .CLK(CLK),
    .nRST(nRST),
    .out_gen_bus_if(out_gen_bus_if),
    .bus_ctrl_if(bus_ctrl_if)
  );
  
endmodule