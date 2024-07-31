module tb_mul32();

//clock
parameter PERIOD = 10;
logic CLK = 0;

logic nRST;
logic [31:0] multiplicand, multiplier;
logic [1:0] is_signed;
logic [31:0] simd_signed;
logic start;
logic is_simd_8, is_simd_16;
logic finished;
logic [63:0] product;
logic [31:0] simd_product3, simd_product4;
logic [15:0] simd_multiplicand3, simd_multiplicand4,
            simd_multiplier3,   simd_multiplier4;
logic [127:0] simd_8_bit_operands, simd_product_8_bits;

vedic_mul32 DUT(.CLK(CLK),
         .nRST(nRST),
         .multiplicand(multiplicand),
         .multiplier(multiplier),
         .simd_multiplicand3(simd_multiplicand3),
         .simd_multiplier3(simd_multiplier3),
         .simd_multiplicand4(simd_multiplicand4),
         .simd_multiplier4(simd_multiplier4),
         .simd_8_bit_operands(simd_8_bit_operands),
         .is_signed(is_signed),
         .simd_signed(simd_signed),
         .start(start),
         .is_simd_8(is_simd_8),
         .is_simd_16(is_simd_16),
         .finished(finished),
         .product(product),
         .simd_product3(simd_product3),
         .simd_product4(simd_product4),
         .simd_product_8_bits(simd_product_8_bits)
         ); 

// SOME TEST SIGNALS
logic tb_expected_finished;
logic [63:0] tb_expected_product;
logic [31:0] tb_expected_simd_1, tb_expected_simd_2, tb_expected_simd_3, tb_expected_simd_4;

always #(PERIOD/2) CLK++;

task reset_inputs();
    begin
        multiplicand = '0;
        multiplier   = '0;
        is_signed    = '0;
        simd_signed = '0;
        start        = '0;
        simd_multiplicand3 = '0;
        simd_multiplicand4 = '0;
        simd_multiplier3   = '0;
        simd_multiplier4   = '0;
    end
endtask

initial begin
$dumpfile("waveform.fst");
$dumpvars(0, mul32);

// Initialize
reset_inputs();
tb_expected_finished = '0;
tb_expected_product  = '0;

nRST = 1'b0;
@(posedge CLK);
@(posedge CLK);
nRST = 1'b1;
@(posedge CLK);
@(posedge CLK);

// Test unsigned x unsigned
multiplicand = 32'h0F231843;
multiplier   = 32'h0A492341;
start        = 1'b1;
tb_expected_product = 64'h9BB20A2D555203;

@(posedge CLK);
@(posedge CLK);
@(posedge CLK);
$display("expected result = %d, result = %d", tb_expected_product, product);
reset_inputs();

// Test signed x unsigned
multiplicand = 32'hFC231394; //-64810092
multiplier   = 32'h0B231394; // 186848148
is_signed    = 2'b10;
start        = 1'b1;
tb_expected_product = -64'd12109645661909616;

@(posedge CLK);
@(posedge CLK);
@(posedge CLK);
$display("expected result = %d, result = %d", $signed(tb_expected_product), $signed(product));
reset_inputs();

// Test unsigned x signed
multiplicand = 32'h0C201394; //203428756
multiplier   = 32'hFC23AA94; //-64771436
is_signed    = 2'b01;
start        = 1'b1;
tb_expected_product = -64'd13176372649813616;

@(posedge CLK);
@(posedge CLK);
@(posedge CLK);
$display("expected result = %d, result = %d", $signed(tb_expected_product), $signed(product));
reset_inputs();

// Test signed x signed
multiplicand = 32'hFA2B8A94; //-97809772
multiplier   = 32'hFC23AA13; //-64771565
is_signed    = 2'b11;
start        = 1'b1;
tb_expected_product = 64'd6335292004733180;

@(posedge CLK);
@(posedge CLK);
@(posedge CLK);
$display("expected result = %d, result = %d", $signed(tb_expected_product), $signed(product));
reset_inputs();


// Test SIMD
// 16 bits
is_simd_16 = 1'b1;
simd_signed = {{24{1'b0}}, 2'b11, 2'b10, 2'b01, 2'b00};
multiplicand = {16'd500, 16'd10000};
multiplier   = {16'd1000, -16'd4000};
simd_multiplicand3 = -16'd5000;
simd_multiplier3   = 16'd5000;
simd_multiplicand4 = -16'd10000;
simd_multiplier4   = -16'd2000;
start = 1'b1;

tb_expected_simd_1 = 32'd5000000;
tb_expected_simd_2 = -32'd4000000;
tb_expected_simd_3 = -32'd25000000;
tb_expected_simd_4 = 32'd20000000;

@(posedge CLK);
@(posedge CLK);
@(posedge CLK);
$display("SIMD");
$display("expected result = %d, result = %d", tb_expected_simd_1, product[31:0]);
$display("expected result = %d, result = %d", tb_expected_simd_2, product[63:32]);
$display("expected result = %d, result = %d", tb_expected_simd_3, simd_product3);
$display("expected result = %d, result = %d", tb_expected_simd_4, simd_product4);
reset_inputs();

// 8 bits
is_simd_8 = 1'b1;
// (simd_8_bit[31:16], simd_8_bit[15:0], multiplicand[15:0], multiplicand[31:16])
// (simd_8_bit[63:48], simd_8_bit[47:32], multiplier[15:0], multiplier[31:16])
// (simd_8_bit[95:80], simd_8_bit[79:64], simd_multiplier3[15:0], simd_multiplicand3[15:0])
// (simd_8_bit[127:112], simd_8_bit[111:96], simd_multiplier4[15:0], simd_multiplicand4[15:0])
simd_signed = {
                {2'b11, 2'b11, 2'b11, 2'b11},
                {2'b10, 2'b10, 2'b10, 2'b10},
                {2'b01, 2'b01, 2'b01, 2'b01},
                {2'b00, 2'b00, 2'b00, 2'b00}
                };
multiplicand = {8'd50, 8'd30, 8'd10, 8'd20};
multiplier   = {-8'd50, 8'd30,-8'd10, 8'd20};
simd_multiplicand3 = {8'd10, -8'd25};
simd_multiplier3   = {8'd10, -8'd20};
simd_multiplicand4 = {-8'd10, -8'd20};
simd_multiplier4   = {-8'd15, -8'd20};
start = 1'b1;

simd_8_bit_operands = {{112{1'd0}}, 8'd10, 8'd60};

tb_expected_simd_1 = {16'd200, 16'd1500};
tb_expected_simd_2 = {-16'd200, -16'd1500};
tb_expected_simd_3 = {-16'd200, -16'd250};
tb_expected_simd_4 = {16'd300, 16'd200};

@(posedge CLK);
@(posedge CLK);
@(posedge CLK);
$display("SIMD");
$display("expected result = %h, result = %h", tb_expected_simd_1, product[31:0]);
$display("expected result = %h, result = %h", tb_expected_simd_2, product[63:32]);
$display("expected result = %h, result = %h", tb_expected_simd_3, simd_product3);
$display("expected result = %h, result = %h", tb_expected_simd_4, simd_product4);
$display("expected result = %h, result = %h", 600, simd_product_8_bits[31:0]);

$finish;
end



endmodule 