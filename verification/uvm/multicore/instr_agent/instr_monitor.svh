`ifndef INSTR_MONITOR_SVH
`define INSTR_MONITOR_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "instr_transaction.svh"
`include "multicore_if.vh"
`include "dut_parameters.sv"

import dut_parameters::*;

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
            instr_tx.mtime = mcif.mtime;
            instr_tx.nRST = mcif.nRST;
            `uvm_info("MONITOR_INPUT",
                $sformatf("iREN: %0b, iaddr: %0h, mtime: %0d, nRST: %0b",
                instr_tx.iREN, instr_tx.iaddr, instr_tx.mtime, instr_tx.nRST),
            UVM_HIGH);
            
	        // --- Output Sample --- //
			@(posedge mcif.CLK);	      
            instr_tx.ierror = mcif.gen_bus_if.ierror;
            instr_tx.i_req_stall = mcif.gen_bus_if.i_req_stall;
            instr_tx.instruction = mcif.gen_bus_if.instruction;
            instr_tx.halt = mcif.halt;
            instr_tx.wfi = mcif.wfi;

            `uvm_info("MONITOR_OUTPUT",
                $sformatf("ierror: %0b, i_req_stall: %0b, instruction: %0h, halt: %0b, wfi: %0b",
                instr_tx.ierror, instr_tx.i_req_stall, instr_tx.instruction, instr_tx.halt, instr_tx.wfi),
            UVM_HIGH);

            // --- Send to Scoreboard --- //
			instr_ap.write(instr_tx);
        end
    endtask
endclass

`endif