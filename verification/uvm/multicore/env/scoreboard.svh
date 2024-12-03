`ifndef SCOREBOARD_SVH
`define SCOREBOARD_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "instr_transaction.svh"
`include "data_transaction.svh"

class scoreboard extends uvm_scoreboard;
    `uvm_component_utils(scoreboard)

    // *** Analysis Ports (Instruction side) ***
    uvm_analysis_port #(instr_transaction) imp_instr_bus;
    uvm_tlm_analysis_fifo #(instr_transaction) instr_fifo;

    // *** Analysis Ports (Data side) ***
    uvm_analysis_port #(data_transaction) imp_data_bus;
    uvm_tlm_analysis_fifo #(data_transaction) data_fifo;

    // *** Transactions ***
    instr_transaction i_tx;
    data_transaction d_tx;

    function new(string name = "scoreboard", uvm_component parent = null);
        super.new(name, parent);

        imp_instr_bus = new("imp_instr_bus", this);
        instr_fifo = new("instr_fifo", this);
        imp_data_bus = new("imp_data_bus", this);
        data_fifo = new("data_fifo", this);

        i_tx = new();
        d_tx = new();
    endfunction

    function void connect_phase(uvm_phase phase);
        imp_instr_bus.connect(instr_fifo.analysis_export);
        imp_data_bus.connect(data_fifo.analysis_export);
    endfunction

    // Nature of this scoreboard will use flushes as checkpoints
    // to compare the CPU cache dump with C-based golden model
    task run_phase(uvm_phase phase);
        forever begin
            // TODO: Implement scoring logic here for multicore specifics
        end
    endtask

    function void report_phase(uvm_phase phase);
        uvm_report_info("SCOREBOARD", "Multicore Scoring Results", UVM_LOW);
    endfunction
endclass

`endif
