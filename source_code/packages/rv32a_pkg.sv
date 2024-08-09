`ifndef RV32A_PKG_SV
`define RV32A_PKG_SV

package rv32a_pkg;
    localparam logic [6:0] RV32A_OPCODE = 7'b0101111;
    localparam logic [2:0] RV32A_FUNCT3 = 3'b010;

    typedef struct packed {
        logic aq;
        logic rl;
    } rv32a_order_t;

    typedef struct packed {
        logic [4:0] funct5;
        logic [1:0] ordering;
        logic [4:0] rs2;
        logic [4:0] rs1;
        logic [2:0] funct3;
        logic [4:0] rd;
        logic [6:0] opcode;
    } rv32a_insn_t;

    // List of operations supported by the A extension
    // Direct-cast of funct5 of `rv32a_insn_t`
    typedef enum logic [4:0] {
        AMO_ADD  = 5'b00000,
        AMO_SWAP = 5'b00001,
        AMO_LR   = 5'b00010,
        AMO_SC   = 5'b00011,
        AMO_XOR  = 5'b00100,
        AMO_OR   = 5'b01000,
        AMO_AND  = 5'b01100,
        AMO_MIN  = 5'b10000,
        AMO_MAX  = 5'b10100,
        AMO_MINU = 5'b11000,
        AMO_MAXU = 5'b11100
    } rv32a_op_e;

    typedef struct packed {
        logic select;
        rv32a_op_e op;
    } rv32a_decode_t;
endpackage

`endif
