`include "uvm_macros.svh"
import uvm_pkg::*;


class sequencer extends uvm_sequencer#(transaction);
   `uvm_component_utils(sequencer)
   function new(input string name= "sequencer", uvm_component parent=null);
      super.new(name, parent);
   endfunction : new
endclass : sequencer
