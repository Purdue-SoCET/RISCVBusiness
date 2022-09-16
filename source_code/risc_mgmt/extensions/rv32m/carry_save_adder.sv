module carry_save_adder #(
    parameter BIT_WIDTH = 32
) (
    input  logic [(BIT_WIDTH-1):0] x,
    input  logic [(BIT_WIDTH-1):0] y,
    input  logic [(BIT_WIDTH-1):0] z,
    output logic [(BIT_WIDTH-1):0] cout,
    output logic [(BIT_WIDTH-1):0] sum
);
    genvar i;
    logic [(BIT_WIDTH-1):0] c;
    generate
        for (i = 0; i < BIT_WIDTH; i = i + 1) begin
            full_adder FA (
                .x(x[i]),
                .y(y[i]),
                .cin(z[i]),
                .cout(c[i]),
                .sum(sum[i])
            );
        end
    endgenerate
    assign cout = c << 1;
endmodule
