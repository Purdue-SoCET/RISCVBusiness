//By            : Joe Nasti
//Last updated  : 7/23/18
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
module ADD_step1 (
    input [31:0] floating_point1_in,
    input [31:0] floating_point2_in,
    output sign_shifted,
    output [25:0] frac_shifted,
    output sign_not_shifted,
    output [25:0] frac_not_shifted,
    output [7:0] exp_max
);

    reg  [7:0]   unsigned_exp_diff;
    reg    cmp_out; //exp1 >= exp2 -> cmp_out == 0
    //exp1 <  exp2 -> cmp_out == 1
    wire [31:0]   floating_point_shift;
    wire [31:0]   floating_point_not_shift;
    reg  [31:0]   shifted_floating_point;

    int_compare cmp_exponents (
        .exp1(floating_point1_in[30:23]),
        .exp2(floating_point2_in[30:23]),
        .u_diff(unsigned_exp_diff),
        .cmp_out(cmp_out)
    );
    assign floating_point_shift = cmp_out ? floating_point1_in : floating_point2_in;
    assign floating_point_not_shift = cmp_out ? floating_point2_in : floating_point1_in;
    assign exp_max = cmp_out ? floating_point2_in[30:23] : floating_point1_in[30:23];

    right_shift shift_frac_with_smaller_exp (
        .fraction({1'b1, floating_point_shift[22:0], 2'b0}),
        .shift_amount(unsigned_exp_diff),
        .result(frac_shifted)
    );

    assign frac_not_shifted = {1'b1, floating_point_not_shift[22:0], 2'b0};
    assign sign_not_shifted = floating_point_not_shift[31];
    assign sign_shifted     = floating_point_shift[31];


endmodule
