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
`include "cache_coherence_if.vh"
`include "bus_ctrl_if.vh"

import rv32i_types_pkg::*;
import machine_mode_types_1_13_pkg::*;

`timescale 1ns/10ps

module supervisor_cache_wrapper(
  input logic CLK, nRST,
  generic_bus_if icache_proc_gen_bus_if,
  generic_bus_if dcache_proc_gen_bus_if,
  prv_pipeline_if prv_pipe_if,
  cache_control_if control_if,
  generic_bus_if out_gen_bus_if
);

  logic clear, fence, clear_done, fence_done, tlb_miss;
  logic fault_load_page, fault_store_page, fault_insn_page;

  // test signals
  generic_bus_if #(.BLOCK_SIZE(2)) icache_mem_gen_bus_if();
  generic_bus_if #(.BLOCK_SIZE(2)) dcache_mem_gen_bus_if();

  cache_coherence_if     i_cache_coherency_if();
  cache_coherence_if     d_cache_coherency_if();

  bus_ctrl_if            bus_ctrl_if();

  cache_coherence_statistics_t icoherence_statistics, dcoherence_statistics;

  // modules
  separate_caches CACHES (
    .CLK(CLK),
    .nRST(nRST),
    .icache_mem_gen_bus_if(icache_mem_gen_bus_if),
    .dcache_mem_gen_bus_if(dcache_mem_gen_bus_if),
    .icache_proc_gen_bus_if(icache_proc_gen_bus_if),
    .dcache_proc_gen_bus_if(dcache_proc_gen_bus_if),
    .control_if(control_if),
    .i_cache_coherency_if(i_cache_coherency_if),
    .d_cache_coherency_if(d_cache_coherency_if),
    .prv_pipe_if(prv_pipe_if)
  );

  coherency_unit #(
    .CPUID(0)
  ) INSN_COH (
    .CLK(CLK),
    .nRST(nRST),
    .bcif(bus_ctrl_if),
    .ccif(i_cache_coherency_if),
    .gbif(icache_mem_gen_bus_if),
    .coherence_statistics(icoherence_statistics)
  );

  coherency_unit #(
    .CPUID(1)
  ) DATA_COH (
    .CLK(CLK),
    .nRST(nRST),
    .bcif(bus_ctrl_if),
    .ccif(d_cache_coherency_if),
    .gbif(dcache_mem_gen_bus_if),
    .coherence_statistics(dcoherence_statistics)
  );

  memory_controller #(
    .NUM_HARTS(1)
  ) MC (
      .CLK(CLK),
      .nRST(nRST),
      .out_gen_bus_if(out_gen_bus_if),
      .bcif(bus_ctrl_if)
  );
  
endmodule