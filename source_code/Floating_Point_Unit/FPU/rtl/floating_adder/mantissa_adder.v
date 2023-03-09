
module mantissa_adder
(
  input      [25:0]  mant_data1,
  input      [25:0]  mant_data2,
  input              sign_data1,
  input              sign_data2,
  output reg [25:0]  mant_sum,
  output reg         carry_out,
  output             sum_sign 
);


reg [25:0] signed_mant_data1;
reg [25:0] signed_mant_data2;
reg [26:0] mant_sum_temp;
reg        sum_msb;



// unsigned to signed conversion of mantissa data1
always@(mant_data1,sign_data1)
begin
  if(sign_data1) begin
    signed_mant_data1 <= -mant_data1;
  end else begin
    signed_mant_data1 <= mant_data1;
  end
end  

// unsigned to signed conversion of mantissa data2
always@(mant_data2,sign_data2)
begin
  if(sign_data2) begin
    signed_mant_data2 <= -mant_data2;
  end else begin
    signed_mant_data2 <= mant_data2;
  end
end 

// addition of signed mantissas
always@(signed_mant_data1,signed_mant_data2)
begin
  mant_sum_temp  <= signed_mant_data1 + signed_mant_data2;
end

// generation of overflow signal
always@(mant_sum_temp,sign_data1,sign_data1)
begin 
  if(signed_mant_data1[26] == 1'b1 && signed_mant_data2[26] == 1'b1 && mant_sum_temp[26] == 1'b0) begin
    carry_out <= 1'b1;
    sum_msb   <= 1'b1;
  end else if(signed_mant_data1[26]== 1'b0 && signed_mant_data2[26] == 1'b0 && mant_sum_temp[26] == 1'b1) begin
    carry_out <= 1'b1;
    sum_msb   <= 1'b0;
  end else begin
    carry_out <= 1'b0;
    sum_msb   <= 1'b0;
  end   
end

//  mantissa sum extraction and signed to unsigned computation
always@(sum_msb,mant_sum_temp)
begin
  if(sum_msb) begin
    mant_sum <= -mant_sum_temp[25:0];
  end else begin
    mant_sum <=  mant_sum_temp[25:0];
  end
end   

assign sum_sign = sum_msb; 

endmodule