/*
  Project       : SoCET RISCVBusiness UVM
  UVM Component : Data Sequencer
  Author        : Adam Keith
*/
`ifndef DATA_SEQUENCER_SVH
`define DATA_SEQUENCER_SVH

// --- Include --- //
`include "uvm_macros.svh"
`include "data_transaction.svh"

// --- Import --- //
import uvm_pkg::*;

// --- Data Sequencer --- //
class data_sequencer extends uvm_sequencer#(data_transaction);
  `uvm_component_utils(data_sequencer)

  // --- Constructor --- //
  function new(string name = "data_sequencer", uvm_component parent);
    super.new(name, parent);
    `uvm_info("DATA_SQR", "Inside Constructor", UVM_HIGH)
  endfunction

  // --- Build Phase --- //
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("DATA_SQR", "Build Phase", UVM_HIGH)
  endfunction
  
  // --- Connect Phase --- //
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("SEQR_CLASS", "Connect Phase", UVM_HIGH)
  endfunction
endclass

`endif