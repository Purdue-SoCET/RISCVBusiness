`include "uvm_macros.svh"
import uvm_pkg::*;
`include "ahb_agent.svh"
`include "comparator.svh"
`include "predictor.svh"

class ahb_env extends uvm_env;
  `uvm_component_utils(ahb_env)
  ahb_agent agt;
  comparator comp; // scoreboard
  predictor pred;
  sim_mem mem;
  // transactionSeq tx_seq; //to record and lookup transactions

  function new(string name = "env", uvm_component parent = null);
		super.new(name, parent);
	endfunction

  function void build_phase(uvm_phase phase);
    agt = ahb_agent::type_id::create("agt", this);
    comp = comparator::type_id::create("comp", this);
    pred = predictor::type_id::create("pred", this);
    // tx_seq = new();
    mem = new();
    if(!mem.randomize()) begin
      `uvm_fatal("environment", "not able to randomize mem")
    end
    pred.mem = mem;
    comp.mem = mem;
    uvm_config_db#(sim_mem)::set( null, "", "slave_mem", mem);
    // pred.tx_seq = tx_seq;
    // comp.tx_seq = tx_seq;
  endfunction

  function void connect_phase(uvm_phase phase);
    agt.cpu.cpu_ap.connect(pred.analysis_export);
    agt.cpu.response_ap.connect(comp.response_export);
  endfunction

endclass //ahb_env
