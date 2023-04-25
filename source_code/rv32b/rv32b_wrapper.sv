`include "component_selection_defines.vh"

module rv32b_wrapper(
    input CLK,
    input nRST,
    input valid_cmd,
    input [31:0] instr, 
    input [31:0] rs1_val,
    input [31:0] rs2_val,
    output logic [31:0] rv32b_out
);
    import rv32b_pkg::*;
    logic valid;
    /*generate
        case(RV32M_ENABLED)
            "disabled": rv32m_disabled RV32M(.*);
            "enabled": rv32m_enabled RV32M(.*);
        endcase
    endgenerate*/

    `ifdef RV32B_SUPPORTED
    rv32b_enabled RV32B(.*);
    `else
    rv32b_disabled RV32B(.*);
    `endif

endmodule
