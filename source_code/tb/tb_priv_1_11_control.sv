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
*   Filename:		  tb_RISCVBusiness.sv	
*   
*   Created by:		John Skubic
*   Email:				jskubic@purdue.edu
*   Date Created:	06/01/2016
*   Description:	Testbench for running RISCVBusiness until a halt condition.
*                 A hexdump of memory will occur after the halt condition.
*/

// Note: Figure out whether or not I need to change the name to Enes Shaltami.

`timescale 1ns/100ps

`include "priv_1_11_internal_if.vh"
`include "component_selection_defines.vh"

`define OUTPUT_FILE_NAME "cpu.hex"
`define STATS_FILE_NAME "stats.txt"
`define RVB_CLK_TIMEOUT 10000

module tb_priv_1_11_control ();
   
  parameter PERIOD = 20;
  import rv32i_types_pkg::*;
  import machine_mode_types_1_11_pkg::*;
 
  logic CLK, nRST;
  logic ram_control; // 1 -> CORE, 0 -> TB
  logic halt;
  logic [31:0] addr, data_temp, data;
  logic [63:0] hexdump_temp;
  logic [7:0] checksum;
  //integer fpt    output mip_rup, mtval_rup, mcause_rup, mepc_rup, mstatus_rup,r, stats_ptr;
  

  // Expected Outputs
  logic tb_expected_mip_rup, tb_expected_mtval_rup, tb_expected_mcause_rup, tb_expected_mepc_rup, tb_expected_mstatus_rup, tb_expected_intr;

  mip_t tb_expected_mip_next;
  mcause_t tb_expected_mcause_next;
  mepc_t tb_expected_mepc_next;
  mstatus_t tb_expected_mstatus_next;
  mtval_t tb_expected_mtval_next;
  

  //Interface Instantiations
  priv_1_11_internal_if prv_internal_if();

  //Module Instantiations

  priv_1_11_control DUT (
    .CLK(CLK),
    .nRST(nRST),
    .prv_intern_if(prv_internal_if)
  ); // The modport is prv_control under the priv_1_11_internal_if.vh file


  task reset_dut();
    nRST = 1'b0;
    @(posedge CLK);
    @(posedge CLK);

    nRST = 1'b1;

/* Commenting out because package change made some signals unusable. Can be deleted later
   // Resetting all of the inputs for the priv_block unit
    prv_internal_if.pipe_clear = '0;
    prv_internal_if.ret = '0;
    prv_internal_if.epc = '0;

    // control signals for the exception combinational logic
    prv_internal_if.fault_insn = 1'b0;
    prv_internal_if.mal_insn = 1'b0;
    prv_internal_if.illegal_insn = 1'b0;
    prv_internal_if.fault_l = 1'b0;
    prv_internal_if.mal_l = 1'b0;
    prv_internal_if.fault_s = 1'b0;
    prv_internal_if.mal_s = 1'b0;
    prv_internal_if.breakpoint = 1'b0;
    prv_internal_if.env_m = 1'b0;

    prv_internal_if.mepc = mepc_t'(32'h0);
    prv_internal_if.mie = mie_t'(32'h0); // defined as a struct
    prv_internal_if.mip = mip_t'(32'h0); // defined as a struct
    prv_internal_if.mcause = mcause_t'(32'h0);
    prv_internal_if.mstatus = mstatus_t'(32'h0);
    prv_internal_if.clear_timer_int = 1'b0;
    prv_internal_if.timer_int = 1'b0;
    prv_internal_if.soft_int = 1'b0;
    prv_internal_if.ext_int = 1'b0;
    prv_internal_if.mtval = word_t'(32'h0);

    prv_internal_if.ex_rmgmt = 1'b0;
    prv_internal_if.ex_rmgmt_cause = '0;

    // Expected Outputs
    tb_expected_mcause_next.cause = ex_code_t'(31'h0); // INSN_MAL value
    tb_expected_mcause_next.interrupt = 1'b0; // the source cannot be an interrupt
    tb_expected_mip_rup = 1'b0;
    tb_expected_mtval_rup = 1'b0;
    tb_expected_mcause_rup = 1'b0; // neither an exception nor an interrupt occurred
    tb_expected_mepc_rup = 1'b0;
    tb_expected_mstatus_rup = 1'b0;
    tb_expected_mip_next.mtip = 1'b0;
    tb_expected_mip_next.msip = 1'b0;
    tb_expected_mepc_next = 1'b0; // takes on value of epc
    tb_expected_mstatus_next.ie = 1'b0;
    tb_expected_mtval_next = 1'b0;
    tb_expected_intr = 1'b0; */

   endtask

  //Clock generation
  initial begin : INIT
    CLK = 0;
  end : INIT

  always begin : CLOCK_GEN
    #(PERIOD/2) CLK = ~CLK;
  end : CLOCK_GEN

  //Setup core and let it run
  initial begin : CORE_RUN
    reset_dut();

  // TODO: Expected output signals: mip_rup, mtval_rup, mcause_rup, mepc_rup, mstatus_rup, mip_next, mcause_next, mepc_next, mstatus_next, mtval_next, intr

    // Test Case #1: Check  mal instruction Exception
    prv_internal_if.mal_insn = 1'b1;
    prv_internal_if.breakpoint = 1'b1; // this will trigger an exception
    tb_expected_mcause_next.cause = ex_code_t'(31'h0); // INSN_MAL value
    tb_expected_mcause_next.interrupt = 1'b0; // the source cannot be an interrupt
    tb_expected_intr = 1'b1;
    tb_expected_mcause_rup = 1'b1;
    tb_expected_mepc_rup = 1'b1;
    tb_expected_mstatus_rup = 1'b1;
    tb_expected_mtval_rup = 1'b1;



    prv_internal_if.fault_insn = 1'b1;
    reset_dut();
    #(PERIOD * 2);
    prv_internal_if.illegal_insn = 1'b1;
    reset_dut();
    #(PERIOD * 2);
    prv_internal_if.fault_l = 1'b1;
    reset_dut();
    #(PERIOD * 2);
    prv_internal_if.fault_s = 1'b1;
    reset_dut();
    #(PERIOD * 2);    
    prv_internal_if.mal_s = 1'b1;
    reset_dut();
    #(PERIOD * 2);
    prv_internal_if.mal_insn = 1'b1;
    reset_dut();
    #(PERIOD * 2);
    prv_internal_if.ext_int = 1'b1;
    reset_dut();
    #(PERIOD * 2);
    prv_internal_if.soft_int = 1'b1;
    reset_dut();
    #(PERIOD * 2);
    prv_internal_if.timer_int = 1'b1;

   
 
    @(posedge CLK);
    @(posedge CLK);

    nRST = 1;
    


    $finish;

  end : CORE_RUN



endmodule
