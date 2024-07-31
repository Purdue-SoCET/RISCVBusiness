module tb_mul8();

//clock
parameter PERIOD = 10;
logic CLK = 0;

logic nRST;
logic [7:0] multiplicand, multiplier;
logic [1:0] is_signed;
logic start;
logic finished;
logic [15:0] product;
logic overflow;

mul8 DUT(.CLK(CLK),
         .nRST(nRST),
         .multiplicand(multiplicand),
         .multiplier(multiplier),
         .is_signed(is_signed),
         .start(start),
         .finished(finished),
         .product(product)
         ); 

// SOME TEST SIGNALS
logic tb_expected_finished;
logic [15:0] tb_expected_product;

always #(PERIOD/2) CLK++;

task reset_inputs();
    begin
        multiplicand = '0;
        multiplier   = '0;
        is_signed    = '0;
        start        = '0;
    end
endtask

initial begin
$dumpfile("waveform.fst");
$dumpvars(0, mul8);

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

// Test signed x signed
multiplicand = 8'b00000011; // 3
multiplier   = 8'b00010000; // 16
start        = 1'b1;
tb_expected_product = multiplicand * multiplier;

@(posedge CLK);
@(posedge CLK);
@(posedge CLK);
$display("expected result = %d, result = %d", tb_expected_product, product);
reset_inputs();

// Test signed x unsigned
multiplicand = -8'd3;
multiplier   = 8'b10111011; // 16
is_signed    = 2'b10;
start        = 1'b1;
tb_expected_product = $signed(multiplicand) * 187;

@(posedge CLK);
@(posedge CLK);
@(posedge CLK);
$display("expected result = %d, result = %d", $signed(tb_expected_product), $signed(product));
reset_inputs();

// Test unsigned x signed
multiplicand = 8'd148;
multiplier   = 8'd11; 
is_signed    = 2'b01;
start        = 1'b1;
tb_expected_product = $unsigned(multiplicand) * $signed(multiplier);


@(posedge CLK);
@(posedge CLK);
@(posedge CLK);
$display("%d, %d", $signed(multiplicand), $signed(multiplier));
$display("expected result = %d, result = %d", $signed(tb_expected_product), $signed(product));
reset_inputs();

// Test signed x signed
multiplicand = 8'b01111101; // 125
multiplier   = 8'b10010000; // -112 144
is_signed    = 2'b11;
start        = 1'b1;
tb_expected_product = $signed(multiplicand) * $signed(multiplier);

@(posedge CLK);
@(posedge CLK);
@(posedge CLK);
$display("%d, %d", $signed(multiplicand), $signed(multiplier));
$display("expected result = %d, result = %d", $signed(tb_expected_product), $signed(product));
reset_inputs();

$finish;
end



endmodule 