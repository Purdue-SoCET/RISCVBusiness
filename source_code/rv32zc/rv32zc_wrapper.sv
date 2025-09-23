`include "component_selection_defines.vh"

module rv32zc_wrapper #(
    parameter HART_ID
) (
    input rv32zc_pkg::rv32zc_op_t operation,
    input [31:0] rv32zc_a,
    input [31:0] rv32zc_b,
    output logic rv32zc_done,
    output logic [31:0] rv32zc_out
);
    import core_configuration_pkg::*;

    // `ifdef RV32ZICOND_SUPPORTED
    //     rv32zc_enabled RV32ZC(.*);
    // `else
    //     rv32zc_disabled RV32ZC(.*);
    // `endif

    generate
        if(CORE_CONFIG[HART_ID][ZICOND]) begin
            rv32zc_enabled RV32ZC(.*);
        end
        else begin
            rv32zc_disabled RV32ZC(.*);
        end
    endgenerate

endmodule
