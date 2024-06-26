`include "component_selection_defines.vh"

module rv32aes_wrapper(
    input rv32aes_pkg::rv32aes_op_t operation,
    input [31:0] rv32aes_a,
    input [31:0] rv32aes_b,
    output logic rv32aes_done,
    output logic [31:0] rv32aes_out
);

    import rv32aes_pkg::*;

    rv32aes_alu RV32AESALU(
        .a(rv32aes_a),
        .b(rv32aes_b),
        .aluop(operation),
        .y(rv32aes_out)
    );

    assign rv32aes_done = 1;

endmodule
