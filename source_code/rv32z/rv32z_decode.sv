module rv32z_decode(
    input [31:0] insn,
    output logic claim,
    output rv32z_pkg::rv32z_decode_t rv32z_control
);
    import rv32i_types_pkg::*;
    import rv32z_pkg::*;

    parameter logic [6:0] OPCODE = 7'b0001111;  //opcode of MISCMEM//7'b1110011;
    parameter logic [2:0] FUNCT3 = 3'b010;      //cbo    //3'b001;
    parameter logic [6:0] FUNCT7 = 7'b0000100;  //flush  //7'b0001010;

    rv32z_insn_t insn_split;
    rv32z_op_t operation;

    assign insn_split = rv32z_insn_t'(insn);

    always_comb begin
        claim = 1'b0;       //initial
        if (insn[6:0] == OPCODE) begin
            if (insn_split.opcode_major == FUNCT7) begin
                if (insn_split.funct == FUNCT3) begin
                    claim = 1'b1;
                    operation = FLUSH;
                end
            end
        end
    
    
    end

    assign rv32z_control = {claim, operation};

endmodule