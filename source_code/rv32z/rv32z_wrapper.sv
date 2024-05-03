`include "component_selection_defines.vh"

module rv32z_wrapper(
    input rv32z_pkg::rv32z_op_t operation,
    input [31:0] rv32z_a,
    input [31:0] rv32z_b,
    output logic rv32z_done,
    output logic [31:0] rv32z_out
);

    `ifdef RV32Z_SUPPORTED
        rv32z_enabled RV32Z(.*);
    `else
        rv32z_disabled RV32Z(.*);
    `endif

endmodule
