/*
*   Copyright 2022 Purdue University
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
*   Filename:     cocherence_ctrl_tb.sv
*
*   Created by:   Jiahao Xu
*   Email:        xu1392@purdue.edu
*   Date Created: 03/18/2022
*   Description:  Testbench for parametrizable L1/L2 coherence controller.
*/

`timescale 1ns/10ps
//`include "generic_bus_if.vh"
`include "coherence_ctrl_if.vh"
//`include "rv32i_types_pkg.sv"

parameter CLK_PERIOD = 10; 
parameter BLOCK_SIZE = 2; 
parameter L2_LATENCY = 0; 

module cocherence_ctrl_tb(); 
	// clock generation. 
	logic CLK = 0;
	always #(CLK_PERIOD/2) CLK++;  

	// reset signal. 
	logic nRST = 0; 

	// testbench variables.
	integer test_case_num = 0; 
	integer i = 0; 
	string test_case_info = "initial reset"; 
	logic tb_err = 0; 

	// interfaces. 
	coherence_ctrl_if ccif(); 

	// DUT instance.
	coherence_ctrl #(.BLOCK_SIZE(BLOCK_SIZE)) DUT(
		.CLK(CLK), 
		.nRST(nRST), 
		.ccif(ccif)
	); 

	task reset_dut; 
		@(negedge CLK) nRST = 1'b0; 
		#(CLK_PERIOD * 2) nRST = 1'b1; 
		@(posedge CLK); 
	endtask

	task reset_inputs;
		ccif.cc.dREN = 0; 
		ccif.dWEN = '0; 
		ccif.daddr = '0;
		ccif.dstore = '0; 
		ccif.cctrans = '0; 
		ccif.ccwrite = '0; 
		ccif.ccdirty = '0; 
		ccif.cchit = '0; 
		ccif.l2load = 32'hBAD0BAD0; 
		ccif.l2state = L2_FREE;  
	endtask

	task l2_load_word(input word_t l2load);
		wait(ccif.l2REN == 1'b1);  
		ccif.l2state = L2_BUSY; 
		#(L2_LATENCY * CLK_PERIOD); 
		ccif.l2state = L2_ACCESS; 
		ccif.l2load = l2load; 
	endtask

	task l2_store_word(input word_t expected_l2store);
		wait(ccif.l2WEN == 1'b1); 
			// check the word written to l2. 
		if (ccif.l2store != word_t'(expected_l2store)) begin
			tb_err = 1'b1; 
		end
		ccif.l2state = L2_BUSY; 
		#(L2_LATENCY * CLK_PERIOD); 
		ccif.l2state = L2_ACCESS; 
	endtask

	task fwd_word(input word_t data, logic srcid, dstid); 
		ccif.dstore[srcid] = data; 
		ccif.dload[dstid] = ccif.dstore[srcid]; 
		wait(~ccif.dwait[dstid]); 
		//#(CLK_PERIOD); 
	endtask

	task check_dload(input word_t expected_word, logic expected_exbit, int prid);
		wait(ccif.dwait[prid] == 1'b0);
		if (word_t'(ccif.dload[prid]) != expected_word) begin
			$display("E: ccif.dload[%1d]: %8h, but expecting: %8h\n", prid, ccif.dload[prid], expected_word);
			tb_err = 1'b1; 
		end
		if (ccif.ccexclusive[prid] != expected_exbit) begin 
			$display("E: wrong ccif.exclusive[%1d]\n", prid); 
			tb_err = 1'b1; 
		end
		wait(ccif.l2REN == 1'b0);  
		ccif.l2state = L2_FREE; 
	endtask

	initial begin
		// set input signals. 
		reset_inputs(); 
		reset_dut();
		$display("I: Test Case %2d %s passed.", test_case_num, test_case_info); 
        /***************************************************************************
        * LOAD: load the word from L2 to L1 and set the shared bit (E/S)           *
        ****************************************************************************/
		
		test_case_num ++; // test case 1
		test_case_info = "I->E, -/-";
		ccif.cctrans[0] = 1'b1; 
		ccif.dREN[0] = 1'b1;
		ccif.cchit[1] = 1'b0; 
		for (i=0; i<BLOCK_SIZE; i++) begin
			l2_load_word(word_t'(i+1)); 
			check_dload(word_t'(i+1), 1, 0); 
		end
		assert (~tb_err) $display("I: Test Case %2d %s passed.", test_case_num, test_case_info); 
			else $error("E: Test Case %2d %s failed.", test_case_num, test_case_info);
		reset_inputs(); 
		#(5*CLK_PERIOD); 

		test_case_num ++; 	// test case 2
		test_case_info = "I->S, E->S";
		ccif.cctrans = 2'b11; 
		ccif.dREN[0] = 1'b1;
		ccif.cchit[1] = 1'b1; 
		for (i=0; i<BLOCK_SIZE; i++) begin
			l2_load_word(word_t'(i+1)); 
			check_dload(word_t'(i+1), 0, 0); 
		end
		assert (~tb_err) $display("I: Test Case %2d %s passed.", test_case_num, test_case_info); 
			else $error("E: Test Case %2d %s failed.", test_case_num, test_case_info);
		reset_inputs(); 
		#(5*CLK_PERIOD); 

		test_case_num ++; 	// test case 3
		test_case_info = "I->S, S->S";
		ccif.cctrans[0] = 1'b1; 
		ccif.dREN[0] = 1'b1;
		ccif.cchit[1] = 1'b1; 
		for (i=0; i<BLOCK_SIZE; i++) begin
			l2_load_word(word_t'(i+1)); 
			check_dload(word_t'(i+1), 0, 0); 
		end
		assert (~tb_err) $display("I: Test Case %2d %s passed.", test_case_num, test_case_info); 
			else $error("E: Test Case %2d %s failed.", test_case_num, test_case_info);
		reset_inputs(); 
		#(5*CLK_PERIOD); 
        /***************************************************************************
        * LOADEX: this core has a write request. load from L2, invalidate other copies.
        ****************************************************************************/

		test_case_num ++; 	//test case 4
		test_case_info = "I->M, S/E->I";
		ccif.cctrans = 2'b11; 
		ccif.ccwrite[0] = 1'b1; 
		ccif.dREN[0] = 1'b1;
		ccif.cchit[1] = 1'b1; 
		for (i=0; i<BLOCK_SIZE; i++) begin
			l2_load_word(word_t'(i+1)); 
			check_dload(word_t'(i+1), 1, 0); 
		end
		wait(ccif.ccinv[1]); // LOADEX will invalidate other copies. 
		assert (~tb_err) $display("I: Test Case %2d %s passed.", test_case_num, test_case_info); 
			else $error("E: Test Case %2d %s failed.", test_case_num, test_case_info);
		reset_inputs(); 
		#(5*CLK_PERIOD); 

		/***************************************************************************
        * FWDWB: cache-to-cache transfer, update the L2 copy, happens only when    *
        *        there is M->S (general bus read from other core).                 *
        ****************************************************************************/
		test_case_num ++; 	//test case 5
		test_case_info = "I->S, M->S";
		ccif.cctrans = 2'b11; 
		ccif.cchit[1] = 1'b1; 
		ccif.ccdirty[1] = 1'b1; 
		ccif.dREN[0] = 1'b1;
		
		for (i=0; i<BLOCK_SIZE; i++) begin
			fwd_word(word_t'(i+1), 1, 0); 
			l2_store_word(word_t'(i+1));
			#(CLK_PERIOD * 2);
		end
		assert (~tb_err) $display("I: Test Case %2d %s passed.", test_case_num, test_case_info); 
			else $error("E: Test Case %2d %s failed.", test_case_num, test_case_info);
		reset_inputs(); 
		#(5*CLK_PERIOD); 

        /***************************************************************************
        * FWDEX: cache-to-cache transfer, not update the L2 copy, invalidate other 
        *        copies. happens when I->M, M->I
        ****************************************************************************/
		test_case_num ++; 	//test case 6
		test_case_info = "I->M, M->I";
		ccif.cctrans = 2'b11; 
		ccif.ccwrite[0] = 1'b1; 
		ccif.cchit[1] = 1'b1; 
		ccif.ccdirty[1] = 1'b1; 
		ccif.dREN[0] = 1'b1; 
		for (i=0; i<BLOCK_SIZE; i++) begin
			fwd_word(word_t'(i+1), 1, 0); 
			wait(ccif.ccinv[1]); 
		end
		assert (~tb_err) $display("I: Test Case %2d %s passed.", test_case_num, test_case_info); 
			else $error("E: Test Case %2d %s failed.", test_case_num, test_case_info);
		reset_inputs(); 
		#(5*CLK_PERIOD); 

        /***************************************************************************
        * INV: write hit from S->M, invalidate other copy, no bus read. 
        ****************************************************************************/
		test_case_num ++; 	//test case 7
		test_case_info = "S->M, S->I";
		ccif.cctrans = 2'b11; 
		ccif.ccwrite[0] = 1'b1; 
		ccif.cchit[1] = 1'b1; 
		ccif.ccdirty[1] = 1'b0; 
		wait(ccif.ccinv[1]); 
		assert (~tb_err) $display("I: Test Case %2d %s passed.", test_case_num, test_case_info); 
			else $error("E: Test Case %2d %s failed.", test_case_num, test_case_info);
		$finish; 
	end
endmodule