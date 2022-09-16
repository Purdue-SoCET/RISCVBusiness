//By            : Joe Nasti
//Last Updated  : 7/18/18
//
//Module Summary:
//    right shifts a 26 bit value by a given amount
//
//Inputs:
//    fraction     - 26 bit value to be shifted
//    shift_amount - unsigned 8 bit value amount to shift fraction
//Outputs:
//    result       - 26 bit result of the shift

module right_shift (
    input      [25:0] fraction,
    input      [ 7:0] shift_amount,
    output reg [25:0] result
);

    always_comb begin
        case (shift_amount)
            0: result = fraction;
            1: result = {1'd0, fraction[25:1]};
            2: result = {2'd0, fraction[25:2]};
            3: result = {3'd0, fraction[25:3]};
            4: result = {4'd0, fraction[25:4]};
            5: result = {5'd0, fraction[25:5]};
            6: result = {6'd0, fraction[25:6]};
            7: result = {7'd0, fraction[25:7]};
            8: result = {8'd0, fraction[25:8]};
            9: result = {9'd0, fraction[25:9]};
            10: result = {10'd0, fraction[25:10]};
            11: result = {11'd0, fraction[25:11]};
            12: result = {12'd0, fraction[25:12]};
            13: result = {13'd0, fraction[25:13]};
            14: result = {14'd0, fraction[25:14]};
            15: result = {15'd0, fraction[25:15]};
            16: result = {16'd0, fraction[25:16]};
            17: result = {17'd0, fraction[25:17]};
            18: result = {18'd0, fraction[25:18]};
            19: result = {19'd0, fraction[25:19]};
            20: result = {20'd0, fraction[25:20]};
            21: result = {21'd0, fraction[25:21]};
            22: result = {22'd0, fraction[25:22]};
            23: result = {23'd0, fraction[25:23]};
            24: result = {24'd0, fraction[25:24]};
            25: result = {25'd0, fraction[25]};
            default: result = 26'd0;
        endcase
    end
endmodule

