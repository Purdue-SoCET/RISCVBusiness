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
*   Filename:     tb_shift_test_restore_divider.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 02/22/2017
*   Description:  Tests a 32bitx32bit divider 
*/

module tb_shift_test_restore_divider ();
  parameter CLOCK_PERIOD = 10ns;

	logic tb_CLK, tb_nRST;
	logic tb_start, tb_finished;
	logic [(XLEN-1):0] tb_operand_a;
	logic [(XLEN-1):0] tb_operand_b;
	logic [(XLEN-1):0] tb_quotient, tb_remainder;
	logic [1:0] tb_is_signed;
	logic [(XLEN-1):0] tb_expected_quotient, tb_expected_remainder;
	integer tb_test_case_num;
	
	typedef struct {
		string test_name;
		logic [(XLEN-1):0] test_operand_a;
		logic [(XLEN-1):0] test_operand_b;
		logic [1:0] test_is_signed;
	} testvector;
	testvector tb_test_case [];

  /*  Module Instantiations */
  shift_test_restore_divider #(XLEN) DUT (
      .CLK(tb_CLK),
      .nRST(tb_nRST),
      .dividend(tb_operand_a),
      .divisor(tb_operand_b),
      .is_signed(tb_is_signed),
      .start(tb_start),
      .remainder(tb_remainder),
      .quotient(tb_quotient),
      .finished(tb_finished)
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
		tb_test_case = new[10];
		
		tb_test_case[0].test_name = "Basic signed division. Positive & Positive.";
		tb_test_case[0].test_operand_a = 32'h0000_0080;
		tb_test_case[0].test_operand_b = 32'h0000_0002;
		tb_test_case[0].test_is_signed = '1;

		tb_test_case[1].test_name = "Basic signed division. Positive & Negative.";
		tb_test_case[1].test_operand_a = 32'h0000_0080;
		tb_test_case[1].test_operand_b = 32'hFFFF_FFFE;
		tb_test_case[1].test_is_signed = '1;

		tb_test_case[2].test_name = "Basic signed division. Negative & Negative.";
		tb_test_case[2].test_operand_a = 32'hFFFF_FFB0;
		tb_test_case[2].test_operand_b = 32'hFFFF_FFFE;
		tb_test_case[2].test_is_signed = '1;

		tb_test_case[3].test_name = "Basic signed division. Negative & Positive.";
		tb_test_case[3].test_operand_a = 32'hFFFF_FFB0;
		tb_test_case[3].test_operand_b = 32'h0000_0002;
		tb_test_case[3].test_is_signed = '1;

		tb_test_case[4].test_name = "Signed divide by 0.";
		tb_test_case[4].test_operand_a = 32'hFFFF_FFB0;
		tb_test_case[4].test_operand_b = 32'h0000_0000;
		tb_test_case[4].test_is_signed = '1;

		tb_test_case[5].test_name = "Basic unsigned division. Positive & Positive.";
		tb_test_case[5].test_operand_a = 32'h0000_0080;
		tb_test_case[5].test_operand_b = 32'h0000_0002;
		tb_test_case[5].test_is_signed = '0;

		tb_test_case[6].test_name = "Basic unsigned division. Positive & (signed) Negative.";
		tb_test_case[6].test_operand_a = 32'h0000_0080;
		tb_test_case[6].test_operand_b = 32'hFFFF_FFFE;
		tb_test_case[6].test_is_signed = '0;

		tb_test_case[7].test_name = "Basic unsigned division. (signed) Negative & (signed) Negative.";
		tb_test_case[7].test_operand_a = 32'hFFFF_FFB0;
		tb_test_case[7].test_operand_b = 32'hFFFF_FFFE;
		tb_test_case[7].test_is_signed = '0;

		tb_test_case[8].test_name = "Basic unsigned division. (signed) Negative & Positive.";
		tb_test_case[8].test_operand_a = 32'hFFFF_FFB0;
		tb_test_case[8].test_operand_b = 32'h0000_0002;
		tb_test_case[8].test_is_signed = '0;

		tb_test_case[9].test_name = "Unsigned divide by 0.";
		tb_test_case[9].test_operand_a = 32'hFFFF_FFB0;
		tb_test_case[9].test_operand_b = 32'h0000_0000;
		tb_test_case[9].test_is_signed = '0;
	end
	initial begin
		tb_operand_b = '0;
		tb_operand_a = '0;
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
			tb_operand_a = tb_test_case[tb_test_case_num].test_operand_a;
			tb_operand_b = tb_test_case[tb_test_case_num].test_operand_b;
			tb_is_signed = tb_test_case[tb_test_case_num].test_is_signed;

			// begin multiplication
			@(negedge tb_CLK);	
			tb_start = 1; 
			@(negedge tb_CLK); // First Clock Cycle
			tb_start = 0;

			// Need to treat multiplication differently if signed or unsigned
      if (tb_is_signed) begin
        tb_expected_quotient = signed'(tb_operand_a) / signed'(tb_operand_b);
        tb_expected_remainder = signed'(tb_operand_a) % signed'(tb_operand_b);
      end else begin
        tb_expected_quotient = unsigned'(tb_operand_a) / unsigned'(tb_operand_b);
        tb_expected_remainder = unsigned'(tb_operand_a) % unsigned'(tb_operand_b);
      end

      if (tb_operand_b == '0) begin
        tb_expected_quotient = 32'hFFFF_FFFF;
        tb_expected_remainder = tb_operand_a;
      end else if (tb_operand_a == 32'h8000_0000 && tb_operand_b == 32'hFFFF_FFFF && tb_is_signed) begin
        tb_expected_quotient = 32'h8000_0000;
        tb_expected_remainder = '0;
      end

			// wait for multiplication to finish
			while(tb_finished == 1'b0) @(posedge tb_CLK);
			#(CLOCK_PERIOD/4.0);

			assert(tb_quotient == tb_expected_quotient) begin
				$info ("TEST PASS\n");
			end else begin
				$info ("IS SIGNED : %s", tb_is_signed ? "YES" : "NO");
				$info ("DIVIDEND  : 0x%8h", tb_operand_a);
				$info ("DIVISOR   : 0x%8h", tb_operand_b);
				$info ("ACTUAL    : 0x%16h", tb_quotient);
				$info ("EXPECTED  : 0x%16h", tb_expected_quotient);
				$info ("TEST FAIL, INCORRECT QUOTIENT\n");
				$stop;
			end

      assert(tb_remainder == tb_expected_remainder) begin
				$info ("TEST PASS\n");
			end else begin
				$info ("IS SIGNED : %s", tb_is_signed ? "YES" : "NO");
				$info ("DIVIDEND  : 0x%8h", tb_operand_a);
				$info ("DIVISOR   : 0x%8h", tb_operand_b);
				$info ("ACTUAL    : 0x%16h", tb_remainder);
				$info ("EXPECTED  : 0x%16h", tb_expected_remainder);
				$info ("TEST FAIL, INCORRECT REMAINER\n");
				$stop;
			end
		end
		$finish;
	end
endmodule
