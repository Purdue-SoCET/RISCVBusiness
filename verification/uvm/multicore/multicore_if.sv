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
    core_interrupt_if.core interrupt_if;

    // Bus interface based on compilation directives
    `ifdef BUS_INTERFACE_GENERIC_BUS
        generic_bus_if.cpu gen_bus_if;
    `elsif BUS_INTERFACE_AHB
        ahb_if.manager ahb_manager;
    `elsif BUS_INTERFACE_APB
        apb_if.requester apb_requester;
    `endif

    modport dut_mp (
        input  CLK,
        input  nRST,
        input  mtime,
        output wfi,
        output halt,
        ref    interrupt_if,
    `ifdef BUS_INTERFACE_GENERIC_BUS
        ref    gen_bus_if
    `elsif BUS_INTERFACE_AHB
        ref    ahb_manager
    `elsif BUS_INTERFACE_APB
        ref    apb_requester
    `endif
    );

    modport tb_mp (
        output CLK,
        output nRST,
        output mtime,
        input  wfi,
        input  halt,
        ref    interrupt_if,
    `ifdef BUS_INTERFACE_GENERIC_BUS
        ref    gen_bus_if
    `elsif BUS_INTERFACE_AHB
        ref    ahb_manager
    `elsif BUS_INTERFACE_APB
        ref    apb_requester
    `endif
    );

endinterface


`endif