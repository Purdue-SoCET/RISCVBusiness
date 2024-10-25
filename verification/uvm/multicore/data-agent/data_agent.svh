`ifndef DATA_AGENT_SVH
`define DATA_AGENT_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "data_sequencer.svh"
`include "data_driver.svh"
`include "data_monitor.svh"
`include "multicore_if.svh"

class data_agent extends uvm_agent;
    `uvm_component_utils(data_agent)
    
    uvm_analysis_port#(data_transaction) data_agent_ap;

    data_sequencer data_sqr;
    data_driver data_drv;
    data_monitor data_mon;

    virtual multicore_if mcif;

    function new (string name = "data_agent", uvm_component parent = null);
        super.new(name, parent);
        data_agent_ap = new("data_agent_ap", this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        data_sqr = data_sequencer::type_id::create("data_sqr", this);
        data_drv = data_driver::type_id::create("data_drv", this);
        data_mon = data_monitor::type_id::create("data_mon", this);

        if(!uvm_config_db#(virtual multicore_if)::get(this, "", "mcif", mcif)) begin
            `uvm_fatal("DATA_AGENT", "No virtual interface specified for multicore_if instance")
        end
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        data_drv.seq_item_port.connect(data_sqr.seq_item_export);
        uvm_report_info("DATA_AGENT", "connect_phase: Connected driver to sequencer", UVM_HIGH);

        data_mon.data_ap.connect(data_agent_ap);
        uvm_report_info("DATA_AGENT", "connect_phase: Connected monitor analysis port to agent analysis port", UVM_HIGH);
    endfunction
endclass : data_agent
`endif
