// --- SoCET Multicore F24 - UVM Data Driver --- //
`ifndef DATA_DRIVER_SVH
`define DATA_DRIVER_SVH

// --- Includes --- //
import uvm_pkg::*;

`include "uvm_macros.svh"
`include "data_transaction.svh"
`include "multicore_if.sv"

class data_driver extends uvm_driver;
    `uvm_component_utils (data_driver)

	// --- Virtual Interface --- //
    virtual multicore_if mcvif;

	// --- Constructor --- //
    function new (string name="data_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

	// --- Build Phase --- //
    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db #(virtual multicore_if)::get(this, "", "mcvif", mcvif)) begin
            `uvm_fatal("data_DRIVER", "No virtual interface for multicore_if")
        end
    endfunction

    task run_phase (uvm_phase phase);
        forever begin 
            data_transaction tx;
            @(posedge mcvif.CLK);
            seq_item_port.get_next_item(tx);

            /*
                Multicore specific Driver Code
            */

            @(posedge busif.clk);    // TODO:
            seq_item_port.item_done();
        end
    endtask
endclass