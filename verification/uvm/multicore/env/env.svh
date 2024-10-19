`ifndef ENV_SVH
`define ENV_SVH

import uvm_pkg::*;
`include "instr_agent.svh"
`include "data_agent.svh"
`include "scoreboard.svh"
`include "core_transaction.svh"

class env extends uvm_env;
    `uvm_component_utils(env)
    instr_agent instr_agent;
    data_agent data_agent;
    scoreboard score;
    
    function new(string name = "env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        instr_agent = data_agent::type_id::create("instr_agent", this);
        data_agent = data_agent::type_id::create("data_agent", this);
        score = scoreboard::type_id::create("score", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        instr_agent.instr_agent_ap.connect(score.imp_plic);     // Connects Analysis Ports between instruction agent and scoreboard
        data_agent.data_agent_ap.connect(score.imp_plic);       // Connects Analysis Ports between data acess agent and scoreboard
    endfunction
endclass

`endif