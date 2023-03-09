
module shifter_mantissa(
  input      [25:0]   mant_data,
  input      [5:0]    shift_length,
  output reg [25:0]   mant_shift_data
);

// shifting the mantissa based on input shift_length
always@(shift_length,mant_data)
begin
  case (shift_length)
    0        : mant_shift_data <= mant_data;
    1        : mant_shift_data <= {1'd0,  mant_data[25:1]};
    2        : mant_shift_data <= {2'd0,  mant_data[25:2]};
    3        : mant_shift_data <= {3'd0,  mant_data[25:3]};
    4        : mant_shift_data <= {4'd0,  mant_data[25:4]};
    5        : mant_shift_data <= {5'd0,  mant_data[25:5]};
    6        : mant_shift_data <= {6'd0,  mant_data[25:6]};
    7        : mant_shift_data <= {7'd0,  mant_data[25:7]};
    8        : mant_shift_data <= {8'd0,  mant_data[25:8]};
    9        : mant_shift_data <= {9'd0,  mant_data[25:9]};
    10       : mant_shift_data <= {10'd0, mant_data[25:10]};
    11       : mant_shift_data <= {11'd0, mant_data[25:11]};
    12       : mant_shift_data <= {12'd0, mant_data[25:12]};
    13       : mant_shift_data <= {13'd0, mant_data[25:13]};
    14       : mant_shift_data <= {14'd0, mant_data[25:14]};
    15       : mant_shift_data <= {15'd0, mant_data[25:15]};
    16       : mant_shift_data <= {16'd0, mant_data[25:16]};
    17       : mant_shift_data <= {17'd0, mant_data[25:17]};
    18       : mant_shift_data <= {18'd0, mant_data[25:18]};
    19       : mant_shift_data <= {19'd0, mant_data[25:19]};
    20       : mant_shift_data <= {20'd0, mant_data[25:20]};
    21       : mant_shift_data <= {21'd0, mant_data[25:21]};
    22       : mant_shift_data <= {22'd0, mant_data[25:22]};
    23       : mant_shift_data <= {23'd0, mant_data[25:23]};
    24       : mant_shift_data <= {23'd0, mant_data[25:24]};
    25       : mant_shift_data <= {23'd0, mant_data[25]};
    default  : mant_shift_data <=  23'd0;
  endcase;
end  

endmodule