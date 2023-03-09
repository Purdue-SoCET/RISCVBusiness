`ifndef ENVIROMENT_SVH
`define ENVIROMENT_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "bus_agent.svh"
`include "l2_agent.svh"
`include "snp_rsp_agent.svh"
`include "bus_ctrl_if.vh"
`include "bus_checker.svh"  // uvm_subscriber
`include "bus_transaction.svh"  // uvm_sequence_item
`include "l2_bfm.svh"
`include "l1_snoopresp_bfm.sv"

class environment extends uvm_env;
  `uvm_component_utils(environment)

  bus_agent bus_agent_agent;  // contains monitor and driver
  l2_agent l2_agent_agent;
  snp_rsp_agent snp_rsp_agent_agent;

  bus_checker bus_check;  // a checker to check the overall results

  l2_bfm l2BFM;
  l1_snoopresp_bfm snpRspBFM;

  function new(string name = "env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    // instantiate all the components through factory method
    l2BFM = l2_bfm::type_id::create("l2_bfm", this);
    snpRspBFM = l1_snoopresp_bfm::type_id::create("l1_snoopresp_bfm", this);
    bus_agent_agent = bus_agent::type_id::create("bus_agent", this);
    snp_rsp_agent_agent = snp_rsp_agent::type_id::create("snp_rsp_agent", this);
    l2_agent_agent = l2_agent::type_id::create("l2_agent", this);
    bus_check = bus_checker::type_id::create("bus_check", this);
  endfunction


  // TODO: Connect everything up correctly
  function void connect_phase(uvm_phase phase);
    bus_agent_agent.l1_req_mon.check_ap.connect(bus_check.l1_req_export);  // connect monitor to predictor
    snp_rsp_agent_agent.snp_rsp_mon.check_ap.connect(bus_check.snp_rsp_export);  // connect monitor to predictor
    l2_agent_agent.l2_mon.check_ap.connect(bus_check.l2_export);  // connect monitor to predictor
  endfunction

endclass : environment

`endif
