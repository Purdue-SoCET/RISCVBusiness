module tb_mul16();

//clock
parameter PERIOD = 10;
logic CLK = 0;

logic nRST;
logic [15:0] multiplicand, multiplier;
logic [1:0] is_signed;
logic start;
logic finished;
logic [31:0] product;

vedic_mul16 DUT(.CLK(CLK),
         .nRST(nRST),
         .multiplicand(multiplicand),
         .multiplier(multiplier),
         .is_signed(is_signed),
         .start(start),
         .finished(finished),
         .product(product)); 

// SOME TEST SIGNALS
logic tb_expected_finished;
logic [31:0] tb_expected_product;

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

@(posedge CLK);
@(posedge CLK);
@(posedge CLK);
reset_inputs();

// Test signed x unsigned
multiplicand = 16'b1000011000000011; // -31229
multiplier   = 16'b0110000000010000; // 24592
is_signed    = 2'b10;
start        = 1'b1;

@(posedge CLK);
@(posedge CLK);
@(posedge CLK);
reset_inputs();

// Test unsigned x signed
multiplicand = 16'b0000011011000011; // 1731
multiplier   = 16'b1110000000010000; // -8176
is_signed    = 2'b01;
start        = 1'b1;

@(posedge CLK);
@(posedge CLK);
@(posedge CLK);
reset_inputs();

// Test signed x signed
multiplicand = 16'b1000011000000011; // -31229
multiplier   = 16'b1110000000010000; // -8176
is_signed    = 2'b11;
start        = 1'b1;

@(posedge CLK);
@(posedge CLK);
@(posedge CLK);
reset_inputs();


$finish;
end



endmodule 