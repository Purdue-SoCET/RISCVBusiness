`ifndef TESTBENCH_TOP_SV
`define TESTBENCH_TOP_SV

`timescale 1ns/1ps
`include "uvm_macros.svh"
`include "reset_test.svh"

module testbench_top();
    import uvm_pkg::*;
    logic clk;

    // --- DUT Params PKG --- //
    import dut_parameters::*;

    reset_test reset_test;

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

    // TODO: param with same clk?
    // bus_if # (
    //     .DATA_WIDTH(D_WIDTH),
    //     .ADDR_WIDTH(A_WIDTH)
    // ) busif(
    //     .CLK(clk),

    // );

    multicore_wrapper # (
        .NUM_HARTS(HARTS), 
        .RESET_PC(RST_PC)
    ) dut(
        .CLK(clk),
        .nRST(mcif.nRST),
        .mcif(mcif)
    );

    initial begin        
        uvm_config_db#(virtual multicore_if #(RST_PC, HARTS, D_WIDTH, A_WIDTH))::set(null, "uvm_test_top", "mcif", mcif);
        // uvm_config_db#(virtual bus_if #(A_WIDTH, D_WIDTH))::set(null, "uvm_test_top", "busif", busif);
        run_test("reset_test");
    end
endmodule

`endif