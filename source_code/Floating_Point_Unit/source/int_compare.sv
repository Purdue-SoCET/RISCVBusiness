//By            : Joe Nasti
//Last Updated  : 7/16/18
//
//Module Summary:
//    Compares magnitude of two unsigned 8 bit integers
//
//Inputs:
//    exp1/2 - 8 bit unsigned integers
//Outputs:
//    u_diff  - unsigned difference between exp1 and exp2
//    cmp_out - exp1 < exp2 -> 1, exp1 >= exp2 -> 0

module int_compare (
    input      [7:0] exp1,
    input      [7:0] exp2,
    output     [7:0] u_diff,
    output reg       cmp_out
);

    wire [8:0] u_exp1 = {1'b0, exp1};
    wire [8:0] u_exp2 = {1'b0, exp2};
    reg [8:0] diff;

    assign u_diff = diff[7:0];

    always_comb begin
        diff = u_exp1 - u_exp2;
        case (diff[8])
            1'b0: cmp_out = 1'b0;
            1'b1: begin
                cmp_out = 1'b1;
                diff = -diff;
            end
        endcase
    end
endmodule


