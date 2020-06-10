//By            : Joe Nasti
//edited by     : Xinlue Liu
//Last updated  : 6/1/20
//
//Module summary:
//    First step for addition operation in three-step pipline.
//    Shifts smaller fraction by difference in exponents
//
//Inputs:
//    floating_point1/2_in - single precision floating point values
//Outputs:
//    sign_shifted         - sign of the floating point that gets shifted
//    frac_shifted         - fraction of the floating point that gets shifted
//    sign_not_shifted     - sign of the floating point that does not get shifted
//    frac_not_shifted     - fraction of the floating point that does not get shifted
//    exp_max              - max exponent of the two given floating points
module ADD_step1
  (
   input  [31:0] floating_point1_in,
   input  [31:0] floating_point2_in,
   output 	 sign_shifted,
   output [25:0] frac_shifted,
   output 	 sign_not_shifted,
   output [25:0] frac_not_shifted,
   output reg [7:0]  exp_max
   );

   reg  [7:0] 	 unsigned_exp_diff;
   reg 		 cmp_out; //exp1 >= exp2 -> cmp_out == 0
                          //exp1 <  exp2 -> cmp_out == 1
   reg [31:0] 	 floating_point_shift;
   reg [31:0] 	 floating_point_not_shift;
   reg  [31:0] 	 shifted_floating_point;
   
   //compare the exponents of two floating points
   int_compare cmp_exponents (
			      .exp1(floating_point1_in[30:23]), 
			      .exp2(floating_point2_in[30:23]),
			      .u_diff(unsigned_exp_diff),
			      .cmp_out(cmp_out)
			      );
   //determine which one to shift
   //shift the smaller exponent
	always_comb begin
		floating_point_shift = 0;
		if (cmp_out ==1) begin
			floating_point_shift = floating_point1_in;
		end else begin
			floating_point_shift = floating_point2_in;
		end
	end
	always_comb begin
		floating_point_not_shift = 0;
		if (cmp_out == 1) begin
			floating_point_not_shift = floating_point2_in;
		end else begin
			floating_point_not_shift = floating_point1_in;
		end
	end
	always_comb begin
		exp_max = 0;
		if (cmp_out == 1) begin
			exp_max = floating_point2_in[30:23];
		end else begin
			exp_max = floating_point1_in[30:23];
		end
	end
   //assign floating_point_shift = cmp_out ? floating_point1_in : floating_point2_in;
   //assign floating_point_not_shift = cmp_out ? floating_point2_in : floating_point1_in;
   //set the result exponent to the bigger exponent between X and Y
   //assign exp_max = cmp_out ? floating_point2_in[30:23] : floating_point1_in[30:23];
   
   //right shift the smaller fp the amount of the difference of two fps.
   right_shift shift_frac_with_smaller_exp (
	       .fraction({1'b1, floating_point_shift[22:0], 2'b0}),
	       .shift_amount(unsigned_exp_diff),
	       .result(frac_shifted)
	       );

   assign frac_not_shifted = {1'b1, floating_point_not_shift[22:0], 2'b0};
   assign sign_not_shifted = floating_point_not_shift[31];
   assign sign_shifted     = floating_point_shift[31];
   

endmodule
