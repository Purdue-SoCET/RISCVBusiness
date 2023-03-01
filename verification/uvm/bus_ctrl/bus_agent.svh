`ifndef BUS_AGENT_SVH
`define BUS_AGENT_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "sequence.svh"
`include "bus_driver_v2.svh"
`include "bus_monitor.svh"

class bus_agent extends uvm_agent;
  `uvm_component_utils(bus_agent)
  sequencer  sqr;
  bus_driver_v2 bus_drv;
  l1_req_monitor l1_req_mon;

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    sqr = sequencer::type_id::create("sqr", this);
    bus_drv = bus_driver_v2::type_id::create("bus_drv", this);
    l1_req_mon = l1_req_monitor::type_id::create("l1_req_mon", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    bus_drv.seq_item_port.connect(sqr.seq_item_export);
  endfunction

endclass : bus_agent

`endif
