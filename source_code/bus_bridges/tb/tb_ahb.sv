//By            : Zhengsen Fu
//Description   : tb for ahb master but without burst mode
//Last Updated  : 8/21/20

`include "ahb.sv"
`include "uvm_macros.svh"
// `include "tb_components.svh"
import uvm_pkg::*;
`include "bus_tx.svh"
`include "ahb_test.svh"

module tb_ahb ();
  logic clk;
  logic n_rst;
  
  // generate clock
  initial begin
    clk = 0;
    forever #10 clk = !clk;
	end

  ahb_if ahbif(clk);
  generic_bus_if bus_if(clk);

  ahb DUT(.CLK(clk), .nRST(n_rst), .ahb_m(ahbif.ahb_m), .out_gen_bus_if(bus_if.generic_bus));

  // reset DUT
  initial begin
    n_rst = 0;
    @(posedge clk);
    n_rst = 1;
  end

  initial begin
    uvm_config_db#(virtual ahb_if)::set( null, "", "ahb_vif", ahbif);
    uvm_config_db#(virtual generic_bus_if)::set( null, "", "bus_vif", bus_if);
    // uvm_config_db#(logic)::set( null, "", "n_rst", n_rst);
    run_test("ahb_test"); // initiate test component

  end

endmodule


