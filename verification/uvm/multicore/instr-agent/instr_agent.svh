`ifndef INSTR_AGENT_SVH
`define INSTR_AGENT_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "instr_sequencer.svh"
`include "instr_driver.svh"
`include "instr_monitor.svh"
`include "multicore_if.svh"

class instr_agent extends uvm_agent;
    `uvm_component_utils(instr_agent)
    
    uvm_analysis_port#(instr_transaction) instr_agent_ap;

    instr_sequencer instr_sqr;
    instr_driver instr_drv;
    instr_monitor instr_mon;

    virtual multicore_if mcif;

    function new (string name = "instr_agent", uvm_component parent = null);
        super.new(name, parent);
        instr_agent_ap = new("instr_agent_ap", this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        instr_sqr = instr_sequencer::type_id::create("instr_sqr", this);
        instr_drv = instr_driver::type_id::create("instr_drv", this);
        instr_mon = instr_monitor::type_id::create("instr_mon", this);

        if(!uvm_config_db#(virtual multicore_if)::get(this, "", "mcif", mcif)) begin
            `uvm_fatal("INSTR_AGENT", "No virtual interface specified for multicore_if instance")
        end
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        instr_drv.seq_item_port.connect(instr_sqr.seq_item_export);
        uvm_report_info("INSTR_AGENT", "connect_phase: Connected driver to sequencer", UVM_HIGH);

        instr_mon.instr_ap.connect(instr_agent_ap);
        uvm_report_info("INSTR_AGENT", "connect_phase: Connected monitor analysis port to agent analysis port", UVM_HIGH);
    endfunction
endclass : instr_agent
`endif