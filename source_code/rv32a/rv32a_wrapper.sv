`include "component_selection_defines.vh"

module rv32a_wrapper(
    input CLK,
    input nRST
);
    `ifdef RV32A_SUPPORTED
    rv32a_enabled RV32A(.*);
    `else
    rv32a_disabled RV32A(.*);
    `endif
endmodule
