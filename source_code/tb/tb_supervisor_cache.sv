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
*                 Instruction Requests:
*                 - L1 + TLB Miss -> Page Walk -> Memory Access
*                 - L1 Miss, TLB Hit -> No Page Walk -> Memory Access
*                 - L1 + TLB Hit -> No Page Walk -> No Memory Access
*                 - L1 Hit, TLB Miss -> Page Walk -> No Memory Access
*                 - L1 + TLB Miss, Faulty Address -> Page Walk Fault -> No Memory Access
*                 - L1 + TLB Miss, Bad Permissions -> Page Walk Fault -> No Memory Access
*                 - L1 + TLB Hit, Bad Permissions -> No Page Walk -> No Memory Access
*                 Data Requests:
*                 - L1 + TLB Miss -> Page Walk -> Memory Access
*                 - L1 Miss, TLB Hit -> No Page Walk -> Memory Access
*                 - L1 + TLB Hit -> No Page Walk -> No Memory Access
*                 - L1 Hit, TLB Miss -> Page Walk -> No Memory Access
*                 - L1 + TLB Miss, Faulty Address -> Page Walk Fault -> No Memory Access
*                 - L1 + TLB Miss, Bad Permissions -> Page Walk Fault -> No Memory Access
*                 - L1 + TLB Hit, Bad Permissions -> No Page Walk -> No Memory Access
*                 Instruction + Data Requests:
*                 - I/D L1 + TLB Miss -> 2 Page Walks -> 2 Memory Accesses
*                 - I/D L1 Miss, TLB Hit -> No Page Walks -> 2 Memory Accesses
*                 - I/D L1 + TLB Hit -> No Page Walks -> 2 Memory Accesses
*                 - I/D L1 + TLB Miss -> 2 Page Walks -> No Memory Access
*                 - DTLB Miss, Faulty Data Address -> Page Walk Fault -> No Memory Access
*                 - DTLB Miss + ITLB Miss, Faulty Instruction Address -> 1 Page Walk, 1 Fault -> No Memory Access
*                 - DTLB Hit, ITLB Miss, Bad Data Permissions -> No Page Walk -> No Memory Access
*                 - DTLB Miss, ITLB Hit, Bad Instruction Permissions -> 1 Page Walk -> No Memory Access
*/

`include "generic_bus_if.vh"
`include "prv_pipeline_if.vh"
`include "address_translation_if.vh"
`include "component_selection_defines.vh"

import rv32i_types_pkg::*;
import machine_mode_types_1_13_pkg::*;

