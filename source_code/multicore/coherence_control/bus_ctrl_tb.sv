/*
*	Copyright 2022 Purdue University
*		
*	Licensed under the Apache License, Version 2.0 (the "License");
*	you may not use this file except in compliance with the License.
*	You may obtain a copy of the License at
*		
*	    http://www.apache.org/licenses/LICENSE-2.0
*		
*	Unless required by applicable law or agreed to in writing, software
*	distributed under the License is distributed on an "AS IS" BASIS,
*	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*	See the License for the specific language governing permissions and
*	limitations under the License.
*
*
*	Filename:     bus_ctrl.sv
*
*	Created by:   Jimmy Mingze Jin
*	Email:        jin357@purdue.edu
*	Date Created: 11/01/2022
*	Description:  Bus controller basic TB
*/

`timescale 1ns/10ps
`include "bus_ctrl_if.vh"

localparam CLK_PERIOD = 10; 
localparam TB_BLOCK_SIZE = BLOCK_SIZE; 
localparam L2_LATENCY = 4; 
localparam TB_CACHES = CACHES;
localparam OUTPUT_CHECK_COUNT = 1;
localparam DADDR = 19;
localparam TB_CPU_ID_LENGTH = $clog2(TB_CACHES);

module bus_ctrl_tb(); 
	// CLK/nRST
	logic CLK = 0, nRST = 1;
	always #(CLK_PERIOD/2) CLK++;

	// testbench variables
	integer test_case_num = 0; 
	integer i = 0; 
	string test_case_info = "initial reset"; 
	logic tb_err = 0;
	logic [TB_CPU_ID_LENGTH-1:0] supplier = 0;

	// interfaces. 
	bus_ctrl_if ccif(); 

	// DUT instance.
	bus_ctrl #(.BLOCK_SIZE(TB_BLOCK_SIZE), .CACHES(TB_CACHES)) DUT(
		.CLK(CLK), 
		.nRST(nRST), 
		.ccif(ccif)
	); 

	// resets the DUT
	task reset_dut; 
		@(negedge CLK) nRST = 1'b0; 
		#(CLK_PERIOD * 2) nRST = 1'b1; 
		@(posedge CLK); 
	endtask

	// initialize to inactive for all inputs to bus
	task reset_stimuli;
		ccif.dREN = 0; 
		ccif.dWEN = '0; 
		ccif.daddr = '0;
		ccif.dstore = 64'hDEADBEEF; 
		// ccif.cctrans = '0; 
		ccif.ccwrite = '0; 
		ccif.ccsnoophit = '0; 
		ccif.ccIsPresent = '0;
		ccif.ccsnoopdone = '1;
		ccif.ccdirty = '0;
		ccif.l2load = 64'hDEADBEEF;
		ccif.l2state = L2_FREE;
		tb_err = 0;
		#(CLK_PERIOD * 2);
	endtask

	/*
	* simulates reading a word and placing it onto the bus
	* given a 64 bit longWord, 
	*/
	task l2_load(input transfer_width_t l2load);
		wait(ccif.l2REN == 1'b1);
		ccif.l2state = L2_BUSY; 
		#(L2_LATENCY * CLK_PERIOD); 
		ccif.l2state = L2_ACCESS; 
		ccif.l2load = l2load;
		wait(ccif.l2REN == 1'b0);
			ccif.l2state = L2_FREE; 
	endtask

	/*
	* from Jiahao's coherence_ctrl_tb
	* given a 64 bit longWord, 
	* simulates putting a particular longWord from bus to L1
	*/
	task cachetransfer(input transfer_width_t data, logic [TB_CPU_ID_LENGTH-1:0] srcid, dstid); 
		ccif.dstore[srcid] = data;
		ccif.ccsnoophit[srcid] = 1;
		wait(~ccif.dwait[dstid]);
		#(CLK_PERIOD/2);
		if (ccif.dload[dstid] != data)
			tb_err = 1'b1;
		#(CLK_PERIOD/2);
	endtask

	/*
	* from Jiahao's coherence_ctrl_tb
	* given a 64 bit longWord, 
	* checks a load based on expected stimuli
	*/
	task check_dload(input transfer_width_t expected_data, logic expected_ccexclusive, logic [TB_CPU_ID_LENGTH-1:0] prid);
		wait(~ccif.dwait[prid]);
		if (transfer_width_t'(ccif.dload[prid]) != expected_data) begin
			$display("E: ccif.dload[%1d]: %8h, but expecting: %8h\n", prid, ccif.dload[prid], expected_data);
			tb_err = 1'b1; 
		end
		if (ccif.ccexclusive[prid] != expected_ccexclusive) begin 
			$display("E: wrong ccif.ccexclusive[%1d]\n", prid); 
			tb_err = 1'b1; 
		end
	endtask

	task ensure_invalidation;
		#(CLK_PERIOD * 2.5);	// checking in the middle of clk
		if (ccif.ccinv != ~cache_bitvec_t'(1)) begin
			$display("E: ccif.ccinv: %8h, but expecting: %8h\n", ccif.ccinv, ~int'(1));
			tb_err = 1'b1;
		end
	endtask

	task check_errors;
		assert (~tb_err) $display("I: Test Case %2d at time %4t %s passed.", test_case_num, $time, test_case_info); 
			else $error("E: Test Case %2d at time %4t %s failed.", test_case_num, $time, test_case_info);
	endtask

	/*
	* based on Jiahao's coherence_ctrl_tb
	* given a 64 bit longWord, 
	* simulates putting a particular longWord from bus to L2
	* analogous to a cache-eviction
	*/
	task l2_store(input transfer_width_t expected_l2store);
		wait(ccif.l2WEN == 1'b1);
		if (ccif.l2store != word_t'(expected_l2store))
			tb_err = 1'b1; 
		ccif.l2state = L2_BUSY; 
		#(L2_LATENCY * CLK_PERIOD); 
		ccif.l2state = L2_ACCESS;
		#(CLK_PERIOD);			// stay in access for a clk
	endtask

	

	initial begin
		// set input signals. 
		reset_stimuli();
		$timeformat(-9, 0, " ns", 20);
		reset_dut();
		$display("I: Test Case %2d %s passed.", test_case_num, test_case_info); 

    /***************************************************************************
    * Set 1: Simulate the behaviour of 1 processor's read miss  			   *
    ****************************************************************************/
		// all other caches do not have the data (no supplier)
		reset_stimuli();
		test_case_num++;
		test_case_info = "I -> E, no transition";
		// set stimuli
		// ccif.cctrans[0] = 1;
		ccif.dREN[0] = 1;
		ccif.ccsnoophit = '0;
		ccif.daddr[0] = word_t'(DADDR);
		// go through and check outputs
		for (i = 0; i < OUTPUT_CHECK_COUNT; i++) begin
			l2_load(transfer_width_t'(i + 1));
			check_dload(transfer_width_t'(i + 1), 1, 0);
		end
		check_errors();
		
		// one other cache has the data (supplier = E)
		reset_stimuli();
		test_case_num++;
		test_case_info = "I -> S, E -> S";
		// set stimuli
		// ccif.cctrans[0] = 1;
		ccif.dREN[0] = 1;
		ccif.ccsnoophit = '0;
		ccif.daddr[0] = word_t'(DADDR);
		// go through and check outputs
		for (i = 0; i < OUTPUT_CHECK_COUNT; i++) begin
			supplier = (!(i % TB_CACHES) ? 1 : (i % TB_CACHES));
			ccif.ccIsPresent[supplier] = 1;
			cachetransfer(transfer_width_t'(i + 1), supplier, 0);
			check_dload(transfer_width_t'(i + 1), 0, 0);
		end
		check_errors();

		// one other cache has the data (supplier = M)
		reset_stimuli();
		test_case_num++;
		test_case_info = "I -> S, M -> S";
		// set stimuli
		// ccif.cctrans[0] = 1;
		ccif.dREN[0] = 1;
		ccif.ccsnoophit = '0;
		ccif.daddr[0] = word_t'(DADDR);
		// go through and check outputs
		for (i = 0; i < OUTPUT_CHECK_COUNT; i++) begin
			supplier = (!(i % TB_CACHES) ? 1 : (i % TB_CACHES));
			ccif.ccdirty[supplier] = 1;
			ccif.ccIsPresent[supplier] = 1;
			cachetransfer(transfer_width_t'(i + 1), supplier, 0);
			check_dload(transfer_width_t'(i + 1), 0, 0);
			l2_store(transfer_width_t'(i + 1));
		end
		check_errors();

		// multiple other caches has the data (other caches = S)
		reset_stimuli();
		test_case_num++;
		test_case_info = "I -> S, no transition";
		// set stimuli
		// ccif.cctrans[0] = 1;
		ccif.dREN[0] = 1;
		ccif.ccsnoophit = '0;
		ccif.dstore[1] = 5;
		ccif.daddr[0] = word_t'(DADDR);
		// go through and check outputs
		for (i = 0; i < OUTPUT_CHECK_COUNT; i++) begin
			ccif.ccIsPresent = 4'b1100;
			l2_load(transfer_width_t'(i + 1));
			check_dload(transfer_width_t'(i + 1), 0, 0);
		end
		check_errors();

    /***************************************************************************
    * Set 2: Simulate the behaviour of 1 processor's write miss; no eviction   *
    ****************************************************************************/
		// all other caches do not have the data (no supplier)
		reset_stimuli();
		test_case_num++;
		test_case_info = "I -> M, no transition";
		// set stimuli
		// ccif.cctrans[0] = 1;
		ccif.dREN[0] = 1;
		ccif.ccsnoophit = '0;
		ccif.daddr[0] = word_t'(DADDR);
		ccif.ccwrite[0] = 1;
		// go through and check outputs
		for (i = 0; i < OUTPUT_CHECK_COUNT; i++) begin
			fork
				ensure_invalidation();
				begin
					l2_load(transfer_width_t'(i + 1));
					check_dload(transfer_width_t'(i + 1), 1, 0);		// need to check ccinv
				end
			join
		end
		check_errors();

		// one other cache has the data (supplier = E)
		reset_stimuli();
		test_case_num++;
		test_case_info = "I -> M, E -> I";
		// set stimuli
		// ccif.cctrans[0] = 1;
		ccif.dREN[0] = 1;
		ccif.ccsnoophit = '0;
		ccif.daddr[0] = word_t'(DADDR);
		ccif.ccwrite[0] = 1;
		// go through and check outputs
		for (i = 0; i < OUTPUT_CHECK_COUNT; i++) begin
			fork
				begin
					supplier = (!(i % TB_CACHES) ? 1 : (i % TB_CACHES));
					ccif.ccIsPresent[supplier] = 1;
					cachetransfer(transfer_width_t'(i + 1), supplier, 0);
					check_dload(transfer_width_t'(i + 1), 0, 0);
				end
				ensure_invalidation();
			join
		end

		// one other cache has the data (supplier = M)
		reset_stimuli();
		test_case_num++;
		test_case_info = "I -> M, M -> I";
		// set stimuli
		// ccif.cctrans[0] = 1;
		ccif.dREN[0] = 1;
		ccif.ccsnoophit = '0;
		ccif.daddr[0] = word_t'(DADDR);
		ccif.ccwrite[0] = 1;
		// go through and check outputs
		for (i = 0; i < OUTPUT_CHECK_COUNT; i++) begin
			fork
				begin
					supplier = (!(i % TB_CACHES) ? 1 : (i % TB_CACHES));
					ccif.ccsnoophit[supplier] = 1;
					ccif.ccdirty[supplier] = 1;
					ccif.ccIsPresent[supplier] = 1;
					cachetransfer(transfer_width_t'(i + 1), supplier, 0);
					check_dload(transfer_width_t'(i + 1), 0, 0);
				end
				ensure_invalidation();
			join
		end
		check_errors();

		// multiple other caches has the data (other caches = S)
		reset_stimuli();
		test_case_num++;
		test_case_info = "I -> M, S -> I";
		// set stimuli
		// ccif.cctrans[0] = 1;
		ccif.dREN[0] = 1;
		ccif.ccsnoophit = '0;
		ccif.daddr[0] = word_t'(DADDR);
		ccif.ccwrite[0] = 1;
		// go through and check outputs
		for (i = 0; i < OUTPUT_CHECK_COUNT; i++) begin
			fork
				begin
					ccif.ccIsPresent[supplier] = 1;
					l2_load(transfer_width_t'(i + 1));
					check_dload(transfer_width_t'(i + 1), 0, 0);		// need to check ccinv
				end
				ensure_invalidation();
			join
		end
		check_errors();

		// cache has data in shared (special write_miss)
		reset_stimuli();
		test_case_num++;
		test_case_info = "S -> M, x -> I";
		// set stimuli
		// ccif.cctrans[0] = 1;
		ccif.dREN[0] = 0;				// indicate that we are going S -> M 
		ccif.ccsnoophit = '0;			// does not matter
		ccif.daddr[0] = word_t'(DADDR);
		ccif.ccwrite[0] = 1;

		// check invalidation
		ensure_invalidation();
		check_errors();


	/***************************************************************************
    * Set 3: Simulate the behaviour of 1 processor's eviction                  *  
    ****************************************************************************/
		// verify that we go through and write our data
		reset_stimuli();
		test_case_num++;
		test_case_info = "cache eviction or flush";
		// evictions from each cache
		for (i = 0; i < OUTPUT_CHECK_COUNT; i++) begin
			supplier = i % CACHES; 	// actually just requester
			// ccif.cctrans[supplier] = 1;
			ccif.dWEN[supplier] = 1;				// writeback 
			ccif.daddr[supplier] = word_t'(DADDR);
			ccif.dstore[supplier] = word_t'(i + 1);
			l2_store(transfer_width_t'(i + 1));
		end
		check_errors();

    /***************************************************************************
    * Set 4: Simulate the behaviour of arbitration of concurrent requests      *
    ****************************************************************************/

		// todo, but unsure what arbitration to go with so its kinda just take the MSB for now :D
		// LRU can be done with a queue-like struct (O((n-1)!)) or something; seems to scale pretty badly, but we also proly wont have more than
		// simulate bus prioritizing higher numbers for dREN
		reset_stimuli();
		test_case_num++;
		test_case_info = "arbitration between multiple read requests";
		#(CLK_PERIOD);
		check_errors();

		// simulate bus prioritizing higher numbers for dWEN
		reset_stimuli();
		test_case_num++;
		test_case_info = "arbitration between multiple write requests";
		#(CLK_PERIOD);
		check_errors();

		// simulate bus choosing eviction above other bus transactions
		reset_stimuli();
		test_case_num++;
		test_case_info = "arbitration between multiple read requests and a write request";
		#(CLK_PERIOD);
		check_errors();

		$finish; 
	end
endmodule