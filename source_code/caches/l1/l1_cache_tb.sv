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
*	Filename:     l1_cache_tb.sv
*
*	Created by:   Pranav Srisankar
*	Email:        psrisank@purdue.edu
*	Date Created: 04/10/2024
*	Description:  basic l1 cache tb
*/

// setup
localparam CLK_PERIOD = 10;
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
	string test;

	// DUT instance.

    l1_cache #(.NUM_HARTS(2)) DUT (.CLK(CLK), .nRST(nRST), .mem_gen_bus_if(mem_gen_bus_if), .proc_gen_bus_if(proc_gen_bus_if));

	task reset_dut; 
		@(negedge CLK) nRST = 1'b0; 
		#(CLK_PERIOD * 2) nRST = 1'b1; 
		@(posedge CLK); 
	endtask

	initial begin
		test = "startup";
        proc_gen_bus_if.addr = 32'h00000000;
        proc_gen_bus_if.ren = 1'b0;
        proc_gen_bus_if.wen = 1'b0;
		mem_gen_bus_if.busy = 1'b1;
		$timeformat(-9, 0, " ns", 20);
		reset_dut();


        for (int i = 0; i < 18; i++) begin
            #(CLK_PERIOD);
        end
        
		test = "read address 10";
		proc_gen_bus_if.addr = 32'h00000010;
		proc_gen_bus_if.ren = 1'b1;
		proc_gen_bus_if.wen = 1'b0;
		proc_gen_bus_if.wdata = '0;

		#(CLK_PERIOD * 1);

		test = "read address 18";
        proc_gen_bus_if.addr = 32'h00000018;
        proc_gen_bus_if.ren = 1'b1;
        proc_gen_bus_if.wen = 1'b0;
		proc_gen_bus_if.wdata = '0;

		#(CLK_PERIOD * 2);

		test = "testing done beep boop";
        proc_gen_bus_if.addr = 32'hFFFFFFFF;
        proc_gen_bus_if.ren = 1'b0;
        proc_gen_bus_if.wen = 1'b0;
		proc_gen_bus_if.wdata = '0;

		#(CLK_PERIOD);

		for (int i = 0; i < 16; i++) begin
			mem_gen_bus_if.busy = ~mem_gen_bus_if.busy;
			if (~mem_gen_bus_if.busy) begin
				mem_gen_bus_if.rdata = 32'hDEADBEEF;
			end
			else begin
				mem_gen_bus_if.rdata = 32'hBAD0BAD0;
			end
			#(CLK_PERIOD);
		end

		$finish;


		test = "read address DEADBEEF";
        proc_gen_bus_if.addr = 32'hDEADBEEF;
        proc_gen_bus_if.ren = 1'b0;
        proc_gen_bus_if.wen = 1'b0;
		proc_gen_bus_if.wdata = '0;
		

		for (int i = 0; i < 6; i++) begin
			mem_gen_bus_if.busy = ~mem_gen_bus_if.busy;
			#(CLK_PERIOD);
		end

		// #(CLK_PERIOD * 4);

		// for (int i = 0; i < 6; i++) begin
		// 	mem_gen_bus_if.busy = ~mem_gen_bus_if.busy;
		// 	#(CLK_PERIOD);
		// end

		// proc_gen_bus_if.addr = 32'h0000F000;
		// proc_gen_bus_if.ren = 1'b1;
		// proc_gen_bus_if.wen = 1'b0;

		// for (int i = 0; i < 6; i++) begin
		// 	mem_gen_bus_if.busy = ~mem_gen_bus_if.busy;
		// 	#(CLK_PERIOD);
		// end

		// proc_gen_bus_if.addr = 32'h0000E000;
		// proc_gen_bus_if.ren = 1'b1;
		// proc_gen_bus_if.wen = 1'b0;

		// for (int i = 0; i < 5; i++) begin
		// 	mem_gen_bus_if.busy = ~mem_gen_bus_if.busy;
		// 	#(CLK_PERIOD);
		// end

		// proc_gen_bus_if.addr = 32'h0000D000;
		// proc_gen_bus_if.ren = 1'b0;
		// proc_gen_bus_if.wen = 1'b1;
		// proc_gen_bus_if.wdata = 32'hFFFFFFFF;

		// for (int i = 0; i < 6; i++) begin
		// 	mem_gen_bus_if.busy = ~mem_gen_bus_if.busy;
		// 	#(CLK_PERIOD);
		// end
		
		$finish; 
	end
endmodule