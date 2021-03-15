  
`ifndef MULT_IF_SVH
`define MULT_IF_SVH


interface mult_if(input logic clk)
    logic nRST, start, finished;
    logic [31:0] multiplicand, multiplier;
    logic [1:0] is_signed;
    logic [63:0] product;
endinterface: mult_if

`endif