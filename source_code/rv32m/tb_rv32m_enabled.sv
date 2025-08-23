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
*   Filename:     tb_pp_mul32.sv
*
*   Created by:   Renzhi Yongtian
*   Email:        ryongtia@purdue.edu
*   Date Created: 08/09/2025
*   Description:  Tests a 32bitx32bit PP mul32 operand_b
*/

`timescale 1ns/10ps
`include "component_selection_defines.vh"

module tb_rv32m_enabled ();
	import rv32m_pkg::*;
	import rv32i_types_pkg::*;

	parameter CLOCK_PERIOD = 10ns;

	// to DUT
	logic tb_CLK, tb_nRST;
	logic tb_start, tb_finished;
	logic [(XLEN-1):0] tb_operand_a;
	logic [(XLEN-1):0] tb_operand_b;
	logic [(2*XLEN-1):0] tb_output;
	logic [(2*XLEN-1):0] tb_expected_out;
	logic [(2*XLEN-1):0] tb_mul_s, tb_mul_u;
	logic [(2*XLEN-1):0] tb_div_s, tb_div_u;
	logic [(2*XLEN-1):0] tb_rem_s, tb_rem_u;
	rv32m_op_t tb_operation;
	integer tb_test_case_num;

	typedef struct {
		string test_name;
		logic [(XLEN-1):0] test_operand_a;
		logic [(XLEN-1):0] test_operand_b;
		rv32m_op_t test_operation;
	} testvector;
	testvector tb_test_case [];

	rv32m_enabled rv32m (
		// SYSTEM
		.CLK(tb_CLK),
		.nRST(tb_nRST),
		// INPUT
		.rv32m_start(tb_start),
		.operation(tb_operation),
		.rv32m_a(tb_operand_a),
		.rv32m_b(tb_operand_b),
		// OUTPUT
		.rv32m_done(tb_finished),
		.rv32m_out(tb_output)
	);

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

	// TB expected out
	assign tb_mul_s =   signed'(tb_operand_a) *   signed'(tb_operand_b);
	assign tb_mul_u = unsigned'(tb_operand_a) * unsigned'(tb_operand_b);
	assign tb_div_s =   signed'(tb_operand_a) /   signed'(tb_operand_b);
	assign tb_div_u = unsigned'(tb_operand_a) / unsigned'(tb_operand_b);
	assign tb_rem_s =   signed'(tb_operand_a) %   signed'(tb_operand_b);
	assign tb_rem_u = unsigned'(tb_operand_a) % unsigned'(tb_operand_b);
	always_comb begin
		casez(tb_operation)
			MUL: begin
				tb_expected_out = tb_mul_s[XLEN-1 : 0];
			end
			MULH: begin
				tb_expected_out = tb_mul_s[(XLEN*2)-1 : XLEN];
			end
			MULHU: begin
				tb_expected_out = tb_mul_u[(XLEN*2)-1 : XLEN];
			end
			MULHSU: begin
				if (tb_operand_a[XLEN-1])
					tb_expected_out = tb_mul_s[(XLEN*2)-1 : XLEN];  // signed operand_a
				else
					tb_expected_out = tb_mul_u[(XLEN*2)-1 : XLEN];  // signed operand_b
			end
			DIV: begin
				tb_expected_out = tb_div_s[XLEN-1 : 0];
				if (tb_operand_b == '0)
					tb_expected_out = 64'hFFFF_FFFF;
				else if (tb_operand_a == 32'h8000_0000 && tb_operand_b == 32'hFFFF_FFFF) 
					tb_expected_out = 64'h8000_0000;
			end
			DIVU: begin
				tb_expected_out = tb_div_u[XLEN-1 : 0];
				if (tb_operand_b == '0) begin
					tb_expected_out = 64'hFFFF_FFFF;
				end
			end
			REM: begin
				tb_expected_out = tb_rem_s[XLEN-1 : 0];
				if (tb_operand_b == '0)
					tb_expected_out = tb_operand_a;
				else if (tb_operand_a == 32'h8000_0000 && tb_operand_b == 32'hFFFF_FFFF) 
					tb_expected_out = 64'h0000_0000;
			end
			REMU: begin
				tb_expected_out = tb_rem_u[XLEN-1 : 0];
				if (tb_operand_b == '0)
					tb_expected_out = tb_operand_a;
			end

			default: begin
				tb_expected_out = '0;
			end
		endcase
	end

	initial begin
		$dumpfile("waveform.fst");
		$dumpvars(0, tb_rv32m_enabled);
	end


	initial begin
		tb_test_case = new[28];
		// Random operand_b and operand_a
		tb_test_case[0].test_name = "Random operand_b and operand_a";
		tb_test_case[0].test_operand_a = 32'd183978223;
		tb_test_case[0].test_operand_b = 32'd490177653;
		tb_test_case[0].test_operation = MULHU;
		// operand_b with concatenation of all possible 3-bits values in bitpair recoding
		tb_test_case[1].test_name = "operand_b with concatenation of all possible 3-bits values in bitpair recoding";
		tb_test_case[1].test_operand_a = 32'd478013;
		tb_test_case[1].test_operand_b = {{10'd0}, {22'b1110100110011100100100}};
		tb_test_case[1].test_operation = MULHU;
		// Unsigned operand_a and unsigned operand_b
		tb_test_case[2].test_name = "Unsigned operand_a and unsigned operand_b";	
		tb_test_case[2].test_operand_a = '1 >> 1;
		tb_test_case[2].test_operand_b = '1 >> 1;
		tb_test_case[2].test_operation = MULHU;
		// Signed operand_a and unsigned operand_b
		tb_test_case[3].test_name = "Signed operand_a and unsigned operand_b";
		tb_test_case[3].test_operand_a = -28752;
		tb_test_case[3].test_operand_b = 32'd839011;
		tb_test_case[3].test_operation = MULHSU;
		// Unsigned operand_a and signed operand_b	
		tb_test_case[4].test_name = "Unsigned operand_a and signed operand_b";
		tb_test_case[4].test_operand_a = 32'd7212691;
		tb_test_case[4].test_operand_b = -43892;
		tb_test_case[4].test_operation = MULHSU;
		// Signed operand_a and signed operand_b
		tb_test_case[5].test_name = "Signed operand_a and signed operand_b";
		tb_test_case[5].test_operand_a = -7268;
		tb_test_case[5].test_operand_b = -897192;
		tb_test_case[5].test_operation = MUL;
		// MSB is 1 but unsigned - Both	
		tb_test_case[6].test_name = "MSB is 1 but unsigned - Both";
		tb_test_case[6].test_operand_a = '1;
		tb_test_case[6].test_operand_b = '1;
		tb_test_case[6].test_operation = MULHU;
		// MSB is 1 but unsigned - operand_a	
		tb_test_case[7].test_name = "MSB is 1 but unsigned - operand_a";
		tb_test_case[7].test_operand_a = '1;
		tb_test_case[7].test_operand_b = 32'd59;
		tb_test_case[7].test_operation = MULHU;
		// MSB is 1 but unsigned - operand_b	
		tb_test_case[8].test_name = "MSB is 1 but unsigned - operand_b";
		tb_test_case[8].test_operand_a = 32'd38013;
		tb_test_case[8].test_operand_b = '1;
		tb_test_case[8].test_operation = MULHU;

		/*
			shift_add_operand_b tests
		*/
		tb_test_case[9].test_name = "Basic multiplication test";
		tb_test_case[9].test_operand_a = 32'd8;
		tb_test_case[9].test_operand_b = 32'd11;
		tb_test_case[9].test_operation = MULHU;

		tb_test_case[10].test_name = "both signed multiplication test";
		tb_test_case[10].test_operand_a = -1;
		tb_test_case[10].test_operand_b = -108;
		tb_test_case[10].test_operation = MUL;

		tb_test_case[11].test_name = "one signed one unsigned 1";
		tb_test_case[11].test_operand_a = -8;
		tb_test_case[11].test_operand_b = 100001;
		tb_test_case[11].test_operation = MULHSU;

		tb_test_case[12].test_name = "one signed one unsigned 2";
		tb_test_case[12].test_operand_a = 100001;
		tb_test_case[12].test_operand_b = -8;
		tb_test_case[12].test_operation = MULHSU;

		tb_test_case[13].test_name = "negative number and 1 1";
		tb_test_case[13].test_operand_a = 32'hffff_ffff;
		tb_test_case[13].test_operand_b = 32'h1;
		tb_test_case[13].test_operation = MUL;

		tb_test_case[14].test_name = "negative number and 1 2";
		tb_test_case[14].test_operand_a = 32'h1;
		tb_test_case[14].test_operand_b = 32'hffff_ffff;
		tb_test_case[14].test_operation = MUL;

		tb_test_case[15].test_name = "largest negative number and 1 1";
		tb_test_case[15].test_operand_a = 32'h8000_0000;
		tb_test_case[15].test_operand_b = 32'h1;
		tb_test_case[15].test_operation = MUL;

		tb_test_case[16].test_name = "largest negative number and 1 2";
		tb_test_case[16].test_operand_a = 32'h8000_0000;
		tb_test_case[16].test_operand_b = 32'h1;
		tb_test_case[16].test_operation = MULHU;

		tb_test_case[17].test_name = "multiply by 0";
		tb_test_case[17].test_operand_a = 32'h0;
		tb_test_case[17].test_operand_b = 32'habcd_1234;
		tb_test_case[17].test_operation = MULHU;

		tb_test_case[18].test_name = "Basic signed division. Positive & Positive.";
		tb_test_case[18].test_operand_a = 32'h0000_0080;
		tb_test_case[18].test_operand_b = 32'h0000_0002;
		tb_test_case[18].test_operation = DIV;

		tb_test_case[19].test_name = "Basic signed division. Positive & Negative.";
		tb_test_case[19].test_operand_a = 32'h0000_0080;
		tb_test_case[19].test_operand_b = 32'hFFFF_FFFE;
		tb_test_case[19].test_operation = DIV;

		tb_test_case[20].test_name = "Basic signed division. Negative & Negative.";
		tb_test_case[20].test_operand_a = 32'hFFFF_FFB0;
		tb_test_case[20].test_operand_b = 32'hFFFF_FFFE;
		tb_test_case[20].test_operation = DIV;

		tb_test_case[21].test_name = "Basic signed division. Negative & Positive.";
		tb_test_case[21].test_operand_a = 32'hFFFF_FFB0;
		tb_test_case[21].test_operand_b = 32'h0000_0002;
		tb_test_case[21].test_operation = DIV;

		tb_test_case[22].test_name = "Signed divide by 0.";
		tb_test_case[22].test_operand_a = 32'hFFFF_FFB0;
		tb_test_case[22].test_operand_b = 32'h0000_0000;
		tb_test_case[22].test_operation = DIV;

		tb_test_case[23].test_name = "Basic unsigned division. Positive & Positive.";
		tb_test_case[23].test_operand_a = 32'h0000_0080;
		tb_test_case[23].test_operand_b = 32'h0000_0002;
		tb_test_case[23].test_operation = DIVU;

		tb_test_case[24].test_name = "Basic unsigned division. Positive & (signed) Negative.";
		tb_test_case[24].test_operand_a = 32'h0000_0080;
		tb_test_case[24].test_operand_b = 32'hFFFF_FFFE;
		tb_test_case[24].test_operation = DIVU;

		tb_test_case[25].test_name = "Basic unsigned division. (signed) Negative & (signed) Negative.";
		tb_test_case[25].test_operand_a = 32'hFFFF_FFB0;
		tb_test_case[25].test_operand_b = 32'hFFFF_FFFE;
		tb_test_case[25].test_operation = DIVU;

		tb_test_case[26].test_name = "Basic unsigned division. (signed) Negative & Positive.";
		tb_test_case[26].test_operand_a = 32'hFFFF_FFB0;
		tb_test_case[26].test_operand_b = 32'h0000_0002;
		tb_test_case[26].test_operation = DIVU;

		tb_test_case[27].test_name = "Unsigned divide by 0.";
		tb_test_case[27].test_operand_a = 32'hFFFF_FFB0;
		tb_test_case[27].test_operand_b = 32'h0000_0000;
		tb_test_case[27].test_operation = DIVU;
	end
	initial begin
		tb_operand_b = '0;
		tb_operand_a = '0;
		tb_start = 0;
		tb_nRST = 1;
		reset_dut();		
		for (tb_test_case_num = 0; tb_test_case_num < tb_test_case.size(); tb_test_case_num ++) begin
			$info (
					"TEST CASE %0d - %s",
					tb_test_case_num,
					tb_test_case[tb_test_case_num].test_name
			);
			// Align inputs to change @ CLK/4
			@(posedge tb_CLK);
			#(CLOCK_PERIOD/4.0);

			// drive inputs to DUT
			tb_operand_a = tb_test_case[tb_test_case_num].test_operand_a;
			tb_operand_b = tb_test_case[tb_test_case_num].test_operand_b;
			tb_operation = tb_test_case[tb_test_case_num].test_operation;

			// begin multiplication
			@(negedge tb_CLK);
			tb_start = 1;
			@(negedge tb_CLK);

			// wait for multiplication to finish
			while(tb_finished == 1'b0) @(posedge tb_CLK);
			#(CLOCK_PERIOD/4.0);

			assert(tb_output == tb_expected_out) begin
				$info ("TEST PASS\n");
			end else begin
				$info ("OPERATION : %0d", tb_operation);
				$info ("OPERAND A : 0x%8h", tb_operand_a);
				$info ("OPERAND B : 0x%8h", tb_operand_b);
				$info ("ACTUAL    : 0x%16h", tb_output);
				$info ("EXPECTED  : 0x%16h", tb_expected_out);
				$info ("TEST FAIL, INCORRECT PRODUCT/QUOTIENT\n");
				$stop;
			end
		end
		$finish;
	end
	
endmodule
