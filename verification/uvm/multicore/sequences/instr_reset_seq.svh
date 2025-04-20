`ifndef INSTR_RESET_SEQ_SVH
`define INSTR_RESET_SEQ_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "instr_transaction.svh"

class instr_reset_seq extends uvm_sequence #(instr_transaction);
    `uvm_object_utils(instr_reset_seq)

    // Constructor
    function new(string name = "");
        super.new(name);
    endfunction: new

    // ******* Reset Sequence *******
    task body();
        `uvm_info(get_type_name(), "Starting Reset Sequence", UVM_HIGH)
        
        // Provide garbage stimulus to the DUT
        provide_stimulus();
        #50ns;
        
        // Apply reset to clear the DUT
        reset_dut();
        
        `uvm_info(get_type_name(), "Completed Reset Sequence", UVM_HIGH)
    endtask: body

    task provide_stimulus();
        instr_transaction tx2;
        tx2 = instr_transaction::type_id::create("tx2", null, get_full_name());

        `uvm_info(get_type_name(), "Generating Garbage Stimulus", UVM_HIGH)
        
        // Randomize all inputs to create garbage outputs
        start_item(tx2);
        assert(tx2.randomize()) else `uvm_error(get_type_name(), "Randomization failed for tx2");
        
        tx2.nRST = 1; 
        finish_item(tx2);
        
        `uvm_info(get_type_name(), "Completed Garbage Stimulus (nRST=1)", UVM_HIGH)
    endtask: provide_stimulus

    task reset_dut();
        instr_transaction tx1;
        tx1 = instr_transaction::type_id::create("tx1", null, get_full_name());

        `uvm_info(get_type_name(), "Asserting Reset (nRST=0)", UVM_HIGH)
        
        start_item(tx1);
        assert(tx1.randomize()) else `uvm_error(get_type_name(), "Randomization failed for tx1");
        
        // Set reset low to reset the DUT
        tx1.nRST = 1'b0;
        finish_item(tx1);
        
        `uvm_info(get_type_name(), "Completed Reset (nRST=0)", UVM_HIGH)
    endtask: reset_dut

endclass

`endif
