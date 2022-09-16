//By            : Joe Nasti
//Last Updated  : 7/18/18
//
//Module Summary:
//    rounds floating point after the operation according to the frm (rounding mode)
//
//Inputs:
//    frm       - rounding mode
//    sign      - one bit sign of floating point
//    exp_in    - 8 bit exponent of floating point
//    fraction  - 25 bit fraction of floating point (2 extra least significant bits used for rounding)
//Ouputs:
//    rount_out - resulting floating point after rounding operation

module rounder (
    input      [ 2:0] frm,
    input             sign,
    input      [ 7:0] exp_in,
    input      [24:0] fraction,
    output reg [31:0] round_out,
    output            rounded
);
    reg round_amount;

    localparam RNE = 3'b000;
    localparam RZE = 3'b001;
    localparam RDN = 3'b010;
    localparam RUP = 3'b011;
    localparam RMM = 3'b100;

    always_comb begin
        round_amount = 0;
        if (fraction[24:2] != '1) begin
            if (frm == RNE) begin
                if (fraction[1:0] == 2'b11) round_amount = 1;
            end else if (frm == RZE) begin
                round_amount = 0;
            end else if (frm == RDN) begin
                if (sign == 1 && ((fraction[0] == 1) || (fraction[1] == 1))) round_amount = 1;
            end else if (frm == RUP) begin
                if (sign == 0 && ((fraction[0] == 1) || (fraction[1] == 1))) round_amount = 1;
            end else if (frm == RMM) begin
                if (fraction[1] == 1) round_amount = 1;
            end
        end  // if (fraction[24:2] != '1)
    end  // always_comb

    assign rounded   = round_amount;
    assign round_out = {sign, exp_in, fraction[24:2] + round_amount};

endmodule


