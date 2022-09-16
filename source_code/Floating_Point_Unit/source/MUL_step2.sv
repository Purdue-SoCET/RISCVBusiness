//By            : Joe Nasti
//Last Updated  : 9/3/18
//
//Module Summary:
//    Second step of multiplication in three-step pipeline
//    Adds exponents together and xor's sign bits
//
//Inputs:
//    sign1/2 - signs to be xor'ed
//    exp1/2  - exponents to be added together
//Outputs:
//    sign_out - result of xor operation
//    sum_exp  - result of addition
//    ovf      - signal if an overflow has occurred
//    unf      - signal if an undeflow has occurred

module MUL_step2 (
    input            sign1,
    input            sign2,
    input      [7:0] exp1,
    input      [7:0] exp2,
    output           sign_out,
    output     [7:0] sum_exp,
    output reg       ovf,
    output reg       unf,
    input            carry
);


    adder_8b add_EXPs (
        .carry(carry),
        .exp1 (exp1),
        .exp2 (exp2),
        .sum  (sum_exp),
        .ovf  (ovf),
        .unf  (unf)
    );

    assign sign_out = sign1 ^ sign2;

endmodule
