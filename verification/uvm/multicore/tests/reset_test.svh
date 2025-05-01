/*
  Project       : SoCET RISCVBusiness UVM
  UVM Component : UVM Test
*/
`ifndef RESET_TEST_SVH
`define RESET_TEST_SVH

// --- Include --- //
`include "uvm_macros.svh"
`include "instr_agent.svh"
`include "data_agent.svh"
`include "env.svh"
`include "instr_reset_seq.svh"
`include "data_reset_seq.svh"
`include "dut_parameters.sv"
`include "multicore_if.vh"

// --- Import --- //
import dut_parameters::*;
import uvm_pkg::*;

// --- Reset Test --- //
class reset_test extends uvm_test;
    `uvm_component_utils(reset_test)
    
    // Test Components
    env e; 
    instr_reset_sequence instr_reset_seq; 
    data_reset_sequence  data_reset_seq; 
    instr_garbage_sequence instr_garbage_seq;
    data_garbage_sequence data_garbage_seq;

    virtual multicore_if #(RST_PC, HARTS, D_WIDTH, A_WIDTH) mcif; 

    // Constructor
    function new(string name = "reset_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // Build Phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // Env
        e = env::type_id::create("e", this);
        // VIF Handle
        if (!uvm_config_db#(virtual multicore_if #(RST_PC, HARTS, D_WIDTH, A_WIDTH))::get(this, "", "mcif", mcif)) begin
            `uvm_fatal("RESET_TEST", "No virtual interface specified for multicore_if instance")
        end 
        // Set VIF
        uvm_config_db#(virtual multicore_if #(RST_PC, HARTS, D_WIDTH, A_WIDTH))::set(this, "*", "mcif", mcif);
    endfunction

    // Run phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("TEST_CLASS", "Run Phase - Reset Test", UVM_LOW)
        phase.raise_objection(this, "Starting reset sequence");

        // FORK?
        repeat (6) begin
            data_garbage_seq  = data_garbage_sequence::type_id::create("data_garbage_seq");
            instr_garbage_seq = instr_garbage_sequence::type_id::create("instr_garbage_seq");
            fork
                data_garbage_seq.start(e.data_agent_inst.data_sqr);
                instr_garbage_seq.start(e.instr_agent_inst.instr_sqr);
            join 
        end

        instr_reset_seq = instr_reset_sequence::type_id::create("instr_reset_seq", this);
        data_reset_seq  = data_reset_sequence::type_id::create("data_reset_seq", this);
        
        fork    
            data_reset_seq.start(e.data_agent_inst.data_sqr);
            instr_reset_seq.start(e.instr_agent_inst.instr_sqr);
        join

        repeat (6) begin
            data_garbage_seq  = data_garbage_sequence::type_id::create("data_garbage_seq");
            instr_garbage_seq = instr_garbage_sequence::type_id::create("instr_garbage_seq");
            fork
                data_garbage_seq.start(e.data_agent_inst.data_sqr);
                instr_garbage_seq.start(e.instr_agent_inst.instr_sqr);
            join 
        end

        phase.drop_objection(this, "Finished reset sequence");
    endtask
endclass
`endif
