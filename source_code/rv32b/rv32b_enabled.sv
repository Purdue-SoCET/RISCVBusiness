`include "component_selection_defines.vh"

module rv32b_enabled(
    input rv32b_pkg::rv32b_op_t operation,
    input [31:0] rv32b_a,
    input [31:0] rv32b_b,
    output logic rv32b_done,
    output logic [31:0] rv32b_out
);

    import rv32b_pkg::*;

    rv32b_alu(
        .a(rv32b_a),
        .b(rv32b_b),
        .aluop(operation),
        .y(rv32b_out)
    );

    assign rv32b_done = 1;

endmodule
