module vedic_mul16(
    input logic CLK,
    input logic nRST,
    input logic [15:0] multiplicand,
    input logic [15:0] multiplier,
    input logic [1:0] is_signed,
    input logic start,
    output logic finished,
    output logic [31:0] product
);

logic [15:0] pp[4];
logic is_finished[4];
logic [7:0] multiplicands[4], multipliers[4];
logic [1:0] vedic_is_signed[4];

assign finished = (is_finished[0] && is_finished[1] && is_finished[2] && is_finished[3]);
assign product = {pp[0], 16'b0} + {{8{pp[1][15]}}, pp[1], 8'b0} + {{8{pp[2][15]}}, pp[2], 8'b0} + {16'b0, pp[3]};

always_comb begin
    vedic_is_signed[0] = '0;
    vedic_is_signed[1] = '0;
    vedic_is_signed[2] = '0;
    vedic_is_signed[3] = '0;
    if(is_signed != 2'b0) begin
        vedic_is_signed[0] = 2'b11;
        vedic_is_signed[1] = 2'b10;
        vedic_is_signed[2] = 2'b01;
    end

    multiplicands[0] = multiplicand[15:8];
    multiplicands[1] = multiplicand[15:8];
    multiplicands[2] = multiplicand[7:0];
    multiplicands[3] = multiplicand[7:0];

    multipliers[0]   = multiplier[15:8];
    multipliers[1]   = multiplier[7:0];
    multipliers[2]   = multiplier[15:8];
    multipliers[3]   = multiplier[7:0];
end

mul8 mul8_1(
    .CLK(CLK),
    .nRST(nRST),
    .multiplicand(multiplicands[0]),
    .multiplier(multipliers[0]),
    .is_signed(vedic_is_signed[0]),
    .start(start),
    .finished(is_finished[0]),
    .product(pp[0])
);

mul8 mul8_2(
    .CLK(CLK),
    .nRST(nRST),
    .multiplicand(multiplicands[1]),
    .multiplier(multipliers[1]),
    .is_signed(vedic_is_signed[1]),
    .start(start),
    .finished(is_finished[1]),
    .product(pp[1])
);

mul8 mul8_3(
    .CLK(CLK),
    .nRST(nRST),
    .multiplicand(multiplicands[2]),
    .multiplier(multipliers[2]),
    .is_signed(vedic_is_signed[2]),
    .start(start),
    .finished(is_finished[2]),
    .product(pp[2])
);

mul8 mul8_4(
    .CLK(CLK),
    .nRST(nRST),
    .multiplicand(multiplicands[3]),
    .multiplier(multipliers[3]),
    .is_signed(vedic_is_signed[3]),
    .start(start),
    .finished(is_finished[3]),
    .product(pp[3])
);

endmodule;