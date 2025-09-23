`include "component_selection_defines.vh"

module rv32m_wrapper #(
    parameter HART_ID
) (
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
    import core_configuration_pkg::*;

    // `ifdef RV32M_SUPPORTED
    // rv32m_enabled RV32M(.*);
    // `else
    // rv32m_disabled RV32M(.*);
    // `endif

    generate
        if(CORE_CONFIG[HART_ID][M]) begin
            rv32m_enabled RV32M(.*);
        end
        else begin
            rv32m_disabled RV32M(.*);
        end
    endgenerate

endmodule
