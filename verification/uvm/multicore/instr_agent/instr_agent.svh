/*
  Project       : SoCET RISCVBusiness UVM
  UVM Component : Instruction Agent
*/
`ifndef INSTR_AGENT_SVH
`define INSTR_AGENT_SVH

// --- Include --- //
`include "uvm_macros.svh"
`include "instr_sequencer.svh"
`include "instr_driver.svh"
`include "instr_monitor.svh"
`include "multicore_if.vh"
`include "bus_if.vh"
`include "dut_parameters.sv"

// --- Import --- //
import uvm_pkg::*;
import dut_parameters::*;

// --- Instruction Agent --- //
class instr_agent extends uvm_agent;
    `uvm_component_utils(instr_agent)
    
    // --- Agent Components --- //
    instr_sequencer instr_sqr;
    instr_driver    instr_drv;
    instr_monitor   instr_mon;

    virtual multicore_if #(RST_PC, HARTS, D_WIDTH, A_WIDTH) mcif;
    uvm_analysis_port#(instr_transaction) instr_agent_ap;

    // --- Constructor --- //
    function new (string name = "instr_agent", uvm_component parent = null);
        super.new(name, parent);
        instr_agent_ap = new("instr_agent_ap", this);
    endfunction

    // --- Build Phase --- //
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("INSTR_AGENT", "Build Phase", UVM_HIGH);
        // Register Agent Components
        instr_sqr = instr_sequencer::type_id::create("instr_sqr", this);
        instr_drv = instr_driver::type_id::create("instr_drv", this);
        instr_mon = instr_monitor::type_id::create("instr_mon", this);
        // VIF Handle
        if(!uvm_config_db#(virtual multicore_if #(RST_PC, HARTS, D_WIDTH, A_WIDTH))::get(this, "", "mcif", mcif)) begin
            `uvm_fatal("INSTR_AGENT", "No virtual interface specified for multicore_if instance")
        end
    endfunction

    // --- Connect Phase --- //
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("INSTR_AGENT", "Connect Phase", UVM_HIGH);
        // Sequencer --> Driver
        instr_drv.seq_item_port.connect(instr_sqr.seq_item_export);
        // Monitor --> Scoreboard 
        instr_mon.instr_ap.connect(instr_agent_ap);
    endfunction
endclass

`endif