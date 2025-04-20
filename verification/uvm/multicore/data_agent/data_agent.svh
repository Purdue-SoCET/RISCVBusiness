/*
  Project       : SoCET RISCVBusiness UVM
  UMV Component : Data Agent
  Author        : Adam Keith
*/
`ifndef DATA_AGENT_SVH
`define DATA_AGENT_SVH

// --- Include --- //
`include "uvm_macros.svh"
`include "data_sequencer.svh"
`include "data_driver.svh"
`include "data_monitor.svh"
`include "multicore_if.vh"
`include "bus_if.vh"
`include "dut_parameters.sv"
`include "data_transaction.svh"

// --- Import --- //
import uvm_pkg::*;
import dut_parameters::*;

// --- Data Agent --- //
class data_agent extends uvm_agent;
    `uvm_component_utils(data_agent)
    
    // Agent Components
    data_sequencer data_sqr;
    data_driver    data_drv;
    data_monitor   data_mon;

    // Data Analysis Port
    uvm_analysis_port#(data_transaction) data_agent_ap;

    virtual multicore_if #(RST_PC, HARTS, D_WIDTH, A_WIDTH) mcif;

    // --- Constructor --- //
    function new (string name = "data_agent", uvm_component parent = null);
        super.new(name, parent);
        data_agent_ap = new("data_agent_ap", this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // agent components
        data_sqr = data_sequencer::type_id::create("data_sqr", this);
        data_drv = data_driver::type_id::create("data_drv", this);
        data_mon = data_monitor::type_id::create("data_mon", this);
        // virtual interface handle
        if(!uvm_config_db#(virtual multicore_if #(RST_PC, HARTS, D_WIDTH, A_WIDTH))::get(this, "", "mcif", mcif)) begin
            `uvm_fatal("DATA_AGENT", "No virtual interface specified for multicore_if instance")
        end
    endfunction

    // --- Connect Phase --- //
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        // sequencer -> driver
        data_drv.seq_item_port.connect(data_sqr.seq_item_export);
        // monitor -> scoreboard/pred
        data_mon.data_ap.connect(data_agent_ap);
    endfunction
endclass

`endif
