`ifndef CPU_TRANSACTION_SVH
`define CPU_TRANSACTION_SVH

import uvm_pkg::*;
import rv32i_types_pkg::*;
`include "uvm_macros.svh"
`include "cache_env.svh"
`include "dut_params.svh"

class cpu_transaction extends uvm_sequence_item;

  rand bit rw; // 0 -> read; 1 -> write
  rand word_t addr;
  rand word_t data;
  int cycle; //cycle number of transaction, used for timing
  
  rand logic [3:0] byte_sel;
  // Byte enable logic
  // 4bits, 4'b {d, c, b, a}
  // a bit == 1 -> one byte
  // b bit == 1 -> two bytes, half word
  // c bit == 1 -> three bytes
  // d bit == 1 -> four bytes, full word

  //TODO: ADD CLEAR
  //TODO: ADD FLUSH

  `uvm_object_utils_begin(cpu_transaction)
      `uvm_field_int(rw, UVM_ALL_ON)
      `uvm_field_int(addr, UVM_ALL_ON)
      `uvm_field_int(data, UVM_ALL_ON)
      `uvm_field_int(byte_sel, UVM_ALL_ON)
      `uvm_field_int(cycle, UVM_NOCOMPARE)
  `uvm_object_utils_end

  constraint usable_addr { addr >= '0; soft addr < `NONCACHE_START_ADDR; }

  constraint usable_byte_en { byte_sel == 4'b1000; } //TODO: We want to actually randomize this

  function new(string name = "cpu_transaction");
    super.new(name);
  endfunction: new

endclass: cpu_transaction

`endif