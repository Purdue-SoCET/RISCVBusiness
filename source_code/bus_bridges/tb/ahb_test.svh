`include "uvm_macros.svh"
import uvm_pkg::*;
`include "ahb_env.svh"
`include "ahb_sequence.svh"

class ahb_test extends uvm_test;
  `uvm_component_utils(ahb_test)

  ahb_env env;
  ahb_seq seq;

  function new(string name = "ahb_test", uvm_component parent);
		super.new(name, parent);
	endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
		env = ahb_env::type_id::create("env",this);
    seq = ahb_seq::type_id::create("seq");
  endfunction: build_phase

  task run_phase(uvm_phase phase);
    phase.raise_objection( this, "Starting sequence in main phase" );
		$display("%t Starting sequence run_phase",$time);

 		seq.start(env.agt.sqr);
		#100ns;
		phase.drop_objection( this , "Finished in main phase" );
  endtask

endclass //ahb_test
