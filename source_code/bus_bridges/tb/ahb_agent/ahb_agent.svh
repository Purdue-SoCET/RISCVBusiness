`include "uvm_macros.svh"
import uvm_pkg::*;
`include "ahb_mon.svh"
`include "ahb_sequencer.svh"
`include "bus_driver.svh"
`include "sim_mem.svh"

class ahb_agent extends uvm_agent;
  `uvm_component_utils(ahb_agent)
  sim_cpu cpu;
  sim_slave slave;
  sequencer sqr;

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);   
    sqr = sequencer::type_id::create("sqr", this);
    slave = sim_slave::type_id::create("slave", this);
    cpu = sim_cpu::type_id::create("cpu", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    cpu.seq_item_port.connect(sqr.seq_item_export);
  endfunction
endclass //ahb_agent

