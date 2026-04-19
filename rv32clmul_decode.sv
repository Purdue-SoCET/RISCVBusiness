module rv32clmul_decode (
    input [31:0] insn,
    output logic claim,
    output rv32clmul_pkg::rv32clmul_decode_t rv32clmul_control
);
    import rv32clmul_pkg::*;

    rv32clmul_insn_t insn_split;

    assign insn_split = rv32clmul_insn_t'(insn);

    // Claim any instruction with CUSTOM-0 opcode and funct3=000
    assign claim = (insn_split.opcode == RV32CLMUL_OPCODE)
                && (insn_split.funct3 == 3'b000);

    assign rv32clmul_control.select = claim;
    assign rv32clmul_control.op = CLMUL;

endmodule
