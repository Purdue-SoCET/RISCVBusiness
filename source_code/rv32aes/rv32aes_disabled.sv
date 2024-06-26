module rv32aes_wrapper(
    input rv32aes_pkg::rv32aes_op_t operation,
    input [31:0] rv32aes_a,
    input [31:0] rv32aes_b,
    output logic rv32aes_done,
    output logic [31:0] rv32aes_out
);
    assign rv32aes_done = 1'b1;
    assign rv32aes_out = 32'b0;
endmodule
