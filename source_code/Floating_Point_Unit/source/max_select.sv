// not used

module max_select (
    input      [7:0] exp1,
    input      [7:0] exp2,
    output reg [7:0] max
);

    reg [8:0] u_exp1;
    reg [8:0] u_exp2;
    reg [8:0] diff;

    assign u_exp1 = {1'b0, exp1};
    assign u_exp2 = {1'b0, exp2};
    assign diff   = u_exp1 - u_exp2;

    always_comb begin
        if (diff[8] == 0) max = exp1;
        else max = exp2;
    end
endmodule
