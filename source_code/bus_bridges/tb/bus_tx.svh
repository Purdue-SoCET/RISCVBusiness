`ifndef TX_SVH
`define TX_SVH

`include "uvm_macros.svh"
import uvm_pkg::*;


class transaction extends uvm_sequence_item;
  // parameter RAM_SIZE = 256;
  localparam IDLE = '0;
  localparam READ = 2'b01;
  localparam WRITE = 2'b10;
  
  rand bit[1:0] trans; //trasaction type. Possible values indicated above
  rand logic [31:0] wdata;
  rand logic [31:0] addr;
  rand logic [3:0] byte_en;

  `uvm_object_utils_begin(transaction)
    `uvm_field_int(trans, UVM_DEFAULT)
    `uvm_field_int(wdata, UVM_DEFAULT)
    `uvm_field_int(addr, UVM_DEFAULT)
    `uvm_field_int(byte_en, UVM_DEFAULT)
  `uvm_object_utils_end

  constraint address_limit {byte_en == 4'b1111 -> addr <= 4'hf - 3;
                            byte_en == 4'b0011 || byte_en == 4'b1100 -> addr <= 4'hf - 1;}
  constraint trans_constraint {trans == IDLE || trans == READ || trans == WRITE;}
  constraint addr_size {addr <= 4'hf;} //testing with a simulated memory smaller than 16 registers
  
  function new(string name = "transaction");
    super.new(name);
  endfunction: new
endclass //transaction

`endif 
