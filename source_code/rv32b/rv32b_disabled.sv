`include "component_selection_defines.vh"

module rv32b_disabled (
    input CLK,
    input nRST,
    input valid_cmd,
    input [31:0] instr,
    input [31:0] rs1_val,
    input [31:0] rs2_val,
    output valid,
    output logic [31:0] rv32b_out
);

    assign valid = 1'b0;
    assign rv32b_out = 32'd0;

endmodule
