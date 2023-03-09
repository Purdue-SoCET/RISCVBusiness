
module fpu_tb ();

reg          clk;
reg          rst_n;
reg  [31:0]  fp_data1;
reg  [31:0]  fp_data2;
reg          fp_dvld;
reg  [6:0]   op_code;
reg  [2 :0]  rnd_mode;
wire [31:0]  fp_result;
wire         fp_out_dvld;
wire  [4:0]   fp_flags;

//
fpu_top inst_fpu_top(
  .clk_i             (clk),
  .rst_n_i           (rst_n),
  .fp_datain1_i      (fp_data1),
  .fp_datain2_i      (fp_data2),
  .fp_in_dvld        (fp_dvld),
  .op_code_i         (op_code),
  .rnd_mode_i        (rnd_mode),
  .fp_result_o       (fp_result),
  .fp_out_dvld       (fp_out_dvld),
  .flags_o           (fp_flags)
);


always
begin
  #5 clk <= ~clk;
end 

initial
begin
  clk        <= 1'b0;
  rst_n      <= 1'b0;
  fp_dvld    <= 1'b0;
  fp_data1   <= 32'h0;   
  fp_data2   <= 32'h0;
  #25 
  rst_n      <= 1'b1;
  #20 
  op_code  <= 7'b0100000;
  fp_data1 <= 32'h3f4ccccd;   
  fp_data2 <= 32'hbfd9999a;
  #10
  fp_dvld  <= 1'b1;
  #15
  fp_dvld  <= 1'b0;
end



endmodule