//By            : Joe Nasti
//Last Updated  : 7.16.18
//
//Module Summary:
//    adds two signed 26 bit fraction values
//
//Inputs:
//    frac1/2 - signed 26 bit values with decimal point fixed after second bit
//Outputs:
//    sum     - output of sum operation regardless of overflow
//    ovf     - high if an overflow has occured

module adder_26b (
    input      [26:0] frac1,
    input      [26:0] frac2,
    output reg [26:0] sum,
    output reg        ovf
);

    always_comb begin

        sum = frac1 + frac2;
        ovf = 0;

        if (frac1[26] == 1 && frac2[26] == 1 && sum[26] == 0) begin
            ovf = 1;
            sum[26] = 1;
        end

        if (frac1[26] == 0 && frac2[26] == 0 && sum[26] == 1) begin
            ovf = 1;
            sum[26] = 0;
        end

    end
endmodule
