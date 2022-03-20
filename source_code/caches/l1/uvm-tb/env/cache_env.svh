`ifndef CACHE_ENV_SVH
`define CACHE_ENV_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "cache_env_config.svh" // config
`include "memory_bfm.svh" // bfm

`include "cpu_agent.svh"
`include "cpu_scoreboard.svh" // uvm_scoreboard
`include "cpu_predictor.svh" // uvm_subscriber
`include "cpu_transaction.svh" // uvm_sequence_item

`include "mem_agent.svh"
`include "mem_scoreboard.svh" // uvm_scoreboard
`include "mem_predictor.svh" // uvm_subscriber

`include "end2end.svh" // uvm_scoreboard

class cache_env extends uvm_env;
  `uvm_component_utils(cache_env)

  cache_env_config env_config; //environment configuration
  memory_bfm mem_bfm; //memory bus functional model
  
  cpu_agent cpu_agt; // contains monitor and driver
  cpu_predictor cpu_pred; // a reference model to check the result
  cpu_scoreboard cpu_score; // scoreboard

  mem_agent mem_agt; // contains monitor
  mem_predictor mem_pred; // a reference model to check the result
  mem_scoreboard mem_score; // scoreboard
  end2end e2e; //end to end checker

  function new(string name = "env", uvm_component parent = null);
		super.new(name, parent);
	endfunction

  function void build_phase(uvm_phase phase);
    cpu_agt = cpu_agent::type_id::create("CPU_AGT", this);
    cpu_pred = cpu_predictor::type_id::create("CPU_PRED", this);
    cpu_score = cpu_scoreboard::type_id::create("CPU_SCORE", this);

    mem_agt = mem_agent::type_id::create("MEM_AGT", this);
    mem_pred = mem_predictor::type_id::create("MEM_PRED", this);
    mem_score = mem_scoreboard::type_id::create("MEM_SCORE", this);

    e2e = end2end::type_id::create("E2E", this);

    mem_bfm = memory_bfm::type_id::create("MEM_BFM", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    cpu_agt.mon.req_ap.connect(cpu_pred.analysis_export); // connect monitor to predictor
    `uvm_info(this.get_name(), $sformatf("Connected <%s>-req_ap to <%s>", cpu_agt.mon.get_name(), cpu_pred.get_name()), UVM_FULL)

    cpu_pred.pred_ap.connect(cpu_score.expected_export); // connect predictor to scoreboard
    `uvm_info(this.get_name(), $sformatf("Connected <%s> to <%s>", cpu_pred.get_name(), cpu_score.get_name()), UVM_FULL)

    cpu_agt.mon.resp_ap.connect(cpu_score.actual_export); // connect monitor to scoreboard
    `uvm_info(this.get_name(), $sformatf("Connected <%s>-resp_ap to <%s>", cpu_agt.mon.get_name(), cpu_score.get_name()), UVM_FULL)


    mem_agt.mon.req_ap.connect(mem_pred.analysis_export); // connect monitor to predictor
    `uvm_info(this.get_name(), $sformatf("Connected <%s>-req_ap to <%s>", mem_agt.mon.get_name(), mem_pred.get_name()), UVM_FULL)

    mem_pred.pred_ap.connect(mem_score.expected_export); // connect predictor to scoreboard
    `uvm_info(this.get_name(), $sformatf("Connected <%s> to <%s>", mem_pred.get_name(), mem_score.get_name()), UVM_FULL)

    mem_agt.mon.resp_ap.connect(mem_score.actual_export); // connect monitor to scoreboard
    `uvm_info(this.get_name(), $sformatf("Connected <%s>-resp_ap to <%s>", mem_agt.mon.get_name(), mem_score.get_name()), UVM_FULL)

    cpu_agt.mon.resp_ap.connect(e2e.cpu_export);
    mem_agt.mon.resp_ap.connect(e2e.mem_export);
  endfunction

endclass: cache_env

`endif