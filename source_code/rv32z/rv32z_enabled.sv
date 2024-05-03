`include "component_selection_defines.vh"

module rv32z_enabled(
    input rv32z_pkg::rv32z_op_t operation,
    input [31:0] rv32z_a,
    input [31:0] rv32z_b,
    output logic rv32z_done,
    output logic [31:0] rv32z_out
);

    import rv32z_pkg::*;

    rv32b_alu RV32BALU( //B or Z???????????? Forwarding and everything done for B extension
        .a(rv32b_a),
        .b(rv32b_b),
        .aluop(operation),
        .y(rv32z_out)
    );

    assign rv32z_done = 1;

endmodule