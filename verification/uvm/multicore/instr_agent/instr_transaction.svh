/*
  Project       : SoCET RISCVBusiness UVM
  UVM Component : Instruction Transaction
*/
`ifndef INSTR_TRANSACTION_SVH
`define INSTR_TRANSACTION_SVH

// --- Include --- //
`include "uvm_macros.svh"
`include "addr_space.sv"
`include "dut_parameters.sv"

// --- Import ---/
import addr_space::*;
import dut_parameters::*;
import uvm_pkg::*;

class instr_transaction extends uvm_sequence_item;
    // *********** DUT Inputs *********** (Just handled by instruction agent but arbitary decision)
    // Universal accross both agents
    randc logic nRST;
    randc logic [63:0] mtime;

    // *********** DUT Output *********** (Just handled by instruction agent but arbitary decision)
    logic halt;
    logic wfi;


    // *********** DUT Inputs ***********
    // CPU Inputs to Instruction Agents
    rand logic                 iREN;            // Instruction read enable
    rand logic [A_WIDTH-1 : 0] iaddr;           // Instruction address

    // *********** DUT Outputs ***********
    // Instruction Agent Outputs to CPU
    logic               ierror;                 // Error signal
    logic               i_req_stall;            // Request stall signal
    logic [A_WIDTH-1 : 0] instruction;          // Instruction data

    `uvm_object_utils_begin(instr_transaction)
        `uvm_field_int(nRST,       UVM_ALL_ON)
        `uvm_field_int(mtime,      UVM_ALL_ON)
        `uvm_field_int(halt,       UVM_ALL_ON)
        `uvm_field_int(wfi,        UVM_ALL_ON)
        `uvm_field_int(iREN,       UVM_ALL_ON)
        `uvm_field_int(iaddr,      UVM_ALL_ON)
        `uvm_field_int(ierror,     UVM_ALL_ON)
        `uvm_field_int(i_req_stall,UVM_ALL_ON)
        `uvm_field_int(instruction,UVM_ALL_ON)
    `uvm_object_utils_end

    // *********** Addr Space ***********
    constraint iaddr_range {
        iaddr >= INSTR_START_ADDR_SPACE;
        iaddr <= INSTR_END_ADDR_SPACE;
    }

    function new(string name = "instr_transaction");
        super.new(name);
    endfunction

endclass

`endif 
