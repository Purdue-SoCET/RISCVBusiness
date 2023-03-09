module fpu_adder(
  input          clk_i,  
  input          rst_n_i,
  input  [2:0]   rnd_mode_i,
  input  [31:0]  fp_data1_i,
  input  [31:0]  fp_data2_i,
  input          fp_in_dvld_i,
  output [31:0]  fp_sum_data_o,
  output         fp_sum_dvld_o
);

wire sign_data1,sign_data2;
wire [7:0]   exp_data1, exp_data2;  
wire [22:0]  mant_data1, mant_data2;
reg  [22:0]  mant_normalized;
wire [25:0]  mant_shift_data1,mant_shift_data2,mant_sum_shifted;
wire [25:0]  mant_shift_data;
wire [25:0]  mant_noshift_data;
reg          shift_oprnd; 
reg  [7:0]   exp_diff;
wire [25:0]  shifted_mant;
reg  [7:0]   exp_max,exp_normalized;
wire         lead_zeros;
wire [24:0]  mant_sum;
wire         over_flow;
wire         sum_sign;
// sign extraction
assign sign_data1 = fp_data1_i[31];
assign sign_data2 = fp_data2_i[31];

// Exponent extraction
assign exp_data1 = fp_data1_i[30:23];
assign exp_data2 = fp_data2_i[30:23];

// mantissa extraction
assign mant_data1 = fp_data1_i[22:0];
assign mant_data2 = fp_data2_i[22:0];


// exponent difference computation
always@(posedge clk_i)
begin
  if(!rst_n_i) begin
    exp_diff     <= 8'b0;  
	shift_oprnd  <= 1'b0;
	exp_max <= 8'b0; 
  end else begin 
    if(exp_data1 > exp_data2) begin 
	  exp_diff      <= exp_data1-exp_data2;
	  shift_oprnd   <= 1'b0;
	  exp_max  <= exp_data1;
	end else begin
	  exp_diff <= exp_data2-exp_data1;
	  shift_oprnd <= 1'b1;	  
	  exp_max  <= exp_data2;	  
	end  
  end
end  

// shift data selection
assign mant_shift_data1   = {1'b1,mant_data1,2'b0}; 
assign mant_shift_data2   = {1'b1,mant_data2,2'b0}; 
assign mant_shift_data    = shift_oprnd ? mant_shift_data1 :mant_shift_data2;
assign mant_noshift_data  = shift_oprnd ? mant_shift_data2 :mant_shift_data1;

// shift mantissa of smaller exponent by diffference of exponents
shifter_mantissa inst_shifter(
  .mant_data         (mant_shift_data),
  .shift_length      (exp_diff),
  .mant_shift_data   (shifted_mant)
);

// Addition of mantissa or fractional part of the floating point datas
mantissa_adder inst_mantissa_adder
(
  .mant_data1      (mant_noshift_data),
  .mant_data2      (shifted_mant),
  .sign_data1      (sign_data1),
  .sign_data2      (sign_data2),
  .mant_sum        (mant_sum),
  .carry_out       (carry_out),
  .sum_sign        (sum_sign)
);

// Rounding and normalization

lead_zero_detector inst_L0D(
  .mant_sum(mant_sum),
  .mant_sum_shifted(mant_sum_shifted),
  .leading_zeros(lead_zeros)
);


always@(carry_out,exp_max,mant_sum,lead_zeros)
begin
  if(carry_out == 1'b1) begin
    exp_normalized  <= exp_max + 1;
	mant_normalized <= mant_sum[25:3];
  end else begin	
    exp_normalized  <= lead_zeros;
	mant_normalized <= mant_sum[24:2];
  end
end   

assign fp_sum_data_o = {sum_sign,exp_normalized,mant_normalized};


endmodule