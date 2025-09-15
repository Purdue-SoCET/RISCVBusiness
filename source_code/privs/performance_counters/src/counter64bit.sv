`include 

module counter64bit (
input logic clk,
input logic n_rst,
input word_t value_in, //overwrite value, can only overwrite 32 bits of the counter at a time
input logic [1:0] csr_active_sel // 0 --> not overwriting; 1 --> write to lower 32 bits ; 2 --> write to upper 32 bits
input logic clear, //clear all 64 bits of counter

output logic [63:0] count_out
);

logic 


endmodule