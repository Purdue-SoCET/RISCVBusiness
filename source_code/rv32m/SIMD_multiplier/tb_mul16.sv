module tb_mul16();

//clock
parameter PERIOD = 10;
logic CLK = 0;

logic nRST;
logic [15:0] multiplicand, multiplier;
logic [1:0] is_signed;
logic [5:0] simd_signed;
logic start;
logic is_simd;
logic finished;
logic [31:0] product;
logic [15:0] simd_product3, simd_product4;
logic [7:0] simd_multiplicand3, simd_multiplicand4,
            simd_multiplier3,   simd_multiplier4;

vedic_mul16 DUT(.CLK(CLK),
         .nRST(nRST),
         .multiplicand(multiplicand),
         .multiplier(multiplier),
         .simd_multiplicand3(simd_multiplicand3),
         .simd_multiplier3(simd_multiplier3),
         .simd_multiplicand4(simd_multiplicand4),
         .simd_multiplier4(simd_multiplier4),
         .is_signed(is_signed),
         .simd_signed(simd_signed),
         .start(start),
         .is_simd(is_simd),
         .finished(finished),
         .product(product),
         .simd_product3(simd_product3),
         .simd_product4(simd_product4)
         ); 

// SOME TEST SIGNALS
logic tb_expected_finished;
logic [31:0] tb_expected_product;
logic [15:0] tb_expected_simd_1, tb_expected_simd_2, tb_expected_simd_3, tb_expected_simd_4;

always #(PERIOD/2) CLK++;

task reset_inputs();
    begin
        multiplicand = '0;
        multiplier   = '0;
        is_signed    = '0;
        start        = '0;
        simd_multiplicand3 = '0;
        simd_multiplicand4 = '0;
        simd_multiplier3   = '0;
        simd_multiplier4   = '0;
    end
endtask

initial begin
$dumpfile("waveform.fst");
$dumpvars(0, mul16);

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
multiplicand = 16'b0000011000000011; // 1539
multiplier   = 16'b0110000000010000; // 24592
start        = 1'b1;
tb_expected_product = multiplicand * multiplier;

@(posedge CLK);
@(posedge CLK);
@(posedge CLK);
$display("expected result = %d, result = %d", tb_expected_product, product);
reset_inputs();

// Test signed x unsigned
multiplicand = 16'b1000011000000011; // -31229
multiplier   = 16'b0110000000010000; // 24592
is_signed    = 2'b10;
start        = 1'b1;
tb_expected_product = $signed(multiplicand) * $signed(multiplier);

@(posedge CLK);
@(posedge CLK);
@(posedge CLK);
$display("expected result = %d, result = %d", tb_expected_product, product);
reset_inputs();

// Test unsigned x signed
multiplicand = 16'd35476; // 1731
multiplier   = -16'd989; // -8176
is_signed    = 2'b01;
start        = 1'b1;
tb_expected_product = -32'd35085764;

@(posedge CLK);
@(posedge CLK);
@(posedge CLK);
$display("expected result = %d, result = %d", tb_expected_product, product);
reset_inputs();

// Test signed x signed
multiplicand = 16'b1000011000000011; // -31229
multiplier   = 16'b1110000000010000; // -8176
is_signed    = 2'b11;
start        = 1'b1;
tb_expected_product = $signed(multiplicand) * $signed(multiplier);

@(posedge CLK);
@(posedge CLK);
@(posedge CLK);
$display("expected result = %d, result = %d", tb_expected_product, product);
reset_inputs();


// Test SIMD
is_simd = 1'b1;
simd_signed = {2'b11, 2'b10, 2'b01};
multiplicand = {8'd30, 8'd30};
multiplier   = {8'd10, -8'd50};
simd_multiplicand3 = -8'd50;
simd_multiplier3   = 8'd50;
simd_multiplicand4 = -8'd100;
simd_multiplier4   = -8'd20;
start = 1'b1;

tb_expected_simd_1 = 16'd900;
tb_expected_simd_2 = -16'd500;
tb_expected_simd_3 = -16'd2500;
tb_expected_simd_4 = 16'd2000;

@(posedge CLK);
@(posedge CLK);
@(posedge CLK);
$display("SIMD");
$display("expected result = %d, result = %d", tb_expected_simd_1, product[15:0]);
$display("expected result = %d, result = %d", tb_expected_simd_2, product[31:16]);
$display("expected result = %d, result = %d", tb_expected_simd_3, simd_product3);
$display("expected result = %d, result = %d", tb_expected_simd_4, simd_product4);

$finish;
end



endmodule 