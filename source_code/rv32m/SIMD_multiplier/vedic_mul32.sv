module vedic_mul32(
    input logic CLK,
    input logic nRST,
    input logic [31:0] multiplicand,
    input logic [31:0] multiplier,
    input logic [1:0] is_signed,
    input logic start,
    output logic finished,
    output logic [63:0] product
);

logic [31:0] pp1, pp2, pp3, pp4;
logic finished1, finished2, finished3, finished4;

assign finished = finished1 && finished2 && finished3 && finished4;

assign product = (pp1 << 32) + (pp2 << 16) + (pp3 << 16) + pp4;

vedic_mul16 vedic_mul16_1(
    .CLK(CLK),
    .nRST(nRST),
    .multiplicand(multiplicand[31:16]),
    .multiplier(multiplier[31:16]),
    .is_signed(),
    .start(start),
    .finished(finished1),
    .product(pp1)
);

vedic_mul16 vedic_mul16_2(
    .CLK(CLK),
    .nRST(nRST),
    .multiplicand(multiplicand[31:16]),
    .multiplier(multiplier[15:0]),
    .is_signed(),
    .start(start),
    .finished(finished2),
    .product(pp2)
);

vedic_mul16 vedic_mul16_3(
    .CLK(CLK),
    .nRST(nRST),
    .multiplicand(multiplicand[15:0]),
    .multiplier(multiplier[31:16]),
    .is_signed(),
    .start(start),
    .finished(finished3),
    .product(pp3)
);

vedic_mul16 vedic_mul16_4(
    .CLK(CLK),
    .nRST(nRST),
    .multiplicand(multiplicand[15:0]),
    .multiplier(multiplier[15:0]),
    .is_signed(),
    .start(start),
    .finished(finished4),
    .product(pp4)
);

endmodule;