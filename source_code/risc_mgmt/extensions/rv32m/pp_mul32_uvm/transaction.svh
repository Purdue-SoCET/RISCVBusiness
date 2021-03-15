`ifndef TRANSACTION_SVH
`define TRANSACTION_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"

class transaction extends uvm_sequence_item;
    `uvm_object_utils(transaction)
    rand bit [31:0] multiplicand;
    rand bit [31:0] multiplier;
    rand bit [1:0] is_signed;
    bit finished;
    bit [63:0] product;

    constraint c_multiplicand {multiplicand > 0; multiplicand < 31'b100000};
    constraint c_multiplier {multiplier > 0; multiplier < 31'b100000};


    function new(string name = "transaction");
        super.new(name);
    endfunction: new
    
endclass: transaction

`endif