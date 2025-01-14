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
*   Filename:     tb_tlb_directmapped.sv
*
*   Created by:   William Cunningham
*   Email:        wrcunnin@purdue.edu
*   Date Created: 12/24/2024
*   Description:  Testbench for a direct mapped TLB design.
*                 Test cases include:
*                   - Address translation off (M-mode)
*                   - Compulsory TLB Misses
*                   - TLB Hit
*                   - TLB Eviction
*                   - Mismatch ASID miss
*                   - Invalidate TLB entry
*                   - Invalid TLB entry miss
*                   - User/Supervisor read permissions
*                   - User/Supervisor write permissions
*                   - User/Supervisor execute permissions
*                   - User/Supervisor other permissions
*                   - Machine mode no operation
*/

`include "generic_bus_if.vh"
`include "prv_pipeline_if.vh"
`include "address_translation_if.vh"

import rv32i_types_pkg::*;
import machine_mode_types_1_13_pkg::*;

`timescale 1ns/100ps

parameter NUM_TESTS = 1000;
parameter NUM_ADDRS = 20;
parameter PERIOD = 20;
parameter DELAY = 5;

parameter SEED = 11;
parameter VERBOSE = 0;

module tb_tlb_directmapped();

  logic CLK = 0, nRST;
  logic clear, fence, clear_done, fence_done, tlb_miss;
  
  // clock
  always #(PERIOD/2) CLK++; 

  // test signals
  generic_bus_if         proc_gen_bus_if(); // Processor to TLB
  generic_bus_if         mem_gen_bus_if();  // TLB to page walker/cache
  prv_pipeline_if        prv_pipe_if ();    // Priv to TLB
  address_translation_if at_if ();          // Cache to TLB

  // test program
  test PROG (CLK, nRST,
    clear_done, fence_done, tlb_miss,
    clear, fence,
    proc_gen_bus_if,
    mem_gen_bus_if,
    prv_pipe_if,
    at_if
  );

  // DUT
  tlb DUT (CLK, nRST,
    clear, fence,
    clear_done, fence_done, tlb_miss,
    mem_gen_bus_if,
    proc_gen_bus_if,
    prv_pipe_if,
    at_if
  );

  // connect address translation signals
  assign at_if.sv32 = prv_pipe_if.satp.mode == 1;
  assign at_if.sv39 = 0; // prv_pipe_if.satp.mode == 8
  assign at_if.sv48 = 0; // prv_pipe_if.satp.mode == 9
  assign at_if.sv57 = 0; // prv_pipe_if.satp.mode == 10
  assign at_if.sv64 = 0; // prv_pipe_if.satp.mode == 11
  assign at_if.addr_trans_on = (at_if.sv32 | at_if.sv39 | at_if.sv48 | at_if.sv57 | at_if.sv64) && (prv_pipe_if.curr_privilege_level == S_MODE || prv_pipe_if.curr_privilege_level == U_MODE);


endmodule

program test
(
  input CLK, output logic nRST,
  input clear_done, fence_done, tlb_miss,
  output clear, fence,
  generic_bus_if.cpu gbif,        // Processor to TLB
  generic_bus_if.generic_bus mbif,                // TLB to page walker/cache
  prv_pipeline_if.priv_block prv_pipe_if, // priv to TLB
  address_translation_if.cache at_if      // to TLB
);

integer seed;
integer error_cnt;

logic                   mode;
logic [ASID_LENGTH-1:0] asid;
logic [PPNLEN-1:0]      ppn;

