`ifndef INSTR_DRIVER_SVH
`define INSTR_DRIVER_SVH
import uvm_pkg::*;

`include "uvm_macros.svh"
`include "instr_transaction.svh"
`include "multicore_if.sv"

class instr_driver extends uvm_driver;
    `uvm_component_utils (instr_driver)

    virtual multicore_if mcif;

    function new (string name="instr_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db #(virtual multicore_if)::get(this, "", "mcif", mcif)) begin
            `uvm_fatal("INSTR_DRIVER", "No virtual interface specified for multicore_if instance")
        end
    endfunction

    task run_phase (uvm_phase phase);
        forever begin 
            instr_transaction tx;
            @(posedge mcif.CLK);
            seq_item_port.get_next_item(tx);

            /*
                Multicore specific Driver Code
            */

            @(posedge busif.clk);    
            seq_item_port.item_done();
        end
    endtask
endclass

