`include "component_selection_defines.vh"

module rv32aes_wrapper(
    input rv32aes_pkg::rv32aes_op_t operation,
    input [31:0] rv32aes_a,
    input [31:0] rv32aes_b,
    output logic rv32aes_done,
    output logic [31:0] rv32aes_out
);

    `ifdef RV32AES_SUPPORTED
        rv32aes_enabled RV32AES(.*);
    `else
        rv32aes_disabled RV32AES(.*);
    `endif

endmodule
