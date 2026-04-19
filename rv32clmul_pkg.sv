package rv32clmul_pkg;

    // CUSTOM-0 opcode (0x0B)
    localparam logic [6:0] RV32CLMUL_OPCODE = 7'b0001011;

    // R-type instruction format
    typedef struct packed {
        logic [6:0] funct7;
        logic [4:0] rs2;
        logic [4:0] rs1;
        logic [2:0] funct3;
        logic [4:0] rd;
        logic [6:0] opcode;
    } rv32clmul_insn_t;

    // Operation type
    typedef enum logic [2:0] {
        CLMUL = 3'b000
    } rv32delay_op_t;

    // Decoder output
    typedef struct packed {
        logic select;
        rv32clmul_op_t op;
    } rv32clmul_decode_t;

endpackage
