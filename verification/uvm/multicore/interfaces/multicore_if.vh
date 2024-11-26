`ifndef MULTICORE_IF_VH
`define MULTICORE_IF_VH

`include "bus_if.vh"
`include "core_interrupt_if.vh"

interface multicore_if #(
    parameter logic [31:0] RESET_PC = 32'h80000000,
    parameter NUM_HARTS = 1,
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 32
)(input CLK);

    // Clock and reset signals
    logic        nRST;

    // mtime input
    logic [63:0] mtime;

    // Output signals from DUT
    logic        wfi;
    logic        halt;

    // Core interrupt interface
    core_interrupt_if interrupt_if ();

    // Bus interface based on compilation directives
    bus_if #(
        .DATA_WIDTH(DATA_WIDTH), 
        .ADDR_WIDTH(ADDR_WIDTH)
    ) gen_bus_if();
    
    modport dut_mp (
        input mtime,
        output wfi, halt,
        ref interrupt_if,
        ref gen_bus_if
    );

    modport tb_mp (
        output mtime,
        input  wfi,  halt,
        ref interrupt_if,
        ref gen_bus_if
    );

endinterface

`endif
