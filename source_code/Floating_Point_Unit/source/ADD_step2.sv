//By            : Joe Nasti
//Last Updated  : 7/23/18
//
//Module Summary:
//    Second Step for addition operation in three-step pipeline
//    Adds the fractions with sign bit from ADD_step1
//
//Inputs:
//    frac1/2    - magnitudes of fractions to be added
//    sign1/2    - signs of fractions to be added
//    exp_max_in - max exponent from step1 (if the sum is zero the exponent is set to zero)
//Outputs:
//    sign_out    - sign of the result
//    sum         - magnitude of the result regardless of any carry out
//    carry_out   - signal if there is an oveflow from the addition
//    exp_max_out - if sum is non-zero, this is equal to exp_max_in

module ADD_step2 (
    input      [25:0] frac1,
    input             sign1,
    input      [25:0] frac2,
    input             sign2,
    input      [ 7:0] exp_max_in,  //
    output            sign_out,
    output     [25:0] sum,
    output            carry_out,
    output reg [ 7:0] exp_max_out  //
);

    reg [26:0] frac1_signed;
    reg [26:0] frac2_signed;
    reg [26:0] sum_signed;

    always_comb begin : exp_max_assignment
        if (sum_signed == 0) exp_max_out = 8'b00000000;
        else exp_max_out = exp_max_in;
    end



    u_to_s change_to_signed1 (
        .sign(sign1),
        .frac_unsigned(frac1),
        .frac_signed(frac1_signed)
    );

    u_to_s change_to_signed2 (
        .sign(sign2),
        .frac_unsigned(frac2),
        .frac_signed(frac2_signed)
    );

    adder_26b add_signed_fracs (
        .frac1(frac1_signed),
        .frac2(frac2_signed),
        .sum  (sum_signed),
        .ovf  (carry_out)
    );

    s_to_u change_to_unsigned (
        .frac_signed(sum_signed),
        .sign(sign_out),
        .frac_unsigned(sum)
    );


endmodule

