
module rv32m_disabled(
    input CLK,
    input nRST,
    input rv32m_start,
    input rv32m_pkg::rv32m_op_t operation,
    input [31:0] rv32m_a,
    input [31:0] rv32m_b,
    output rv32m_busy,
    output logic [31:0] rv32m_out
);

    assign rv32m_busy = 1'b0;
    assign rv32m_out = 32'b0;

endmodule