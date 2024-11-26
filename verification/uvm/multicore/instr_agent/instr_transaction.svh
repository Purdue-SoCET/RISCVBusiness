`ifndef INSTR_TRANSACTION_SVH
`define INSTR_TRANSACTION_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "addr_space.sv"
`include "dut_parameters.sv"

class instr_transaction extends uvm_sequence_item;

    // *********** DUT Inputs *********** (Just handled by instruction agent but arbitary decision)
    // Universal accross both agents
    bit nRST;
    logic [63:0] mtime;

    // *********** DUT Output *********** (Just handled by instruction agent but arbitary decision)
    bit halt;
    bit wfi;


    // *********** DUT Inputs ***********
    // CPU Inputs to Instruction Agents
    rand bit iREN;                                // Instruction read enable
    rand bit [A_WIDTH-1 : 0] iaddr;            // Instruction address

    // *********** DUT Outputs ***********
    // Instruction Agent Outputs to CPU
    bit ierror;                                   // Error signal
    bit i_req_stall;                              // Request stall signal
    bit [A_WIDTH-1 : 0] instruction;           // Instruction data

    `uvm_object_utils_begin(instr_transaction)
        `uvm_field_int(nRST,          UVM_ALL_ON)
        `uvm_field_int(mtime,          UVM_ALL_ON)
        `uvm_field_int(halt,          UVM_ALL_ON)
        `uvm_field_int(wfi,          UVM_ALL_ON)
        `uvm_field_int(iREN,          UVM_ALL_ON)
        `uvm_field_int(iaddr,         UVM_ALL_ON)
        `uvm_field_int(ierror,        UVM_ALL_ON)
        `uvm_field_int(i_req_stall,   UVM_ALL_ON)
        `uvm_field_int(instruction,   UVM_ALL_ON)
    `uvm_object_utils_end

    constraint iaddr_range {
        iaddr >= INSTR_START_ADDR_SPACE;
        iaddr <= INSTR_END_ADDR_SPACE;
    }

    function new(string name = "instr_transaction");
        super.new(name);
    endfunction

endclass
`endif 
