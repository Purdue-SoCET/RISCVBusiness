

module rv32b_decode(
    input [31:0] insn,
    output logic claim,
    output rv32b_pkg::rv32b_decode_t rv32b_control
);
    import rv32i_types_pkg::*;
    import rv32b_pkg::*;

    localparam RV32B_MINOR_SHIFTADD  = 7'b0010000;
    localparam RV32B_MINOR_LOGNEGATE = 7'b0100000;
    localparam RV32B_MINOR_SEXT_COUNT_ROTATE  = 7'b0110000; // sign extend, bit counting, and rotate have same minor opcode
    localparam RV32B_MINOR_MINMAX    = 7'b0000101;
    localparam RV32B_MINOR_ZEXT      = 7'b0000100;

    rv32b_insn_t insn_split;
    rv32b_op_t operation;
    logic shift_add, log_with_negate, bit_counting, min_max, 
        sign_extend, zero_extend, rotate, orc, rev8;


    assign insn_split = rv32b_insn_t'(insn);

    always_comb begin
        claim = 1'b1; // Reverse this?
        operation = SH1ADD;
        // shift-add
        if(insn_split.opcode_major == REGREG && insn_split.opcode_minor == RV32B_MINOR_SHIFTADD) begin
            casez(insn_split.funct)
                2'b01: operation = SH1ADD;
                2'b10: operation = SH2ADD;
                2'b11: operation = SH3ADD;
                default: claim = 1'b0; // Illegal encoding for RV32B
            endcase
        // logical-with-negate
        end else if(insn_split.opcode_major == REGREG && insn_split.opcode_minor == RV32B_MINOR_LOGNEGATE) begin
            casez(insn_split.funct)
                3'b100: operation = XNOR;
                3'b110: operation = ORN;
                3'b111: operation = ANDN;
                default: claim = 1'b0;
            endcase
        // count-sext-rori
        end else if(insn_split.opcode_major == IMMED && insn_split.opcode_minor == RV32B_MINOR_SEXT_COUNT_ROTATE) begin
            casez({insn_split.rs2, insn_split.funct})
                8'b00000_001: operation = CLZ;
                8'b00001_001: operation = CTZ;
                8'b00010_001: operation = CPOP;
                8'b00100_001: operation = SEXTB;
                8'b00101_001: operation = SEXTH;
                8'b?????_101: operation = ROR; // rori
                default: claim = 1'b0;
            endcase
        // rotate-reg
        end else if(insn_split.opcode_major == REGREG && insn_split.opcode_minor == RV32B_MINOR_SEXT_COUNT_ROTATE) begin
            if(insn_split.funct == 3'b001) begin
                operation = ROL;
            end else if(insn_split.funct == 3'b101) begin
                operation = ROR;
            end else begin
                claim = 1'b0;
            end
        // zext
        end else if(insn_split.opcode_major == REGREG && insn_split.opcode_minor == RV32B_MINOR_ZEXT) begin
            if(insn_split.rs2 == 5'b0 && insn_split.funct == 3'b100) begin
                operation = ZEXTH;
            end else begin
                claim = 1'b0;
            end
        // min/max
        end else if(insn_split.opcode_major == REGREG && insn_split.opcode_minor == RV32B_MINOR_MINMAX) begin
            casez(insn_split.funct)
                3'b110: operation = MAX;
                3'b111: operation = MAXU;
                3'b100: operation = MIN;
                3'b101: operation = MINU;
                default: claim = 1'b0;
            endcase
        end else if(insn_split.opcode_major == IMMED) begin
            if(insn[31:20] == 12'b001_010_000_111 && insn[14:12] == 3'b101) begin
                operation = ORC;
            end else if(insn[31:20] == 12'b011_010_011_000 && insn[14:12] == 3'b101) begin
                operation = REV8;
            end else begin
                claim = 1'b0;
            end
        end
    end

    assign rv32b_control = {claim, operation};

endmodule
