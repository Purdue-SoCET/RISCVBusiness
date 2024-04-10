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

    l1_cache DUT (.CLK(CLK), .nRST(nRST), .mem_gen_bus_if(mem_gen_bus_if), .proc_gen_bus_if(proc_gen_bus_if));

	task reset_dut; 
		@(negedge CLK) nRST = 1'b0; 
		#(CLK_PERIOD * 2) nRST = 1'b1; 
		@(posedge CLK); 
	endtask

	initial begin
        proc_gen_bus_if.addr = 32'h00000010;
        proc_gen_bus_if.ren = 1'b1;
        proc_gen_bus_if.wen = 1'b0;
		$timeformat(-9, 0, " ns", 20);
		reset_dut();


        for (int i = 0; i < 18; i++) begin
            #(CLK_PERIOD);
        end
        
        proc_gen_bus_if.addr = 32'h00000004;
        proc_gen_bus_if.ren = 1'b1;
        proc_gen_bus_if.wen = 1'b0;

        for (int i = 0; i < 2; i++) begin
            #(CLK_PERIOD);
        end

        proc_gen_bus_if.addr = 32'h00000026;
        proc_gen_bus_if.ren = 1'b1;
        proc_gen_bus_if.wen = 1'b0;
		
		#(CLK_PERIOD * 4);

		mem_gen_bus_if.busy = 1'b0;
		#(CLK_PERIOD * 5);
		$finish; 
	end
endmodule