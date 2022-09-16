//By            : Joe Nasti
//Last Updated  : 7/18/18
//
//Module Summary:
//    converts a signed 27 value to a 26 bit magnitude and a one bit sign
//
//Inputs:
//    frac_signed   - 27 bit signed value
//Outputs:
//    sign          - 1 bit sign 'frac_unsigned'
//    frac_unsigned - 26 bit magnitude of 'frac_signed'

module s_to_u (
    input      [26:0] frac_signed,
    output reg        sign,
    output     [25:0] frac_unsigned
);

    reg [26:0] rfrac_signed;

    assign frac_unsigned = rfrac_signed[25:0];

    always_comb begin
        sign = 0;
        rfrac_signed = frac_signed;
        if (frac_signed[26] == 1) begin
            rfrac_signed = -frac_signed;
            sign         = 1;
        end
    end
endmodule
