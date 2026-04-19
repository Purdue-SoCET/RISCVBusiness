`include "component_selection_defines.vh"

module rv32clmul_wrapper (
    input CLK,
    input nRST,
    input rv32clmul_start,
    input rv32clmul_pkg::rv32delay_op_t operation,
    input [31:0] rv32clmul_a,
    input [31:0] rv32clmul_b,
    output rv32clmul_done,
    output logic [31:0] rv32clmul_out
);
    import rv32clmul_pkg::*;

    `ifdef RV32CLMUL_SUPPORTED
    rv32clmul_enabled RV32CLMUL(.*);
    `else
    rv32clmul_disabled RV32CLMUL(.*);
    `endif

endmodule
