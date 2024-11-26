`ifndef INSTR_MONITOR_SVH
`define INSTR_MONITOR_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "instr_transaction.svh"
`include "multicore_if.vh"
`include "dut_parameters.sv"

class instr_monitor extends uvm_monitor;
    `uvm_component_utils (instr_monitor)

    virtual multicore_if #(RST_PC, HARTS, D_WIDTH, A_WIDTH) mcif;
    instr_transaction instr_tx;

    uvm_analysis_port#(instr_transaction) instr_ap;


    function new (string name = "instr_monitor", uvm_component parent = null);
        super.new(name, parent);
        instr_ap = new("instr_ap", this);
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual multicore_if #(RST_PC, HARTS, D_WIDTH, A_WIDTH))::get(this, "", "mcif", mcif)) begin
            `uvm_fatal("INSTR_MONITOR", "No virtual interface specified for multicore_if instance")
        end
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        instr_tx = instr_transaction::type_id::create("instr_tx");

        forever begin 
            wait(mcif.nRST);

			// --- Input Sample --- //
            @(posedge mcif.CLK);			
            instr_tx.iREN = mcif.gen_bus_if.iREN;
            instr_tx.iaddr = mcif.gen_bus_if.iaddr;

	        // --- Output Sample --- //
			@(posedge mcif.CLK);	      
            instr_tx.nRST = mcif.nRST;
            instr_tx.ierror = mcif.gen_bus_if.ierror;
            instr_tx.i_req_stall = mcif.gen_bus_if.i_req_stall;
            instr_tx.instruction = mcif.gen_bus_if.instruction;

            instr_tx.halt = mcif.halt;
            instr_tx.wfi = mcif.wfi;

            // --- Send to Scoreboard --- //
			instr_ap.write(instr_tx);
        end
    endtask
endclass

`endif