`timescale 1ns/10ps
module tb_radix4_divider ();

  parameter PERIOD = 10;

  /*  Signal Instantiations */
  logic CLK, nRST;
  logic [31:0] divisor;
  logic [31:0] dividend;
  logic  is_signed;
  logic start, finished;
  logic [31:0] remainder, quotient;
  logic [31:0] test_num; 

  /*  Module Instantiations */
  radix4_divider #(32) DUT 
  (
	.CLK(CLK), 
	.nRST(nRST), 
	.start(start),
	.dividend(dividend),
	.divisor(divisor), 
	.quotient(quotient), 
	.remainder(remainder)
 );
  /*  CLK generation */

  initial begin
    CLK = 0;
  end

  always begin
    CLK = ~CLK;
    #(PERIOD/2);
  end

  task wait_result();
	for (int i = 0; i < 20; i++)
	@(posedge CLK);
  endtask

  task test_div(
    input logic [31:0] a,
    input logic [31:0] b,
    input logic is_signed_t,
    input logic [31:0] exp_quot, exp_rem
    );
    divisor = a;
    dividend = b;
    is_signed = is_signed_t;
    start = 1;
    @(posedge CLK);
    @(posedge CLK);
    #(9);
    start = 0;
    while(!finished) 
      @(posedge CLK);
    
    assert (quotient == exp_quot) else $error("Division failed for test %0d: Expected %h Received %h\n", test_num, exp_quot, quotient);
    assert (remainder == exp_rem) else $error("Remainder failed for test %0d: Expected %h Received %h\n", test_num, exp_rem, remainder);
    test_num++;
  endtask

  /*  Begin Testing   */

  initial begin
    // reset divider 
    test_num = 0;
    nRST = 1'b0;
    divisor = 0;
    dividend = 0;
    is_signed = 0;
    start = 0;
    @(posedge CLK);
    @(posedge CLK);
    #(PERIOD/2);
    nRST = 1'b1;
    @(posedge CLK);
    @(posedge CLK);
    @(posedge CLK);

    @(negedge CLK);
    divisor = 32'd6;
    dividend = 32'd18;
    start = 1'b1;
    #(PERIOD);
    start = 1'b0;
    wait_result();

    @(negedge CLK);
    divisor = 32'd23910;
    dividend = 32'd8212148;
    start = 1'b1;
    #(PERIOD);
    start = 1'b0;
    wait_result();

    //Basic test divisor, dividend, signed, quot, rem
    //test_div(32'h80, 32'h2, 1'b0, 32'h40, 32'h0);
 
 
    $finish;
  end
  
endmodule
