/*
*   Copyright 2022 Purdue University
*
*   Licensed under the Apache License, Version 2.0 (the "License");
*   you may not use this file except in compliance with the License.
*   You may obtain a copy of the License at
*
*       http://www.apache.org/licenses/LICENSE-2.0
*
*   Unless required by applicable law or agreed to in writing, software
*   distributed under the License is distributed on an "AS IS" BASIS,
*   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*   See the License for the specific language governing permissions and
*   limitations under the License.
*
*
*   Filename:     cache_env.svh
*
*   Created by:   Mitch Arndt
*   Email:        arndt20@purdue.edu
*   Date Created: 03/27/2022
*   Description:  UVM Environment for cache verification
*/

`ifndef CACHE_ENV_SVH
`define CACHE_ENV_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "cache_env_config.svh"  // config
`include "memory_bfm.svh"  // bfm

`include "bus_predictor.svh"  // uvm_subscriber
`include "bus_scoreboard.svh"  // uvm_scoreboard

`include "d_cpu_agent.svh"
`include "i_cpu_agent.svh"
`include "mem_arb_agent.svh"

`include "cpu_transaction.svh"  // uvm_sequence_item

`include "mem_agent.svh"
`include "l2_agent.svh"
`include "mem_arb_agent.svh"

`include "end2end.svh"  // uvm_scoreboard

typedef uvm_analysis_port#(cpu_transaction) cpu_ap;

class cache_env extends uvm_env;
  `uvm_component_utils(cache_env)

  function new(string name = "env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  cache_env_config env_config;  //environment configuration
  memory_bfm mem_bfm;  //memory bus functional model

`ifdef TB_L1_CONFIG
  d_cpu_agent cpu_agt;  // contains monitor and driver
  bus_predictor cpu_pred;  // a reference model to check the result
  bus_scoreboard cpu_score;  // scoreboard

  mem_agent mem_agt;  // contains monitor
  bus_predictor mem_pred;  // a reference model to check the result
  bus_scoreboard mem_score;  // scoreboard

  end2end e2e;  //end to end checker from l1 cache to memory bus

  function void build_phase(uvm_phase phase);
    mem_bfm = memory_bfm::type_id::create("MEM_BFM", this);

    cpu_agt = d_cpu_agent::type_id::create("CPU_AGT", this);
    cpu_pred = bus_predictor::type_id::create("CPU_PRED", this);
    cpu_pred.cache = new("CPU_PRED_CACHE", mem_bfm, 0);
    cpu_score = bus_scoreboard::type_id::create("CPU_SCORE", this);

    mem_agt = mem_agent::type_id::create("MEM_AGT", this);
    mem_pred = bus_predictor::type_id::create("MEM_PRED", this);
    mem_pred.cache = new("MEM_PRED_CACHE", mem_bfm, 1);
    mem_score = bus_scoreboard::type_id::create("MEM_SCORE", this);

    e2e = end2end::type_id::create("E2E", this);
    e2e.cache = new("E2E_CACHE", mem_bfm, 0);
  endfunction

  function void connect_phase(uvm_phase phase);
    // L1 CACHE AGENT
    bus_connect(cpu_agt, cpu_pred, cpu_score);

    // MEMORY AGENT
    bus_connect(mem_agt, mem_pred, mem_score);

    // L1 CACHE <-> MEMORY :: END TO END CHECKER
    cpu_agt.mon.req_ap.connect(e2e.src_req_export);
    cpu_agt.mon.resp_ap.connect(e2e.src_resp_export);
    mem_agt.mon.resp_ap.connect(e2e.dest_resp_export);
  endfunction : connect_phase
`endif

`ifdef TB_L2_CONFIG
  mem_arb_agent  mem_arb_agt;  // contains monitor and driver
  bus_predictor  mem_arb_pred;  // a reference model to check the result
  bus_scoreboard mem_arb_score;  // scoreboard

  mem_agent      mem_agt;  // contains monitor
  bus_predictor  mem_pred;  // a reference model to check the result
  bus_scoreboard mem_score;  // scoreboard

  end2end        e2e;  //end to end checker from l2 cache to memory bus

  function void build_phase(uvm_phase phase);
    mem_bfm = memory_bfm::type_id::create("MEM_BFM", this);

    mem_arb_agt = mem_arb_agent::type_id::create("MEM_ARB_AGT", this);
    mem_arb_pred = bus_predictor::type_id::create("MEM_ARB_PRED", this);
    mem_arb_pred.cache = new("MEM_ARB_PRED_CACHE", mem_bfm, 1);
    mem_arb_score = bus_scoreboard::type_id::create("MEM_ARB_SCORE", this);

    mem_agt = mem_agent::type_id::create("MEM_AGT", this);
    mem_pred = bus_predictor::type_id::create("MEM_PRED", this);
    mem_pred.cache = new("MEM_PRED_CACHE", mem_bfm, 1);
    mem_score = bus_scoreboard::type_id::create("MEM_SCORE", this);

    e2e = end2end::type_id::create("E2E", this);
    e2e.cache = new("E2E_CACHE", mem_bfm, 1);
  endfunction

  function void connect_phase(uvm_phase phase);
    // L1 CACHE AGENT
    bus_connect(mem_arb_agt, mem_arb_pred, mem_arb_score);

    // MEMORY AGENT
    bus_connect(mem_agt, mem_pred, mem_score);

    // L1 CACHE <-> MEMORY :: END TO END CHECKER
    mem_arb_agt.mon.req_ap.connect(e2e.src_req_export);
    mem_arb_agt.mon.resp_ap.connect(e2e.src_resp_export);
    mem_agt.mon.resp_ap.connect(e2e.dest_resp_export);
  endfunction : connect_phase
`endif

`ifdef TB_FULL_CONFIG
  d_cpu_agent d_cpu_agt;  // contains monitor and driver
  bus_predictor d_cpu_pred;  // a reference model to check the result
  bus_scoreboard d_cpu_score;  // scoreboard

  i_cpu_agent i_cpu_agt;  // contains monitor and driver
  bus_predictor i_cpu_pred;  // a reference model to check the result
  bus_scoreboard i_cpu_score;  // scoreboard

  l2_agent l2_agt;  // contains monitor
  bus_predictor l2_pred;  // a reference model to check the result
  bus_scoreboard l2_score;  // scoreboard

  mem_agent mem_agt;  // contains monitor
  bus_predictor mem_pred;  // a reference model to check the result
  bus_scoreboard mem_score;  // scoreboard

  end2end dl1_l2_e2e;  //end to end checker from data l1 cache to l2 cache
  end2end il1_l2_e2e;  //end to end checker from instr l1 cache to l2 cache
  end2end l2_mem_e2e;  //end to end checker from l2 cache to memory bus

  function void build_phase(uvm_phase phase);
    mem_bfm = memory_bfm::type_id::create("MEM_BFM", this);

    d_cpu_agt = d_cpu_agent::type_id::create("D_CPU_AGT", this);
    d_cpu_pred = bus_predictor::type_id::create("D_CPU_PRED", this);
    d_cpu_pred.cache = new("D_CPU_PRED_CACHE", mem_bfm, 0);
    d_cpu_score = bus_scoreboard::type_id::create("D_CPU_SCORE", this);

    i_cpu_agt = i_cpu_agent::type_id::create("I_CPU_AGT", this);
    i_cpu_pred = bus_predictor::type_id::create("I_CPU_PRED", this);
    i_cpu_pred.cache = new("I_CPU_PRED_CACHE", mem_bfm, 0);
    i_cpu_score = bus_scoreboard::type_id::create("I_CPU_SCORE", this);

    l2_agt = l2_agent::type_id::create("L2_AGT", this);
    l2_pred = bus_predictor::type_id::create("L2_PRED", this);
    l2_pred.cache = new("L2_PRED_CACHE", mem_bfm, 1);
    l2_score = bus_scoreboard::type_id::create("L2_SCORE", this);

    mem_agt = mem_agent::type_id::create("MEM_AGT", this);
    mem_pred = bus_predictor::type_id::create("MEM_PRED", this);
    mem_pred.cache = new("MEM_PRED_CACHE", mem_bfm, 1);
    mem_score = bus_scoreboard::type_id::create("MEM_SCORE", this);

    dl1_l2_e2e = end2end::type_id::create("DL1_L2_E2E", this);
    dl1_l2_e2e.cache = new("DL1_L2_E2E_CACHE", mem_bfm, 0);

    il1_l2_e2e = end2end::type_id::create("IL1_L2_E2E", this);
    il1_l2_e2e.cache = new("IL1_L2_E2E_CACHE", mem_bfm, 0);

    l2_mem_e2e = end2end::type_id::create("L2_MEM_E2E", this);
    l2_mem_e2e.cache = new("L2_MEM_E2E_CACHE", mem_bfm, 1);
  endfunction

  function void connect_phase(uvm_phase phase);
    // DATA L1 CACHE AGENT
    bus_connect(d_cpu_agt, d_cpu_pred, d_cpu_score);

    // INSTRUCTION L1 CACHE AGENT
    bus_connect(i_cpu_agt, i_cpu_pred, i_cpu_score);

    // MEMORY AGENT
    bus_connect(mem_agt, mem_pred, mem_score);

    // DATA L1 CACHE <-> L2 CACHE :: END TO END CHECKER
    d_cpu_agt.mon.req_ap.connect(dl1_l2_e2e.src_req_export);
    d_cpu_agt.mon.resp_ap.connect(dl1_l2_e2e.src_resp_export);
    l2_agt.mon.resp_ap.connect(dl1_l2_e2e.dest_resp_export);

    // L2 CACHE <-> MEMORY :: END TO END CHECKER
    l2_agt.mon.req_ap.connect(l2_mem_e2e.src_req_export);
    l2_agt.mon.resp_ap.connect(l2_mem_e2e.src_resp_export);
    mem_agt.mon.resp_ap.connect(l2_mem_e2e.dest_resp_export);
  endfunction : connect_phase
`endif

  function void bus_connect(bus_agent agt, bus_predictor pred, bus_scoreboard score);
    agt.mon.req_ap.connect(pred.analysis_export);  // connect monitor to predictor 
    `uvm_info(this.get_name(), $sformatf(
              "Connected <%s>-req_ap to <%s>", agt.mon.get_name(), pred.get_name()), UVM_FULL)

    pred.pred_ap.connect(score.expected_export);  // connect predictor to scoreboard
    `uvm_info(this.get_name(), $sformatf("Connected <%s> to <%s>", pred.get_name(), score.get_name()
              ), UVM_FULL)

    agt.mon.resp_ap.connect(score.actual_export);  // connect monitor to scoreboard
    `uvm_info(this.get_name(), $sformatf(
              "Connected <%s>-resp_ap to <%s>", agt.mon.get_name(), score.get_name()), UVM_FULL)
  endfunction : bus_connect

endclass : cache_env

`endif
