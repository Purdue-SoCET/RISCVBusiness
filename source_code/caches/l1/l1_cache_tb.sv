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
`include "generic_bus_if.vh"

`timescale 1ns/10ps
module l1_cache_tb(); 
	// CLK/nRST
	logic CLK = 0, nRST = 1;
	always #(CLK_PERIOD/2) CLK++;
	
	

	// tb vars
    logic tb_clear, tb_flush, tb_clear_done, tb_flush_done;
    generic_bus_if proc_gen_bus_if();
    generic_bus_if mem_gen_bus_if();

	// DUT instance.

    l1_cache #
        DUT (CLK, nRST, .mem_gen_bus_if(mem_gen_bus_if), .proc_gen_bus_if(proc_gen_bus_if))

	task reset_dut; 
		@(negedge CLK) nRST = 1'b0; 
		#(CLK_PERIOD * 2) nRST = 1'b1; 
		@(posedge CLK); 
	endtask

	initial begin

		$finish; 
	end
endmodule