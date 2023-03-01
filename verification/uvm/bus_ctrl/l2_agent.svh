`ifndef L2_AGENT_SVH
`define L2_AGENT_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "sequence.svh"
`include "l2_monitor.svh"

class l2_agent extends uvm_agent;
  `uvm_component_utils(l2_agent)
  l2_monitor l2_mon;

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    l2_mon = l2_monitor::type_id::create("l2_mon", this);
  endfunction

endclass : l2_agent

`endif
