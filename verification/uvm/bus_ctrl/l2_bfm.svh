`ifndef L2_BFM_SVH
`define L2_BFM_SVH

`include "bus_ctrl_if.vh"
`include "dut_params.svh"
`include "uvm_macros.svh"
`include "Utils.svh"

import uvm_pkg::*;
import rv32i_types_pkg::*;

class l2_bfm extends uvm_component;
  `uvm_component_utils(memory_bfm)

  virtual bus_ctrl_if bif;

  env_config bus_env_config;

  word_t mem[word_t];  // initialized memory array
  word_t mmio[word_t];  // initialized memory mapped array

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
    if (!uvm_config_db#(virtual cache_if)::get(this, "", "d_cif", bif)) begin
      `uvm_fatal($sformatf("%s/d_cif", this.get_name()),
                 "No virtual interface specified for this test instance");
    end
    `uvm_info(this.get_name(), "pulled <d_cif> from db", UVM_FULL)
  endfunction : build_phase

  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge bif.CLK);
      `PROPAGATION_DELAY

      // default values on bus
      bus_if.dload = 64'hbad0bad0bad0bad0;

      if (bus_if.dREN) begin
        mem_read();
      end else if (bus_if.dWEN) begin
        mem_write();
      end
    end
  endtask : run_phase

  task mem_read();
    int count;

    bus_if.busy = '1;
    count = 1;
    while (count < bus_env_config.mem_latency && bus_if.ren) begin
      @(posedge cif.CLK);
      `PROPAGATION_DELAY
      count++;
    end

    bus_if.rdata = read(bus_if.addr);
    bus_if.busy  = '0;
  endtask : mem_read

  task mem_write();
    int count;

    bus_if.busy = '1;
    count = 1;
    while (count < bus_env_config.mem_latency) begin
      @(posedge cif.CLK);
      `PROPAGATION_DELAY
      count++;
    end

    mem[bus_if.addr] = bus_if.wdata;

    bus_if.busy = '0;
  endtask : mem_write

  function word_t read(word_t addr);
    if (mem.exists(bus_if.addr)) begin
      return mem[bus_if.addr];
    end else begin
      return {bus_env_config.mem_tag, addr[15:0]};  // return non-initialized data
    end
  endfunction : read

endclass : memory_bfm

`endif