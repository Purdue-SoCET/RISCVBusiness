`ifndef ENV_CONFIG
`define ENV_CONFIG

import uvm_pkg::*; 
`include "uvm_macros.svh"

class env_config extends uvm_object;
    `uvm_object_utils(env_config)
    rand bit [15:0] addr_prefix;

    function new (string name="env_config");
        super.new(name);
    endfunction
endclass

`endif
