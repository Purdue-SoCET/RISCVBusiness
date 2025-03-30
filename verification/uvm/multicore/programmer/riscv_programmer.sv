`ifndef RISCV_PROGRAMMER_SV
`define RISCV_PROGRAMMER_SV

class riscv_programmer;
    static function logic [31:0] encode_instruction(string mnemonic, int immediate, int rs1 = 0, int rs2 = 0, int rd = 0);
        case(mnemonic)
            "lw": begin
                // I-type format: opcode (6 bits) | rd (5 bits) | funct3 (3 bits) | rs1 (5 bits) | imm[11:0] (12 bits)
                return {immediate[11:0], rs1[4:0], 3'b010, rd[4:0], 7'b0000011};
            end
            "sw": begin
                // S-type format: imm[11:5] (7 bits) | rs2 (5 bits) | rs1 (5 bits) | funct3 (3 bits) | imm[4:0] (5 bits) | opcode (7 bits)
                return {immediate[11:5], rs2[4:0], rs1[4:0], 3'b010, immediate[4:0], 7'b0100011};
            end
            "jal": begin
                // UJ-type format: imm[20] (1 bit) | imm[10:1] (10 bits) | imm[11] (1 bit) | imm[19:12] (8 bits) | rd (5 bits) | opcode (7 bits)
                return {immediate[20], immediate[10:1], immediate[11], immediate[19:12], rd[4:0], 7'b1101111};
            end
            "addi": begin
                // I-type format: imm[11:0] | rs1 (5 bits) | funct3 (3 bits) | rd (5 bits) | opcode (7 bits)
                return {immediate[11:0], rs1[4:0], 3'b000, rd[4:0], 7'b0010011};
            end
            "beq": begin
                // SB-type format: imm[12] (1 bit) | imm[10:5] (6 bits) | rs2 (5 bits) | rs1 (5 bits) | funct3 (3 bits) | imm[4:1] (4 bits) | imm[11] (1 bit) | opcode (7 bits)
                return {immediate[12], immediate[10:5], rs2[4:0], rs1[4:0], 3'b000, immediate[4:1], immediate[11], 7'b1100011}; 
            end
            default: begin
                // `uvm_error("RISC-V Programmer", $sformatf("Unknown instruction mnemonic: %s", mnemonic));
                return 32'h0; 
            end
        endcase
    endfunction

endclass

`endif
