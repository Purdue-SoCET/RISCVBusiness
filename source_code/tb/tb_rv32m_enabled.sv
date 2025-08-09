`timescale 1ns/10ps

module tb_rv32m_enabled ();

	parameter BIT_WIDTH = 32;
	parameter CLOCK_PERIOD = 10ns;
	logic tb_CLK, tb_nRST;
	logic tb_start, tb_finished;
	logic [(BIT_WIDTH-1):0] tb_multiplicand;
	logic [(BIT_WIDTH-1):0] tb_multiplier;
	logic [(2*BIT_WIDTH-1):0] tb_product;
	logic [(2*BIT_WIDTH+5):0] tb_expected_out;
	integer tb_test_case_num;

	int count = 0;	

	typedef enum logic [2:0] {
        MUL     = 3'b000,
        MULH    = 3'b001,
        MULHSU  = 3'b010,
        MULHU   = 3'b011,
        DIV     = 3'b100,
        DIVU    = 3'b101,
        REM     = 3'b110,
        REMU    = 3'b111
    } rv32m_op_t;

	rv32m_op_t operation;

	typedef struct {
		string test_name;
		logic [(BIT_WIDTH-1):0] test_multiplicand;
		logic [(BIT_WIDTH-1):0] test_multiplier;
		rv32m_op_t test_operation;
	} testvector;
	testvector tb_test_case [];

	
	// pp_mul32 DUT (.CLK(tb_CLK), .nRST(tb_nRST), .multiplicand(tb_multiplicand), .multiplier(tb_multiplier), .is_signed(tb_is_signed), .start(tb_start), .finished(tb_finished), .product(tb_product));

	rv32m_enabled rv32m(
		// SYSTEM
		.CLK(tb_CLK),
		.nRST(tb_nRST),
		// INPUT
		.rv32m_start(tb_start),
		.operation(operation),
		.rv32m_a(tb_multiplicand),
		.rv32m_b(tb_multiplier),
		// OUTPUT
		.rv32m_done(tb_finished),
		.rv32m_out(tb_product)
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

	// From source sv.
	// always_comb begin
    //     casez (operation)
    //         MUL, MULH, DIV, REM:    is_signed = 2'b11;
    //         MULHU, DIVU, REMU:      is_signed = 2'b00;
    //         MULHSU:                 is_signed = 2'b10; // 2'b01 too
    //         default:                is_signed = 2'b11;
    //     endcase
    // end

	initial begin
		$dumpfile("wave.vcd");
		$dumpvars(0, tb_rv32m_enabled);
	end


	initial begin
		tb_test_case = new[18];
		// Random multiplier and multiplicand
		tb_test_case[0].test_name = "Random multiplier and multiplicand";
		tb_test_case[0].test_multiplicand = 32'd183978223;
		tb_test_case[0].test_multiplier = 32'd490177653;
		tb_test_case[0].test_operation = MULHU;
		// Multiplier with concatenation of all possible 3-bits values in bitpair recoding
		tb_test_case[1].test_name = "Multiplier with concatenation of all possible 3-bits values in bitpair recoding";
		tb_test_case[1].test_multiplicand = 32'd478013;
		tb_test_case[1].test_multiplier = {{10'd0}, {22'b1110100110011100100100}};
		tb_test_case[1].test_operation = MULHU;
		// Unsigned multiplicand and unsigned multiplier
		tb_test_case[2].test_name = "Unsigned multiplicand and unsigned multiplier";	
		tb_test_case[2].test_multiplicand = '1 >> 1;
		tb_test_case[2].test_multiplier = '1 >> 1;
		tb_test_case[2].test_operation = MULHU;
		// Signed multiplicand and unsigned multiplier
		tb_test_case[3].test_name = "Signed multiplicand and unsigned multiplier";
		tb_test_case[3].test_multiplicand = -28752;
		tb_test_case[3].test_multiplier = 32'd839011;
		tb_test_case[3].test_operation = MULHSU;
		// Unsigned multiplicand and signed multiplier	
		tb_test_case[4].test_name = "Unsigned multiplicand and signed multiplier";
		tb_test_case[4].test_multiplicand = 32'd7212691;
		tb_test_case[4].test_multiplier = -43892;
		tb_test_case[4].test_operation = MULHSU;
		// Signed multiplicand and signed multiplier
		tb_test_case[5].test_name = "Signed multiplicand and signed multiplier";
		tb_test_case[5].test_multiplicand = -7268;
		tb_test_case[5].test_multiplier = -897192;
		tb_test_case[5].test_operation = MUL;
		// MSB is 1 but unsigned - Both	
		tb_test_case[6].test_name = "MSB is 1 but unsigned - Both";
		tb_test_case[6].test_multiplicand = '1;
		tb_test_case[6].test_multiplier = '1;
		tb_test_case[6].test_operation = MULHU;	
		// MSB is 1 but unsigned - Multiplicand	
		tb_test_case[7].test_name = "MSB is 1 but unsigned - Multiplicand";
		tb_test_case[7].test_multiplicand = '1;
		tb_test_case[7].test_multiplier = 32'd59;
		tb_test_case[7].test_operation = MULHU;	
		// MSB is 1 but unsigned - Multiplier	
		tb_test_case[8].test_name = "MSB is 1 but unsigned - Multiplier";
		tb_test_case[8].test_multiplicand = 32'd38013;
		tb_test_case[8].test_multiplier = '1;
		tb_test_case[8].test_operation = MULHU;	

		/*
			shift_add_multiplier tests
		*/
		tb_test_case[9].test_name = "basic multiplication test";
		tb_test_case[9].test_multiplicand = 32'd8;
		tb_test_case[9].test_multiplier = 32'd11;
		tb_test_case[9].test_operation = MULHU;	

		tb_test_case[10].test_name = "both signed multiplication test";
		tb_test_case[10].test_multiplicand = -1;
		tb_test_case[10].test_multiplier = -108;
		tb_test_case[10].test_operation = MUL;	

		tb_test_case[11].test_name = "one signed one unsigned 1";
		tb_test_case[11].test_multiplicand = -8;
		tb_test_case[11].test_multiplier = 100001;
		tb_test_case[11].test_operation = MULHSU;	

		tb_test_case[12].test_name = "one signed one unsigned 2";
		tb_test_case[12].test_multiplicand = 100001;
		tb_test_case[12].test_multiplier = -8;
		tb_test_case[12].test_operation = MULHSU;	

		tb_test_case[13].test_name = "negative number and 1 1";
		tb_test_case[13].test_multiplicand = 32'hffff_ffff;
		tb_test_case[13].test_multiplier = 32'h1;
		tb_test_case[13].test_operation = MUL;	

		tb_test_case[14].test_name = "negative number and 1 2";
		tb_test_case[14].test_multiplicand = 32'h1;
		tb_test_case[14].test_multiplier = 32'hffff_ffff;
		tb_test_case[14].test_operation = MUL;	

		tb_test_case[15].test_name = "largest negative number and 1 1";
		tb_test_case[15].test_multiplicand = 32'h8000_0000;
		tb_test_case[15].test_multiplier = 32'h1;
		tb_test_case[15].test_operation = MUL;	

		tb_test_case[16].test_name = "largest negative number and 1 2";
		tb_test_case[16].test_multiplicand = 32'h8000_0000;
		tb_test_case[16].test_multiplier = 32'h1;
		tb_test_case[16].test_operation = MULHU;	

		tb_test_case[17].test_name = "multiply by 0";
		tb_test_case[17].test_multiplicand = 32'h0;
		tb_test_case[17].test_multiplier = 32'habcd_1234;
		tb_test_case[17].test_operation = MULHU;	
	end
	initial begin
		tb_multiplier = '0;
		tb_multiplicand = '0;
		tb_start = 0;
		tb_nRST = 1;
		reset_dut();		
		for (tb_test_case_num = 0; tb_test_case_num < tb_test_case.size(); tb_test_case_num ++) begin
			$display("TEST CASE %d - %s", tb_test_case_num, tb_test_case[tb_test_case_num].test_name);
			@(posedge tb_CLK);
			#(CLOCK_PERIOD/4.0);
			tb_multiplicand = tb_test_case[tb_test_case_num].test_multiplicand;
			tb_multiplier = tb_test_case[tb_test_case_num].test_multiplier;
			operation = tb_test_case[tb_test_case_num].test_operation;
			@(negedge tb_CLK);	
			tb_start = 1; 
			@(negedge tb_CLK); // First Clock Cycle
			tb_start = 0;
			tb_expected_out = tb_multiplicand * tb_multiplier;
			// @(posedge tb_CLK); // Second Clock Cycle
			// @(posedge tb_CLK); // Third Clock Cycle

			// #(CLOCK_PERIOD/4.0);
			count = 0;
			while (!tb_finished && count < 32) begin
				@(negedge tb_CLK);
				count++;
			end

			if (tb_product == tb_expected_out) begin
				$info ("CORRECT MULTIPLICATION");
				$display("%0h", tb_product);
			end else begin
				$info ("ACTUAL: %h, EXPECTED: %h", tb_product, tb_expected_out); // see waveform value for test case 3-5 (waveform will show negative value)
				$display("%0h\n", tb_product);
			end

			#(CLOCK_PERIOD*4);
		end
		$stop;
	end
	
endmodule
