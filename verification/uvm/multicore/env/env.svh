/*
  Project       : SoCET RISCVBusiness UVM
  UVM Component : Multicore Env
*/
`ifndef ENV_SVH
`define ENV_SVH

// --- Include --- //
`include "instr_agent.svh"
`include "data_agent.svh"
`include "scoreboard.svh"

// --- Import --- //
import uvm_pkg::*;

// --- Environment --- //
class env extends uvm_env;
    `uvm_component_utils(env)
    
    // --- Env Components --- //
    instr_agent instr_agent_inst;
    data_agent  data_agent_inst;
    scoreboard  scoreboard_inst;
    
    // --- Constructor --- //
    function new(string name = "env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // --- Build Phase --- //
    function void build_phase(uvm_phase phase);
        instr_agent_inst = instr_agent::type_id::create("instr_agent_inst", this);
        data_agent_inst  = data_agent::type_id::create("data_agent_inst", this);
        scoreboard_inst  = scoreboard::type_id::create("scoreboard_inst", this);
    endfunction

    // --- Connect Phase --- //
    function void connect_phase(uvm_phase phase);
        instr_agent_inst.instr_agent_ap.connect(scoreboard_inst.imp_instr_bus);     // Connects Analysis Ports between instruction agent and scoreboard
        data_agent_inst.data_agent_ap.connect(scoreboard_inst.imp_data_bus);       // Connects Analysis Ports between data acess agent and scoreboard
    endfunction
endclass

`endif