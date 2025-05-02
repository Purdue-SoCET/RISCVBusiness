module rv32zc_disabled(
    input rv32zc_pkg::rv32zc_op_t operation,
    input [31:0] rv32zc_a,
    input [31:0] rv32zc_b,
    output logic rv32zc_done,
    output logic [31:0] rv32zc_out
);
    assign rv32zc_done = 1'b1;
    assign rv32zc_out = 32'b0;
endmodule
