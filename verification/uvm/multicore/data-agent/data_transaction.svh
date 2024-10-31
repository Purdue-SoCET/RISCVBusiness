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

	// --- DUT Inputs --- //
	rand logic 						dREN;      // -> gen_bus.ren
	rand logic 						dWEN;      // -> gen_bus.wen
	rand logic [ADDR_WIDTH-1 : 0] 	daddr;     // -> gen_bus.addr
	rand logic [DATA_WIDTH-1 : 0] 	dstore;    // -> gen_bus.wdata

	// --- DUT Outputs --- //
	logic 							derror;    // -> gen_bus.error
	logic 							dbusy;     // -> gen_bus.busy
	logic      [DATA_WIDTH-1 : 0]   dload;	   // -> geb_bus.rdata

	// --- Enable UVM Macros --- //
    `uvm_object_utils_begin(data_transaction)
        `uvm_field_int(nRST,          UVM_ALL_ON)
        `uvm_field_int(dREN,          UVM_ALL_ON)
        `uvm_field_int(dWEN,          UVM_ALL_ON)
        `uvm_field_int(daddr,         UVM_ALL_ON)
        `uvm_field_int(dstore,         UVM_ALL_ON)
        `uvm_field_int(derror,         UVM_ALL_ON)
        `uvm_field_int(dbusy,         UVM_ALL_ON)
        `uvm_field_int(dload,         UVM_ALL_ON)
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