/*
  Project       : SoCET RISCVBusiness UVM
  UVM Component : Data Driver
  Author        : Adam Keith
*/
`ifndef DATA_DRIVER_SVH
`define DATA_DRIVER_SVH

// --- Includes --- //
`include "uvm_macros.svh"
`include "data_transaction.svh"
`include "multicore_if.vh"
`include "bus_if.vh"
`include "dut_parameters.sv"

// --- Import --- //
import dut_parameters::*;
import uvm_pkg::*;

// --- Data Driver --- //
class data_driver extends uvm_driver#(data_transaction);
    `uvm_component_utils (data_driver)

    data_transaction data_tx;
    virtual multicore_if #(RST_PC, HARTS, D_WIDTH, A_WIDTH) mcif;

	// --- Constructor --- //
    function new (string name="data_driver", uvm_component parent = null);
        super.new(name, parent);
		`uvm_info("DATA_DRV", "Constructor", UVM_HIGH)
    endfunction

	// --- Build Phase --- //
    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
		`uvm_info("DATA_DRV", "Build Phase", UVM_HIGH)
		// virtual interface handle
        if(!uvm_config_db #(virtual multicore_if #(RST_PC, HARTS, D_WIDTH, A_WIDTH))::get(this, "", "mcif", mcif)) begin
            `uvm_fatal("DATA_DRV", "No virtual interface for multicore_if")
        end
    endfunction

    // --- Run Phase --- //
    task run_phase (uvm_phase phase);
		super.run_phase(phase);
        `uvm_info("DATA_DRV", "Run Phase", UVM_HIGH)
    
        // Transaction Queue
        forever begin
          data_tx = data_transaction::type_id::create("data_tx"); 
          seq_item_port.get_next_item(data_tx);
          drive(data_tx);
          seq_item_port.item_done();
        end
    endtask

    // --- Drive Task --- //
    task drive(data_transaction data_tx);
        // Input Drive
        @(posedge mcif.CLK);
        
        // Note: not sure I love this yet but we'll see
        if (~(data_tx.nRST)) begin 
            @(negedge mcif.CLK);
            mcif.gen_bus_if.derror      = '0;
            mcif.gen_bus_if.dload       = '0;
            mcif.gen_bus_if.d_req_stall = '0;
        end else begin
            @(negedge mcif.CLK);
            mcif.gen_bus_if.dload       = data_tx.dload;
            mcif.gen_bus_if.derror      = data_tx.derror;
            mcif.gen_bus_if.d_req_stall = data_tx.d_req_stall;
        end
    endtask
endclass

`endif