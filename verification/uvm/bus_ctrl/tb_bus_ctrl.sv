`ifndef TB_BUS_CTRL
`define TB_BUS_CTRL

`include "bus_ctrl.sv"

// interface file
`include "bus_ctrl.sv"

// UVM test file
`include "test_basic.svh"

// Include params
`include "dut_params.svh"

`timescale 1ns / 1ns
// import uvm packages
import uvm_pkg::*;

module tb_bus_ctrl ();
  logic clk;

  // generate clock
  initial begin
    clk = 0;
    forever #10 clk = !clk;
  end

  // instantiate the interface
  bus_ctrl_if bus_ctrl_if  ();

  assign bus_ctrl_if.clk = clk;

  // TODO: instantiate the DUT
  bus_ctrl #(
      .BLOCK_SIZE(dut_params::BLOCK_SIZE_WORDS),
      .CPUS(dut_params::NUM_CPUS_USED)
  ) bus_ctrl_mod (
      bus_ctrl_if.clk,
      bus_ctrl_if.nRST,
      bus_ctrl_if
  );

  initial begin
    uvm_config_db#(virtual bus_ctrl_if)::set(null, "", "bus_ctrl_vif",
                                             bus_ctrl_if); // configure the interface into the database, so that it can be accessed throughout the hierachy
    run_test("test_basic");
  end
endmodule

`endif
