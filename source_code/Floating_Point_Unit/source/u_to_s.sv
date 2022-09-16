//By            : Joe Nasti
//Last Updated  : 7/21/18
//
//Module Summary:
//    Converts a one bit sign and 26 bit magnitude to a 27 bit signed value
//
//Inputs:
//    sign          - one bit value to represent the sign (0 -> +, 1 -> -)
//    frac_unsigned - 26 bit unsigned magnitude
//Outputs:
//    frac_signed   - 27 bit signed result of conversion

module u_to_s (
    input             sign,
    input      [25:0] frac_unsigned,
    output reg [26:0] frac_signed
);

    always_comb begin
        frac_signed = {1'b0, frac_unsigned};
        if (sign == 1) begin
            frac_signed = -frac_signed;
        end
    end
endmodule
