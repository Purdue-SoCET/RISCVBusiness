`ifndef INSTR_DRIVER_SVH
`define INSTR_DRIVER_SVH
import uvm_pkg::*;

`include "uvm_macros.svh"
`include "instr_transaction.svh"
`include "multicore_if.vh"
`include "dut_parameters.sv"

class instr_driver extends uvm_driver;
    `uvm_component_utils (instr_driver)

    virtual multicore_if #(RST_PC, HARTS, D_WIDTH, A_WIDTH) mcif;

    function new (string name="instr_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db #(virtual multicore_if #(RST_PC, HARTS, D_WIDTH, A_WIDTH))::get(this, "", "mcif", mcif)) begin
            `uvm_fatal("INSTR_DRIVER", "No virtual interface specified for multicore_if instance")
        end
    endfunction

    task run_phase (uvm_phase phase);
        forever begin 
            instr_transaction tx;
            @(posedge mcif.CLK);
            seq_item_port.get_next_item(tx);
            // RESET
            if(!tx.nrst) begin 
                @(negedge mcif.CLK);
                mcif.halt = 1'b0;
                mcif.mtime = 1'b0;
                mcif.gen_bus_if.instruction = '0;
                mcif.gen_bus_if.ierror = '0;
                mcif.gen_bus_if.i_req_stall = '0;
                mcif.nRST = 1'b0;

                repeat (2) @(posedge mcif.CLK);
            end
            /*
                Multicore specific Driver Code
            */

            @(posedge busif.clk);    
            seq_item_port.item_done();
        end
    endtask
endclass

`endif