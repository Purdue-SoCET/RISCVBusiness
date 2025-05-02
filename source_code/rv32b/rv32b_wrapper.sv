`include "component_selection_defines.vh"

module rv32b_wrapper(
    input rv32b_pkg::rv32b_op_t operation,
    input [31:0] rv32b_a,
    input [31:0] rv32b_b,
    output logic rv32b_done,
    output logic [31:0] rv32b_out
);

    `ifdef RV32B_SUPPORTED
        rv32b_enabled RV32B(.*);
    `else
        rv32b_disabled RV32B(.*);
    `endif

endmodule
