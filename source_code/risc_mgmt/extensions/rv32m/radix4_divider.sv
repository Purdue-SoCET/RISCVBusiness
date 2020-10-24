module radix4_divider
#(
	parameter NUM_BITS = 32
)
(
	input logic CLK, 
	input logic nRST, 
  	input logic start,
	input logic is_signed, //new
	input logic [NUM_BITS-1:0] dividend, 
	input logic [NUM_BITS-1:0] divisor, 
	output logic [NUM_BITS-1:0] quotient, 
	output logic [NUM_BITS-1:0] remainder,
	output logic finished

);
	logic [NUM_BITS-1:0] next_remainder, next_quotient, shifted_remainder, shifted_quotient;
	logic [NUM_BITS-1:0] Result1, Result2, Result3;
	logic [NUM_BITS-1:0] DivisorX2, DivisorX3;
	logic [4:0] count, next_count;

	assign usign_divisor        = is_signed & divisor[NUM_BITS-1] ? (~divisor)+1 : divisor;
	assign usign_dividend       = is_signed & dividend[NUM_BITS-1] ? (~dividend)+1 : dividend;
	assign adjustment_possible  = is_signed && (divisor[NUM_BITS-1] ^ dividend[NUM_BITS-1]); 
	assign adjust_quotient      = adjustment_possible && ~quotient[NUM_BITS-1];
	assign adjust_remainder     = is_signed && dividend[NUM_BITS-1];
	assign div_done             = (count == 0);

//adjust signed to unsigned output 
//change the output at the end : every cycle
	always_comb begin 
		if (~finished && adjust_quotient)
			quotient <= ~quotient +1;
		else if(~finished && adjust_remainder)
			remainder <= ~remainder	+1;
		else begin
			quotient <= quotient;
			remainder <= remainder;
		end
	end
					

	always_ff @(posedge CLK, negedge nRST) begin
		if (nRST == 0 || start)
			finished <= 0;
		else if (div_done)
			finished <= 1;

	end
	//initialize d2 d3
	assign DivisorX2 = divisor << 1; //Divisor*2
	assign DivisorX3 = (divisor << 1) + divisor; //Divisor*3
	always_ff @(posedge CLK, negedge nRST) begin
		if (nRST == 0) begin
			quotient <= '0;
			remainder <= '0;
			count <= 5'd16;
		end else if (start) begin
			quotient <= dividend;
			remainder <= '0;
			count <= 5'd16;
		end else if (count >= 0) begin
			quotient <= next_quotient;
			remainder <= next_remainder;
			count <= next_count;
		end
	end

	always_comb begin
		next_quotient = quotient;
		next_remainder = remainder;
		next_count = count;
		if (count != 0) begin
			next_count = count - 1;
			shifted_remainder = (remainder << 2) | quotient[NUM_BITS-1:NUM_BITS-2];
			shifted_quotient = quotient << 2;
			Result1 = shifted_remainder - divisor;
			Result2 = shifted_remainder - DivisorX2;
			Result3 = shifted_remainder - DivisorX3;
			if(Result1[NUM_BITS-1]) begin 
				next_remainder = shifted_remainder;
				next_quotient = shifted_quotient | 0;
			end else if(Result2[NUM_BITS-1]) begin 
				next_remainder = Result1;
				next_quotient = shifted_quotient | 1;
			end else if(Result3[NUM_BITS-1]) begin 
				next_remainder = Result2;
				next_quotient = shifted_quotient | 2;
			end else begin 
				next_remainder = Result3;
				next_quotient = shifted_quotient | 3;
			end
		end
	end
endmodule
