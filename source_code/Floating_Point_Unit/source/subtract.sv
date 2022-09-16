// subtracts shifted amount from the exponent

module subtract (
    input  [7:0] exp1,
    input  [7:0] shifted_amount,
    output [7:0] result
);

    reg [8:0] u_exp1 = {1'b0, exp1};
    reg [8:0] u_shifted_amount = {1'b0, shifted_amount};
    reg [8:0] u_result;

    always_comb begin
        u_exp1           = {1'b0, exp1};
        u_shifted_amount = {1'b0, shifted_amount};
        u_result         = u_exp1 - u_shifted_amount;
    end

    assign result = u_result[7:0];
endmodule  // subtract
