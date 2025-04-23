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
    function new(string name = "instr_reset_seq");
        super.new(name);
    endfunction

    // --- Reset Sequence --- //
    task body();
        `uvm_info("INSTR_RST_SEQ", "Initiating Instruction Reset Sequence", UVM_HIGH)
        
        instr_reset_tx = instr_transaction::type_id::create("instr_reset_tx", null, get_full_name());
        start_item(instr_reset_tx);
        instr_reset_tx.randomize() with {nRST==1'b0;};
        finish_item(instr_reset_tx);

    endtask
endclass

// --- Instr Garbage Seq --- //
class instr_garbage_seq extends uvm_sequence #(instr_transaction);
    `uvm_object_utils(instr_garbage_seq)

    // --- Constructor --- //
    function new(string name = "instr_garbage_seq");
        super.new(name);
    endfunction

    // --- Reset Sequence --- //
    task body();
        `uvm_info("INSTR_GRBG_SEQ", "Initiating Instruction Garbage Sequence", UVM_HIGH)
        
        instr_garbage_tx = instr_transaction::type_id::create("instr_garbage_tx", null, get_full_name());
        start_item(instr_garbage_tx);
        instr_garbage_tx.randomize() with {nRST==1'b1;};
        // TODO: seq item soft constraints?
        finish_item(instr_garbage_tx);

    endtask
endclass

`endif
