`include "component_selection_defines.vh"

module rv32b_wrapper #(
    parameter HART_ID
) (
    input rv32b_pkg::rv32b_op_t operation,
    input [31:0] rv32b_a,
    input [31:0] rv32b_b,
    output logic rv32b_done,
    output logic [31:0] rv32b_out
);
    import core_configuration_pkg::*;

    generate
        if(CORE_CONFIG[HART_ID][B]) begin
            rv32b_enabled RV32B(.*);
        end
        else begin
            rv32b_disabled RV32B(.*);
        end
    endgenerate

endmodule
