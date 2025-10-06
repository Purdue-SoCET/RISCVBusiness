`include "rv32c_if.vh"
`include "component_selection_defines.vh"

module rv32c_wrapper #(
    parameter HART_ID
) (
    input logic CLK,
    nRST,
    rv32c_if.rv32c rv32cif
);
    // `ifdef RV32C_SUPPORTED
    //     rv32c_enabled RV32C (.clk(CLK), .nrst(nRST), .rv32cif(rv32cif));
    // `else
    //     rv32c_disabled RV32C (.clk(CLK), .nrst(nRST), .rv32cif(rv32cif));
    // `endif
    import core_configuration_pkg::*;
    generate
        if(CORE_CONFIG[HART_ID][C]) begin
            rv32c_enabled RV32C (.clk(CLK), .nrst(nRST), .rv32cif(rv32cif));
        end
        else begin
            rv32c_disabled RV32C (.clk(CLK), .nrst(nRST), .rv32cif(rv32cif));
        end
    endgenerate
endmodule
