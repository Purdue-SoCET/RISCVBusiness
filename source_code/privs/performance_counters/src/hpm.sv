`include "priv_ext_if.vh"

/*modport ext (
    output invalid_csr, ack, value_out,
    input csr_addr, value_in, csr_active
);*/

/*module counter64bit (
input logic clk,
input logic n_rst,
input logic enable, //counter enable
input logic [31:0] overwrite_val, //overwrite value, can only overwrite 32 bits of the counter at a time
input logic [1:0] csr_active_sel, // 0 --> not overwriting; 1 --> write to lower 32 bits ; 2 --> write to upper 32 bits
input logic clear, //clear all 64 bits of counter

output logic [63:0] count_out,
output logic rollover_flag
);*/

module hpm #(
   parameter NUM_PEFORMANCE_COUNTERS = 3 // ASSUME DEFAULT OF 3 FOR NOW 
) (
    input logic clk,
    input logic n_rst,
    priv_ext_if.ext priv
);

localparam ADDRLOWERCOUNTER1 = 12'hC00; // ADDRESS TO ACCESS LOWER 32 BITS OF FIRST COUNTER
localparam ADDRUPPERCOUNTER1 = 12'hC80; // ADDRESS TO ACCESS UPPER 32 BITS OF FIRST COUNTER
localparam ADDRLOWERCOUNTER2 = 12'hC01; // ADDRESS TO ACCESS LOWER 32 BITS OF SECOND COUNTER
localparam ADDRUPPERCOUNTER2 = 12'hC81; // ADDRESS TO ACCESS UPPER 32 BITS OF SECOND COUNTER
localparam ADDRLOWERCOUNTER3 = 12'hC02; // ADDRESS TO ACCESS LOWER 32 BITS OF THIRD COUNTER
localparam ADDRUPPERCOUNTER3 = 12'hC82; // ADDRESS TO ACCESS UPPER 32 BITS OF THIRD COUNTER

genvar i;

generate
    for(i = 0; i < NUM_PEFORMANCE_COUNTERS; i++) begin

    end
endgenerate

endmodule