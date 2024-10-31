// --- SoCET Multicore F24 - UVM Data Monitor --- //
`ifndef DATA_MONITOR_SVH
`define DATA_MONITOR_SVH

// --- Includes --- //
import uvm_pkg::*;

`include "uvm_macros.svh"
`include "data_transaction.svh"
`include "multicore_if.sv"

// --- Data Transaction --- //
class data_monitor extends uvm_monitor;
	`uvm_component_utils(data_monitor)

	// --- Virtual Interface --- //
	virtual multicore_if mcvif;

	// --- Transaction --- //
	data_transaction data_trans;

	// --- Create Analysis Port --- //
	uvm_analysis_port#(data_transaction) data_ap;

	// --- Constructor --- //
	function new(string name = "data_monitor", uvm_component parent = null);
		super.new(name, parent);
		`uvm_info("DATA_MONITOR", "Inside Constructor", UVM_HIGH)
	endfunction

	// --- Build Phase --- //
	virtual function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("DATA_MONITOR", "Build Phase", UVM_HIGH)
		
		// --- Build Monitor Port --- //
		data_ap = new("data_ap", this);
		
		if(!uvm_config_db #(virtual multicore_if)::get(this, "", "mcif", mcif)) begin
			`uvm_fatal("DATA_MONITOR", "No virtual interface for multicore_if")
		end
	endfunction : build_phase

	// --- Run Phase --- //
	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info("DATA_MONITOR", "Run Phase", UVM_HIGH)

		// --- Create Data Transaction --- //		
		data_trans = data_transaction::type_id::create("data_trans");

		// --- Run Phase --- //
		forever begin

			wait(mcvif.NRST);

			// --- Input Sample --- //
			@(posedge mcvif.CLK);			
			
			data_trans.dREN   = mcvif.dREN;
			data_trans.wREN   = mcvif.wREN;
			data_trans.daddr  = mcvif.daddr;
			data_trans.dstore = mcvif.dstore;

			// --- Output Sample --- //
			@(posedge mcvif.CLK);			

			data_trans.derror = mcvif.derror;
			data_trans.dbusy  = mcvif.dbusy;
			data_trans.dload  = mcvif.dload;

			// --- Send to Scoreboard --- //
			data_ap.write(data_trans);
	
		end
	endtask : run_phase
endclass : data_monitor

`endif
