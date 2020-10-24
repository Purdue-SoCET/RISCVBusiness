module div#(  //radix 2 non restoring division
  parameter N = 32
)(
  input logic CLK, nRST,
  input logic [N-1:0] divisor, dividend,
  input logic is_signed,
  input logic start,
  output logic [N-1:0] remainder, quotient, 
  output logic finished
);

    localparam COUNTER_BITS = $clog2(N) + 1;
//  localparam U_Q = N-1;
//  localparam U_R = (2*N)-1;

//  logic [(2*N)+1:0] result;
//  assign {remainder, quotient} = result[(2*N)-1:0];
//  logic test_phase;

  logic [COUNTER_BITS-1:0] counter;
//  logic [N-1:0] usign_divisor, usign_dividend;
//  logic adjustment_possible, adjust_quotient, adjust_remainder;
  logic div_done;
  reg [N-1:0] p,a,temp;
  integer i;

//  assign usign_divisor        = is_signed & divisor[N-1] ? (~divisor)+1 : divisor;
//  assign usign_dividend       = is_signed & dividend[N-1] ? (~dividend)+1 : dividend;
//  assign adjustment_possible  = is_signed && (divisor[N-1] ^ dividend[N-1]); 
//  assign adjust_quotient      = adjustment_possible && ~quotient[N-1];
 // assign adjust_remainder     = is_signed && dividend[N-1];
  assign div_done             = (counter==0);




  always_ff @ (posedge CLK, negedge nRST) begin
    if(~nRST || ~start) begin
	quotient <= 0;
	remainder <= 0;
	counter <= N;
    end 
    else begin
	quotient <= a;
	remainder <= p;
        counter <= counter - 1;
    end
  end 

always_comb begin
a = dividend;
p = 0;

for(i=0;i<N;i=i+1) begin
	p = (p<<1)|a[N-1];
	a = a<<1;

if(p[N-1])
	temp = divisor;
else 
	temp = ~divisor+1;
p = p + temp;

if(p[N-1])
	a = a|0;
else  
	a = a|1;
end

if(p[N-1])
	p = p + divisor;

//div_done = 1'b1; //????

end

 
  always_ff @ (posedge CLK, negedge nRST) begin
    if(~nRST) 
      finished <= 1'b0;
    else if (start)
      finished <= 1'b0;
    else if (div_done) 
      finished <= 1'b1;
  end

endmodule

 
