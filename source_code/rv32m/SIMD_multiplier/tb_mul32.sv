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

vedic_mul32 DUT(.CLK(CLK),
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
         .is_simd_8(is_simd_8),
         .is_simd_16(is_simd_16),
         .finished(finished),
         .product(product),
         .simd_product3(simd_product3),
         .simd_product4(simd_product4)
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
// is_simd = 1'b1;
// simd_signed = {2'b11, 2'b10, 2'b01};
// multiplicand = {8'd30, 8'd30};
// multiplier   = {8'd10, -8'd50};
// simd_multiplicand3 = -8'd50;
// simd_multiplier3   = 8'd50;
// simd_multiplicand4 = -8'd100;
// simd_multiplier4   = -8'd20;
// start = 1'b1;

// tb_expected_simd_1 = 16'd900;
// tb_expected_simd_2 = -16'd500;
// tb_expected_simd_3 = -16'd2500;
// tb_expected_simd_4 = 16'd2000;

// @(posedge CLK);
// @(posedge CLK);
// @(posedge CLK);
// $display("SIMD");
// $display("expected result = %d, result = %d", tb_expected_simd_1, product[15:0]);
// $display("expected result = %d, result = %d", tb_expected_simd_2, product[31:16]);
// $display("expected result = %d, result = %d", tb_expected_simd_3, simd_product3);
// $display("expected result = %d, result = %d", tb_expected_simd_4, simd_product4);

$finish;
end



endmodule 