`timescale 1ns/10ps

module tb_supervisor_cache();

  logic CLK = 0, nRST;
  logic clear, fence, clear_done, fence_done, tlb_miss;
  logic fault_load_page, fault_store_page, fault_insn_page;
  
  // clock
  always #(PERIOD/2) CLK++; 

  // test signals
  generic_bus_if         icache_proc_gen_bus_if (); // Fetch to I$/iTLB
  generic_bus_if         dcache_proc_gen_bus_if (); // Fetch to D$/dTLB
  prv_pipeline_if        prv_pipe_if            (); // Priv to TLB
  cache_coherence_if     control_if             (); // coherence bus to caches
  bus_ctrl_if            bus_ctrl               (); // Mem to bus controller

  // test program
  test_id_tlb_vipt_pw PROG (
    .CLK(CLK),
    .nRST(nRST),
    .icache_proc_gen_bus_if(icache_proc_gen_bus_if),
    .dcache_proc_gen_bus_if(dcache_proc_gen_bus_if),
    .prv_pipe_if(prv_pipe_if),
    .control_if(control_if),
    .bus_ctrl_if(bus_ctrl)
  );

  // DUT
  supervisor_cache_wrapper DUT (
    .CLK(CLK),
    .nRST(nRST),
    .icache_proc_gen_bus_if(icache_proc_gen_bus_if),
    .dcache_proc_gen_bus_if(dcache_proc_gen_bus_if),
    .prv_pipe_if(prv_pipe_if),
    .control_if(control_if),
    .bus_ctrl_if(bus_ctrl)
  );
  
endmodule

program test_id_tlb_vipt_pw
(
  input logic CLK,
  generic_bus_if icache_proc_gen_bus_if,
  generic_bus_if dcache_proc_gen_bus_if,
  prv_pipeline_if prv_pipe_if,
  control_if control_if,
  bus_ctrl_if bus_ctrl,
  output logic nRST
);

integer seed;
integer error_cnt;

string test_case;

typedef enum logic [1:0] {
  ICACHE, DCACHE, BUSCTRL
} tb_access_t;

// current TLB entry entries used by the fill_* tasks
logic [ASID_LENGTH-1:0] tlb_asid [TLB_SIZE];
logic [SXLEN-1:0]      tlb_rdata [TLB_SIZE];
logic [PPNLEN-1:0]       tlb_ppn [TLB_SIZE];

logic                    test_mode;
logic [ASID_LENGTH-1:0]  test_asid;
logic [PPNLEN-1:0]       test_ppn;
logic [TLB_TAG_BITS-1:0] test_tag;
logic [SXLEN-1:0]        test_rdata, test_va;
logic [TLB_SIZE_LOG2-1:0] test_index;

initial begin : MAIN

  $dumpfile("waveform.fst");
  $dumpvars(0, tb_tlb_directmapped);

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
  $random(seed);

  // I may be going crazy, but the first time I call $random it returns all 1's...
  // warming up $random
  generate_rdata(test_rdata);
  generate_asid(test_asid);
  generate_tlb_tag(test_tag);
  generate_ppn(test_ppn);

  // Assert nRST
  #(DELAY);
  @(posedge CLK);
  nRST = 1;
  @(posedge CLK);

  // wait for TLB startup to finish
  while (fence_done == 1'b0)
    @(posedge CLK);
  @(posedge CLK);

  /**************************
  
  Begin testing!
  
  **************************/
  $display("\n---------- Beginning Basic Test Cases ---------\n");


  /**************************
  
  Address translation off (M-mode and S-Mode Bare addressing)
  
  **************************/
  begin_test("Address translation off (M-mode and S-Mode Bare addressing)");

  // attempt a read in M-mode
  set_satp(1, '1, '1); // give Sv32 translation for S-mode
  set_priv_level(M_MODE); // ensure M_MODE
  @(posedge CLK);

  initiate_read(32'h10001000);
  if (tlb_miss || gbif.rdata) begin
    $display("Error in test [%s]: tlb_miss or non-zero rdata received when in M-mode\n", test_case);
    error_cnt += 1;
  end
  else begin
    $display("Valid TLB response in M-mode");
  end
  reset_gbif();

  // attempt a read in S-mode, with bare address translation
  set_satp(0, '1, '1); // give Bare translation for S-mode
  set_priv_level(S_MODE); // ensure M_MODE
  @(posedge CLK);

  initiate_read(32'h10001000);
  if (tlb_miss || gbif.rdata) begin
    $display("Error in test [%s]: tlb_miss or non-zero rdata received when in Bare S-mode\n", test_case);
    error_cnt += 1;
  end
  else begin
    $display("Valid TLB response in Bare S-mode");
  end
  reset_gbif();

  complete_test();


  /**************************
  
  Compulsory TLB miss
  
  **************************/
  begin_test("Compulsory TLB miss");
  set_priv_level(S_MODE);
  set_satp(1, 9'h1FF, 22'hFFFF);
  complete_read_check(32'h10001000, 32'hFFFFFC00);
  complete_test();


  /**************************
  
  TLB Hit
  
  **************************/
  begin_test("TLB Hit");
  complete_read_check(32'h10001000, 32'hFFFFFC00);
  complete_test();


  /**************************
  
  TLB Eviction
  
  **************************/
  begin_test("TLB Eviction");
  complete_read_check(32'h80001000, 32'hAAAAAC00);
  complete_test();


  /**************************
  
  Mismatch ASID miss
  
  **************************/
  begin_test("Mismatch ASID miss");
  set_satp(1, 9'h100, 22'hFFFF); // new asid 0x100
  complete_read_check(32'h80001000, 32'hAAAAAC00);
  complete_test();


  /**************************
  
  Invalidate TLB entry, by VA & ASID
  
  **************************/
  begin_test("Invalidate TLB entry, by VA & ASID");
  // generate a random tag and asid to fill cache with
  generate_tlb_tag(test_tag);
  generate_asid(test_asid);
  fill_tlb_fixed_asid_tag(test_asid, test_tag);

  if (VERBOSE) begin
    for (integer i = 0; i < TLB_SIZE; i = i + 1) begin
      $display("Index %2d - ASID: 0x%03h PPN: 0x%06h RDATA: 0x%08h\n", i, tlb_asid[i], tlb_ppn[i], tlb_rdata[i]);
    end
  end

  // generate an index to fence with and assign tag and index to test_ppn
  generate_index(test_index);
  test_ppn = {test_tag, test_index};
  test_va = {test_ppn, 12'h000};

  // fence asid and va and verify the tlb fence
  fence_tlb_asid_va(test_asid, test_va);
  verify_tlb_fence();

  complete_test();


  /**************************
  
  Invalidate TLB entry, by VA
  
  **************************/
  begin_test("Invalidate TLB entry, by VA");
  // generate a random tag and set test_asid = 0 to fill cache with
  generate_tlb_tag(test_tag);
  test_asid = '0;
  fill_tlb_fixed_tag(test_tag);

  if (VERBOSE) begin
    for (integer i = 0; i < TLB_SIZE; i = i + 1) begin
      $display("Index %2d - ASID: 0x%03h PPN: 0x%06h RDATA: 0x%08h\n", i, tlb_asid[i], tlb_ppn[i], tlb_rdata[i]);
    end
  end

  // generate an index to fence with and assign tag and index to test_ppn
  generate_index(test_index);
  test_ppn = {test_tag, test_index};
  test_va = {test_ppn, 12'h000};

  // fence asid and va and verify the tlb fence
  fence_tlb_asid_va(test_asid, test_va);
  verify_tlb_fence();

  complete_test();


  /**************************
  
  Invalidate TLB entry, by ASID
  
  **************************/
  begin_test("Invalidate TLB entry, by ASID");
  // generate a random asid and set test_tag = 0 to fill cache with
  test_tag = '0;
  generate_asid(test_asid);
  fill_tlb_fixed_asid(test_asid);

  if (VERBOSE) begin
    for (integer i = 0; i < TLB_SIZE; i = i + 1) begin
      $display("Index %2d - ASID: 0x%03h PPN: 0x%06h RDATA: 0x%06h\n", i, tlb_asid[i], tlb_ppn[i], tlb_rdata[i]);
    end
  end

  // set test_ppn and test_va to '0;
  test_ppn = '0;
  test_va = '0;

  // fence asid and va and verify the tlb fence
  fence_tlb_asid_va(test_asid, test_va);
  verify_tlb_fence();

  complete_test();


  /**************************
  
  Invalidate TLB entry, all entries
  
  **************************/
  begin_test("Invalidate TLB entry, all entries");
  // set test_tag and test_asid = 0 to fill cache with
  test_tag = '0;
  test_asid = '0;
  fill_tlb_random();

  if (VERBOSE) begin
    for (integer i = 0; i < TLB_SIZE; i = i + 1) begin
      $display("Index %2d - ASID: 0x%03h PPN: 0x%06h RDATA: 0x%08h\n", i, tlb_asid[i], tlb_ppn[i], tlb_rdata[i]);
    end
  end

  // set test_ppn and test_va to '0;
  test_ppn = '0;
  test_va = '0;

  // fence asid and va and verify the tlb fence
  fence_tlb_asid_va(test_asid, test_va);
  verify_tlb_fence();

  complete_test();


  /**************************
  
  Address translation off (again)
  
  **************************/
  begin_test("Address translation off (again)");
  // attempt a read in M-mode
  set_satp(1, '1, '1); // give Sv32 translation for S-mode
  set_priv_level(M_MODE); // ensure M_MODE
  @(posedge CLK);

  initiate_read(32'h10001000);
  if (tlb_miss || gbif.rdata) begin
    $display("Error in test [%s]: tlb_miss or non-zero rdata received when in M-mode\n", test_case);
    error_cnt += 1;
  end
  else begin
    $display("Valid TLB response in M-mode");
  end
  reset_gbif();

  // attempt a read in S-mode, with bare address translation
  set_satp(0, '1, '1); // give Bare translation for S-mode
  set_priv_level(S_MODE); // ensure M_MODE
  @(posedge CLK);

  initiate_read(32'h10001000);
  if (tlb_miss || gbif.rdata) begin
    $display("Error in test [%s]: tlb_miss or non-zero rdata received when in Bare S-mode\n", test_case);
    error_cnt += 1;
  end
  else begin
    $display("Valid TLB response in Bare S-mode");
  end
  reset_gbif();

  complete_test();


  /**************************
  
  Testing Completed
  
  **************************/
  $display("\n---------- Testing Completed ---------\n");

  if (error_cnt == 0) begin
    $display("\nAll tests passed!\n");
  end else begin
    $display("\nTests Failed: %0d\n", error_cnt);
  end

  $finish;
end

// --- Helper Tasks and Functions --- //

task begin_test;
  input string test_name;
  test_case = test_name;
  $display("\n---------- %s ---------\n", test_case);
endtask

task complete_test;
  // $display("--------------------------------------------------\n");
  // $fflush(); // unfortunately does not work with v-rilator
endtask

// set_ren
// sets the read enable from processor to the TLB to new_ren
task set_ren;
  input logic new_ren;
  input tb_access_t access;

  case (access)
    ICACHE: icache_proc_gen_bus_if.ren = new_ren;
    DCACHE: icache_proc_gen_bus_if.ren = new_ren;
  endcase
endtask

// set_wen
// sets the write enable from processor to the TLB to new_ren
task set_wen;
  input logic new_wen;
  input tb_access_t access;

  case (access)
    ICACHE: icache_proc_gen_bus_if.wen = 0;
    DCACHE: icache_proc_gen_bus_if.wen = new_wen;
  endcase
endtask

// set_byte_en
// sets the byte enable from processor to the TLB to new_byte_en
task set_byte_en;
  input logic [3:0] new_byte_en;
  input tb_access_t access;

  case (access)
    ICACHE: icache_proc_gen_bus_if.byte_en = new_byte_en;
    DCACHE: icache_proc_gen_bus_if.byte_en = new_byte_en;
  endcase
endtask

// set_addr
// sets the address from processor to the TLB to new_addr
task set_addr;
  input logic [RAM_ADDR_SIZE-1:0] new_addr;
  input tb_access_t access;

  case (access)
    ICACHE: icache_proc_gen_bus_if.addr = new_addr;
    DCACHE: icache_proc_gen_bus_if.addr = new_addr;
  endcase
endtask

// set_wdata
// sets the write data from processor to the TLB to new_wdata
task set_wdata;
  input logic [SXLEN-1:0] new_wdata;
  input tb_access_t access;

  case (access)
    ICACHE: icache_proc_gen_bus_if.wdata = '0;
    DCACHE: icache_proc_gen_bus_if.wdata = new_wdata;
  endcase

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

task reset_icache_proc;
  set_ren(0, 0); // 


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
// sets the fence signal the TLB and waits until done
task fence_tlb;
  fence = 1'b1;
  @(posedge CLK);
  fence = 1'b0;

  @(posedge fence_done);
  @(posedge CLK); // let TLB go back to HIT state
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
    $display("\nData Mismatch \nAddr: 0x%08h\nExpected: 0x%08h\nReceived: 0x%08h\n", 
      read_addr, expected_rdata, actual_rdata); 
    error_cnt = error_cnt + 1;
    #(DELAY);
    $finish;
  end

endtask

// handle_tlb_miss
// handles a miss from the tlb if there is one
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
        if (VERBOSE)
          $display("Handled TLB miss for rdata: 0x%h\n", new_rdata);
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

// generate_asid
task generate_asid;
  output logic [ASID_LENGTH-1:0] random_asid;

  random_asid = {$random % ASID_MAX};
endtask

task generate_tlb_tag;
  output logic [TLB_TAG_BITS-1:0] random_tag;

  random_tag = $random % TLB_TAG_MAX;
endtask

task generate_ppn;
  output logic [PPNLEN-1:0] random_ppn;

  random_ppn = $random % PPN_MAX;
endtask

task generate_perms;
  output logic [9:0] random_perms;

  random_perms = (($random % (1 << 8)) | RWXV_PERMS) & (~PAGE_PERM_USER);
endtask

task generate_rdata;
  output logic [SXLEN-1:0] random_rdata;

  random_rdata = $random;
endtask

task generate_pte;
  output logic [SXLEN-1:0] random_pte;

  generate_ppn(random_pte[SXLEN-1:10]);
  generate_perms(random_pte[9:0]);
  random_pte[9:8] = '0;
endtask

task generate_index;
  output logic [TLB_SIZE_LOG2-1:0] random_index;

  random_index = $random % TLB_SIZE;
endtask

task reset_tlb_test_metadata;
  for (integer i = 0; i < TLB_SIZE; i = i + 1) begin
    tlb_asid[i]  = '0;
    tlb_ppn[i]   = '0;
    tlb_rdata[i] = '0;
  end
endtask

task set_tlb_test_metadata;
  input logic [ASID_LENGTH-1:0] asid;
  input logic [TLB_TAG_BITS-1:0] tag;
  input logic [SXLEN-1:0] rdata;
  input logic [TLB_SIZE_LOG2-1:0] index;

  tlb_asid[index]  = asid;
  tlb_ppn[index]   = {tag, index};
  tlb_rdata[index] = rdata;
endtask

task fill_tlb_random;
  logic [ASID_LENGTH-1:0] asid;
  logic [TLB_TAG_BITS-1:0] tag;
  logic [TLB_SIZE_LOG2-1:0] index;
  logic [SXLEN-1:0] rdata, rdata_out;

  for (integer a = 0; a < TLB_ASSOC; a = a + 1) begin
    for (integer i = 0; i < TLB_SIZE; i = i + 1) begin
      index = i;
      // generate the random values for filling
      generate_asid(asid);
      generate_tlb_tag(tag);
      generate_pte(rdata);

      // set asid (don't care about satp.ppn)
      set_satp(1, asid, '1);

      // read the value into tlb
      if (VERBOSE)
        $display("Filling row %d with tag 0x%h and asid 0x%h\n", index, tag, asid);
      initiate_read({tag, index, 12'h000});
      complete_read(rdata, rdata_out);

      set_tlb_test_metadata(asid, tag, rdata_out, index);
    end
  end
endtask

task fill_tlb_fixed_asid;
  input logic [ASID_LENGTH-1:0] asid;
  logic [TLB_TAG_BITS-1:0] tag;
  logic [TLB_SIZE_LOG2-1:0] index;
  logic [SXLEN-1:0] rdata, rdata_out;

  for (integer a = 0; a < TLB_ASSOC; a = a + 1) begin
    for (integer i = 0; i < TLB_SIZE; i = i + 1) begin
      index = i;
      // generate the random values for filling
      generate_tlb_tag(tag);
      generate_pte(rdata);

      // set asid (don't care about satp.ppn)
      set_satp(1, asid, '1);

      // read the value into tlb
      if (VERBOSE)
        $display("Filling row %d with tag 0x%h and asid 0x%h\n", index, tag, asid);
      initiate_read({tag, index, 12'h000});
      complete_read(rdata, rdata_out);

      set_tlb_test_metadata(asid, tag, rdata_out, index);
    end
  end
endtask

task fill_tlb_fixed_tag;
  input logic [TLB_TAG_BITS-1:0] tag;
  logic [ASID_LENGTH-1:0] asid;
  logic [TLB_SIZE_LOG2-1:0] index;
  logic [SXLEN-1:0] rdata, rdata_out;

  for (integer a = 0; a < TLB_ASSOC; a = a + 1) begin
    for (integer i = 0; i < TLB_SIZE; i = i + 1) begin
      index = i;
      // generate the random values for filling
      generate_asid(asid);
      generate_pte(rdata);

      // set asid (don't care about satp.ppn)
      set_satp(1, asid, '1);

      // read the value into tlb
      if (VERBOSE)
        $display("Filling row %d with tag 0x%h and asid 0x%h\n", index, tag, asid);
      initiate_read({tag, index, 12'h000});
      complete_read(rdata, rdata_out);

      set_tlb_test_metadata(asid, tag, rdata_out, index);
    end
  end
endtask

task fill_tlb_fixed_asid_tag;
  input logic [ASID_LENGTH-1:0] asid;
  input logic [TLB_TAG_BITS-1:0] tag;
  logic [TLB_SIZE_LOG2-1:0] index;
  logic [SXLEN-1:0] rdata, rdata_out;

  for (integer a = 0; a < TLB_ASSOC; a = a + 1) begin
    for (integer i = 0; i < TLB_SIZE; i = i + 1) begin
      index = i;
      // generate the random values for filling
      generate_pte(rdata);

      // set asid (don't care about satp.ppn)
      set_satp(1, asid, '1);

      // read the value into tlb
      if (VERBOSE)
        $display("Filling row %d with tag 0x%h and asid 0x%h\n", index, tag, asid);
      initiate_read({tag, index, 12'h000});
      complete_read(rdata, rdata_out);

      set_tlb_test_metadata(asid, tag, rdata_out, index);
    end
  end
endtask

task fence_tlb_asid_va;
  input logic [ASID_LENGTH-1:0] asid;
  input logic [SXLEN-1:0] va;

  // set fence values in prv_pipe_if
  prv_pipe_if.fence_asid = asid;
  prv_pipe_if.fence_va   = va;

  // begin fence
  fence_tlb();

  prv_pipe_if.fence_asid = '0;
  prv_pipe_if.fence_va   = '0;
endtask

task fence_tlb_va;
  input logic [SXLEN-1:0] va;
  logic [ASID_LENGTH-1:0] asid;

  // set asid to 0 since we only care about va
  asid = '0;

  // fence tlb
  fence_tlb_asid_va(asid, va);
endtask

task fence_tlb_asid;
  input logic [ASID_LENGTH-1:0] asid;
  logic [SXLEN-1:0] va;

  // set va to 0 since we only care about asid
  va = '0;

  // fence tlb
  fence_tlb_asid_va(asid, va);
endtask

task fence_tlb_all;
  logic [ASID_LENGTH-1:0] asid;
  logic [SXLEN-1:0] va;

  // set asid and va to 0 to fence every entry
  asid = '0;
  va   = '0;

  // fence tlb
  fence_tlb_asid_va(asid, va);
endtask

task verify_tlb_fence;

  // read through each set, check at the fenced address set that there's a tlb miss
  for (integer i = 0; i < TLB_SIZE; i = i + 1) begin
    // set asid to the one in the tlb
    set_satp(1, tlb_asid[i], '1);

    // start the read transaction
    initiate_read({tlb_ppn[i], 12'h000});

    // check for TLB miss
    if (tlb_miss) begin 
      // verify tlb_ppn[i] matches test_ppn and tlb_asid[i] matches test_asid 
      if (!(tlb_rdata[i] & PAGE_PERM_GLOBAL) && ((tlb_ppn[i] !== test_ppn && test_ppn !== '0) || (tlb_asid[i] !== test_asid && test_asid !== '0))) begin
        $display("Invalid fence, data mismatch - tlb_ppn[%3d]: 0x%06h, test_ppn: 0x%06h - tlb_asid[%3d]: 0x%03h, test_asid: 0x%03h\n", 
          i, tlb_ppn[i], test_ppn, i, tlb_asid[i], test_asid); 
        error_cnt = error_cnt + 1;
      end else begin
        $display("Valid fence - tlb_ppn[%3d]: 0x%06h - tlb_asid[%3d]: 0x%03h\n", i, tlb_ppn[i], i, tlb_asid[i]);
      end
    end

    // finish the read
    complete_read(tlb_rdata[i], test_rdata);
  end

endtask

endprogram