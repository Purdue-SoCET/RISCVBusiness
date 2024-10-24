`ifndef INSTR_MONITOR_SVH
`define INSTR_MONITOR_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "instr_transaction.svh"
`include "multicore_if.sv"

class instr_monitor extends uvm_monitor;
    `uvm_component_utils (instr_monitor)

    virtual multicore_if mcif;
    instr_transaction instr_tx;

    uvm_analysis_port#(instr_transaction) instr_ap;


    function new (string name = "instr_monitor", uvm_component parent = null);
        super.new(name, parent);
        instr_ap = new("instr_ap", this);
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual multicore_if)::get(this, "", "mcif", mcif)) begin
            `uvm_fatal("INSTR_MONITOR", "No virtual interface specified for multicore_if instance")
        end
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        instr_tx = instr_transaction::type_id::create("instr_tx");

        forever begin 
            @(posedge mcif.CLK);

            /*
                Multicore Specific Monitor Code
            */
        end

    endtask
endclass

`endif