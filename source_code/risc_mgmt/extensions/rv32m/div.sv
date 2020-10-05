module div(input clk,
input reset,
input [31:0] dividend,
input [31:0] divisor,
output [31:0] quotient, 
output [31:0] remainder
);

reg [31:0] r1,r2,r3,d2,d3,p,a;

always_ff@(posedge clk, negedge reset)
begin

if (reset == 0) begin
	quotient <= 0;
	remainder <= 0;
end

else begin 
	quotient <= a;
	remainder <= p;
end
end

always_comb begin

a = dividend;
p = 0;
d2 = divisor << 1;
d3 = divisor << 1 + 1;

for (i = 0; i < 16; i++) begin

p = (p<<2) | a [63:62];
a = a << 2;

r1 = p - divisor;
r2 = p - d2;
r3 = p - d3;

if (r1[63])
	a = a | 0;
else if (r2[63]) begin
	p = r1;
	a = a | 1;
end
else if (r3[63]) begin 
	p = r2;
	a = a | 2;
end
else begin
	p = r3;
	a = a | 3;
end
end
end
endmodule



