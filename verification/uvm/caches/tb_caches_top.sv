/*
*   Copyright 2022 Purdue University
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
*   Filename:     tb_caches_top.svh
*
*   Created by:   Mitch Arndt
*   Email:        arndt20@purdue.edu
*   Date Created: 03/27/2022
*   Description:  Top Level Module for UVM Cache Verification
*/

// package file
`include "rv32i_types_pkg.sv"

// design file
`include "l1_cache.sv"
`include "l2_cache.sv"
`include "memory_arbiter.sv"

// Interface checker file
`include "interface_checker.svh"

// interface file
`include "generic_bus_if.vh"
`include "cache_if.svh"

// UVM test file
`include "nominal_test.svh"
`include "index_test.svh"
`include "evict_test.svh"
`include "mmio_test.svh"
`include "flush_test.svh"
`include "random_test.svh"

// Device Parameter Build Constants
`include "dut_params.svh"

`timescale 1ns / 1ps
// import uvm packages
import uvm_pkg::*;

module tb_caches_top ();
  logic clk;

  // generate clock
  initial begin
    clk = 0;
    forever #(`CLK_PERIOD) clk = !clk;
  end

  // instantiate the interface
  generic_bus_if i_cpu_bus_if ();  // from processor to instruction l1 cache
  generic_bus_if d_cpu_bus_if ();  // from processor to data l1 cache
  generic_bus_if i_l1_arb_bus_if ();  // from instruction l1 cache to memory arbiter
  generic_bus_if d_l1_arb_bus_if ();  // from data l1 cache to memory arbiter
  generic_bus_if arb_l2_bus_if ();  // from memory arbiter to l2 cache
  generic_bus_if mem_bus_if ();  // from l2 cache to memory bus

  cache_if i_cif (clk);  // holds flush, clear signals for i cache
  cache_if d_cif (clk);  // holds flush, clear signals for d cache
  cache_if l2_cif (clk);  // holds flush, clear signals for l2 cache

  if (`INTERFACE_CHECKER == 1) begin
    interface_checker if_check (  //FIXME: THIS NEEDS TO BE UPDATED WITH PROPER INTERFACES
        .d_cif(d_cif.cache),
        .i_cif(i_cif.cache),
        .l2_cif(l2_cif.cache),
        .d_cpu_if(d_cpu_bus_if.generic_bus),
        .i_cpu_if(i_cpu_bus_if.generic_bus),
        .d_l1_arb_bus_if(d_l1_arb_bus_if.generic_bus),
        .i_l1_arb_bus_if(i_l1_arb_bus_if.generic_bus),
        .arb_l2_bus_if(arb_l2_bus_if.generic_bus),
        .mem_if(mem_bus_if.generic_bus)
    );
  end


  /********************** Instantiate the DUT **********************/


`ifdef TB_L1_CONFIG
  // L1 Cache
  l1_cache #(
      .CACHE_SIZE(`L1_CACHE_SIZE),
      .BLOCK_SIZE(`L1_BLOCK_SIZE),
      .ASSOC(`L1_ASSOC),
      .NONCACHE_START_ADDR(`NONCACHE_START_ADDR)
  ) l1 (
      .CLK(d_cif.CLK),
      .nRST(d_cif.nRST),
      .clear(d_cif.clear),
      .flush(d_cif.flush),
      .clear_done(d_cif.clear_done),
      .flush_done(d_cif.flush_done),
      .proc_gen_bus_if(d_cpu_bus_if.generic_bus),
      .mem_gen_bus_if(mem_bus_if.cpu)
  );
`endif

`ifdef TB_L2_CONFIG
  // L2
  l2_cache #(
      .CACHE_SIZE(`L2_CACHE_SIZE),
      .BLOCK_SIZE(`L2_BLOCK_SIZE),
      .ASSOC(`L2_ASSOC),
      .NONCACHE_START_ADDR(`NONCACHE_START_ADDR)
  ) l2 (
      .CLK(l2_cif.CLK),
      .nRST(l2_cif.nRST),
      .clear(l2_cif.clear),
      .flush(l2_cif.flush),
      .clear_done(l2_cif.clear_done),
      .flush_done(l2_cif.flush_done),
      .proc_gen_bus_if(arb_l2_bus_if.generic_bus),
      .mem_gen_bus_if(mem_bus_if.cpu)
  );
