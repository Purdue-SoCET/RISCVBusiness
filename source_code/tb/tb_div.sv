module tb_div ();

  parameter PERIOD = 20;

  /*  Signal Instantiations */
  logic CLK, nRST;
  logic [31:0] divisor;
  logic [31:0] dividend;
  logic  is_signed;
  logic start, finished;
  logic [31:0] remainder, quotient;
  logic [31:0] test_num; 

  /*  Module Instantiations */
  shift_test_restore_divider #(32) DUT (.*);

  /*  CLK generation */

  initial begin
    CLK = 0;
  end

  always begin
    CLK = ~CLK;
    #(PERIOD/2);
  end


  task test_div(
	input logic [31:0] a,
	input logic [31:0] b,
	input logic is_signed_t,
	input logic [31:0] exp_quot,exp_rem
);
divisor = a;
dividend = b;
is_signed = is_signed_t;
start = 1;
@(posedge CLK);
@(posedge CLK);
#(9)
start=0;
while(finished==0)
@(posedge CLK);

assert (quotient == exp_quot) else $error ("Division failed for test %0d: Expected %h Received %h\n",test_num, exp_quot, quotient);

assert (remainder == exp_rem) else $error ("Remainder failed for test %0d: Expected %h Received %h\n",test_num, exp_rem, remainder);

test_num++;
endtask


initial begin
// reset
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

//       80/2         unsigned = 40 .... 0
test_div(32'd8,32'd20,1'd0,32'd2, 32'h4);

test_div(32'h7,32'hFFFFFFF7,1'h1,32'hFFFFFFFE, 32'h2);//-9 / 7 = -1...-2


$finish;
end
endmodule 





