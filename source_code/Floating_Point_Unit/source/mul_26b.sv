//By            : Joe Nasti
//Last Updated  : 7/18/18
//
//Module Summary:
//    multiplies two 26 bit fraction values with decimal point after the first bit
//
//Inputs:
//    frac_in1/2 - 26 bit fractions with decimal point after first bit
//Outputs:
//    frac_out   - 26 bit result of operation regardless of overflow occuring
//    overflow   - flags if an overflow has occured

module mul_26b (
    input  [25:0] frac_in1,
    input  [25:0] frac_in2,
    output [25:0] frac_out,
    output        overflow
);

    reg [51:0] frac_out_52b;

    assign overflow = frac_out_52b[51];
    assign frac_out = frac_out_52b[50:25];

    always_comb begin : MULTIPLY
        frac_out_52b = frac_in1 * frac_in2;

    end
endmodule
