
module rv32b_disabled(
    input rv32b_pkg::rv32b_op_t operation,
    input [31:0] rv32b_a,
    input [31:0] rv32b_b,
    output logic rv32b_done,
    output logic [31:0] rv32b_out
);
    assign rv32b_done = 1'b1;
    assign rv32b_out = 32'b0;
endmodule
