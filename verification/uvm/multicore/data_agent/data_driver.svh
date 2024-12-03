// --- SoCET Multicore F24 - UVM Data Driver --- //
`ifndef DATA_DRIVER_SVH
`define DATA_DRIVER_SVH

// --- Includes --- //
import uvm_pkg::*;

`include "uvm_macros.svh"
`include "data_transaction.svh"
`include "multicore_if.vh"
`include "dut_parameters.sv"

import dut_parameters::*;

class data_driver extends uvm_driver;
    `uvm_component_utils (data_driver)

	// --- Virtual Interface --- //
    virtual multicore_if #(RST_PC, HARTS, D_WIDTH, A_WIDTH) mcif;

	// --- Constructor --- //
    function new (string name="data_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

	// --- Build Phase --- //
    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db #(virtual multicore_if #(RST_PC, HARTS, D_WIDTH, A_WIDTH))::get(this, "", "mcif", mcif)) begin
            `uvm_fatal("data_DRIVER", "No virtual interface for multicore_if")
        end
    endfunction

    task run_phase (uvm_phase phase);
        forever begin 
            data_transaction tx;
            @(posedge mcif.CLK);
            seq_item_port.get_next_item(tx);
            // RESET
            if(!tx.nRST) begin 
                @(negedge mcif.CLK);
                mcif.gen_bus_if.data_load = 0;
                mcif.gen_bus_if.derror = 0;
                mcif.gen_bus_if.d_req_stall = '0;
            end
            /*
                Multicore specific Driver Code
            */

            @(posedge busif.clk);    // TODO:
            seq_item_port.item_done();
        end
    endtask
endclass

`endif