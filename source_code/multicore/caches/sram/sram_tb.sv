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
*	Filename:     sram_tb.sv
*
*	Created by:   Jimmy Mingze Jin
*	Email:        jin357@purdue.edu
*	Date Created: 01/29/2023
*	Description:  basic sram tb
*/

// setup
localparam CLK_PERIOD = 10; 
localparam TB_SRAM_WR_SIZE = 128;
localparam TB_SRAM_HEIGHT = 128;
localparam TB_IS_BIDIRECTIONAL = 0;
typedef logic [TB_SRAM_WR_SIZE-1:0] sram2_entry_size_t; // is this legal

`timescale 1ns/10ps
module sram_tb(); 
	// CLK/nRST
	logic CLK = 0, nRST = 1;
	always #(CLK_PERIOD/2) CLK++;
	
	

	// tb vars
	sram2_entry_size_t wVal, rVal;
	logic REN, WEN;
	logic [$clog2(TB_SRAM_HEIGHT):0] SEL;

	// DUT instance.
	sram  #(.SRAM_WR_SIZE(TB_SRAM_WR_SIZE),
			.SRAM_HEIGHT(TB_SRAM_HEIGHT),
			.IS_BIDIRECTIONAL(TB_IS_BIDIRECTIONAL))
		DUT	(CLK, nRST, wVal, rVal, REN, WEN, SEL);

	task reset_dut; 
		@(negedge CLK) nRST = 1'b0; 
		#(CLK_PERIOD * 2) nRST = 1'b1; 
		@(posedge CLK); 
	endtask

	initial begin
		// set input signals. 
		REN = 0;
		WEN = 0;
		SEL = 0;
		wVal = 0;
		$timeformat(-9, 0, " ns", 20);
		reset_dut();
		#(CLK_PERIOD);

		// try to fill data
		for (SEL = 0; SEL < TB_SRAM_HEIGHT; SEL++) begin
			wVal = 1 + SEL;
			WEN = 1;
			#(CLK_PERIOD * 2);
			WEN = 0;
			#(CLK_PERIOD);
		end

		#(CLK_PERIOD);

		// try to read in order
		for (SEL = 0; SEL < TB_SRAM_HEIGHT; SEL++) begin
			REN = 1;
			#(CLK_PERIOD * 1.5);
			if (rVal != SEL + 1)
				$display("expected %d but got %d at time %4t", SEL + 1, rVal, $time);
			else
				$display("correctly got %d at time %4t", rVal, $time);

			#(CLK_PERIOD * 0.5);
			REN = 0;
			#(CLK_PERIOD);
		end

		#(CLK_PERIOD);

		$finish; 
	end
endmodule