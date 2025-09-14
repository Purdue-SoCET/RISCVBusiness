module rv32a_decode(
    input logic [31:0] insn,
    output logic claim,
    output rv32a_pkg::rv32a_decode_t rv32a_control
);
    import rv32a_pkg::*;

    rv32a_insn_t insn_decode;
    rv32a_op_e insn_op;
    // Ensures that funct5 is a valid A extension instruction
    logic valid_funct5;
    // Ensures that rs2 is 0 if funct5 is lr
    logic lr_valid_rs2;

    always_comb begin
        insn_decode = rv32a_insn_t'(insn);
        insn_op = rv32a_op_e'(insn_decode.funct5);
        case (insn_decode.funct5)
            AMO_ADD, AMO_SWAP, AMO_LR, AMO_SC, AMO_XOR, AMO_OR, AMO_AND, AMO_MIN,
            AMO_MAX, AMO_MINU, AMO_MAXU : valid_funct5 = 1;
            default : valid_funct5 = 0;
        endcase
        lr_valid_rs2 = insn_decode.rs2 == 0;

        claim = (insn_decode.opcode == RV32A_OPCODE) &&
            valid_funct5 &&
            (insn_decode.funct3 == RV32A_FUNCT3) &&
            (insn_decode.funct5 != AMO_LR || lr_valid_rs2) &&
            // TODO: temporary hack to generate illegal instruction for AMO
            // emulation
            (insn_decode.funct5 == AMO_LR || insn_decode.funct5 == AMO_SC);

        rv32a_control.select = claim;
        rv32a_control.op = insn_op;
    end

endmodule