`endif

`ifdef TB_FULL_CONFIG
  // Data L1
  l1_cache #(
      .CACHE_SIZE(`L1_CACHE_SIZE),
      .BLOCK_SIZE(`L1_BLOCK_SIZE),
      .ASSOC(`L1_ASSOC),
      .NONCACHE_START_ADDR(`NONCACHE_START_ADDR)
  ) d_l1 (
      .CLK(d_cif.CLK),
      .nRST(d_cif.nRST),
      .clear(d_cif.clear),
      .flush(d_cif.flush),
      .clear_done(d_cif.clear_done),
      .flush_done(d_cif.flush_done),
      .proc_gen_bus_if(d_cpu_bus_if.generic_bus),
      .mem_gen_bus_if(d_l1_arb_bus_if.cpu)
  );

  assign i_cif.nRST = d_cif.nRST;

  // Instruction L1
  l1_cache #(
      .CACHE_SIZE(`L1_CACHE_SIZE),
      .BLOCK_SIZE(`L1_BLOCK_SIZE),
      .ASSOC(`L1_ASSOC),
      .NONCACHE_START_ADDR(`NONCACHE_START_ADDR)
  ) i_l1 (
      .CLK(i_cif.CLK),
      .nRST(i_cif.nRST),
      .clear(i_cif.clear),
      .flush(i_cif.flush),
      .clear_done(i_cif.clear_done),
      .flush_done(i_cif.flush_done),
      .proc_gen_bus_if(i_cpu_bus_if.generic_bus),
      .mem_gen_bus_if(i_l1_arb_bus_if.cpu)
  );

  // Memory Arbiter
  memory_arbiter mem_arb (
      .CLK(d_cif.CLK),
      .nRST(d_cif.nRST),
      .icache_if(i_l1_arb_bus_if.generic_bus),
      .dcache_if(d_l1_arb_bus_if.generic_bus),
      .mem_arb_if(arb_l2_bus_if.cpu)
  );

  assign l2_cif.nRST  = d_cif.nRST;
  assign l2_cif.flush = d_cif.flush;
  assign l2_cif.clear = d_cif.clear;

  // L2
  l2_cache #(
      .CACHE_SIZE(`L2_CACHE_SIZE),
      .BLOCK_SIZE(`L2_BLOCK_SIZE),
      .ASSOC(`L2_ASSOC),
      .NONCACHE_START_ADDR(`NONCACHE_START_ADDR)
  ) l2 (
      .CLK(l2_cif.CLK),
      .nRST(l2_cif.nRST),
      .clear(l2_cif.clear),
      .flush(l2_cif.flush),
      .clear_done(l2_cif.clear_done),
      .flush_done(l2_cif.flush_done),
      .proc_gen_bus_if(arb_l2_bus_if.generic_bus),
      .mem_gen_bus_if(mem_bus_if.cpu)
  );
`endif

  initial begin
    uvm_config_db#(virtual cache_if)::set(null, "", "i_cif", i_cif);
    uvm_config_db#(virtual cache_if)::set(null, "", "d_cif", d_cif);
    uvm_config_db#(virtual cache_if)::set(null, "", "l2_cif", l2_cif);

    uvm_config_db#(virtual generic_bus_if)::set(null, "", "i_cpu_bus_if", i_cpu_bus_if);
    uvm_config_db#(virtual generic_bus_if)::set(null, "", "d_cpu_bus_if", d_cpu_bus_if);

    uvm_config_db#(virtual generic_bus_if)::set(null, "", "i_l1_arb_bus_if", i_l1_arb_bus_if);
    uvm_config_db#(virtual generic_bus_if)::set(null, "", "d_l1_arb_bus_if", d_l1_arb_bus_if);

    uvm_config_db#(virtual generic_bus_if)::set(null, "", "arb_l2_bus_if", arb_l2_bus_if);

    uvm_config_db#(virtual generic_bus_if)::set(null, "", "mem_bus_if", mem_bus_if);

    run_test();
  end
endmodule
