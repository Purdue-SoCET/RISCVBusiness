// --- SoCET Multicore F24 - UVM Data Sequencer --- //
`ifndef DATA_SEQUENCER_SVH
`define DATA_SEQUENCER_SVH

// --- Include --- //
import uvm_pkg::*;

`include "uvm_macros.svh"
`include "data_transaction.svh"

// --- Data Sequencer --- //
class data_sequencer extends uvm_sequencer#(data_transaction);
  `uvm_component_utils(data_sequencer)
  
  // --- Constructor --- //
  function new(string name = "data_sequencer", uvm_component parent);
    super.new(name, parent);
    `uvm_info("SEQR_CLASS", "Inside Constructor", UVM_HIGH)
  endfunction: new
  
  // --- Build Phase --- //
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("SEQR_CLASS", "Build Phase", UVM_HIGH)
  endfunction: build_phase
  
  // --- Connect Phase --- //
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("SEQR_CLASS", "Connect Phase", UVM_HIGH)
  endfunction: connect_phase
  
endclass : data_sequencer

`endif