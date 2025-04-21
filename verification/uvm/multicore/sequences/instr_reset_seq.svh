/*
  Project       : SoCET RISCVBusiness UVM
  UVM Component : Reset Sequence - Instr
*/
`ifndef INSTR_RESET_SEQ_SVH
`define INSTR_RESET_SEQ_SVH

// --- Include --- //
`include "uvm_macros.svh"
`include "instr_transaction.svh"

// --- Import --- //
import uvm_pkg::*;

// --- Instr Reset Seq --- //
class instr_reset_seq extends uvm_sequence #(instr_transaction);
    `uvm_object_utils(instr_reset_seq)

    // --- Constructor --- //
    function new(string name = "");
        super.new(name);
    endfunction

    // --- Reset Sequence --- //
    task body();
        `uvm_info(get_type_name(), "Initiating Reset Sequence", UVM_HIGH)
        
        provide_stimulus();
        #50ns;
        reset_dut();
        
        `uvm_info(get_type_name(), "Completed Reset Sequence", UVM_HIGH)
    endtask

    // --- Drive Garbage --- //
    task provide_stimulus();
        instr_transaction garbage_tx;
        garbage_tx = instr_transaction::type_id::create("garbage_tx", null, get_full_name());

        `uvm_info(get_type_name(), "Generating garbage stimulus", UVM_HIGH)
        
        start_item(garbage_tx);
        assert(garbage_tx.randomize()) else `uvm_error(get_type_name(), "Randomization failed garbage_tx");
        
        garbage_tx.nRST = 1'b1; 
        finish_item(garbage_tx);
        
        `uvm_info(get_type_name(), "Completed garbage stimulus", UVM_HIGH)
    endtask

    // --- Reset Sequence --- //
    task reset_dut();
        instr_transaction reset_tx;
        reset_tx = instr_transaction::type_id::create("reset_tx", null, get_full_name());

        `uvm_info(get_type_name(), "Asserting reset sequence", UVM_HIGH)
        
        start_item(reset_tx);
        assert(reset_tx.randomize()) else `uvm_error(get_type_name(), "Randomization failed for reset_tx");
        
        // Set reset low to reset the DUT
        reset_tx.nRST = 1'b0;
        finish_item(reset_tx);
        
        `uvm_info(get_type_name(), "Completed reset sequence", UVM_HIGH)
    endtask
endclass

`endif
