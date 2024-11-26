`ifndef INSTR_SEQUENCER_SVH
`define INSTR_SEQUENCER_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "instr_transaction.svh"

typedef uvm_sequencer #(instr_transaction) instr_sequencer;

`endif