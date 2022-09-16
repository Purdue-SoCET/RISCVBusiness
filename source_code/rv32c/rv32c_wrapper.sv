`include "rv32c_if.vh"
`include "component_selection_defines.vh"

module rv32c_wrapper (
    input logic CLK,
    nRST,
    rv32c_if.rv32c rv32cif
);

    generate
        /* verilator lint_off width */
        case (RV32C_ENABLED)
            /* verilator lint_on width */
            "disabled": rv32c_disabled RV32C (.clk(CLK), .nrst(nRST), .rv32cif(rv32cif));
            "enabled":  rv32c_enabled RV32C (.clk(CLK), .nrst(nRST), .rv32cif(rv32cif));
        endcase
    endgenerate

endmodule
