/*
  Project       : SoCET RISCVBusiness UVM
  UVM Component : Instruction Sequencer
*/
`ifndef INSTR_SEQUENCER_SVH
`define INSTR_SEQUENCER_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "instr_transaction.svh"

typedef uvm_sequencer #(instr_transaction) instr_sequencer;

/* TODO: not sure why Indy used typedef for this, ik no
         seq utilties are being used but still like to have
         the full uvm object written out like is done in data
         for future proofing/debug statement opproptunities
*/
`endif