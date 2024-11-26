// --- SoCET Multicore F24 - UVM Data Transaction --- //
`ifndef DATA_TRANSACTION_SVH
`define DATA_TRANSACTION_SVH

import uvm_pkg::*;

// --- Include --- //
`include "addr_space.sv"
`include "dut_parameters.sv"
`include "uvm_macros.svh"

import addr_space::*;

// --- Data Transaction --- //
class data_transaction extends uvm_sequence_item;

	// --------- Reset --------------- //
	logic nRST;

	// --------- DUT Inputs ---------- //
	rand logic                    dREN;
	rand logic                    dWEN;
	rand logic [A_WIDTH-1 : 0] daddr; 
	rand logic [D_WIDTH-1 : 0] dstore;

	// --------- DUT Outputs --------- //
	logic                         derror;
	logic                         dbusy; 
	logic      [D_WIDTH-1 : 0] dload;

	// --- Enable UVM Macros --- //
    `uvm_object_utils_begin(data_transaction)
        `uvm_field_int(nRST,		UVM_ALL_ON)
        `uvm_field_int(dREN,		UVM_ALL_ON)
        `uvm_field_int(dWEN,		UVM_ALL_ON)
        `uvm_field_int(daddr,		UVM_ALL_ON)
        `uvm_field_int(dstore,		UVM_ALL_ON)
        `uvm_field_int(derror,		UVM_ALL_ON)
        `uvm_field_int(dbusy,		UVM_ALL_ON)
        `uvm_field_int(dload,		UVM_ALL_ON)
    `uvm_object_utils_end

	// --- Constraints --- //
	// constraint enable_c {
	// }

	constraint daddr_range_c {
		daddr >= DATA_START_ADDR_SPACE;
		daddr <= DATA_END_ADDR_SPACE;
	}

    function new(string name = "data_transaction");
        super.new(name);
    endfunction

endclass : data_transaction

`endif