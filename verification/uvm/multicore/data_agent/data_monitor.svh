/*
  Project       : SoCET RISCVBusiness UVM
  UVM Component : Data Monitor
  Author        : Adam Keith
*/
`ifndef DATA_MONITOR_SVH
`define DATA_MONITOR_SVH

// --- Include --- //
`include "uvm_macros.svh"
`include "data_transaction.svh"
`include "bus_if.vh"
`include "multicore_if.vh"
`include "dut_parameters.sv"

// --- Import --- //
import uvm_pkg::*;
import dut_parameters::*;

// --- Data Monitor --- //
class data_monitor extends uvm_monitor;
	`uvm_component_utils(data_monitor)

	data_transaction data_tx;
	virtual multicore_if #(RST_PC, HARTS, D_WIDTH, A_WIDTH) mcif;
	uvm_analysis_port#(data_transaction) data_ap;

	// --- Constructor --- //
	function new(string name = "data_monitor", uvm_component parent = null);
		super.new(name, parent);
		`uvm_info("DATA_MON", "Inside Constructor", UVM_HIGH)
	endfunction

	// --- Build Phase --- //
	virtual function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("DATA_MON", "Build Phase", UVM_HIGH)
		// build analysis port
		data_ap = new("data_ap", this);
		// virtual interface handle
		if(!uvm_config_db #(virtual multicore_if #(RST_PC, HARTS, D_WIDTH, A_WIDTH))::get(this, "", "mcif", mcif)) begin
			`uvm_fatal("DATA_MONITOR", "No virtual interface for multicore_if")
		end
	endfunction

	// --- Connect Phase --- //
  	function void connect_phase(uvm_phase phase);
    	super.connect_phase(phase);
    	`uvm_info("DATA_MON", "Connect Phase", UVM_HIGH)
	endfunction

	// --- Run Phase --- //
	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info("DATA_MON", "Run Phase", UVM_HIGH)

		// --- Run Phase --- //
		forever begin
			data_tx = data_transaction::type_id::create("data_tx");

			// Reset
			data_tx.nRST = mcif.nRST;
			
			// Input Sample
			@(posedge mcif.CLK);			
			data_tx.dREN   = mcif.gen_bus_if.dREN;
			data_tx.dWEN   = mcif.gen_bus_if.dWEN;
			data_tx.daddr  = mcif.gen_bus_if.daddr;
			data_tx.dstore = mcif.gen_bus_if.dstore;
			
			// Debug
			`uvm_info("DATA_MONITOR_INPUT",
				$sformatf("dREN: %0b, wREN: %0b, daddr: %0h, dstore: %0h",
				data_tx.dREN, data_tx.dWEN, data_tx.daddr, data_tx.dstore),
			UVM_DEBUG);

			// Output Sample
			@(posedge mcif.CLK);			
			data_tx.derror	    = mcif.gen_bus_if.derror;
			data_tx.d_req_stall = mcif.gen_bus_if.d_req_stall;
			data_tx.dload	    = mcif.gen_bus_if.dload;

			// Debug
			`uvm_info("DATA_MONITOR_OUTPUT",
				$sformatf("derror: %0b, d_req_stall: %0b, dload: %0h",
				data_tx.derror, data_tx.d_req_stall, data_tx.dload),
			UVM_DEBUG);

			// Send to Scoreboard/Predictor
            `uvm_info("DATA_MON", $sformatf("Data Transaction:\n%s", data_tx.sprint()), UVM_HIGH)
			data_ap.write(data_tx);
		end
	endtask
endclass

`endif
