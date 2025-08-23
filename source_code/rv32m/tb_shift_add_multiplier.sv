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
*   Filename:     tb_shift_add_multiplier.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 02/15/2017
*   Description:  Tests a 32bitx32bit multiplier
*/

`timescale 1ns/10ps
`include "component_selection_defines.vh"

module tb_shift_add_multiplier ();
	parameter CLOCK_PERIOD = 10ns;

	logic tb_CLK, tb_nRST;
	logic tb_start, tb_finished;
	logic [(XLEN-1):0] tb_multiplicand;
	logic [(XLEN-1):0] tb_multiplier;
	logic [(2*XLEN-1):0] tb_product;
	logic [1:0] tb_is_signed;
	logic [(2*XLEN-1):0] tb_expected_out;
	integer tb_test_case_num;
	
	typedef struct {
		string test_name;
		logic [(XLEN-1):0] test_multiplicand;
		logic [(XLEN-1):0] test_multiplier;
		logic [1:0] test_is_signed;
	} testvector;
	testvector tb_test_case [];
  shift_add_multiplier #(32) DUT (
			.CLK(tb_CLK),
			.nRST(tb_nRST),
			.multiplicand(tb_multiplicand),
			.multiplier(tb_multiplier),
			.is_signed(tb_is_signed),
			.start(tb_start),
			.finished(tb_finished),
			.product(tb_product)
	);

  /*  CLK generation */
	always begin
		tb_CLK=0;
		#(CLOCK_PERIOD/2.0);
		tb_CLK=1;
		#(CLOCK_PERIOD/2.0);
	end

	task reset_dut();
		@(negedge tb_CLK);
		tb_nRST = 0;
		@(posedge tb_CLK);
		@(posedge tb_CLK);
		#(CLOCK_PERIOD/4.0);
		tb_nRST = 1;
	endtask

	initial begin
		tb_test_case = new[18];
		// Random multiplier and multiplicand
		tb_test_case[0].test_name = "Random multiplier and multiplicand";
		tb_test_case[0].test_multiplicand = 32'd183978223;
		tb_test_case[0].test_multiplier = 32'd490177653;
		tb_test_case[0].test_is_signed = 2'b00;
		// Multiplier with concatenation of all possible 3-bits values in bitpair recoding
		tb_test_case[1].test_name = "Multiplier with concatenation of all possible 3-bits values in bitpair recoding";
		tb_test_case[1].test_multiplicand = 32'd478013;
		tb_test_case[1].test_multiplier = {{10'd0}, {22'b1110100110011100100100}};
		tb_test_case[1].test_is_signed = 2'b00;
		// Unsigned multiplicand and unsigned multiplier
		tb_test_case[2].test_name = "Unsigned multiplicand and unsigned multiplier";	
		tb_test_case[2].test_multiplicand = '1 >> 1;
		tb_test_case[2].test_multiplier = '1 >> 1;
		tb_test_case[2].test_is_signed = 2'b00;
		// Signed multiplicand and unsigned multiplier
		tb_test_case[3].test_name = "Signed multiplicand and unsigned multiplier";
		tb_test_case[3].test_multiplicand = -28752;
		tb_test_case[3].test_multiplier = 32'd839011;
		tb_test_case[3].test_is_signed = 2'b10;
		// Unsigned multiplicand and signed multiplier	
		tb_test_case[4].test_name = "Unsigned multiplicand and signed multiplier";
		tb_test_case[4].test_multiplicand = 32'd7212691;
		tb_test_case[4].test_multiplier = -43892;
		tb_test_case[4].test_is_signed = 2'b01;
		// Signed multiplicand and signed multiplier
		tb_test_case[5].test_name = "Signed multiplicand and signed multiplier";
		tb_test_case[5].test_multiplicand = -7268;
		tb_test_case[5].test_multiplier = -897192;
		tb_test_case[5].test_is_signed = 2'b11;
		// MSB is 1 but unsigned - Both	
		tb_test_case[6].test_name = "MSB is 1 but unsigned - Both";
		tb_test_case[6].test_multiplicand = '1;
		tb_test_case[6].test_multiplier = '1;
		tb_test_case[6].test_is_signed = 2'b00;	
		// MSB is 1 but unsigned - Multiplicand	
		tb_test_case[7].test_name = "MSB is 1 but unsigned - Multiplicand";
		tb_test_case[7].test_multiplicand = '1;
		tb_test_case[7].test_multiplier = 32'd59;
		tb_test_case[7].test_is_signed = 2'b00;	
		// MSB is 1 but unsigned - Multiplier	
		tb_test_case[8].test_name = "MSB is 1 but unsigned - Multiplier";
		tb_test_case[8].test_multiplicand = 32'd38013;
		tb_test_case[8].test_multiplier = '1;
		tb_test_case[8].test_is_signed = 2'b00;	

		/*
			shift_add_multiplier tests
		*/
		tb_test_case[9].test_name = "basic multiplication test";
		tb_test_case[9].test_multiplicand = 32'd8;
		tb_test_case[9].test_multiplier = 32'd11;
		tb_test_case[9].test_is_signed = 2'b00;	

		tb_test_case[10].test_name = "both signed multiplication test";
		tb_test_case[10].test_multiplicand = -1;
		tb_test_case[10].test_multiplier = -108;
		tb_test_case[10].test_is_signed = 2'b11;	

		tb_test_case[11].test_name = "one signed one unsigned 1";
		tb_test_case[11].test_multiplicand = -8;
		tb_test_case[11].test_multiplier = 100001;
		tb_test_case[11].test_is_signed = 2'b10;	

		tb_test_case[12].test_name = "one signed one unsigned 2";
		tb_test_case[12].test_multiplicand = 100001;
		tb_test_case[12].test_multiplier = -8;
		tb_test_case[12].test_is_signed = 2'b01;	

		tb_test_case[13].test_name = "negative number and 1 1";
		tb_test_case[13].test_multiplicand = 32'hffff_ffff;
		tb_test_case[13].test_multiplier = 32'h1;
		tb_test_case[13].test_is_signed = 2'b11;	

		tb_test_case[14].test_name = "negative number and 1 2";
		tb_test_case[14].test_multiplicand = 32'h1;
		tb_test_case[14].test_multiplier = 32'hffff_ffff;
		tb_test_case[14].test_is_signed = 2'b11;	

		tb_test_case[15].test_name = "largest negative number and 1 1";
		tb_test_case[15].test_multiplicand = 32'h8000_0000;
		tb_test_case[15].test_multiplier = 32'h1;
		tb_test_case[15].test_is_signed = 2'b11;	

		tb_test_case[16].test_name = "largest negative number and 1 2";
		tb_test_case[16].test_multiplicand = 32'h8000_0000;
		tb_test_case[16].test_multiplier = 32'h1;
		tb_test_case[16].test_is_signed = 2'b00;	

		tb_test_case[17].test_name = "multiply by 0";
		tb_test_case[17].test_multiplicand = 32'h0;
		tb_test_case[17].test_multiplier = 32'habcd_1234;
		tb_test_case[17].test_is_signed = 2'b00;	
	end
	initial begin
		tb_multiplier = '0;
		tb_multiplicand = '0;
		tb_is_signed = '0;
		tb_start = 0;
		tb_nRST = 1;		
		for (tb_test_case_num = 0; tb_test_case_num < tb_test_case.size(); tb_test_case_num++) begin
			$info (
					"TEST CASE %0d - %s",
					tb_test_case_num,
					tb_test_case[tb_test_case_num].test_name
			);
			reset_dut();

			// Align inputs to change @ CLK/4
			@(posedge tb_CLK);
			#(CLOCK_PERIOD/4.0);

			// drive inputs to DUT
			tb_multiplicand = tb_test_case[tb_test_case_num].test_multiplicand;
			tb_multiplier = tb_test_case[tb_test_case_num].test_multiplier;
			tb_is_signed = tb_test_case[tb_test_case_num].test_is_signed;

			// begin multiplication
			@(negedge tb_CLK);	
			tb_start = 1; 
			@(negedge tb_CLK); // First Clock Cycle
			tb_start = 0;

			// Need to treat multiplication differently if signed or unsigned
			if (tb_is_signed) begin
				tb_expected_out = signed'(tb_multiplicand) * signed'(tb_multiplier);
			end else begin
				tb_expected_out = tb_multiplicand * tb_multiplier;
			end

			// wait for multiplication to finish
			while(tb_finished == 1'b0) @(posedge tb_CLK);
			#(CLOCK_PERIOD/4.0);

			assert(tb_product == tb_expected_out) begin
				$info ("TEST PASS\n");
			end else begin
				$info ("IS SIGNED    : %s", tb_is_signed ? "YES" : "NO");
				$info ("MULTIPLICAND : 0x%8h", tb_multiplicand);
				$info ("MULTIPLIER   : 0x%8h", tb_multiplier);
				$info ("ACTUAL       : 0x%16h", tb_product);
				$info ("EXPECTED     : 0x%16h", tb_expected_out);
				$info ("TEST FAIL, INCORRECT PRODUCT\n");
				$stop;
			end
		end
		$finish;
	end
endmodule
