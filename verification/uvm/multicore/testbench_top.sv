`ifndef TESTBENCH_TOP_SV
`define TESTBENCH_TOP_SV

`include "bus_if.vh"
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
`include "multicore_if.vh"

`include "dut_parameters.sv"
`include "addr_space.sv"
`include "reset_test.svh"

`timescale 1ns/1ps
`include "uvm_macros.svh"

module testbench_top();
    import uvm_pkg::*;
    logic clk;

    // import dut_parameters::*;

    initial begin
        clk = 0;
        forever #10 clk = !clk;
    end

    multicore_if # (
        .NUM_HARTS(HARTS), 
        .RESET_PC(RST_PC),
        .DATA_WIDTH(D_WIDTH),
        .ADDR_WIDTH(A_WIDTH)
    ) mcif(clk);

    multicore_wrapper # (
        .NUM_HARTS(HARTS), 
        .RESET_PC(RST_PC)
    ) dut(
        .CLK(clk),
        .nRST(mcif.nRST),
        .multicore_if(mcif)
    );

    initial begin        
        uvm_config_db#(virtual multicore_if #(RST_PC, HARTS, D_WIDTH, A_WIDTH))::set(null, "uvm_test_top", "mcif", mcif);
        run_test("reset_test");
    end
endmodule

`endif