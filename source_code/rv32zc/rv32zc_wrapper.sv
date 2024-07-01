`include "component_selection_defines.vh"

module rv32zc_wrapper(
    input rv32zc_pkg::rv32zc_op_t operation,
    input [31:0] rv32zc_a,
    input [31:0] rv32zc_b,
    output logic rv32zc_done,
    output logic [31:0] rv32zc_out
);

    `ifdef RV32ZC_SUPPORTED
        rv32zc_enabled rv32zc(.*);
    `else
        rv32zc_disabled rv32zc(.*);
    `endif

endmodule
