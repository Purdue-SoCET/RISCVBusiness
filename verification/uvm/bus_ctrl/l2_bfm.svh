`ifndef L2_BFM_SVH
`define L2_BFM_SVH

`include "bus_ctrl_if.vh"
`include "dut_params.svh"
`include "uvm_macros.svh"
//`include "Utils.svh"
`define PROPAGATION_DELAY #(2000);

import uvm_pkg::*;

class l2_bfm extends uvm_component;
  `uvm_component_utils(l2_bfm)

  virtual bus_ctrl_if bus_if;

  env_config bus_env_config;

  function new(string name = "l2_bfm", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    string bus_if_str;
    super.build_phase(phase);

    // get config from database
    if (!uvm_config_db#(env_config)::get(this, "", "bus_env_config", bus_env_config)) begin
      `uvm_fatal(this.get_name(), "env config not registered to db")
    end

    // get interface from database
   // if (!uvm_config_db#(virtual cache_if)::get(this, "", "d_cif", bif)) begin
   //   `uvm_fatal($sformatf("%s/d_cif", this.get_name()),
   //              "No virtual interface specified for this test instance");
   // end
    `uvm_info(this.get_name(), "pulled <d_cif> from db", UVM_FULL)
  endfunction : build_phase

  virtual task run_phase(uvm_phase phase);
    forever begin
      //@(posedge bif.CLK);
      //`PROPAGATION_DELAY
      for(int i = 0; i < 1999; i++) begin
        @(posedge bus_if.clk);
      end

      // default values on bus
      bus_if.l2load = 64'hbad0bad0bad0bad0;
      bus_if.l2state = L2_FREE;

      if (bus_if.l2REN) begin
        mem_read();
      end 
      else if (bus_if.l2WEN) begin
        mem_write();
      end
    end
  endtask : run_phase

  task mem_read();
    int count = 0;
    int cycles = $urandom() % (dut_params::l2_RAND_RANGE);
    bus_if.l2state = L2_BUSY;

    count = 1;
    while (count < cycles) begin
      @(posedge bus_if.CLK);
      count++;
    end

    bus_if.l2load = {32'haaaaaaaa, bus_if.l2addr[31:0]};
    bus_if.l2state = L2_ACCESS;
  endtask : mem_read

  task mem_write();
    int count = 0;
    int cycles = $urandom() % (dut_params::l2_RAND_RANGE);
    bus_if.l2state = L2_BUSY;

    count = 1;
    while (count < cycles) begin
      @(posedge bus_if.CLK);
      count++;
    end

    bus_if.l2state = L2_ACCESS;
  endtask : mem_write

endclass : l2_bfm

`endif
