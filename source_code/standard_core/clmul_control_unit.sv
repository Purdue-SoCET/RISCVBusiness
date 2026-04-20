import rv32clmul_pkg::*;

logic rv32clmul_claim;

`ifdef RV32CLMUL_SUPPORTED
rv32clmul_decode RV32CLMUL_DECODE(
    .insn(cu_if.instr),
    .claim(rv32clmul_claim),
    .rv32delay_control(cu_if.rv32clmul_control)
);
`else
assign cu_if.rv32clmul_control = {1'b0, rv32clmul_op_t'(0)};
assign rv32clmul_claim = 1'b0;
`endif // RV32CLMUL_SUPPORTED

assign claimed = rv32m_claim || rv32a_claim || rv32b_claim || rv32zc_claim || rv32clmul_claim;
