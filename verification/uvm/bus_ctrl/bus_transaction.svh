`ifndef TRANSACTION_SVH
`define TRANSACTION_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "dut_params.svh"
import dut_params::*;

class bus_transaction extends uvm_sequence_item;

  localparam TRANS_SIZE = dut_params::WORD_W * dut_params::BLOCK_SIZE_WORDS;

  rand bit [dut_params::NUM_CPUS_USED - 1:0][1023:0] idle;
  rand bit [dut_params::NUM_CPUS_USED - 1:0][1023:0][dut_params::WORD_W - 1:0] daddr;
  rand bit [dut_params::NUM_CPUS_USED - 1:0][1023:0] dWEN;
  rand bit [dut_params::NUM_CPUS_USED - 1:0][1023:0] readX;
  rand bit [dut_params::NUM_CPUS_USED - 1:0][1023:0][TRANS_SIZE - 1:0] dstore;
  rand bit [dut_params::NUM_CPUS_USED - 1:0][1023:0][TRANS_SIZE - 1:0] dload;
  rand bit [dut_params::NUM_CPUS_USED - 1:0][1023:0] exclusive;

  rand
  bit [dut_params::NUM_CPUS_USED - 1:0][dut_params::DRVR_SNOOP_ARRAY_SIZE-1:0][dut_params::WORD_W - 1:0]
  snoopHitAddr;  // if 1 at address index then hit
  rand
  bit [dut_params::NUM_CPUS_USED - 1:0][dut_params::DRVR_SNOOP_ARRAY_SIZE-1:0][dut_params::WORD_W - 1:0]
  snoopDirty;  // if 1 at address index thn dirty

  rand int numTransactions;

  // Bus monitor side stuff we need
  bit procReq; // indicates a proc req happened at the given index in time
  bit [dut_params::NUM_CPUS_USED-1:0] snoopReq; // indicated a snoop request happened at the given index in time
  bit [dut_params::NUM_CPUS_USED-1:0] snoopRsp; // indicated a snoop response happened at the given index in time
  bit [dut_params::NUM_CPUS_USED-1:0] busCtrlRsp; // indicates a bus control response to the processors at the given index in time
  bit l2Req; // indicates a l2 request by bus controller at the given index in time
  bit l2Rsp; // indicates a l2 rsp by the l2 at the given index in time
  bit l2_rw; // 1--> write request to l2; 0 --> read request to l2
  bit [dut_params::WORD_W - 1:0] procReqAddr;
  bit [TRANS_SIZE-1:0] procReq_dstore;
  bit [1:0] procReqType; // 0 --> read; 1 --> busReadX; 2 --> write
  bit [TRANS_SIZE - 1:0] busCtrlRsp_dload;
  bit busCtrlRsp_exclusive;
  bit [dut_params::WORD_W - 1:0] l2ReqAddr;
  bit [dut_params::NUM_CPUS_USED - 1:0][dut_params::WORD_W - 1:0] snoopReqAddr;
  bit [dut_params::NUM_CPUS_USED - 1:0] snoopReqInvalidate;
  bit [dut_params::NUM_CPUS_USED - 1:0][1:0] snoopRspType; // 0 -> no hit; 1 -> snoop hit S/E; 2 -> snoop hit M (dirty)
  bit [dut_params::NUM_CPUS_USED - 1:0][TRANS_SIZE-1:0] snoopRspData; // the data being provided by snooped cache
  bit [TRANS_SIZE-1:0] l2RspData; // the data being provided by the l2 on a read
  bit [TRANS_SIZE-1:0] l2StoreData; // the data being provided to the l2 on a write

  // Constraints on the data
  constraint numTransConstraint {numTransactions > 0;}
  constraint busReadX {  // can't have a bus write along with a readX
    foreach (dWEN[i]) (dWEN[i] && readX[i]) == 0;
  }


  //TODO: YOU MAY WANT TO RECONSIDER HOW MANY OF THESE FIELDS YOU INCLUDE FOR PRINTING
  // NOTE: EXAMPLE OF NOT PRINTING CERTAIN FIELDS BELOW
  // `uvm_field_int(haddr, UVM_NOCOMPARE | UVM_NOPRINT)

  `uvm_object_utils_begin(bus_transaction)
    `uvm_field_int(idle, UVM_DEFAULT)
    `uvm_field_int(daddr, UVM_DEFAULT)
    `uvm_field_int(dWEN, UVM_DEFAULT)
    `uvm_field_int(dstore, UVM_DEFAULT)
    `uvm_field_int(dload, UVM_DEFAULT)
    `uvm_field_int(exclusive, UVM_DEFAULT)
    `uvm_field_int(snoopHitAddr, UVM_DEFAULT)
    `uvm_field_int(snoopDirty, UVM_DEFAULT)
    `uvm_field_int(numTransactions, UVM_DEFAULT)
    `uvm_field_int(procReq, UVM_DEFAULT)
    `uvm_field_int(snoopReq, UVM_DEFAULT)
    `uvm_field_int(snoopRsp, UVM_DEFAULT)
    `uvm_field_int(busCtrlRsp, UVM_DEFAULT)
    `uvm_field_int(snoopReqAddr, UVM_DEFAULT)
    `uvm_field_int(snoopReqInvalidate, UVM_DEFAULT)
    `uvm_field_int(snoopRspType, UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name = "bus_transaction");
    super.new(name);
  endfunction : new

endclass : bus_transaction

`endif
