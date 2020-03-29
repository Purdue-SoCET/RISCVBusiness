module c_to_cp
  (
   input [26:0] frac2_input,
   output reg [26:0] frac2_output
   );
 
   always_comb begin
   //find the two's complement of the frac2
      frac2_output[26:0] = (~frac2_input[26:0] + 1'b1);
   end
   
   
endmodule // c_to_cp
