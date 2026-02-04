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
*   Filename:     tb_caches.sv
*
*   Created by:   John Skubic
*   Email:        jjs.skubic@gmail.com
*   Date Created: 05/26/2017
*   Description:  Blackbox testbench for the caches.  This should be used to test any
*                 newly developed cache for correctness.  Test cases include:
*                   - replacement up to 8 ways and 8 word blocks
*                   - cache line clear
*                   - cache flush
*                   - constrained random testing of read and write xactions
*/

`include "generic_bus_if.vh"

module tb_caches ();

  import rv32i_types_pkg::*;

  parameter NUM_TESTS = 1000;
  parameter NUM_ADDRS = 20;
  parameter PERIOD = 20;
  parameter DELAY = 5;
  parameter CACHE_SELECT = "direct_mapped_tpf";// "pass_through";

  parameter SEED = 11;
  parameter VERBOSE = 0;

  parameter CACHE_CONTROL = 1'b1;
  parameter TB_CONTROL    = 1'b0;

  parameter DATA_1 = 32'h12ab_89ef;
  /* TAG_BIT needed because memory doesn't use full 32 bit addr space*/
  parameter TAG_BIT = 14;

  // -- TB Variables -- //

  logic CLK, nRST;
  integer seed;

  logic   [RAM_ADDR_SIZE-1:0] tb_addr;
  word_t  tb_wdata;
  logic   [3:0] tb_byte_sel;
  logic   tb_xaction_type;
  word_t  tb_DUT_rdata;
  word_t  tb_gold_rdata;
  integer i,j, error_cnt;
  logic   mem_ctrl;
  logic   [RAM_ADDR_SIZE-1:0] tb_addr_array [NUM_ADDRS];

  // -- DUT -- //

  generic_bus_if DUT_bus_if();
  generic_bus_if tb_bus_if();
  generic_bus_if DUT_ram_if();
  generic_bus_if cache_2_ram_if();
  logic DUT_flush, DUT_clear;

  generate
    if (CACHE_SELECT == "pass_through") begin : g_cache_pt
      pass_through_cache DUT (
        .CLK(CLK),
        .nRST(nRST),
        .proc_gen_bus_if(DUT_bus_if),
        .mem_gen_bus_if(cache_2_ram_if)
      );
    end else if (CACHE_SELECT == "direct_mapped_tpf") begin : g_cache_dm_tpf
      direct_mapped_tpf_cache DUT (
        .CLK(CLK),
        .nRST(nRST),
        .proc_gen_bus_if(DUT_bus_if),
        .mem_gen_bus_if(cache_2_ram_if),
        .clear(DUT_clear),
        .flush(DUT_flush)
      );
    end
  endgenerate

  // multiplexor for testbench cache bypass to memory
  assign DUT_ram_if.addr      = (mem_ctrl == CACHE_CONTROL) ? cache_2_ram_if.addr :
                                tb_bus_if.addr;
  assign DUT_ram_if.wdata     = (mem_ctrl == CACHE_CONTROL) ? cache_2_ram_if.wdata :
                                tb_bus_if.wdata;
  assign DUT_ram_if.ren       = (mem_ctrl == CACHE_CONTROL) ? cache_2_ram_if.ren :
                                tb_bus_if.ren;
  assign DUT_ram_if.wen       = (mem_ctrl == CACHE_CONTROL) ? cache_2_ram_if.wen :
                                tb_bus_if.wen;
  assign DUT_ram_if.byte_en   = (mem_ctrl == CACHE_CONTROL) ? cache_2_ram_if.byte_en :
                                tb_bus_if.byte_en;
  assign cache_2_ram_if.rdata = DUT_ram_if.rdata;
  assign tb_bus_if.rdata      = DUT_ram_if.rdata;
  assign cache_2_ram_if.busy  = !(mem_ctrl == CACHE_CONTROL) || DUT_ram_if.busy;
  assign tb_bus_if.busy       = !(mem_ctrl == TB_CONTROL) || DUT_ram_if.busy;

  ram_wrapper DUT_ram (
    .CLK(CLK),
    .nRST(nRST),
    .gen_bus_if(DUT_ram_if)
  );

  // -- Gold Model -- //

  generic_bus_if gold_bus_if();

  ram_wrapper gold_ram (
    .CLK(CLK),
    .nRST(nRST),
    .gen_bus_if(gold_bus_if)
  );

  // -- Clock Generation -- //

  initial begin : CLK_INIT
    CLK = 1'b0;
  end : CLK_INIT

  always begin : CLK_GEN
    #(PERIOD/2) CLK = ~CLK;
  end : CLK_GEN


  // -- Testing -- //

  initial begin : MAIN

    //-- Initial reset --//
    nRST = 0;
    DUT_flush = 0;
    DUT_clear = 0;
    set_mem_ctrl(CACHE_CONTROL);
    set_ren(1'b0);
    set_wen(1'b0);
    set_addr('0);
    set_wdata('0);
    set_byte_en('0);

    // -- Setup Seed for randomized testing -- //
    error_cnt = 0;
    seed = SEED;
    $urandom(seed);

    #(DELAY);
    @(posedge CLK);
    nRST = 1;
    @(posedge CLK);

    // -- Basic Testing -- //

    $info("---------- Beginning Basic Test Cases ---------");

    // Write a word to memory and perform a read

    tb_addr = 0;
    tb_wdata = DATA_1;

    write_mem(tb_addr, tb_wdata, 4'hf);
    read_cache_check(tb_addr);

    // write word to cache

    tb_addr = tb_addr + 4;
    write_cache(tb_addr, tb_wdata, 4'hf);
    read_cache_check(tb_addr);

    // write halfwords to cache
    tb_addr = tb_addr + 4;
    write_cache(tb_addr, tb_wdata, 4'h3);
    read_cache_check(tb_addr);

    tb_addr = tb_addr + 4;
    write_cache(tb_addr, tb_wdata, 4'hc);
    read_cache_check(tb_addr);

    // write quarterwords to cache

    tb_addr = tb_addr + 4;
    write_cache(tb_addr, tb_wdata, 4'h1);
    read_cache_check(tb_addr);

    tb_addr = tb_addr + 4;
    write_cache(tb_addr, tb_wdata, 4'h2);
    read_cache_check(tb_addr);

    tb_addr = tb_addr + 4;
    write_cache(tb_addr, tb_wdata, 4'h4);
    read_cache_check(tb_addr);

    tb_addr = tb_addr + 4;
    write_cache(tb_addr, tb_wdata, 4'h8);
    read_cache_check(tb_addr);

    // -- Testing Replacement -- //

    $info("---------- Beginning Replacement Testing----------");

    // Write to different address to force replacements
    tb_addr = 0;
    for (i = 0; i < 9; i++) begin // iterate through all the ways
      tb_addr[TAG_BIT-1 -: 4] = i; // set bits in the tag
      for (j = 0; j < 8; j++) begin // iterate through blocks and write to each word
        tb_addr[4:2] = j;
        tb_wdata = $urandom;
        write_cache(tb_addr, tb_wdata, 4'hf);
      end
    end
    // Read from the previously written addresses
    tb_addr = 0;
    for (i = 0; i < 9; i++) begin // iterate through all the ways
      tb_addr[TAG_BIT-1 -: 4] = i; // set bits in the tag
      for (j = 0; j < 8; j++) begin // iterate through blocks and write to each word
        tb_addr[4:2] = j;
        read_cache_check(tb_addr);
      end
    end

    // -- Random Testing -- //

    $info("---------- Beginning Random Testing of %0d Xactions %0d Unique Addrs ----------", NUM_TESTS, NUM_ADDRS);

    // Generate the addresses and fill mem with random values
    for (i = 0; i < NUM_ADDRS; i++) begin
      j = $urandom;
      tb_addr_array[i] = j & 32'hffff_fffc;
      tb_wdata = $urandom;
      write_mem(tb_addr_array[i] , tb_wdata, 4'hf);
    end

    for (i = 0; i < NUM_TESTS; i++) begin
      tb_xaction_type = $urandom%2;
      j = $urandom%NUM_ADDRS;
      tb_addr         = tb_addr_array[j];
      tb_wdata        = $urandom;
      case ($urandom%7)
        0 : tb_byte_sel = 4'hf;
        1 : tb_byte_sel = 4'h1;
        2 : tb_byte_sel = 4'h2;
        3 : tb_byte_sel = 4'h3;
        4 : tb_byte_sel = 4'h4;
        5 : tb_byte_sel = 4'h3;
        6 : tb_byte_sel = 4'hc;
        default : tb_byte_sel = 4'hf;
      endcase

      if (tb_xaction_type == 0) begin // write
        if(VERBOSE) begin
          $info("\nXaction %0d -- Write -- Addr: %0h Wdata: %0h Byte_en: %h",
            i, tb_addr, tb_wdata, tb_byte_sel);
        end
        write_cache(tb_addr, tb_wdata, tb_byte_sel);
      end else begin // read
        if(VERBOSE) begin
          $info("\nXaction %0d -- Read --  Addr: %0h", i, tb_addr);
        end
        read_cache_check(tb_addr);
      end
    end

    // -- Cache Clear -- //

    $info("---------- Beginning Cache Clear Testing ----------");

    tb_addr = 0;
    tb_wdata = $urandom;
    read_cache_check(tb_addr);
    clear_line(tb_addr);
    write_mem(tb_addr, tb_wdata, 4'hf);
    read_cache_check(tb_addr);

    // -- Cache Flush -- //

    $info("---------- Beginning Cache Flush Testing ----------");

    // fill cache contents
    tb_addr = 0;
    for (i = 0; i < 9; i++) begin // iterate through all the ways
      tb_addr[TAG_BIT-1 -: 4] = i; // set bits in the tag
      for (j = 0; j < 8; j++) begin // iterate through blocks and write to each word
        tb_addr[4:2] = j;
        read_cache_check(tb_addr);
      end
    end

    // flush cache
    flush_cache();

    // Read to dummy addr to ensure flushing is completed
    tb_addr = '1;
    read_cache_check(tb_addr);

    // write directly to mem
    tb_addr = 0;
    for (i = 0; i < 9; i++) begin // iterate through all the ways
      tb_addr[TAG_BIT-1 -: 4] = i; // set bits in the tag
      for (j = 0; j < 8; j++) begin // iterate through blocks and write to each word
        tb_addr[4:2] = j;
        tb_wdata = $urandom;
        write_mem(tb_addr, tb_wdata, 4'hf);
      end
    end

    // re-read memory to ensure up to date data is received
    tb_addr = 0;
    for (i = 0; i < 9; i++) begin // iterate through all the ways
      tb_addr[TAG_BIT-1 -: 4] = i; // set bits in the tag
      for (j = 0; j < 8; j++) begin // iterate through blocks and write to each word
        tb_addr[4:2] = j;
        read_cache_check(tb_addr);
      end
    end


    $info("\n---------- Testing Completed Successfully---------\n", error_cnt);

    $finish;
  end : MAIN



  // --- Helper Tasks and Functions --- //

  // read_cache
  // Reads a value from memory through the cache interface
  task read_cache;
    input [RAM_ADDR_SIZE-1:0] read_addr;
    output word_t DUT_rdata;
    output word_t gold_rdata;

    set_mem_ctrl(CACHE_CONTROL);
    set_ren(1'b1);
    set_wen(1'b0);
    set_addr(read_addr);
    set_byte_en(4'b1111);

    @(posedge CLK);

    while (caches_busy())
      @(posedge CLK);

    DUT_rdata = DUT_bus_if.rdata;
    gold_rdata = gold_bus_if.rdata;
  endtask

  // read_cache_check
  // Reads a value from memory and reports an error if there is a mismatch.
  task read_cache_check;
    input [RAM_ADDR_SIZE-1:0] read_addr;

    word_t DUT_rdata;
    word_t gold_rdata;

    read_cache(read_addr, DUT_rdata, gold_rdata);

    if (DUT_rdata !== gold_rdata) begin
      $info("\nData Mismatch \nAddr: 0x%0h\nExpected: 0x%0h\nReceived: 0x%0h\n",
        read_addr, gold_rdata, DUT_rdata);
      error_cnt = error_cnt + 1;
      #(DELAY);
      $finish;
    end

  endtask

  // write_cache
  // Writes a value to memory through the cache interface
  task write_cache;
    input [RAM_ADDR_SIZE-1:0] write_addr;
    input word_t write_data;
    input logic [3:0] write_byte_en;

    set_mem_ctrl(CACHE_CONTROL);
    set_ren(1'b0);
    set_wen(1'b1);
    set_addr(write_addr);
    set_wdata(write_data);
    set_byte_en(write_byte_en);

    @(posedge CLK);

    while (caches_busy())
      @(posedge CLK);

  endtask

  // write_mem
  // Bypasses the caches layer and directly modifies values in memory
  // This is useful to test clearing and flushing functionality
  task write_mem;
    input logic [RAM_ADDR_SIZE-1:0] write_addr;
    input word_t write_data;
    input logic [3:0] write_byte_en;

    set_mem_ctrl(TB_CONTROL);
    set_ren(1'b0);
    set_wen(1'b1);
    set_addr(write_addr);
    set_wdata(write_data);
    set_byte_en(write_byte_en);

    @(posedge CLK);

    while (mem_busy())
      @(posedge CLK);

  endtask

  // clear_line
  // Sends the request to clear a cache line to the cache
  task clear_line;
    input logic [RAM_ADDR_SIZE-1:0] clear_addr;

    DUT_clear = 1'b1;
    set_addr(clear_addr);
    @(posedge CLK);
    DUT_clear = 1'b0;
  endtask

  // flush
  // Sends the request to flush the entire contents of the cache
  task flush_cache;
    DUT_flush = 1'b1;
    @(posedge CLK);
    DUT_flush = 1'b0;
  endtask

  // caches_busy
  // blocks execution until the DUT and gold model are no longer busy
  function caches_busy;
    caches_busy = (DUT_bus_if.busy || gold_bus_if.busy);
  endfunction

  // mem_busy
  // blocks execution until the TB memory bypass and gold model are no longer busy
  function mem_busy;
    mem_busy = (tb_bus_if.busy || gold_bus_if.busy);
  endfunction

  // set_addr
  // Sets the address to the DUT and gold model
  task set_addr;
    input logic [RAM_ADDR_SIZE-1:0] new_addr;

    DUT_bus_if.addr = new_addr;
    gold_bus_if.addr = new_addr;
    tb_bus_if.addr = new_addr;
  endtask

  // set_wdata
  // sets the write data to the DUT and gold model
  task set_wdata;
    input word_t new_wdata;

    DUT_bus_if.wdata = new_wdata;
    gold_bus_if.wdata = new_wdata;
    tb_bus_if.wdata = new_wdata;
  endtask

  // set_wen
  // sets the write enable to the DUT and gold model
  task set_wen;
    input logic new_wen;

    DUT_bus_if.wen = new_wen;
    gold_bus_if.wen = new_wen;
    tb_bus_if.wen = new_wen;
  endtask

  // set_ren
  // sets the read enable to the DUT and gold model
  task set_ren;
    input logic new_ren;

    DUT_bus_if.ren = new_ren;
    gold_bus_if.ren = new_ren;
    tb_bus_if.ren = new_ren;
  endtask

  // set_byte_en
  // sets the byte enable to the DUT and gold model
  task set_byte_en;
    input logic [3:0] new_byte_en;

    DUT_bus_if.byte_en = new_byte_en;
    gold_bus_if.byte_en = new_byte_en;
    tb_bus_if.byte_en = new_byte_en;
  endtask

  // set_mem_ctrl
  // Sets the memory control.  A value of 1 indicates the cache
  // has access to memory.  A value of 0 indicates the tb has
  // access to memory.
  task set_mem_ctrl;
    input logic new_mem_ctrl;

    mem_ctrl = new_mem_ctrl;
  endtask

endmodule
