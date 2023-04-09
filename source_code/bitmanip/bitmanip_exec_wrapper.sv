`include "component_selection_defines.vh"

module bitmanip_exec_wrapper(
    input CLK,
    input nRST,
    input rv32m_pkg::rv32m_op_t operation,
    input valid_cmd,
    input [31:0] instr, 
    input [31:0] rv32m_a,
    input [31:0] rv32m_b,
    output logic [31:0] bitmanip_out
);
    import bitmanip_pkg::*;

    /*generate
        case(RV32M_ENABLED)
            "disabled": rv32m_disabled RV32M(.*);
            "enabled": rv32m_enabled RV32M(.*);
        endcase
    endgenerate*/

    `ifdef BITMANIP_SUPPORTED
    bitmanip_enabled BITMANIPULATION(.*);
    `else
    bitmanip_disabled BITMANIPULATION(.*);
    `endif

endmodule
