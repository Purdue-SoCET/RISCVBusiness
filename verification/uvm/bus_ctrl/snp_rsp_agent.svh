`ifndef SNP_RSP_AGENT_SVH
`define SNP_RSP_AGENT_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "snp_rsp_monitor.svh"

class snp_rsp_agent extends uvm_agent;
  `uvm_component_utils(snp_rsp_agent)
  snp_rsp_monitor snp_rsp_mon;

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    snp_rsp_mon = snp_rsp_monitor::type_id::create("snp_rsp_mon", this);
  endfunction


endclass : snp_rsp_agent

`endif
