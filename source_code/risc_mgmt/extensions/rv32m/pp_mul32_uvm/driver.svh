import uvm_pkg::*;
`include "uvm_macros.svh"
`include "mult_if.svh"

class driver extends uvm_driver#(transaction);
    `uvm_component_utils(driver)

    function new(string name, uvm_component parent);
		  super.new(name, parent);
	  endfunction: new

    virtual mult_if vif;

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if( !uvm_config_db#(virtual mult_if)::get(this, "", "mult_vif", vif) ) begin
        `uvm_fatal("Driver", "No interface");
      end
    endfunction: build_phase

    task run_phase(uvm_phase phase);
      transaction tx;

      forever begin

        @(posedge mult_if.CLK);
        seq_item_port.get_next_item(tx);
        DUT_reset();
        while(!vif.finished) {
          vif.multiplicand = tx.multiplicand;
          vif.multiplier = tx.multiplier;
          vif.is_signed = 2'b0;
          vif.start = 1'b1;
        }

        @(posedge vif.clk);
        seq_item_port.item_done();
      end

    endtask:run_phase


    task DUT_reset();
        vif.nRST = 1;
        @(posedge vif.CLK);
        vif.nRST = 0;
        @(posedge vif.CLK);
    endtask
    
endclass: driver