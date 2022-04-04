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
*   Filename:		  tb_priv_1_12_block.sv
*
*   Created by:		Hadi Ahmed
*   Email:			ahmed138@purdue.edu
*   Date Created:	04/02/2022
*   Description:	Testbench for running the privileged unit v1.12.
*/

`timescale 1ns/1ns

`include "rv32i_types_pkg.sv"
`include "machine_mode_types_1_12_pkg.sv"
`include "prv_pipeline_if.vh"
`include "priv_1_12_internal_if.vh"
`include "core_interrupt_if.vh"

`define OUTPUT_FILE_NAME "cpu.hex"
`define STATS_FILE_NAME "stats.txt"
`define RVB_CLK_TIMEOUT 10000

module tb_priv_1_12_block ();

  parameter PERIOD = 10;

  localparam PROP_DELAY = 1ns;

  logic CLK, nRST;
  logic ram_control; // 1 -> CORE, 0 -> TB
  logic halt;
  logic [31:0] addr, data_temp, data;
  logic [63:0] hexdump_temp;
  logic [7:0] checksum;
  integer fptr, stats_ptr;

  integer test_num;

  //Interface Instantiations
  prv_pipeline_if prv_pipeline_if();
  core_interrupt_if core_int_if();

  // Package Instantiations
  import machine_mode_types_1_12_pkg::*;

  //Module Instantiations
  priv_1_12_block DUT (
    .CLK(CLK),
    .nRST(nRST),
    .prv_pipe_if(prv_pipeline_if),
    .interrupt_if(core_int_if)
  );

  //Clock generation
  initial begin : INIT
    CLK = 0;
  end : INIT

  always begin : CLOCK_GEN
    #(PERIOD/2) CLK = ~CLK;
  end : CLOCK_GEN

  //Setup core and let it run
  initial begin : CORE_RUN
    $display("\n");
    $display("==== Starting tests");

    nRST = 0;
    test_num = 0;

    prv_pipeline_if.pipe_clear = '0;
    prv_pipeline_if.ret = '0;
    prv_pipeline_if.epc = '0;
    prv_pipeline_if.fault_insn = '0;
    prv_pipeline_if.mal_insn = '0;
    prv_pipeline_if.illegal_insn = '0;
    prv_pipeline_if.fault_l = '0;
    prv_pipeline_if.mal_l = '0;
    prv_pipeline_if.fault_s = '0;
    prv_pipeline_if.mal_s = '0;
    prv_pipeline_if.breakpoint = '0;
    prv_pipeline_if.env_m = '0;
    prv_pipeline_if.badaddr = '0;
    prv_pipeline_if.swap = '0;
    prv_pipeline_if.clr = '0;
    prv_pipeline_if.set = '0;
    prv_pipeline_if.wdata = '0;
    prv_pipeline_if.maddr = MSTATUS_ADDR;
    prv_pipeline_if.valid_write = '0;
    prv_pipeline_if.wb_enable = '0;
    prv_pipeline_if.instr = '0;
    prv_pipeline_if.ex_rmgmt = '0;
    prv_pipeline_if.ex_rmgmt_cause = '0;

    @(posedge CLK);
    @(posedge CLK);
    nRST = 1;

    $display("=== DUT reset");

    @(posedge CLK);
    #PROP_DELAY;

    $display("== CSR cases");
    // ****************
    // Test Case 0: Read mvendorid
    // ***************
    prv_pipeline_if.swap = 1'b1;
    prv_pipeline_if.maddr = MVENDORID_ADDR;
    #PROP_DELAY;
    if (prv_pipeline_if.rdata == 32'b0)
      $display("> Test %d: PASS", test_num);
    else
      $display("> Test %d: FAIL (got %h) (expected %h)", test_num, prv_pipeline_if.rdata, 32'b0);
    @(posedge CLK);
    #PROP_DELAY;
    test_num++;

    // ****************
    // Test Case 1: Read marchid
    // ***************
    prv_pipeline_if.swap = 1'b1;
    prv_pipeline_if.maddr = MARCHID_ADDR;
    #PROP_DELAY;
    if (prv_pipeline_if.rdata == 32'b0)
      $display("> Test %d: PASS", test_num);
    else
      $display("> Test %d: FAIL (got %b) (expected %b)", test_num, prv_pipeline_if.rdata, 32'b0);
    @(posedge CLK);
    #PROP_DELAY;
    test_num++;

    // ****************
    // Test Case 2: Read mimpid
    // ***************
    prv_pipeline_if.swap = 1'b1;
    prv_pipeline_if.maddr = MIMPID_ADDR;
    #PROP_DELAY;
    if (prv_pipeline_if.rdata == 32'b0)
      $display("> Test %d: PASS", test_num);
    else
      $display("> Test %d: FAIL (got %b) (expected %b)", test_num, prv_pipeline_if.rdata, 32'b0);
    @(posedge CLK);
    #PROP_DELAY;
    test_num++;

    // ****************
    // Test Case 3: Read mhartid
    // ***************
    prv_pipeline_if.swap = 1'b1;
    prv_pipeline_if.maddr = MHARTID_ADDR;
    #PROP_DELAY;
    if (prv_pipeline_if.rdata == 32'b0)
      $display("> Test %d: PASS", test_num);
    else
      $display("> Test %d: FAIL (got %b) (expected %b)", test_num, prv_pipeline_if.rdata, 32'b0);
    @(posedge CLK);
    #PROP_DELAY;
    test_num++;

    // ****************
    // Test Case 4: Read mconfigptr
    // ***************
    prv_pipeline_if.swap = 1'b1;
    prv_pipeline_if.maddr = MCONFIGPTR_ADDR;
    #PROP_DELAY;
    if (prv_pipeline_if.rdata == 32'b0)
      $display("> Test %d: PASS", test_num);
    else
      $display("> Test %d: FAIL (got %b) (expected %b)", test_num, prv_pipeline_if.rdata, 32'b0);
    @(posedge CLK);
    #PROP_DELAY;
    test_num++;

    // ****************
    // Test Case 5: Emulate CSRRW to mstatus
    // ***************
    prv_pipeline_if.swap = 1'b1;
    prv_pipeline_if.wdata = 32'h1088;
    prv_pipeline_if.maddr = MSTATUS_ADDR;
    #PROP_DELAY;
    if (prv_pipeline_if.rdata == 32'h201800)
      $display("> Test %d: PASS", test_num);
    else
      $display("> Test %d: FAIL (got %h) (expected %h)", test_num, prv_pipeline_if.rdata, 32'h201800);
    @(posedge CLK);
    #PROP_DELAY;
    test_num++;

    // ****************
    // Test Case 6: Emulate CSRRW to mstatus pt2
    // ***************
    prv_pipeline_if.swap = 1'b1;
    prv_pipeline_if.wdata = 32'h00001088;
    prv_pipeline_if.maddr = MSTATUS_ADDR;
    #PROP_DELAY;
    if (prv_pipeline_if.rdata == 32'h88)
      $display("> Test %d: PASS", test_num);
    else
      $display("> Test %d: FAIL (got %h) (expected %h)", test_num, prv_pipeline_if.rdata, 32'h88);
    @(posedge CLK);
    #PROP_DELAY;
    test_num++;

    // ****************
    // Test Case 7: Emulate CSRRW to mscratch
    // ***************
    prv_pipeline_if.swap = 1'b1;
    prv_pipeline_if.wdata = 32'hdeadbeef;
    prv_pipeline_if.maddr = MSCRATCH_ADDR;
    #PROP_DELAY;
    if (prv_pipeline_if.rdata == 32'h0)
      $display("> Test %d: PASS", test_num);
    else
      $display("> Test %d: FAIL (got %h) (expected %h)", test_num, prv_pipeline_if.rdata, 32'h0);
    @(posedge CLK);
    #PROP_DELAY;
    test_num++;

    // ****************
    // Test Case 8: Emulate CSRRS to mscratch
    // ***************
    prv_pipeline_if.swap = 1'b0;
    prv_pipeline_if.set = 1'b1;
    prv_pipeline_if.wdata = 32'h21524110;
    prv_pipeline_if.maddr = MSCRATCH_ADDR;
    #PROP_DELAY;
    if (prv_pipeline_if.rdata == 32'hdeadbeef)
      $display("> Test %d: PASS", test_num);
    else
      $display("> Test %d: FAIL (got %h) (expected %h)", test_num, prv_pipeline_if.rdata, 32'hdeadbeef);
    @(posedge CLK);
    #PROP_DELAY;
    test_num++;

    // ****************
    // Test Case 9: Emulate CSRRS to mscratch pt2
    // ***************
    prv_pipeline_if.set = 1'b1;
    prv_pipeline_if.wdata = 32'h21524110;
    prv_pipeline_if.maddr = MSCRATCH_ADDR;
    #PROP_DELAY;
    if (prv_pipeline_if.rdata == 32'hffffffff)
      $display("> Test %d: PASS", test_num);
    else
      $display("> Test %d: FAIL (got %h) (expected %h)", test_num, prv_pipeline_if.rdata, 32'hffffffff);
    @(posedge CLK);
    #PROP_DELAY;
    test_num++;

    // ****************
    // Test Case 10: Emulate CSRRC to mscratch
    // ***************
    prv_pipeline_if.set = 1'b0;
    prv_pipeline_if.clr = 1'b1;
    prv_pipeline_if.wdata = 32'hffffffff;
    prv_pipeline_if.maddr = MSCRATCH_ADDR;
    #PROP_DELAY;
    if (prv_pipeline_if.rdata == 32'hffffffff)
      $display("> Test %d: PASS", test_num);
    else
      $display("> Test %d: FAIL (got %h) (expected %h)", test_num, prv_pipeline_if.rdata, 32'hffffffff);
    @(posedge CLK);
    #PROP_DELAY;
    test_num++;

    // ****************
    // Test Case 11: Emulate CSRRC to mscratch pt2
    // ***************
    prv_pipeline_if.clr = 1'b1;
    prv_pipeline_if.wdata = 32'h0;
    prv_pipeline_if.maddr = MSCRATCH_ADDR;
    #PROP_DELAY;
    if (prv_pipeline_if.rdata == 32'h0)
      $display("> Test %d: PASS", test_num);
    else
      $display("> Test %d: FAIL (got %h) (expected %h)", test_num, prv_pipeline_if.rdata, 32'h0);
    @(posedge CLK);
    #PROP_DELAY;
    test_num++;


    $display("==== Finishing tests");
    $display("\n");
    $finish;

  end : CORE_RUN

endmodule
