module lead_zero_detector(
  input       [25:0] mant_sum,
  output  reg [25:0] mant_sum_shifted,
  output  reg [7:0]  leading_zeros
);


always@(mant_sum)
begin
    casez (mant_sum)
        26'b01????????????????????????: begin
            mant_sum_shifted = {mant_sum[24:0], 1'd0};
            leading_zeros = 1;
        end
        26'b001???????????????????????: begin
            mant_sum_shifted = {mant_sum[23:0], 2'd0};
            leading_zeros = 2;
        end
        26'b0001??????????????????????: begin
            mant_sum_shifted = {mant_sum[22:0], 3'd0};
            leading_zeros = 3;
        end
        26'b00001?????????????????????: begin
            mant_sum_shifted = {mant_sum[21:0], 4'd0};
            leading_zeros = 4;
        end
        26'b000001????????????????????: begin
            mant_sum_shifted = {mant_sum[20:0], 5'd0};
            leading_zeros = 5;
        end
        26'b0000001???????????????????: begin
            mant_sum_shifted = {mant_sum[19:0], 6'd0};
            leading_zeros = 6;
        end
        26'b00000001??????????????????: begin
            mant_sum_shifted = {mant_sum[18:0], 7'd0};
            leading_zeros = 7;
        end
        26'b000000001?????????????????: begin
            mant_sum_shifted = {mant_sum[17:0], 8'd0};
            leading_zeros = 8;
        end
        26'b0000000001????????????????: begin
            mant_sum_shifted = {mant_sum[16:0], 9'd0};
            leading_zeros = 9;
        end
        26'b00000000001???????????????: begin
            mant_sum_shifted = {mant_sum[15:0], 10'd0};
            leading_zeros = 10;
        end
        26'b000000000001??????????????: begin
            mant_sum_shifted = {mant_sum[14:0], 11'd0};
            leading_zeros = 11;
        end
        26'b0000000000001?????????????: begin
            mant_sum_shifted = {mant_sum[13:0], 12'd0};
            leading_zeros = 12;
        end
        26'b00000000000001????????????: begin
            mant_sum_shifted = {mant_sum[12:0], 13'd0};
            leading_zeros = 13;
        end
        26'b000000000000001???????????: begin
            mant_sum_shifted = {mant_sum[11:0], 14'd0};
            leading_zeros = 14;
        end
        26'b0000000000000001??????????: begin
            mant_sum_shifted = {mant_sum[10:0], 15'd0};
            leading_zeros = 15;
        end
        26'b00000000000000001?????????: begin
            mant_sum_shifted = {mant_sum[9:0], 16'd0};
            leading_zeros = 16;
        end
        26'b000000000000000001????????: begin
            mant_sum_shifted = {mant_sum[8:0], 17'd0};
            leading_zeros = 17;
        end
        26'b0000000000000000001???????: begin
            mant_sum_shifted = {mant_sum[7:0], 18'd0};
            leading_zeros = 18;
        end
        26'b00000000000000000001??????: begin
            mant_sum_shifted = {mant_sum[6:0], 19'd0};
            leading_zeros = 19;
        end
        26'b000000000000000000001?????: begin
            mant_sum_shifted = {mant_sum[5:0], 20'd0};
            leading_zeros = 20;
        end
        26'b0000000000000000000001????: begin
            mant_sum_shifted = {mant_sum[4:0], 21'd0};
            leading_zeros = 21;
        end
        26'b00000000000000000000001???: begin
            mant_sum_shifted = {mant_sum[3:0], 22'd0};
            leading_zeros = 22;
        end
        26'b000000000000000000000001??: begin
            mant_sum_shifted = {mant_sum[2:0], 23'd0};
            leading_zeros = 23;
        end
        26'b0000000000000000000000001?: begin
            mant_sum_shifted = {mant_sum[1:0], 24'd0};
            leading_zeros = 24;
        end
        26'b00000000000000000000000001: begin
            mant_sum_shifted = {mant_sum[0], 25'd0};
            leading_zeros = 25;
        end
    endcase
end

endmodule

  