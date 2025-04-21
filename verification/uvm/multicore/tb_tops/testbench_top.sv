/*
  Project       : SoCET RISCVBusiness UVM
  UVM Component : Testbench Top
*/
`ifndef TESTBENCH_TOP_SV
`define TESTBENCH_TOP_SV

`timescale 1ns/1ns

// --- Include --- //
`include "uvm_macros.svh"
`include "reset_test.svh"

// --- Testbench Top --- //
module testbench_top();
    // Packages
    import uvm_pkg::*;
    import dut_parameters::*;
    // Sim Clock
    logic clk;
    parameter CLK_PERIOD = 10;
    // UVM Tests
    reset_test reset_test;
    // Clock Generation 
    always begin : CLK_GEN
        clk = 1'b1;
        #(0.5 * CLK_PERIOD);
        clk = 1'b0;
        #(0.5 * CLK_PERIOD);
    end
    // Multicore Interface 
    multicore_if # (
        .NUM_HARTS(HARTS), 
        .RESET_PC(RST_PC),
        .DATA_WIDTH(D_WIDTH),
        .ADDR_WIDTH(A_WIDTH)
    ) mcif(clk);
    // DUT
    multicore_wrapper # (
        .NUM_HARTS(HARTS), 
        .RESET_PC(RST_PC)
    ) dut(
        .CLK(clk),
        .nRST(mcif.nRST),
        .mcif(mcif)
    );
    // UVM Test Procedure
    initial begin        
        uvm_config_db#(virtual multicore_if #(RST_PC, HARTS, D_WIDTH, A_WIDTH))::set(null, "uvm_test_top", "mcif", mcif);
        run_test("reset_test");
    end
endmodule

`endif