`ifndef TRANSACTION_SVH
`define TRANSACTION_SVH

import uvm_pkg::*;
import rv32i_types_pkg::*;
`include "uvm_macros.svh"

class transaction extends uvm_sequence_item;

  logic rw; // 0 -> read; 1 -> write
  logic instr_data; // 0 -> instr cache, 1 -> data cache
  rand word_t addr;
  rand word_t data;
  logic p; //processor number p0 or p1

  `uvm_object_utils_begin(transaction)
      `uvm_field_int(rw, UVM_ALL_ON)
      `uvm_field_int(instr_data, UVM_ALL_ON)
      `uvm_field_int(addr, UVM_ALL_ON)
      `uvm_field_int(data, UVM_ALL_ON)
      `uvm_field_int(p, UVM_ALL_ON)
  `uvm_object_utils_end

  //TODO: FIGURE OUT HOW TO USE CONSTRAINTS
  // constraint rollover {rollover_value != 0; rollover_value != 1;}
  // constraint clk_number{num_clk > 0; num_clk < 20;}

  function new(string name = "transaction");
    super.new(name);
  endfunction: new

  // // comparison between two transaction object
  // // if two transactions are the same, return 1 else return 0
  // function int input_equal(transaction tx);
  //   int result;
  //   if((rollover_value == tx.rollover_value) && (num_clk == tx.num_clk)) begin
  //     result = 1;
  //     return result;
  //   end
  //   result = 0;
  //   return result;
  // endfunction

endclass: transaction

`endif
