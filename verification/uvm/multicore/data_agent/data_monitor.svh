// --- SoCET Multicore F24 - UVM Data Monitor --- //
`ifndef DATA_MONITOR_SVH
`define DATA_MONITOR_SVH

// --- Includes --- //
import uvm_pkg::*;

`include "uvm_macros.svh"
`include "data_transaction.svh"
`include "multicore_if.vh"
`include "dut_parameters.sv"

// --- Data Transaction --- //
class data_monitor extends uvm_monitor;
	`uvm_component_utils(data_monitor)

	// --- Virtual Interface --- //
	virtual multicore_if #(RST_PC, HARTS, D_WIDTH, A_WIDTH) mcif;

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
		
		if(!uvm_config_db #(virtual multicore_if #(RST_PC, HARTS, D_WIDTH, A_WIDTH))::get(this, "", "mcif", mcif)) begin
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
			wait(mcif.nRST);

			// --- Input Sample --- //
			@(posedge mcif.CLK);			
			
			data_trans.dREN   = mcif.gen_bus_if.dREN;
			data_trans.dWEN   = mcif.gen_bus_if.dWEN;
			data_trans.daddr  = mcif.gen_bus_if.daddr;
			data_trans.dstore = mcif.gen_bus_if.dstore;
			`uvm_info("MONITOR_INPUT",
				$sformatf("dREN: %0b, wREN: %0b, daddr: %0h, dstore: %0h",
				data_trans.dREN, data_trans.wREN, data_trans.daddr, data_trans.dstore),
			UVM_HIGH);

			// --- Output Sample --- //
			@(posedge mcif.CLK);			

			data_trans.derror = mcif.gen_bus_if.derror;
			data_trans.dbusy  = mcif.gen_bus_if.dbusy;
			data_trans.dload  = mcif.gen_bus_if.dload;
			
			`uvm_info("MONITOR_OUTPUT",
				$sformatf("derror: %0b, dbusy: %0b, dload: %0h",
				data_trans.derror, data_trans.dbusy, data_trans.dload),
			UVM_HIGH);

			// --- Send to Scoreboard --- //
			data_ap.write(data_trans);
	
		end
	endtask : run_phase
endclass : data_monitor

`endif
