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

`timescale 1ns/100ps

`include "rv32i_types_pkg.sv"
`include "machine_mode_types_1_12_pkg.sv"
`include "prv_pipeline_if.vh"
`include "priv_1_12_internal_if.vh"
`include "core_interrupt_if.vh"

`define OUTPUT_FILE_NAME "cpu.hex"
`define STATS_FILE_NAME "stats.txt"
`define RVB_CLK_TIMEOUT 10000

module tb_priv_1_12_block ();

parameter PERIOD = 20;

  logic CLK, nRST;
  logic ram_control; // 1 -> CORE, 0 -> TB
  logic halt;
  logic [31:0] addr, data_temp, data;
  logic [63:0] hexdump_temp;
  logic [7:0] checksum;
  integer fptr, stats_ptr;

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
    nRST = 0;

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

    $finish;

  end : CORE_RUN

endmodule
