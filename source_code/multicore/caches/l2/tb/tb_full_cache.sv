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

	//L1 Instr signals
	logic l1_iclear;
	logic l1_iclear_done;
	logic l1_iflush;
	logic l1_iflush_done;

	//L1 Data signals
	logic l1_dclear;
	logic l1_dclear_done;
	logic l1_dflush;
	logic l1_dflush_done;

	//L2 signals
	logic l2_clear;
	logic l2_clear_done;
	logic l2_flush;
	logic l2_flush_done;

    generic_bus_if icache_bus(); // Between ICache and Memory Arbiter
    generic_bus_if dcache_bus(); // Between DCache and Memory Arbiter
    generic_bus_if arbiter_bus(); // Between Arbiter and L2
	generic_bus_if proc_inst_bus(); //From processor to l1-icache
	generic_bus_if proc_data_bus(); //From processor to l1-dcache
	generic_bus_if mem_gen_bus_if(); // From L2 to Memory Controller

	// Clock generation block	
	always begin
		tb_CLK = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_CLK = 1'b1;
		#(CLK_PERIOD/2.0);
  	end
	
	// L1 Cache Portmap
	l1_cache  #	(.CACHE_SIZE(1024), .BLOCK_SIZE(2), .ASSOC(2), .NONCACHE_START_ADDR(32'h8000_0000)) 
		 icache (.CLK(tb_CLK), .nRST(tb_nRST),
				 .clear(l1_iclear), .clear_done(l1_iclear_done),
				 .flush(l1_iflush), .flush_done(l1_iflush_done),
				 .mem_gen_bus_if(icache_bus),
				 .proc_gen_bus_if(proc_inst_bus));

	// L1 Cache Portmap
	l1_cache  #	(.CACHE_SIZE(1024), .BLOCK_SIZE(2),  .ASSOC(2),  .NONCACHE_START_ADDR(32'h8000_0000)) 
		 dcache (.CLK(tb_CLK), .nRST(tb_nRST),
				 .clear(l1_dclear), .clear_done(l1_dclear_done),
				 .flush(l1_dflush), .flush_done(l1_dflush_done),
				 .mem_gen_bus_if(dcache_bus),
				 .proc_gen_bus_if(proc_data_bus));

    memory_arbiter arbiter 	(.CLK(tb_CLK), .nRST(tb_nRST),
							 .icache_if(icache_bus), // Connection to I-Cache
							 .dcache_if(dcache_bus), // Connection to D-Cache
							 .mem_arb_if(arbiter_bus)); //Connection to L2 Cache

	// L2 Cache Portmap
	l2_cache  #	(.CACHE_SIZE(16384), .BLOCK_SIZE(4), .ASSOC(4), .NONCACHE_START_ADDR(32'h8000_0000))
			 l2 (.CLK(tb_CLK), .nRST(tb_nRST),
				 .clear(l2_clear), .clear_done(l2_clear_done),
				 .flush(l2_flush), .flush_done(l2_flush_done),
				 .mem_gen_bus_if(mem_gen_bus_if),
				 .proc_gen_bus_if(arbiter_bus));


	task reset;
		begin
		tb_nRST = 1'b0;
		l1_iclear = 1'b0;
		l1_iflush = 1'b0;
		l1_dclear = 1'b0;
		l1_dflush = 1'b0;
		l2_clear = 1'b0;
		l2_flush = 1'b0;
		
		proc_inst_bus.rdata = '0;
		proc_inst_bus.ren = 1'b0;
		proc_inst_bus.wen = 1'b0;
		proc_inst_bus.wdata = '0;
		proc_inst_bus.byte_en = 4'hf;
		proc_inst_bus.addr = 32'h0000_0000;

		proc_data_bus.rdata = '0;
		proc_data_bus.ren = 1'b0;
		proc_data_bus.wen = 1'b0;
		proc_data_bus.wdata = '0;
		proc_data_bus.byte_en = 4'hf;
		proc_data_bus.addr = 32'h0000_0000;

		mem_gen_bus_if.rdata 	 = '0;
		mem_gen_bus_if.busy = 1'b1;
		@(posedge tb_CLK);
		tb_nRST = 1'b1;
		@(posedge tb_CLK);
		@(posedge tb_CLK);
		end
	endtask

	initial begin
		//--------------------------------------------------------------------------------------
		// Test 00: Power On Reset
		//--------------------------------------------------------------------------------------
		test_number = 0;
		test_case = "Power-On and Reset";
		sub_test_case = "";
		reset();
		//--------------------------------------------------------------------------------------

		//--------------------------------------------------------------------------------------
		// Test 01: Processor Read Instruction
		//--------------------------------------------------------------------------------------
		test_number ++;
		test_case = "I$ Read";

		@(negedge tb_CLK);
		proc_inst_bus.addr = 32'h0000_1000;
		proc_inst_bus.ren = 1'b1;
		wait(mem_gen_bus_if.ren);
		mem_gen_bus_if.busy = '1;
		mem_gen_bus_if.rdata = 32'h0011_1100;
		#(5 * CLK_PERIOD);
		@(negedge tb_CLK);
		mem_gen_bus_if.busy = '0;
		@(posedge tb_CLK); #1;
		mem_gen_bus_if.busy = '1;
		mem_gen_bus_if.rdata = 32'h0022_2200;
		#(5 * CLK_PERIOD);
		@(negedge tb_CLK);
		mem_gen_bus_if.busy = '0;
		@(posedge tb_CLK); #1;
		mem_gen_bus_if.busy = '1;
		mem_gen_bus_if.rdata = 32'h0033_3300;
		#(5 * CLK_PERIOD);
		@(negedge tb_CLK);
		mem_gen_bus_if.busy = '0;
		@(posedge tb_CLK); #1;
		mem_gen_bus_if.busy = '1;
		mem_gen_bus_if.rdata = 32'h0044_4400;
		#(5 * CLK_PERIOD);
		@(negedge tb_CLK);
		mem_gen_bus_if.busy = '0;
		@(posedge tb_CLK); #1;
		mem_gen_bus_if.busy = '1;
		wait(~proc_inst_bus.busy);
		proc_inst_bus.addr = 32'h0000_0000;
		proc_inst_bus.ren = 1'b0;
		#1;
		assert(proc_inst_bus.rdata == 32'h0011_1100) else $error("Testcase %s:\nReceived incorrect data", test_case);
		#(CLK_PERIOD * 5);
		//--------------------------------------------------------------------------------------

		//--------------------------------------------------------------------------------------
		// Test 02: Processor D$ Read
		//--------------------------------------------------------------------------------------
		test_number ++;
		test_case = "D$ Read";

		@(negedge tb_CLK);
		proc_data_bus.addr = 32'h0500_0000;
		proc_data_bus.ren = 1'b1;
		wait(mem_gen_bus_if.ren);
		mem_gen_bus_if.busy = '1;
		mem_gen_bus_if.rdata = 32'h1111_1111;
		#(5 * CLK_PERIOD);
		@(negedge tb_CLK);
		mem_gen_bus_if.busy = '0;
		@(posedge tb_CLK); #1;
		mem_gen_bus_if.busy = '1;
		mem_gen_bus_if.rdata = 32'h2222_2222;
		#(5 * CLK_PERIOD);
		@(negedge tb_CLK);
		mem_gen_bus_if.busy = '0;
		@(posedge tb_CLK); #1;
		mem_gen_bus_if.busy = '1;
		mem_gen_bus_if.rdata = 32'h3333_3333;
		#(5 * CLK_PERIOD);
		@(negedge tb_CLK);
		mem_gen_bus_if.busy = '0;
		@(posedge tb_CLK); #1;
		mem_gen_bus_if.busy = '1;
		mem_gen_bus_if.rdata = 32'h4444_4444;
		#(5 * CLK_PERIOD);
		@(negedge tb_CLK);
		mem_gen_bus_if.busy = '0;
		@(posedge tb_CLK); #1;
		mem_gen_bus_if.busy = '1;
		wait(~proc_data_bus.busy);
		proc_data_bus.addr = 32'h0000_0000;
		proc_data_bus.ren = 1'b0;
		#1;
		assert(proc_data_bus.rdata == 32'h1111_1111) else $error("Testcase %s:\nReceived incorrect data", test_case);

		#(CLK_PERIOD * 5);
		//--------------------------------------------------------------------------------------

		//--------------------------------------------------------------------------------------
		// Test 03: D$ Write Miss
		//--------------------------------------------------------------------------------------
		test_number ++;
		test_case = "D$ Write Miss";

		@(negedge tb_CLK);
		proc_data_bus.addr = 32'h0600_0000;
		proc_data_bus.wen = 1'b1;
		proc_data_bus.wdata = 32'h1111_1111;
		wait(mem_gen_bus_if.ren);
		mem_gen_bus_if.busy = '1;
		mem_gen_bus_if.rdata = 32'hbad00bad;
		#(5 * CLK_PERIOD);
		@(negedge tb_CLK);
		mem_gen_bus_if.busy = '0;
		@(posedge tb_CLK); #1;
		mem_gen_bus_if.busy = '1;
		mem_gen_bus_if.rdata = 32'h2222_2222;
		#(5 * CLK_PERIOD);
		@(negedge tb_CLK);
		mem_gen_bus_if.busy = '0;
		@(posedge tb_CLK); #1;
		mem_gen_bus_if.busy = '1;
		mem_gen_bus_if.rdata = 32'h3333_3333;
		#(5 * CLK_PERIOD);
		@(negedge tb_CLK);
		mem_gen_bus_if.busy = '0;
		@(posedge tb_CLK); #1;
		mem_gen_bus_if.busy = '1;
		mem_gen_bus_if.rdata = 32'h4444_4444;
		#(5 * CLK_PERIOD);
		@(negedge tb_CLK);
		mem_gen_bus_if.busy = '0;
		@(posedge tb_CLK); #1;
		mem_gen_bus_if.busy = '1;
		wait(~proc_data_bus.busy);

		@(posedge tb_CLK); #1;

		proc_data_bus.addr = 32'h0000_0000;
		proc_data_bus.wen = 1'b0;
		#1;

		#(CLK_PERIOD * 5);
		//--------------------------------------------------------------------------------------


		//--------------------------------------------------------------------------------------
		// Test 04: Write to Each I$ Set
		//--------------------------------------------------------------------------------------
		test_number ++;
		test_case = "Write to Each I$ Set";
		reset();


		for(integer i = 0; i < 8; i+=2)begin
			sub_test_case = "L2 Miss";
			@(negedge tb_CLK);
			proc_inst_bus.addr = {26'h0, 3'(i),3'h0};
			proc_inst_bus.ren = 1'b1;
			wait(mem_gen_bus_if.ren);
			mem_gen_bus_if.busy = '1; mem_gen_bus_if.rdata = 32'((i*4)/2 + 1);
			#(5 * CLK_PERIOD);
			@(negedge tb_CLK);
			mem_gen_bus_if.busy = '0;
			@(posedge tb_CLK); #1;
			mem_gen_bus_if.busy = '1; mem_gen_bus_if.rdata = 32'((i*4)/2 + 2); #(5 * CLK_PERIOD);
			@(negedge tb_CLK);
			mem_gen_bus_if.busy = '0;
			@(posedge tb_CLK); #1;
			mem_gen_bus_if.busy = '1; mem_gen_bus_if.rdata = 32'((i*4)/2 + 3); #(5 * CLK_PERIOD);
			@(negedge tb_CLK);
			mem_gen_bus_if.busy = '0;
			@(posedge tb_CLK); #1;
			mem_gen_bus_if.busy = '1; mem_gen_bus_if.rdata = 32'((i*4)/2 + 4); #(5 * CLK_PERIOD);
			@(negedge tb_CLK);
			mem_gen_bus_if.busy = '0;
			@(posedge tb_CLK); #1;
			mem_gen_bus_if.busy = '1;
			wait(~proc_inst_bus.busy);
			proc_inst_bus.addr = 32'h0000_0000;
			proc_inst_bus.ren = 1'b0;
			#1;
			assert(proc_inst_bus.rdata == 32'((i*4)/2 +1)) else $error("############################\nTestcase %s:\nAccessing %h\nReceived incorrect data\nExpected: %h\nReceived %h\n############################\n", test_case, {26'h0, 3'(i),3'h0}, 32'(i+1), proc_inst_bus.rdata);
			#(CLK_PERIOD * 3);
			
			sub_test_case = "L2 Hit";
			@(negedge tb_CLK);
			proc_inst_bus.addr = {26'h0, 3'((i+1)),3'h0};
			proc_inst_bus.ren = 1'b1;
			wait(arbiter_bus.ren);
			wait(~arbiter_bus.ren);
			wait(~proc_inst_bus.busy);
			proc_inst_bus.addr = 32'h0000_0000;
			proc_inst_bus.ren = 1'b0;
			#1;
			assert(proc_inst_bus.rdata == 32'((i*4)/2 +3)) else $error("############################\nTestcase %s:\nAccessing %h\nReceived incorrect data\nExpected: %h\nReceived %h\n############################\n", test_case, {26'h0, 3'(i+1),3'h0},32'(i+3), proc_inst_bus.rdata);
		end

		sub_test_case = "IDLE";		
		#(5 * CLK_PERIOD);
		sub_test_case = "I$ readout W/ Constant Hits";
		for(integer i = 0; i < 32; i+=4)begin
			@(negedge tb_CLK);
			proc_inst_bus.addr = {26'h0, 6'(i)}; proc_inst_bus.ren = 1'b1;
			@(posedge tb_CLK); 
			#1;
			wait(~proc_inst_bus.busy);
			proc_inst_bus.addr = 32'h0000_0000; proc_inst_bus.ren = 1'b0;
			#1;
			assert(proc_inst_bus.rdata == 32'((i/4)+1)) else $error("############################\nTestcase %s:\nAccessing %h\nReceived incorrect data\nExpected: %h\nReceived %h\n############################\n",test_case, 32'(i),32'((i/4)+1), proc_inst_bus.rdata);
		end
		//--------------------------------------------------------------------------------------
		
		#(5 * CLK_PERIOD);
		$finish();
	end


endmodule
