/*
  Project       : SoCET RISCVBusiness UVM
  UVM Component : Instruction Driver
*/
`ifndef INSTR_DRIVER_SVH
`define INSTR_DRIVER_SVH

// --- Include --- //
`include "uvm_macros.svh"
`include "instr_transaction.svh"
`include "multicore_if.vh"
`include "bus_if.vh"
`include "dut_parameters.sv"

// --- Import --- //
import uvm_pkg::*;
import dut_parameters::*;

// --- Instruction Driver --- //
class instr_driver extends uvm_driver#(instr_transaction);
    `uvm_component_utils (instr_driver)

    instr_transaction tx;
    virtual multicore_if #(RST_PC, HARTS, D_WIDTH, A_WIDTH) mcif;

    // --- Constructor --- //
    function new (string name="instr_driver", uvm_component parent = null);
        super.new(name, parent);
		`uvm_info("INSTR_DRV", "Constructor", UVM_HIGH)
    endfunction

    // --- Build Phase --- //
    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
		`uvm_info("INSTR_DRV", "Build Phase", UVM_HIGH)
        // VIF Handle
        if(!uvm_config_db #(virtual multicore_if #(RST_PC, HARTS, D_WIDTH, A_WIDTH))::get(this, "", "mcif", mcif)) begin
            `uvm_fatal("INSTR_DRV", "No virtual interface specified for multicore_if instance")
        end
    endfunction

    // --- Run Phase --- //
    task run_phase (uvm_phase phase);
		super.run_phase(phase);
        `uvm_info("INSTR_DRV", "Run Phase", UVM_HIGH)
    
        // --- Sequence Item Queue --- //
        forever begin
          tx = instr_transaction::type_id::create("tx"); 
          seq_item_port.get_next_item(tx);
          drive(tx);
          seq_item_port.item_done();
        end
    endtask

    // --- Drive Task --- //
    task drive (instr_transaction tx);
            @(posedge mcif.CLK);
            // RESET
            if(~tx.nRST) begin 
                @(negedge mcif.CLK);
                mcif.halt                   = '0;
                mcif.wfi                    = '0;
                mcif.gen_bus_if.instruction = '0;
                mcif.gen_bus_if.ierror      = '0;
                mcif.gen_bus_if.i_req_stall = '0;
                mcif.nRST                   = '0;
            end else begin
                // TODO: multicore instr driver code
            end
            // @(posedge mcif.CLK);    
    endtask
endclass

`endif