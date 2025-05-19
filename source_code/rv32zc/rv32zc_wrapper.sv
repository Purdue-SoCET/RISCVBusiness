`include "component_selection_defines.vh"

module rv32zc_wrapper(
    input rv32zc_pkg::rv32zc_op_t operation,
    input [31:0] rv32zc_a,
    input [31:0] rv32zc_b,
    output logic rv32zc_done,
    output logic [31:0] rv32zc_out
);

    `ifdef RV32ZICOND_SUPPORTED
        rv32zc_enabled RV32ZC(.*);
    `else
        rv32zc_disabled RV32ZC(.*);
    `endif

endmodule
