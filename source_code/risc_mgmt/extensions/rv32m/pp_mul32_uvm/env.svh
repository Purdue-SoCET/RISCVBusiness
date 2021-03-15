import uvm_pkg::*;
`include "uvm_macros.svh"
`include "agent.svh"
`include "mult_if.svh"
`include "comparator.svh" // uvm_scoreboard
`include "predictor.svh" // uvm_subscriber
`include "transaction.svh" // uvm_sequence_item

class environment extends uvm_env;
  `uvm_component_utils(environment)
  
  agent agt; // contains monitor and driver
  predictor pred; // a reference model to check the result
  comparator comp; // scoreboard

  function new(string name = "env", uvm_component parent = null);
		super.new(name, parent);
	endfunction



  function void build_phase(uvm_phase phase);
    // instantiate all the components through factory method
    agt = agent::type_id::create("agt", this);
    pred = predictor::type_id::create("pred", this);
    comp = comparator::type_id::create("comp", this);

  endfunction

  function void connect_phase(uvm_phase phase);
    agt.mon.counter_ap.connect(pred.analysis_export); // connect monitor to predictor
    pred.pred_ap.connect(comp.expected_export); // connect predictor to comparator
    agt.mon.result_ap.connect(comp.actual_export); // connect monitor to comparator
  endfunction

endclass: environment