initial begin : MAIN

  $dumpfile("waveform.fst");
  $dumpvars(0, tb_register_file_1r1w);

  // Initial reset
  nRST = 0;
  clear = 0;
  fence = 0;
  reset_gbif();
  reset_mbif();
  reset_priv();
  
  // Setup seed
  error_cnt = 0;
  seed = SEED;
  $urandom(seed);

  // Assert nRST
  #(DELAY);
  @(posedge CLK);
  nRST = 1;
  @(posedge CLK);

  // wait for TLB startup to finish
  while (fence_done == 1'b0)
    @(posedge CLK);
  @(posedge CLK);

  // Begin testing!
  $info("\n---------- Beginning Basic Test Cases ---------\n");

  // Compulsory TLB miss
  $info("\n---------- Compulsory TLB miss ---------\n");
  set_priv_level(S_MODE);
  set_satp(1, 9'h1FF, 22'hFFFF);
  complete_read_check(32'h10001000, 32'hFFFFFC00);

  $info("\n---------- Testing Completed Successfully---------\n", error_cnt);

  $finish;
end

// --- Helper Tasks and Functions --- //

// set_ren
// sets the read enable from processor to the TLB to new_ren
task set_ren;
  input logic new_ren;

  gbif.ren = new_ren;
endtask

// set_wen
// sets the write enable from processor to the TLB to new_ren
task set_wen;
  input logic new_wen;

  gbif.wen = new_wen;
endtask

// set_byte_en
// sets the byte enable from processor to the TLB to new_byte_en
task set_byte_en;
  input logic [3:0] new_byte_en;

  gbif.byte_en = new_byte_en;
endtask

// set_addr
// sets the address from processor to the TLB to new_addr
task set_addr;
  input logic [RAM_ADDR_SIZE-1:0] new_addr;

  gbif.addr = new_addr;
endtask

// set_wdata
// sets the write data from processor to the TLB to new_wdata
task set_wdata;
  input logic [SXLEN-1:0] new_wdata;

  gbif.wdata = new_wdata;
endtask

// set_rdata;
// sets the read data from page walker to TLB to new_rdata
task set_rdata;
  input logic [WORD_SIZE-1:0] new_rdata;

  mbif.rdata = new_rdata;
endtask

// set_busy;
// sets the busy signal from page walker to TLB to new_busy
task set_busy;
  input logic new_busy;

  mbif.busy = new_busy;
endtask

// set_error;
// sets the error signal from page walker to TLB to new_error
task set_error;
  input logic new_error;

  mbif.error = new_error;
endtask

// set_priv_level
// sets the current privilege level to new_priv_level
task set_priv_level;
  input priv_level_t new_priv_level;

  prv_pipe_if.curr_privilege_level = new_priv_level;
endtask

// set_satp
// sets the supervisor address translation register to new_satp
task set_satp;
  input logic new_mode;
  input logic [ASID_LENGTH-1:0] new_asid;
  input logic [PPNLEN-1:0] new_ppn;

  prv_pipe_if.satp.mode = new_mode;
  prv_pipe_if.satp.asid = new_asid;
  prv_pipe_if.satp.ppn  = new_ppn;
endtask

// reset_gbif
// resets gbif
task reset_gbif;
  set_ren(1'b0);
  set_wen(1'b0);
  set_addr('0);
  set_wdata('0);
  set_byte_en('0);
endtask

// reset_mbif
// resets mbif
task reset_mbif;
  set_rdata('0);
  set_busy(1'b0);
  set_error(1'b0);
endtask

// reset_priv
// resets prv_pipe_if
task reset_priv;
  // prv_pipe_if = 0;
  set_priv_level(M_MODE);
  set_satp('0, '0, '0);
endtask

// fence_tlb
// sets the fence signal the TLB
task fence_tlb;
  fence = 1'b1;
  @(posedge CLK);
  fence = 1'b0;
endtask

// initiate_read
// initiates a read transaction to the tlb
task initiate_read;
  input logic [RAM_ADDR_SIZE-1:0] read_addr;

  set_ren(1'b1);
  set_wen(1'b0);
  set_addr(read_addr);
  set_wdata('0);
  set_byte_en(4'hf);

  @(posedge CLK);
endtask

// complete_read
// completes a read transaction to the tlb
task complete_read;
  input  logic [SXLEN-1:0] expected_rdata;
  output logic [SXLEN-1:0] actual_rdata;

  // will manage a TLB miss if it happens
  handle_tlb_miss(expected_rdata);
  
  // go a clock cycle, definitely in a hit at this point
  @(posedge CLK);

  // assert that we don't have a miss and the TLB returned something
  assert(tlb_miss == 1'b0);
  assert(gbif.rdata != '0);

  // read the data from the TLB
  actual_rdata = gbif.rdata;

  // finish the read
  @(posedge CLK);
  reset_gbif();
  @(posedge CLK);
endtask

// complete_read_check
// completes and verifies a read transaction to the tlb
task complete_read_check;
  input logic [RAM_ADDR_SIZE-1:0] read_addr;
  input logic [SXLEN-1:0] expected_rdata;

  logic [SXLEN-1:0] actual_rdata;

  initiate_read(read_addr);
  complete_read(expected_rdata, actual_rdata);

  if (expected_rdata !== actual_rdata) begin
    $info("\nData Mismatch \nAddr: 0x%0h\nExpected: 0x%0h\nReceived: 0x%0h\n", 
      read_addr, expected_rdata, actual_rdata); 
    error_cnt = error_cnt + 1;
    #(DELAY);
    $finish;
  end

endtask

// handle_tlb_miss
task handle_tlb_miss;
  input logic [WORD_SIZE-1:0] new_rdata;

  // fork between waiting and servicing a tlb miss
  fork
    begin : WAIT_FOR_SERVICE // does nothing atm but might be important in the future
      while (tlb_miss) begin
        @(posedge CLK);
      end
    end

    begin : SERVICE_MISS
      if (tlb_miss) begin
        $info("Handled TLB miss for rdata: 0x%h\n", new_rdata);
        // assert busy
        set_busy(1'b1);

        // be busy for a couple cycles
        @(posedge CLK);
        @(posedge CLK);

        // set the data to fill in the TLB
        set_rdata(new_rdata);
        set_busy(1'b0);

        // miss should be serviced
        @(posedge CLK);
      end
    end
  join
endtask

endprogram