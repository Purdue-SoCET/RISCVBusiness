import uvm_pkg::*;
`include "uvm_macros.svh"
`include "instr_transaction.svh"

class scoreboard extends uvm_scoreboard;
    `uvm_component_utils(scoreboard)


    // *** Analysis Ports ***
    uvm_analysis_port #(instr_transaction) imp_bus;
    uvm_tlm_analysis_fifo  #(instr_transaction) instr_fifo;

    instr_transaction i_tx;
    function new (string name = "scoreboard", uvm_component parent = null);
        super.new(name, parent);
        imp_bus = new("imp_bus", this);
        instr_fifo = new("instr_fifo", this);

        i_tx = new();
    endfunction

    function void connect_phase(uvm_phase phase);
        imp_bus.connect(instr_fifo.analysis_export);
    endfunction

    task run_phase (uvm_phase phase);
        /*
            MULTICORE SPECIFIC SCORING
        */
    endtask 
endclass