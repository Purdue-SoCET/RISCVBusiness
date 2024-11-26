`ifndef ENV_SVH
`define ENV_SVH

import uvm_pkg::*;
`include "instr_agent.svh"
`include "data_agent.svh"
`include "scoreboard.svh"

class env extends uvm_env;
    `uvm_component_utils(env)
    instr_agent instr_agent_inst;
    data_agent data_agent_inst;
    scoreboard scoreboard_inst;
    
    function new(string name = "env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        instr_agent_inst = instr_agent::type_id::create("instr_agent_inst", this);
        data_agent_inst = data_agent::type_id::create("data_agent_inst", this);
        scoreboard_inst = scoreboard::type_id::create("scoreboard_inst", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        instr_agent_inst.instr_agent_ap.connect(scoreboard_inst.imp_bus);     // Connects Analysis Ports between instruction agent and scoreboard
        data_agent_inst.data_agent_ap.connect(scoreboard_inst.imp_bus);       // Connects Analysis Ports between data acess agent and scoreboard
    endfunction
endclass

`endif