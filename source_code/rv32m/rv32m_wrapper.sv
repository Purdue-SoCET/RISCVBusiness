`include "component_selection_defines.vh"

module rv32m_wrapper(
    input CLK,
    input nRST,
    input rv32m_start,
    input rv32m_pkg::rv32m_op_t operation,
    input [31:0] rv32m_a,
    input [31:0] rv32m_b,
    output rv32m_done,
    output logic [31:0] rv32m_out
);
    import rv32m_pkg::*;

    `ifdef RV32M_SUPPORTED
    rv32m_enabled RV32M(.*);
    `else
    rv32m_disabled RV32M(.*);
    `endif

endmodule
