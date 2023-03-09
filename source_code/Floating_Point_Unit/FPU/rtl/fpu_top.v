
module fpu_top(
  input              clk_i ,
  input              rst_n_i,
  input       [31:0] fp_datain1_i,
  input       [31:0] fp_datain2_i,
  input              fp_in_dvld,
  input       [6 :0] op_code_i,
  input       [2 :0] rnd_mode_i,
  output  reg [31:0] fp_result_o,
  output  reg        fp_out_dvld,
  output  reg [4:0]  flags_o
);

// operation code definitions
localparam ADD = 7'b0100000;
localparam SUB = 7'b0010000;
localparam MUL = 7'b0000010;


wire [31:0] s_sum_addder;
wire [4:0]  s_adder_flags;
wire [31:0] s_sub_data;
wire [4:0]  s_sub_flags;
wire [31:0] s_product;
wire [4:0]  s_prod_flags;
wire        s_prod_dvld;
wire        s_sum_dvld;
wire        s_sub_dvld;

// opcode selection
always@(posedge clk_i)
begin
  if(!rst_n_i) begin
    fp_result_o <= 32'b0;
    flags_o     <= 5'b0;
	fp_out_dvld <= 1'b0;
  end else begin
    case (op_code_i)
      ADD   : begin
                fp_result_o <= s_sum_addder;
                flags_o     <= s_adder_flags;
				fp_out_dvld <= s_sum_dvld;
              end
      SUB   : begin
                fp_result_o <= s_sub_data;
                flags_o     <= s_sub_flags;
				fp_out_dvld <= s_sub_dvld;				
              end   

      MUL   : begin
                fp_result_o <= s_product;
                flags_o     <= s_prod_flags;
				fp_out_dvld <= s_prod_dvld;								
              end
    endcase
  end	
end 

// multiplication
// multiplier_float_top FPU_multiplier(
  // .i_clk          (clk_i),
  // .i_rst          (rst_n_i),
  // .i_start        (fp_in_dvld),
  // .i_multiplicand (fp_datain1_i),
  // .i_multiplier   (fp_datain2_i),
  // .o_done         (s_prod_dvld),
  // .o_product      (s_product),
  // .o_ovrflow      (),
  // .o_undrflow     ()
// );


// floating point adder
fpu_adder inst_fpu_adder(
  .clk_i          (clk_i),
  .rst_n_i        (rst_n_i),
  .rnd_mode_i     (rnd_mode_i),
  .fp_data1_i     (fp_datain1_i),
  .fp_data2_i     (fp_datain2_i) ,
  .fp_in_dvld_i   (fp_in_dvld),
  .fp_sum_data_o  (s_sum_addder),
  .fp_sum_dvld_o  (s_sum_dvld)
);

endmodule