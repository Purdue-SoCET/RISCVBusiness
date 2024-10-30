`ifndef MULTICORE_IF_SV
`define MULTICORE_IF_SV

`include "generic_bus_if.vh"
`include "cache_coherence_if.vh"
`include "component_selection_defines.vh"
`include "risc_mgmt_if.vh"
`include "cache_control_if.vh"
`include "sparce_pipeline_if.vh"
`include "tspp_fetch_execute_if.vh"
`include "tspp_hazard_unit_if.vh"
`include "core_interrupt_if.vh"
`include "rv32c_if.vh"
`include "bus_ctrl_if.vh"

interface multicore_if #(
    parameter logic [31:0] RESET_PC = 32'h80000000,
    parameter NUM_HARTS = 1
);

    // Clock and reset signals
    logic        CLK;
    logic        nRST;

    // mtime input
    logic [63:0] mtime;

    // Output signals from DUT
    logic        wfi;
    logic        halt;

    // Core interrupt interface
    core_interrupt_if interrupt_if;

    // Bus interface based on compilation directives
    generic_bus_if gen_bus_if;
    
    modport dut_mp (
        input  CLK, nRST, mtime,
        output wfi, halt,
        ref interrupt_if,
        ref gen_bus_if
    );

    modport tb_mp (
        output CLK, nRST, mtime,
        input  wfi,  halt,
        ref interrupt_if,
        ref gen_bus_if
    );

endinterface

`endif
