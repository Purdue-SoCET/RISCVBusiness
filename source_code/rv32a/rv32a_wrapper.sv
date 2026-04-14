`include "component_selection_defines.vh"

module rv32a_wrapper(
    input CLK,
    input nRST,
    input logic amo_en,
    input logic mem_ready,
    input logic [3:0] alu_op,
    input logic [31:0] mem_output, rs2_data,
    output logic stall_amo_en,
    output logic read_mem_en, 
    output logic write_mem_en,
    output logic [31:0] mem_input, 
    output logic [31:0] writeback_data
);


    `ifdef RV32A_SUPPORTED
    rv32a_enabled RV32A(.*);
    `else
    rv32a_disabled RV32A(.*);
    `endif
endmodule
