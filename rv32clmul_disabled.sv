module rv32clmul_disabled (
    input  logic CLK,
    input  logic nRST,
    input  logic rv32clmul_start,
    input  rv32clmul_pkg::rv32clmul_op_t operation,
    input  logic [31:0] rv32clmul_a,
    input  logic [31:0] rv32clmul_b,
    output logic rv32clmul_done,
    output logic [31:0] rv32clmul_out
);

    // Always ready, return zero
    assign rv32clmul_done = 1'b1;
    assign rv32clmul_out  = 32'b0;

endmodule