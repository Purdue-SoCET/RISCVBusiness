`include "component_selection_defines.vh"

module rv32zc_enabled(
    input rv32zc_pkg::rv32zc_op_t operation,
    input [31:0] rv32zc_a,
    input [31:0] rv32zc_b,
    output logic rv32zc_done,
    output logic [31:0] rv32zc_out
);

    import rv32zc_pkg::*;

    rv32zc_handler RV32ZCHANDLER(
        .a(rv32zc_a),
        .b(rv32zc_b),
        .aluop(operation),
        .y(rv32zc_out)
    );

    assign rv32zc_done = 1;

endmodule
