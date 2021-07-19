`include "rv32c_if.vh"
`include "fetch_buffer_if.vh"
`include "decompressor_if.vh"

module rv32c_disabled (
    input logic clk,
    nrst,
    rv32c_if.rv32c rv32cif
);


    assign rv32cif.done = '0;
    assign rv32cif.done_earlier = '0;
    assign rv32cif.nextpc = '0;
    assign rv32cif.imem_pc = '0;
    assign rv32cif.result = '0;
    assign rv32cif.inst32 = '0;
    assign rv32cif.c_ena = '0;

    assign rv32cif.rv32c_ena = '0;

endmodule
