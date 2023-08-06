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
*   Revised:      08/02/2023
*   Description:  Blackbox testbench for the caches.  This should be used to test any
*                 newly developed cache for correctness.  Test cases include:
*                   - replacement up to 8 ways and 8 word blocks
*                   - cache line clear
*                   - cache flush
*                   - constrained random testing of read and write xactions
*/

module tb_caches ();
  
  import rv32i_types_pkg::*;

  parameter NUM_TESTS = 1000;
  parameter NUM_ADDRS = 20;
  parameter PERIOD = 20; 
  parameter DELAY = 5;
  parameter CACHE_SELECT = "l1_cache";// "pass_through";

  parameter SEED = 11;
  parameter VERBOSE = 0;

  parameter CACHE_CONTROL = 1'b1;
  parameter TB_CONTROL    = 1'b0;

  parameter DATA_1 = 32'h12ab_89ef;
  parameter DATA_2 = 32'habcd_ef01;
  /* TAG_BIT needed because memory doesn't use full 32 bit addr space*/
  parameter TAG_BIT = 14;

  // -- TB Variables -- //

  string test;
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

  bus_if DUT_bus_if();
  bus_if tb_bus_if();
  bus_if DUT_ram_if();
  bus_if cache_2_ram_if();
  bus_if ram_bus_if();
  ahb_if ahb_bus(CLK, nRST);
  logic DUT_flush, DUT_clear;

  l1_cache DUT (
        .CLK(CLK),
        .nRST(nRST),
        .proc_bus_if(DUT_bus_if),
        .mem_bus_if(cache_2_ram_if),
        .clear(DUT_clear),
        .flush(DUT_flush)
      );
  /*
  generate 
    if (CACHE_SELECT == "pass_through") begin
      pass_through_cache DUT (
        .CLK(CLK),
        .nRST(nRST),
        .proc_gen_bus_if(DUT_bus_if),
        .mem_gen_bus_if(cache_2_ram_if)
      );
    end else if (CACHE_SELECT == "direct_mapped_tpf") begin
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
  */

  // multiplexor for testbench cache bypass to memory
  assign DUT_ram_if.trans          = (mem_ctrl == CACHE_CONTROL) ? cache_2_ram_if.trans :
                                    tb_bus_if.trans;
  assign DUT_ram_if.addr          = (mem_ctrl == CACHE_CONTROL) ? cache_2_ram_if.addr :
                                    tb_bus_if.addr;
  assign DUT_ram_if.wdata         = (mem_ctrl == CACHE_CONTROL) ? cache_2_ram_if.wdata : 
                                    tb_bus_if.wdata;
  assign DUT_ram_if.write_enable  = (mem_ctrl == CACHE_CONTROL) ? cache_2_ram_if.write_enable :
                                    tb_bus_if.write_enable;
  assign DUT_ram_if.size          = (mem_ctrl == CACHE_CONTROL) ? cache_2_ram_if.size :
                                    tb_bus_if.size;
  assign cache_2_ram_if.rdata     = DUT_ram_if.rdata;
  assign tb_bus_if.rdata          = DUT_ram_if.rdata;
  assign cache_2_ram_if.busy      = !(mem_ctrl == CACHE_CONTROL) || DUT_ram_if.busy;
  assign tb_bus_if.busy           = !(mem_ctrl == TB_CONTROL) || DUT_ram_if.busy;


  ahb_manager mem_bus_manager (
    .bus(DUT_ram_if),
    .ahb(ahb_bus)
  );
  
  ahb_subordinate ram_sub (
    .ahb(ahb_bus),
    .bus(ram_bus_if)
  );
  

  ram_wrapper DUT_ram (
    .CLK(CLK),
    .nRST(nRST),
    .bus(ram_bus_if)
  );

  // -- Gold Model -- //

  bus_if gold_bus_if();

  ram_wrapper gold_ram (
    .CLK(CLK),
    .nRST(nRST),
    .bus(gold_bus_if)
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
    set_trans(bus_pkg::IDLE);
    set_write_enable('0);
    set_addr('0);
    set_wdata('0);
    set_size(bus_pkg::WORD);

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
    test = "Write a word to memory and perform a read";
    tb_addr = 0;
    tb_wdata = DATA_1;

    write_mem(tb_addr, tb_wdata, bus_pkg::WORD);
    read_cache_check(tb_addr);

    // write word to cache

    test = "write word to cache";
    tb_addr = tb_addr + 4;
    write_cache(tb_addr, tb_wdata, bus_pkg::WORD);
    read_cache_check(tb_addr);

    // write halfwords to cache
    test = "write halfwords to cache";
    tb_wdata = DATA_2;
    tb_addr = tb_addr + 4;
    write_cache(tb_addr, tb_wdata, bus_pkg::HALFWORD);
    read_cache_check(tb_addr);

    tb_addr = tb_addr + 4;
    write_cache(tb_addr+2, tb_wdata, bus_pkg::HALFWORD);  
    read_cache_check(tb_addr+2); 

    // write quarterwords to cache

    test = "write quarterwords to cache";
    tb_addr = tb_addr + 4;
    write_cache(tb_addr, tb_wdata, bus_pkg::BYTE);
    read_cache_check(tb_addr);

    tb_addr = tb_addr + 4;
    write_cache(tb_addr+1, tb_wdata, bus_pkg::BYTE);
    read_cache_check(tb_addr+1);

    tb_addr = tb_addr + 4;
    write_cache(tb_addr+2, tb_wdata, bus_pkg::BYTE);
    read_cache_check(tb_addr+1);

    tb_addr = tb_addr + 4;
    write_cache(tb_addr+3, tb_wdata, bus_pkg::BYTE);
    read_cache_check(tb_addr+1);

    // -- Testing Replacement -- //

    $info("---------- Beginning Replacement Testing----------");

    // Write to different address to force replacements
    test = "Write to different address to force replacements";
    tb_addr = 0;
    for (i = 0; i < 9; i++) begin // iterate through all the ways
      tb_addr[TAG_BIT-1 -: 4] = i; // set bits in the tag
      for (j = 0; j < 8; j++) begin // iterate through blocks and write to each word
        tb_addr[4:2] = j;
        tb_wdata = $urandom;
        write_cache(tb_addr, tb_wdata, bus_pkg::WORD);
      end
    end
    @(posedge CLK);
    // Read from the previously written addresses
    test = "Read from the previously written addresses";
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

  /*
    test = "Random Testing";
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
    */
    
    // -- Cache Clear -- //
    
    $info("---------- Beginning Cache Clear Testing ----------");

    test = "Cache Clear";
    tb_addr = 0;
    tb_wdata = $urandom;
    read_cache_check(tb_addr);
    clear_line(tb_addr);
    write_mem(tb_addr, tb_wdata, bus_pkg::WORD);
    read_cache_check(tb_addr);

    // -- Cache Flush -- //

    $info("---------- Beginning Cache Flush Testing ----------");

    // fill cache contents
    test = "fill cache contents";
    tb_addr = 0;
    for (i = 0; i < 9; i++) begin // iterate through all the ways
      tb_addr[TAG_BIT-1 -: 4] = i; // set bits in the tag
      for (j = 0; j < 8; j++) begin // iterate through blocks and write to each word
        tb_addr[4:2] = j;
        read_cache_check(tb_addr);
      end
    end

    // flush cache
    test = "flush cache";
    flush_cache();
 
    // Read to dummy addr to ensure flushing is completed 
    test = "Read to dummy addr to ensure flushing is completed";
    tb_addr = '1;
    read_cache_check(tb_addr);

    // write directly to mem
    test = "write directly to mem";
    tb_addr = 0;
    for (i = 0; i < 9; i++) begin // iterate through all the ways
      tb_addr[TAG_BIT-1 -: 4] = i; // set bits in the tag
      for (j = 0; j < 8; j++) begin // iterate through blocks and write to each word
        tb_addr[4:2] = j;
        tb_wdata = $urandom;
        write_mem(tb_addr, tb_wdata, bus_pkg::WORD);
      end
    end

    // re-read memory to ensure up to date data is received
    test = "re-read memory to ensure up to date data is received";
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

    #(PERIOD / 8);

    set_mem_ctrl(CACHE_CONTROL);
    set_trans(bus_pkg::NONSEQ);
    set_write_enable('0);
    set_addr(read_addr);
    set_size(bus_pkg::WORD);
  
    @(posedge CLK);
    

    while (caches_busy()) begin
      @(posedge CLK);
    end

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
    input bus_pkg::size_t size;

    #(PERIOD / 8);
    
    set_mem_ctrl(CACHE_CONTROL);
    set_trans(bus_pkg::NONSEQ);
    set_write_enable(1'b1);
    set_addr(write_addr);
    set_wdata(write_data);
    set_size(size);

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
    input bus_pkg::size_t size;

    #(PERIOD / 8);

    set_mem_ctrl(TB_CONTROL);
    set_trans(bus_pkg::NONSEQ);
    DUT_bus_if.trans = bus_pkg::IDLE;
    set_write_enable(1'b1);
    set_addr(write_addr);
    set_wdata(write_data);
    set_size(size);

    @(posedge CLK);

    while (mem_busy())
      @(posedge CLK);
  endtask

  // clear_line
  // Sends the request to clear a cache line to the cache
  task clear_line;
    input logic [RAM_ADDR_SIZE-1:0] clear_addr;
    
    #(PERIOD / 8);

    DUT_clear = 1'b1;
    set_trans(bus_pkg::IDLE);
    set_addr(clear_addr);
    @(posedge CLK);
    DUT_clear = 1'b0;
  endtask

  // flush
  // Sends the request to flush the entire contents of the cache
  task flush_cache;

    #(PERIOD / 8);

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

    // set_ren
  // sets the read enable to the DUT and gold model
  task set_trans;
    input bus_pkg::trans_t new_trans;

    DUT_bus_if.trans = new_trans;
    gold_bus_if.trans = new_trans;
    tb_bus_if.trans = new_trans;
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
  task set_write_enable;
    input logic new_write_enable;

    DUT_bus_if.write_enable = new_write_enable;
    gold_bus_if.write_enable = new_write_enable;
    tb_bus_if.write_enable = new_write_enable;
  endtask

  // set_byte_en
  // sets the byte enable to the DUT and gold model
  task set_size;
    input logic [3:0] new_size;

    DUT_bus_if.size = new_size;
    gold_bus_if.size = new_size;
    tb_bus_if.size = new_size;
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
