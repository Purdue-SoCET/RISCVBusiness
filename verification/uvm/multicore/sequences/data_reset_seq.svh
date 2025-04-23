/*
  Project       : SoCET RISCVBusiness UVM
  UVM Component : Reset Sequence - Data
*/
`ifndef DATA_RESET_SEQ_SVH
`define DATA_RESET_SEQ_SVH

// --- Include --- //
`include "uvm_macros.svh"
`include "data_transaction.svh"

// --- Import --- //
import uvm_pkg::*;

// --- Data Reset Seq --- //
class data_reset_seq extends uvm_sequence #(data_transaction);
    `uvm_object_utils(data_reset_seq)

    // --- Constructor --- //
    function new(string name = "data_reset_seq");
        super.new(name);
    endfunction

    // --- Reset Sequence --- //
    task body();
        `uvm_info("DATA_RST_SEQ", "Initiating Data Reset Sequence", UVM_HIGH)
        
        data_reset_tx = data_transaction::type_id::create("data_reset_tx", null, get_full_name());
        start_item(data_reset_tx);
        data_reset_tx.randomize() with {nRST==1'b0;};
        finish_item(data_reset_tx);

    endtask
endclass

// --- Data Garbage Sequence --- //
class data_garbage_seq extends uvm_sequence #(data_transaction);
    `uvm_object_utils(data_garbage_seq)

    // --- Constructor --- //
    function new(string name = "data_garbage_seq");
        super.new(name);
    endfunction

    // --- Reset Sequence --- //
    task body();
        `uvm_info("DATA_GRBG_SEQ", "Initiating Data Garbage Sequence", UVM_HIGH)
        
        data_garbage_tx = data_transaction::type_id::create("data_garbage_tx", null, get_full_name());
        start_item(data_garbage_tx);
        data_garbage_tx.randomize() with {nRST==1'b1;};
        finish_item(data_garbage_tx);

    endtask
endclass

`endif
