// --- SoCET Multicore F24 - UVM Data Transaction --- //
`ifndef DATA_TRANSACTION_SVH
`define DATA_TRANSACTION_SVH

// --- Include --- //
`include "addr_space.sv"

// --- Data Transaction --- //
class data_transaction extends uvm_sequnce_item:
	`uvm_object_utils(data_transaction)

	// --- Reset --- //
	logic nRST;

	// --- Stimulus --- //
	rand logic 						dREN;
	rand logic 						dWEN;
	rand logic [ADDR_WIDTH-1 : 0] 	daddr;
	// TODO: add rest

	// --- DUT Outputs --- //
	logic 							derror;
	logic 							d_req_stall;
	logic [ADDR_WIDTH-1 : 0] 		data;
	// TODO: add rest

	// --- Enable UVM Macros --- //
    `uvm_object_utils_begin(data_transaction)
        `uvm_field_int(nRST,          UVM_ALL_ON)
        `uvm_field_int(dREN,          UVM_ALL_ON)
        `uvm_field_int(dWEN,          UVM_ALL_ON)
        `uvm_field_int(daddr,         UVM_ALL_ON)
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