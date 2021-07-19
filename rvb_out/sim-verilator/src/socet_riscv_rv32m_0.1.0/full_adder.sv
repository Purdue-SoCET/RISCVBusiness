module full_adder (
    input  logic x,
    input  logic y,
    input  logic cin,
    output logic cout,
    output logic sum
);
    assign sum  = x ^ y ^ cin;
    assign cout = (x & y) | (x & cin) | (y & cin);

endmodule
