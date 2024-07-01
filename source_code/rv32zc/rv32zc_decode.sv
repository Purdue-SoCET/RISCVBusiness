module rv32zc_decode(
    input [31:0] insn,
    output logic claim,
    output rv32zc_pkg::rv32zc_decode_t rv32zc_control
);
    import rv32i_types_pkg::*;
    import rv32zc_pkg::*;

    localparam CZERO = 7'b0000111; 

    rv32zc_insn_t insn_split;
    rv32zc_op_t operation;

    assign insn_split = rv32zc_insn_t'(insn);

    always_comb begin
        claim = 1'b1;
        operation = NEZ;

        if (insn_split.opcode_major == REGREG && insn_split.opcode_minor == CZERO) begin 
            casez(insn_split.funct) begin 
                3'b111  : operation = NEZ; 
                3'b101  : operation = EQZ; 
                default: claim = 1'b0; 
            endcase
        end  

    end

    assign rv32zc_control = {claim, operation};

endmodule