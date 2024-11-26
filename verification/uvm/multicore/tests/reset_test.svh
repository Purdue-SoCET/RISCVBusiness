`ifndef RESET_TEST_SVH
`define RESET_TEST_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "instr_agent.svh"
`include "data_agent.svh"
`include "env.svh"
`include "reset_seq.svh"
`include "dut_parameters.sv"
`include "multicore_if.vh"

class reset_test extends uvm_test;
    `uvm_component_utils(reset_test)
    
    env e; 
    reset_seq multicore_rst_seq; 

    virtual multicore_if #(RST_PC, HARTS, D_WIDTH, A_WIDTH) mcif; 

    function new(string name = "reset_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        e = env::type_id::create("e", this);

        // Retrieve the virtual interface from the configuration database
        if (!uvm_config_db#(virtual multicore_if #(RST_PC, HARTS, D_WIDTH, A_WIDTH))::get(this, "", "mcif", mcif)) begin
            `uvm_fatal("RESET_TEST", "No virtual interface specified for multicore_if instance")
        end 

        // Set the virtual interface in the configuration database
        uvm_config_db#(virtual multicore_if #(RST_PC, HARTS, D_WIDTH, A_WIDTH))::set(this, "*", "mcif", mcif);

        // Create the reset sequence
        multicore_rst_seq = reset_seq::type_id::create("multicore_rst_seq", this);
    endfunction

    // Run phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        phase.raise_objection(this, "Starting reset sequence");
        $display("%t Starting reset sequence run_phase", $time);

        // Start the reset sequence
        fork 
            multicore_rst_seq.start(e.instr_agent.instr_sqr);        
        join
        #100ns;
        phase.drop_objection(this, "Finished reset sequence");
    endtask
endclass

`endif
