//By            : Joe Nasti
//Last Updated  : 7/23/18
//
//Module Summary:
//    Third step of addition operation in three-step pipeline.
//    Rounds result based on rounding mode (frm) and left shifts fraction if needed
//
//Inputs:
//    frm              - 3 bit rounding mode
//    exponent_max_in  - exponent of result floating point
//    sign_in          - sign of result floating point
//    frac_in          - fraction of result floating point
//    carry_out        - carry out from step 2
//Outputs:
//    floating_point_out - final floating point

module ADD_step3 (
    input ovf_in,
    input unf_in,
    input dz,  // divide by zero flag
    input inv,
    input [2:0] frm,
    input [7:0] exponent_max_in,
    input sign_in,
    input [25:0] frac_in,
    input carry_out,
    output [31:0] floating_point_out,
    output [4:0] flags
);

    wire        inexact;
    wire        sign;
    wire [ 7:0] exponent;
    wire [22:0] frac;

    assign {sign, exponent, frac} = floating_point_out;

    reg [ 7:0] exp_minus_shift_amount;
    reg [25:0] shifted_frac;
    reg [ 7:0] shifted_amount;
    reg [ 7:0] exp_out;
    reg        ovf;
    reg        unf;


    left_shift shift_left (
        .fraction(frac_in),
        .result(shifted_frac),
        .shifted_amount(shifted_amount)
    );

    subtract SUB (
        .exp1(exponent_max_in),
        .shifted_amount(shifted_amount),
        .result(exp_minus_shift_amount)
    );


    reg [24:0] round_this;

    always_comb begin
        ovf = 0;
        unf = 0;
        if (carry_out == 1) begin
            round_this = frac_in[25:1];
            exp_out    = exponent_max_in + 1;
            if ((exponent_max_in == 8'b11111110) && (~unf_in)) ovf = 1;
        end else begin
            round_this = shifted_frac[24:0];
            exp_out    = exp_minus_shift_amount;
            if (({1'b0, exponent_max_in} < shifted_amount) && (~ovf_in)) unf = 1;
        end
    end

    reg [31:0] round_out;

    rounder ROUND (
        .frm(frm),
        .sign(sign_in),
        .exp_in(exp_out),
        .fraction(round_this),
        .round_out(round_out),
        .rounded(round_flag)
    );

    assign inexact = ovf_in | ovf | unf_in | unf | round_flag;
    assign flags = {inv, dz, (ovf | ovf_in), (unf | unf_in), inexact};
    assign floating_point_out[31] = round_out[31];
    assign floating_point_out[30:0] = inv    ? 31'b1111111101111111111111111111111 :
				     ovf_in ? 31'b1111111100000000000000000000000 :
				     ovf    ? 31'b1111111100000000000000000000000 :
				     unf_in ? 31'b0000000000000000000000000000000 :
				     unf    ? 31'b0000000000000000000000000000000 :
				     round_out[30:0];

endmodule
