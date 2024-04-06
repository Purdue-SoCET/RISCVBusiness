

module rv32b_decode(
    input [31:0] insn,
    output logic claim,
    output rv32b_pkg::rv32b_op_t operation
);
    import rv32i_types_pkg::*;
    import rv32b_pkg::*;

    rv32b_insn_t insn_split;
    logic [9:0] opcode_minor = {insn_split.opcode_minor, insn_split.funct};

    assign insn_split = rv32b_insn_t'(insn);


    always_comb begin
        claim = 1'b0;
        if(insn_split.opcode_major == REGREG) begin
            
        end else if(insn_split.opcode_major == IMMED) begin

        end
    end

endmodule
