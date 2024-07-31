// SIMD
// 1. multiplicand       2. multiplier        3. simd3          4.simd4
// [31:16] = multiplicand [15:0] = multiplier
// simd_signed    [1:0]                 [3:2]         [5:4]            [7:6]
// product        [31:0]                [63:16]       simd_product3    simd_product4
module vedic_mul32(
    input logic CLK,
    input logic nRST,
    input logic [31:0] multiplicand,
    input logic [31:0] multiplier,
    input logic [15:0] simd_multiplicand3,
    input logic [15:0] simd_multiplier3,
    input logic [15:0] simd_multiplicand4,
    input logic [15:0] simd_multiplier4,
    input logic [127:0] simd_8_bit_operands,
    input logic [1:0] is_signed,
    input logic start,
    input logic is_simd_8,
    input logic is_simd_16,
    input logic [31:0] simd_signed,
    output logic finished,
    output logic [63:0] product,
    output logic [31:0] simd_product3,
    output logic [31:0] simd_product4,
    output logic [127:0] simd_product_8_bits
);

logic [31:0] pp[4];
logic is_finished[4];
logic [15:0] multiplicands[4], multipliers[4];
logic [1:0] vedic_is_signed[4];
logic [15:0] vedic_simd_product3[4], vedic_simd_product4[4];

genvar i;

assign finished = (is_finished[0] && is_finished[1] && is_finished[2] && is_finished[3]);

always_comb begin
    product = {pp[0], 32'b0} + {{16{pp[1][31]}}, pp[1], 16'b0} + {{16{pp[2][31]}}, pp[2], 16'b0} + {{32{pp[3][31]}}, pp[3]};
    simd_product3 = pp[2];
    simd_product4 = pp[3];

    simd_product_8_bits = {
                            vedic_simd_product4[3], vedic_simd_product3[3],
                            vedic_simd_product4[2], vedic_simd_product3[2],
                            vedic_simd_product4[1], vedic_simd_product3[1],
                            vedic_simd_product4[0], vedic_simd_product3[0]
                            };

    if (is_simd_8) begin
        product = {pp[1], pp[0]};
        simd_product3 = pp[2];
        simd_product4 = pp[3];

    end
    else if (is_simd_16) begin
        product = {pp[1], pp[0]};
    end
end

always_comb begin
    // default not simd unsigned
    vedic_is_signed[0] = '0;
    vedic_is_signed[1] = '0;
    vedic_is_signed[2] = '0;
    vedic_is_signed[3] = '0;

    // default not simd
    multiplicands[0] = multiplicand[31:16];
    multiplicands[1] = multiplicand[31:16];
    multiplicands[2] = multiplicand[15:0];
    multiplicands[3] = multiplicand[15:0];

    multipliers[0] = multiplier[31:16];
    multipliers[1] = multiplier[15:0];
    multipliers[2] = multiplier[31:16];
    multipliers[3] = multiplier[15:0];
    
    if(!(is_simd_8 || is_simd_16)) begin
        if(is_signed != 2'b0) begin
            casez(is_signed)
                2'b01: begin
                    vedic_is_signed[0] = 2'b01;
                    vedic_is_signed[1] = 2'b00;
                    vedic_is_signed[2] = 2'b01;
                end
                2'b10: begin
                    vedic_is_signed[0] = 2'b10;
                    vedic_is_signed[1] = 2'b10;
                    vedic_is_signed[2] = 2'b00;
                end
                2'b11: begin
                    vedic_is_signed[0] = 2'b11;
                    vedic_is_signed[1] = 2'b10;
                    vedic_is_signed[2] = 2'b01;
                end
                default: ;
            endcase
        end
    end
    else begin
        if (is_simd_16) begin
            vedic_is_signed[0] = simd_signed[1:0];
            vedic_is_signed[1] = simd_signed[3:2];
            vedic_is_signed[2] = simd_signed[5:4];
            vedic_is_signed[3] = simd_signed[7:6];
        end

        multiplicands[0] = multiplicand[31:16];
        multipliers[0]   = multiplicand[15:0];

        multiplicands[1] = multiplier[31:16];
        multipliers[1]   = multiplier[15:0];

        multiplicands[2] = simd_multiplicand3;
        multipliers[2]   = simd_multiplier3;

        multiplicands[3] = simd_multiplicand4;
        multipliers[3]   = simd_multiplier4;
    end
end

generate
    for (i = 0; i < 4; i = i + 1) begin
        vedic_mul16 mul16(
            .CLK(CLK),
            .nRST(nRST),
            .multiplicand(multiplicands[i]),
            .multiplier(multipliers[i]),
            .simd_multiplicand3(simd_8_bit_operands[i * 32 + 7 : i * 32]),
            .simd_multiplier3(simd_8_bit_operands[i * 32 + 15 : i * 32 + 8]),
            .simd_multiplicand4(simd_8_bit_operands[i * 32 + 23 : i * 32 + 16]),
            .simd_multiplier4(simd_8_bit_operands[i * 32 + 31 : i * 32 + 24]),
            .is_signed(vedic_is_signed[i]),
            .start(start),
            .is_simd(is_simd_8),
            .simd_signed(simd_signed[i * 8 + 7:i * 8]),
            .finished(is_finished[i]),
            .product(pp[i]),
            .simd_product3(vedic_simd_product3[i]),
            .simd_product4(vedic_simd_product4[i])
        );
    end
endgenerate

endmodule;