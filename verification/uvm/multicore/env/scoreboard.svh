/*
  Project       : SoCET RISCVBusiness UVM
  UVM Component : Multicore Scoreboard
*/
`ifndef SCOREBOARD_SVH
`define SCOREBOARD_SVH

// --- Include --- //
`include "uvm_macros.svh"
`include "instr_transaction.svh"
`include "data_transaction.svh"

// --- Import --- //
import uvm_pkg::*;

// --- Scoreboard --- //
class scoreboard extends uvm_scoreboard;
    `uvm_component_utils(scoreboard)

    // --- Instruction Ports --- //
    uvm_analysis_export   #(instr_transaction) imp_instr_bus;
    uvm_tlm_analysis_fifo #(instr_transaction) instr_fifo;

    // --- Data Ports --- //
    uvm_analysis_export   #(data_transaction) imp_data_bus;
    uvm_tlm_analysis_fifo #(data_transaction) data_fifo;

    // --- Transactions --- //
    instr_transaction i_tx;
    data_transaction  d_tx;

    // --- Constructor --- //
    function new(string name = "scoreboard", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // Build APs
        imp_instr_bus = new("imp_instr_bus", this);
        instr_fifo    = new("instr_fifo",    this);
        imp_data_bus  = new("imp_data_bus",  this);
        data_fifo     = new("data_fifo",     this);
    endfunction

    // --- Connect Phase --- //
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        imp_instr_bus.connect(instr_fifo.analysis_export);
        imp_data_bus.connect(data_fifo.analysis_export);
    endfunction

    // --- Run Phase --- //
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("SCB_CLASS", "Run Phase", UVM_HIGH)
        // Build TXs
        i_tx = instr_transaction::type_id::create("i_tx");
        d_tx = data_transaction::type_id::create("d_tx");

        forever begin
            instr_fifo.get(i_tx);
            // `uvm_info("SCB", $sformatf("Instruction Transaction:\n%s", i_tx.sprint()), UVM_HIGH)

            data_fifo.get(d_tx);
            // `uvm_info("SCB", $sformatf("Data Transaction:\n%s", d_tx.sprint()), UVM_HIGH)

            compare_instr(i_tx);
            compare_data(d_tx);
        end
    endtask
    
    task compare_instr(instr_transaction i_tx);
        if (i_tx.nRST == 1'b0) begin
            `uvm_info("COMPARE", "RESET TEST PRINT INSTR", UVM_LOW)
        end
    endtask

    task compare_data(data_transaction d_tx);
        if (d_tx.nRST == 1'b0) begin
            `uvm_info("COMPARE", "RESET TEST PRINT DATA", UVM_LOW)
        end
    endtask
endclass

`endif
