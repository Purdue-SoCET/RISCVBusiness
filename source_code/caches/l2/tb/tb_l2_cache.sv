/*
*   Copyright 2021 Purdue University
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
*   Filename:     tb_l2_cache.sv
*
*   Created by:   Aedan Frazier		 , Dhruv Gupta		  ,  Rufat Imanov
*   Email:        frazie35@purdue.edu, gupta479@purdue.edu,	 rimanov@purdue.edu
*   Date Created: 07/18/2021
*   Description:  Testbench for parametrizable L1 Cache.
*/

`timescale 1ns / 10ps
`include "generic_bus_if.vh"

parameter CLK_PERIOD = 10;

module tb_l2_cache;
	// Defined Constants
	localparam RAM_WIDTH = 32;
	localparam ADDR_WIDTH = 32;
	localparam CLK_PERIOD = 10;
	localparam PROPAGATION_DELAY = 3;

	// Testbench Signals
	integer test_number;
	string test_case;
	string sub_test_case;
	logic tb_CLK;
	logic tb_nRST;

	//L2 signals
	logic l1_clear;
	logic l1_clear_done;
	logic l1_flush;
	logic l1_flush_done;

	//L2 signals
	logic l2_clear;
	logic l2_clear_done;
	logic l2_flush;
	logic l2_flush_done;

	generic_bus_if proc_gen_bus_if(); //To processor
	generic_bus_if cache_gen_bus_if(); // Between Caches.
	generic_bus_if mem_gen_bus_if(); // To Memory Controller

	// Clock generation block	
	always begin
		tb_CLK = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_CLK = 1'b1;
		#(CLK_PERIOD/2.0);
  	end
	
	// L1 Cache Portmap
	l1_cache #(.CACHE_SIZE(1024), 
			   .BLOCK_SIZE(2), 
			   .ASSOC(2), 
			   .NONCACHE_START_ADDR(32'h8000_0000)) 
	l1 (.CLK(tb_CLK),
		.nRST(tb_nRST),
		.clear(l1_clear),
		.clear_done(l1_clear_done),
		.flush(l1_flush),
		.flush_done(l1_flush_done),
		.mem_gen_bus_if(cache_gen_bus_if),
		.proc_gen_bus_if(proc_gen_bus_if)
		);


	// L2 Cache Portmap
	l2_cache  #(.CACHE_SIZE(16384),
				.BLOCK_SIZE(4),
				.ASSOC(4),
				.NONCACHE_START_ADDR(32'h8000_0000)
				)
	l2 (.CLK(tb_CLK),
		.nRST(tb_nRST),
		.clear(l2_clear),
		.clear_done(l2_clear_done),
		.flush(l2_flush),
		.flush_done(l2_flush_done),
		.mem_gen_bus_if(mem_gen_bus_if),
		.proc_gen_bus_if(cache_gen_bus_if)
		);


	  // Task to Reset DUTs
	task reset_dut;
		begin
		tb_nRST = 1'b0;
		l1_clear = 1'b0;
		l1_flush = 1'b0;
		l2_clear = 1'b0;
		l2_flush = 1'b0;
		mem_gen_bus_if.busy = 1'b1;

		proc_gen_bus_if.rdata = '0;
		proc_gen_bus_if.ren = 1'b0;
		proc_gen_bus_if.wen = 1'b0;
		proc_gen_bus_if.wdata = '0;
		proc_gen_bus_if.byte_en = 4'hf;
		proc_gen_bus_if.addr = 32'h0000_0000;
		
		mem_gen_bus_if.busy 	 = 1'b1;
		mem_gen_bus_if.rdata 	 = '0;

		@(posedge tb_CLK);
		@(posedge tb_CLK);
		@(negedge tb_CLK);
		tb_nRST = 1'b1;
		@(negedge tb_CLK);
		@(negedge tb_CLK);
		end
	endtask

	// Testbench Process
	initial begin
		test_number = 0;
		test_case = "";

		



		/////////////////////////////////////////////////////////////////////////////////////
		// TEST 00: Power-On and Reset Test
		/////////////////////////////////////////////////////////////////////////////////////
		test_number = 0;
		test_case = "Power-On and Reset";
		sub_test_case = "";
		reset_dut();
		/////////////////////////////////////////////////////////////////////////////////////

		/////////////////////////////////////////////////////////////////////////////////////
		// TEST 01: L1 Write Miss
		/////////////////////////////////////////////////////////////////////////////////////
		test_number++;
		test_case 	       		= "L1 Write miss";
		sub_test_case 			= "Begin";
		@(negedge tb_CLK);
		sub_test_case 			= "Write Signals Activated";
		tb_nRST 		       = 1'b1;
		proc_gen_bus_if.ren    = 1'b0;
		proc_gen_bus_if.wen    = 1'b1;
		proc_gen_bus_if.addr   = '0; // miss
		proc_gen_bus_if.wdata  = 32'hDEAD_DEAF;
		wait(mem_gen_bus_if.ren);
		sub_test_case 			= "Go Memory";
		mem_gen_bus_if.rdata  = 32'hAAAA_AAAA;
		mem_gen_bus_if.busy   = 1'b0;
		@(posedge tb_CLK);
		sub_test_case 			= "Read First Block into L2";
		assert(mem_gen_bus_if.addr == 32'd0) else $error("Test Case %d:\nExpected L2 cache to read from address 32'h0000_0000, but it requested data from address %h",test_number, mem_gen_bus_if.addr); 
		mem_gen_bus_if.rdata  = 32'hAAAA_AAAA;
		@(posedge tb_CLK);
		sub_test_case 			= "Read Second Block into L2";
		assert(mem_gen_bus_if.addr == 32'd4) else $error("Test Case %d:\nExpected L2 cache to read from address 32'h0000_0004, but it requested data from address %h",test_number, mem_gen_bus_if.addr); 
		mem_gen_bus_if.rdata  = 32'hBBBB_BBBB;
		@(posedge tb_CLK);
		sub_test_case 			= "Read Third Block into L2";
		assert(mem_gen_bus_if.addr == 32'd8) else $error("Test Case %d:\nExpected L2 cache to read from address 32'h0000_0008, but it requested data from address %h",test_number, mem_gen_bus_if.addr); 
		mem_gen_bus_if.rdata  = 32'hCCCC_CCCC;
		@(posedge tb_CLK);
		sub_test_case 			= "Read Fourth Block into L2";
		assert(mem_gen_bus_if.addr == 32'd12) else $error("Test Case %d:\nExpected L2 cache to read from address 32'h0000_000C, but it requested data from address %h",test_number, mem_gen_bus_if.addr); 
		mem_gen_bus_if.rdata  = 32'hDDDD_DDDD;
		wait(~mem_gen_bus_if.ren);
		sub_test_case 			= "Read Blocks to L1";
		mem_gen_bus_if.busy   = 1'b1;
		mem_gen_bus_if.rdata  = 32'hBADD_BADD;
		wait(~proc_gen_bus_if.busy);
		sub_test_case 			= "Write to L1";
		mem_gen_bus_if.busy  = 1'b1;
		@(posedge tb_CLK); #1;
		sub_test_case 			= "Finish";
		proc_gen_bus_if.wen    = 1'b0;

		reset_dut();
		/////////////////////////////////////////////////////////////////////////////////////

		/////////////////////////////////////////////////////////////////////////////////////
		// TEST 02: L1 Write Miss Fill Set 0
		/////////////////////////////////////////////////////////////////////////////////////
		
		test_number++;
		test_case 	       		= "L1 Write Miss Set 0";
		sub_test_case 			= "Begin";
		@(negedge tb_CLK);
		sub_test_case 			= "Write Signals Activated";
		proc_gen_bus_if.ren    = 1'b0;
		proc_gen_bus_if.wen    = 1'b1;
		proc_gen_bus_if.addr   = '0; // miss
		proc_gen_bus_if.wdata  = 32'hDEAD_DEAF;
		wait(mem_gen_bus_if.ren);
		sub_test_case 			= "Go Memory";
		mem_gen_bus_if.rdata  = 32'hAAAA_AAAA;
		mem_gen_bus_if.busy   = 1'b0;
		@(posedge tb_CLK);
		sub_test_case 			= "Read First Block into L2";
		assert(mem_gen_bus_if.addr == 32'd0) else $error("Test Case %d:\nExpected L2 cache to read from address 32'h0000_0000, but it requested data from address %h",test_number, mem_gen_bus_if.addr); 
		mem_gen_bus_if.rdata  = 32'hAAAA_AAAA;
		@(posedge tb_CLK);
		sub_test_case 			= "Read Second Block into L2";
		assert(mem_gen_bus_if.addr == 32'd4) else $error("Test Case %d:\nExpected L2 cache to read from address 32'h0000_0004, but it requested data from address %h",test_number, mem_gen_bus_if.addr); 
		mem_gen_bus_if.rdata  = 32'hBBBB_BBBB;
		@(posedge tb_CLK);
		sub_test_case 			= "Read Third Block into L2";
		assert(mem_gen_bus_if.addr == 32'd8) else $error("Test Case %d:\nExpected L2 cache to read from address 32'h0000_0008, but it requested data from address %h",test_number, mem_gen_bus_if.addr); 
		mem_gen_bus_if.rdata  = 32'hCCCC_CCCC;
		@(posedge tb_CLK);
		sub_test_case 			= "Read Fourth Block into L2";
		assert(mem_gen_bus_if.addr == 32'd12) else $error("Test Case %d:\nExpected L2 cache to read from address 32'h0000_000C, but it requested data from address %h",test_number, mem_gen_bus_if.addr); 
		mem_gen_bus_if.rdata  = 32'hDDDD_DDDD;
		wait(~mem_gen_bus_if.ren);
		sub_test_case 			= "Read Blocks to L1";
		mem_gen_bus_if.busy   = 1'b1;
		mem_gen_bus_if.rdata  = 32'hBADD_BADD;
		wait(~proc_gen_bus_if.busy);
		sub_test_case 			= "Write to L1";
		mem_gen_bus_if.busy  = 1'b1;
		@(posedge tb_CLK); #1;
		sub_test_case 			= " Finish 1";
		proc_gen_bus_if.wen    = 1'b0;

		@(posedge tb_CLK);
		sub_test_case 			= "Write Signals Activated";
		proc_gen_bus_if.ren    = 1'b0;
		proc_gen_bus_if.wen    = 1'b1;
		proc_gen_bus_if.addr   = 32'h1000_0000; // miss
		proc_gen_bus_if.wdata  = 32'hDEAD_DEAF;
		wait(mem_gen_bus_if.ren);
		sub_test_case 			= "Go Memory";
		mem_gen_bus_if.rdata  = 32'h4444_4444;
		mem_gen_bus_if.busy   = 1'b0;
		@(posedge tb_CLK);
		sub_test_case 			= "Read First Block into L2";
		assert(mem_gen_bus_if.addr == 32'h1000_0000) else $error("Test Case %d:\nExpected L2 cache to read from address 32'h1000_0000, but it requested data from address %h",test_number, mem_gen_bus_if.addr); 	
		mem_gen_bus_if.rdata  = 32'h4444_4444;
		@(posedge tb_CLK);
		sub_test_case 			= "Read Second Block into L2";
		assert(mem_gen_bus_if.addr == 32'h1000_0004) else $error("Test Case %d:\nExpected L2 cache to read from address 32'h1000_0004, but it requested data from address %h",test_number, mem_gen_bus_if.addr); 
		mem_gen_bus_if.rdata  = 32'h5555_5555;
		@(posedge tb_CLK);
		sub_test_case 			= "Read Third Block into L2";
		assert(mem_gen_bus_if.addr == 32'h1000_0008) else $error("Test Case %d:\nExpected L2 cache to read from address 32'h1000_0008, but it requested data from address %h",test_number, mem_gen_bus_if.addr);
		mem_gen_bus_if.rdata  = 32'h6666_6666;
		@(posedge tb_CLK);
		sub_test_case 			= "Read Fourth Block into L2";
		assert(mem_gen_bus_if.addr == 32'h1000_000c) else $error("Test Case %d:\nExpected L2 cache to read from address 32'h1000_000C, but it requested data from address %h",test_number, mem_gen_bus_if.addr); 
		mem_gen_bus_if.rdata  = 32'h7777_7777;
		wait(~mem_gen_bus_if.ren);
		sub_test_case 			= "Read Blocks to L1";
		mem_gen_bus_if.busy   = 1'b1;
		mem_gen_bus_if.rdata  = 32'hBADD_BADD;
		wait(~proc_gen_bus_if.busy);
		sub_test_case 			= "Write to L1";
		mem_gen_bus_if.busy  = 1'b1;
		@(posedge tb_CLK); #1;
		sub_test_case 			= " Finish 2";
		proc_gen_bus_if.wen    = 1'b0;

		reset_dut();
		/////////////////////////////////////////////////////////////////////////////////////

		/////////////////////////////////////////////////////////////////////////////////////
		// TEST 03: L1 Write Back to L2 from Full Set 0
		/////////////////////////////////////////////////////////////////////////////////////
		
		test_number++;
		test_case 	       		= "L1 Write Back to L2 from Full Set 0";
		sub_test_case 			= "Begin";
		@(negedge tb_CLK);
		sub_test_case 			= "Write Signals Activated";
		proc_gen_bus_if.ren    = 1'b0;
		proc_gen_bus_if.wen    = 1'b1;
		proc_gen_bus_if.addr   = '0; // miss
		proc_gen_bus_if.wdata  = 32'hb00fb00f;
		wait(mem_gen_bus_if.ren);
		sub_test_case 			= "Go Memory";
		mem_gen_bus_if.rdata  = 32'hAAAA_AAAA;
		mem_gen_bus_if.busy   = 1'b0;
		@(posedge tb_CLK);
		sub_test_case 			= "Read First Block into L2";
		assert(mem_gen_bus_if.addr == 32'd0) else $error("Test Case %d:\nExpected L2 cache to read from address 32'h0000_0000, but it requested data from address %h",test_number, mem_gen_bus_if.addr); 
		mem_gen_bus_if.rdata  = 32'hAAAA_AAAA;
		@(posedge tb_CLK);
		sub_test_case 			= "Read Second Block into L2";
		assert(mem_gen_bus_if.addr == 32'd4) else $error("Test Case %d:\nExpected L2 cache to read from address 32'h0000_0000, but it requested data from address %h",test_number, mem_gen_bus_if.addr); 
		mem_gen_bus_if.rdata  = 32'hBBBB_BBBB;
		@(posedge tb_CLK);
		sub_test_case 			= "Read Third Block into L2";
		assert(mem_gen_bus_if.addr == 32'd08) else $error("Test Case %d:\nExpected L2 cache to read from address 32'h0000_0000, but it requested data from address %h",test_number, mem_gen_bus_if.addr); 
		mem_gen_bus_if.rdata  = 32'hCCCC_CCCC;
		@(posedge tb_CLK);
		sub_test_case 			= "Read Fourth Block into L2";
		assert(mem_gen_bus_if.addr == 32'd12) else $error("Test Case %d:\nExpected L2 cache to read from address 32'h0000_0000, but it requested data from address %h",test_number, mem_gen_bus_if.addr); 
		mem_gen_bus_if.rdata  = 32'hDDDD_DDDD;
		wait(~mem_gen_bus_if.ren);
		sub_test_case 			= "Read Blocks to L1";
		mem_gen_bus_if.busy   = 1'b1;
		mem_gen_bus_if.rdata  = 32'hBADD_BADD;
		wait(~proc_gen_bus_if.busy);
		sub_test_case 			= "Write to L1";
		mem_gen_bus_if.busy  = 1'b1;
		@(posedge tb_CLK); #1;
		sub_test_case 			= " Finish 1";
		proc_gen_bus_if.wen    = 1'b0;

		@(posedge tb_CLK);
		sub_test_case 			= "Write Signals Activated";
		proc_gen_bus_if.ren    = 1'b0;
		proc_gen_bus_if.wen    = 1'b1;
		proc_gen_bus_if.addr   = 32'h1000_0000; // miss
		proc_gen_bus_if.wdata  = 32'hbeefbeef;
		wait(mem_gen_bus_if.ren);
		sub_test_case 			= "Go Memory";
		mem_gen_bus_if.rdata  = 32'h4444_4444;
		mem_gen_bus_if.busy   = 1'b0;
		@(posedge tb_CLK);
		sub_test_case 			= "Read First Block into L2";
		assert(mem_gen_bus_if.addr == 32'h1000_0000) else $error("Test Case %d:\nExpected L2 cache to read from address 32'h1000_0000, but it requested data from address %h",test_number, mem_gen_bus_if.addr); 	
		mem_gen_bus_if.rdata  = 32'h4444_4444;
		@(posedge tb_CLK);
		sub_test_case 			= "Read Second Block into L2";
		assert(mem_gen_bus_if.addr == 32'h1000_0004) else $error("Test Case %d:\nExpected L2 cache to read from address 32'h1000_0004, but it requested data from address %h",test_number, mem_gen_bus_if.addr); 
		mem_gen_bus_if.rdata  = 32'h5555_5555;
		@(posedge tb_CLK);
		sub_test_case 			= "Read Third Block into L2";
		assert(mem_gen_bus_if.addr == 32'h1000_0008) else $error("Test Case %d:\nExpected L2 cache to read from address 32'h1000_0008, but it requested data from address %h",test_number, mem_gen_bus_if.addr);
		mem_gen_bus_if.rdata  = 32'h6666_6666;
		@(posedge tb_CLK);
		sub_test_case 			= "Read Fourth Block into L2";
		assert(mem_gen_bus_if.addr == 32'h1000_000c) else $error("Test Case %d:\nExpected L2 cache to read from address 32'h1000_000C, but it requested data from address %h",test_number, mem_gen_bus_if.addr); 
		mem_gen_bus_if.rdata  = 32'h7777_7777;
		wait(~mem_gen_bus_if.ren);
		sub_test_case 			= "Read Blocks to L1";
		mem_gen_bus_if.busy   = 1'b1;
		mem_gen_bus_if.rdata  = 32'hBADD_BADD;
		wait(~proc_gen_bus_if.busy);
		sub_test_case 			= "Write to L1";
		mem_gen_bus_if.busy  = 1'b1;
		@(posedge tb_CLK); #1;
		sub_test_case 			= " Finish 2";
		proc_gen_bus_if.wen    = 1'b0;

		@(posedge tb_CLK);
		sub_test_case 			= "L1 -> L2 WB";
		proc_gen_bus_if.ren    = 1'b0;
		proc_gen_bus_if.wen    = 1'b1;
		proc_gen_bus_if.addr   = 32'h2000_0000; // miss
		proc_gen_bus_if.wdata  = 32'hdeaddead;
		wait(mem_gen_bus_if.ren);
		sub_test_case 			= "Go Memory";
		mem_gen_bus_if.rdata  = 32'h000a_ecaf;
		mem_gen_bus_if.busy   = 1'b0;
		@(posedge tb_CLK);
		sub_test_case 			= "Read First Block into L2";
		assert(mem_gen_bus_if.addr == 32'h2000_0000) else $error("Test Case %d:\nExpected L2 cache to read from address 32'h2000_0000, but it requested data from address %h",test_number, mem_gen_bus_if.addr); 	
		mem_gen_bus_if.rdata  = 32'h000a_ecaf;
		@(posedge tb_CLK);
		sub_test_case 			= "Read Second Block into L2";
		assert(mem_gen_bus_if.addr == 32'h2000_0004) else $error("Test Case %d:\nExpected L2 cache to read from address 32'h2000_0004, but it requested data from address %h",test_number, mem_gen_bus_if.addr); 	
		mem_gen_bus_if.rdata  = 32'h000b_ecaf;
		@(posedge tb_CLK);
		sub_test_case 			= "Read Third Block into L2";
		assert(mem_gen_bus_if.addr == 32'h2000_0008) else $error("Test Case %d:\nExpected L2 cache to read from address 32'h2000_0008, but it requested data from address %h",test_number, mem_gen_bus_if.addr); 	
		mem_gen_bus_if.rdata  = 32'h000c_ecaf;
		@(posedge tb_CLK);
		sub_test_case 			= "Read Fourth Block into L2";
		assert(mem_gen_bus_if.addr == 32'h2000_000c) else $error("Test Case %d:\nExpected L2 cache to read from address 32'h2000_000C, but it requested data from address %h",test_number, mem_gen_bus_if.addr); 	
		mem_gen_bus_if.rdata  = 32'h000d_ecaf;
		wait(~mem_gen_bus_if.ren);
		sub_test_case 			= "Read Blocks to L1";
		mem_gen_bus_if.busy   = 1'b1;
		mem_gen_bus_if.rdata  = 32'hBADD_BADD;
		wait(~proc_gen_bus_if.busy);
		sub_test_case 			= "Write to L1";
		mem_gen_bus_if.busy  = 1'b1;
		@(posedge tb_CLK); #1;
		sub_test_case 			= " Finish 3";
		proc_gen_bus_if.wen    = 1'b0;

		reset_dut();
		/////////////////////////////////////////////////////////////////////////////////////

		/////////////////////////////////////////////////////////////////////////////////////
		// TEST 04: L1 Write Back to L2 WB to memory from Full Sets 0
		/////////////////////////////////////////////////////////////////////////////////////
		
		test_number++;
		test_case 	       		= "L1 WB to L2 WB to Memory from Full Sets 0";
		sub_test_case 			= "Begin";

		for(integer i = 0; i < 16; i+=4)begin
			@(posedge tb_CLK);
			sub_test_case 			= "Write Signals Activated";
			proc_gen_bus_if.ren    = 1'b0;
			proc_gen_bus_if.wen    = 1'b1;
			proc_gen_bus_if.addr   = {4'(i/4), 28'h000_0000}; // miss
			proc_gen_bus_if.wdata  = 32'hbeef_0000 + 32'(i);
			wait(mem_gen_bus_if.ren);
			sub_test_case 			= "Go Memory";
			mem_gen_bus_if.rdata  = 32'hda7a_0000 + 32'(i);
			mem_gen_bus_if.busy   = 1'b0;
			@(posedge tb_CLK);
			sub_test_case 			= "Read First Block into L2";
			mem_gen_bus_if.rdata  = 32'hda7a_0000 + 32'(i);
			@(posedge tb_CLK);
			sub_test_case 			= "Read Second Block into L2";
			mem_gen_bus_if.rdata  = 32'hda7a_0000 + 32'(i+1);
			@(posedge tb_CLK);
			sub_test_case 			= "Read Third Block into L2";
			mem_gen_bus_if.rdata  = 32'hda7a_0000 + 32'(i+2);
			@(posedge tb_CLK);
			sub_test_case 			= "Read Fourth Block into L2";
			mem_gen_bus_if.rdata  = 32'hda7a_0000 + 32'(i+3);
			wait(~mem_gen_bus_if.ren);
			sub_test_case 			= "Read Blocks to L1";
			mem_gen_bus_if.busy   = 1'b1;
			mem_gen_bus_if.rdata  = 32'hBADD_BADD;
			wait(~proc_gen_bus_if.busy);
			sub_test_case 			= "Write to L1";
			mem_gen_bus_if.busy  = 1'b1;
			@(posedge tb_CLK); #1;
			sub_test_case 			= {"Finish ", 8'(i)};
			proc_gen_bus_if.wen    = 1'b0;
		end
		@(posedge tb_CLK);
		sub_test_case 			= "Write Signals Activated";
		proc_gen_bus_if.ren    = 1'b0;
		proc_gen_bus_if.wen    = 1'b1;
		proc_gen_bus_if.addr   = 32'h5000_0000; // miss
		proc_gen_bus_if.wdata  = 32'h0007_0a57;
		mem_gen_bus_if.busy   = 1'b0;
		wait(mem_gen_bus_if.wen);
		sub_test_case 			= "L2 WB initiated";			
		wait(~mem_gen_bus_if.wen);
		sub_test_case 			= "L2 WB Finished";			
		mem_gen_bus_if.busy   = 1'b1;
		wait(mem_gen_bus_if.ren);
		sub_test_case 			= "Go Memory";
		mem_gen_bus_if.rdata  = 32'hDEADBEEF;
		mem_gen_bus_if.busy   = 1'b0;
		@(posedge tb_CLK);
		sub_test_case 			= "Read First Block into L2";
		mem_gen_bus_if.rdata  = 32'hDEADBEEF;
		@(posedge tb_CLK);
		sub_test_case 			= "Read Second Block into L2";
		mem_gen_bus_if.rdata  = 32'hDEADBEEF;
		@(posedge tb_CLK);
		sub_test_case 			= "Read Third Block into L2";
		mem_gen_bus_if.rdata  = 32'hDEADBEEF;
		@(posedge tb_CLK);
		sub_test_case 			= "Read Fourth Block into L2";
		mem_gen_bus_if.rdata  = 32'hDEADBEEF;
		wait(~mem_gen_bus_if.ren);
		sub_test_case 			= "Read Blocks to L1";
		mem_gen_bus_if.busy   = 1'b1;
		mem_gen_bus_if.rdata  = 32'hDEADBEEF;
		wait(~proc_gen_bus_if.busy);
		sub_test_case 			= "Write to L1";
		mem_gen_bus_if.busy  = 1'b1;
		@(posedge tb_CLK); #1;
		sub_test_case 			= "Finished";
		proc_gen_bus_if.wen    = 1'b0;
		reset_dut();
		/////////////////////////////////////////////////////////////////////////////////////

		/////////////////////////////////////////////////////////////////////////////////////
		// TEST 05: Fill all of cache
		/////////////////////////////////////////////////////////////////////////////////////
		
		test_number++;
		test_case 	       		= "Fill all of cache";
		sub_test_case 			= "Begin";

		for(integer j=0; j<8; j++)begin
			for(integer i = 0; i < 16; i+=4)begin
				@(posedge tb_CLK);
				$sformat(sub_test_case,"Write Signals Activated L1 Set %d",j);
				proc_gen_bus_if.ren    = 1'b0;
				proc_gen_bus_if.wen    = 1'b1;
				proc_gen_bus_if.addr   = {4'(i/4), 20'd0, 3'(j), 3'b00, 2'b00}; // miss
				proc_gen_bus_if.wdata  = 32'hbeef_0000 + 32'(i);
				wait(mem_gen_bus_if.ren);
				sub_test_case 			= "Go Memory";
				mem_gen_bus_if.rdata  = 32'hda7a_0000 + 32'(i);
				mem_gen_bus_if.busy   = 1'b0;
				@(posedge tb_CLK);
				sub_test_case 			= "Read First Block into L2";
				mem_gen_bus_if.rdata  = 32'hda7a_0000 + 32'(i);
				@(posedge tb_CLK);
				sub_test_case 			= "Read Second Block into L2";
				mem_gen_bus_if.rdata  = 32'hda7a_0000 + 32'(i+1);
				@(posedge tb_CLK);
				sub_test_case 			= "Read Third Block into L2";
				mem_gen_bus_if.rdata  = 32'hda7a_0000 + 32'(i+2);
				@(posedge tb_CLK);
				sub_test_case 			= "Read Fourth Block into L2";
				mem_gen_bus_if.rdata  = 32'hda7a_0000 + 32'(i+3);
				wait(~mem_gen_bus_if.ren);
				sub_test_case 			= "Read Blocks to L1";
				mem_gen_bus_if.busy   = 1'b1;
				mem_gen_bus_if.rdata  = 32'hBADD_BADD;
				wait(~proc_gen_bus_if.busy);
				sub_test_case 			= "Write to L1";
				mem_gen_bus_if.busy  = 1'b1;
				@(posedge tb_CLK); #1;
				sub_test_case 			= {"Finish ", 8'(i)};
				proc_gen_bus_if.wen    = 1'b0;
			end
		end
		reset_dut();
		/////////////////////////////////////////////////////////////////////////////////////


		test_case 				= "END END END END";
		sub_test_case 			= "END END END END";
		#(CLK_PERIOD* 10);
		$finish;
	end

endmodule
