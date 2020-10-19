module radix4_divider(input clk,
input reset,
input is_signed,
input [31:0] dividend,
input [31:0] divisor,
output logic [31:0] quotient, 
output logic [31:0] remainder
);
logic [31:0] usign_divisor, usign_dividend;
logic adj_possible, adj_quo,adj_rem;

assign usign_divisor = is_signed & divisor[31] ? (~divisor)+1: divisor;
assign usign_dividend = is_signed & dividend[31] ? (~dividend)+1:dividend;
assign adj_possible = is_signed && (divisor[31]^dividend[31]);
assign adj_quo = adj_possible && ~quotient[31];
assign adj_rem = is_signed && dividend[31];


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

a = usign_dividend;
p = 0;
d2 = usign_divisor << 1;
d3 = usign_divisor << 1 + 1;

for (int i = 0; i < 16; i++) begin

p = (p<<2) | a [63:62];
a = a << 2;

r1 = p - usign_divisor;
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



