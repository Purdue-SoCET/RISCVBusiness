`ifndef L2_MONITOR_SVH
`define L2_MONITOR_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "bus_ctrl_if.vh"
class l2_monitor extends uvm_monitor;
  `uvm_component_utils(l2_monitor)

  localparam TRANS_SIZE = dut_params::WORD_W * dut_params::BLOCK_SIZE_WORDS;

  virtual bus_ctrl_if vif;

  uvm_analysis_port #(bus_transaction) check_ap;
  int timeoutCount;

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
    check_ap = new("check_ap", this);
  endfunction : new

  // Build Phase - Get handle to virtual if from config_db
  virtual function void build_phase(uvm_phase phase);
    if (!uvm_config_db#(virtual bus_ctrl_if)::get(this, "", "bus_ctrl_vif", vif)) begin
      `uvm_fatal("monitor", "No virtual interface specified for this monitor instance")
    end
  endfunction

virtual function bus_transaction zeroTrans(bus_transaction tx);
  tx.procReq = '0;
  tx.snoopReq = '0;
  tx.snoopRsp = '0;
  tx.busCtrlRsp = '0;
  tx.l2Req = '0;
  tx.l2Rsp = '0;
  tx.l2_rw = '0;
  tx.procReqAddr = '0;
  tx.procReq_dstore = '0;
  tx.procReqType = '0;
  tx.busCtrlRsp_dload = '0;
  tx.busCtrlRsp_exclusive = '0;
  tx.l2ReqAddr = '0;
  tx.snoopReqAddr = '0;
  tx.snoopReqInvalidate = '0;
  tx.snoopRspType = '0;
  tx.snoopRspData = '0;
  tx.l2RspData = '0;
  tx.l2StoreData = '0;

  return tx;
endfunction


virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
        bus_transaction tx;
        bus_transaction newTx;
        bit l2ReqPhaseDone = 0;
        bit l2RspPhaseDone = 0;

        timeoutCount = 0;

        // captures activity between the driver and DUT
        tx = bus_transaction::type_id::create("tx");
        newTx = bus_transaction::type_id::create("newTx");

        // zero out everything
        tx = zeroTrans(tx);

        @(posedge vif.clk);
        // Now check up on the L2 request
        if((vif.l2WEN || vif.l2REN) && !l2ReqPhaseDone) begin
         if(vif.l2WEN && vif.l2REN) begin
           `uvm_fatal("Monitor", "L2 read and write request at the same time!");
         end

         tx.l2Req = 1; 
         tx.l2_rw = vif.l2WEN;
         tx.l2ReqAddr = vif.l2addr;
         tx.l2StoreData = vif.l2store;
         l2ReqPhaseDone = 1;
        end

        // Now check up on the L2 response
        if(vif.l2state == L2_ACCESS) begin
         if(~l2ReqPhaseDone) begin // if we didn't see an l2 request before l2 response --> bad!
           `uvm_fatal("Monitor", "L2 went into free state without an l2 request happening before, not allowed");
         end
         tx.l2Rsp = 1;
         tx.l2RspData = vif.l2load;
         l2RspPhaseDone = 1;
        end

        if(l2ReqPhaseDone) begin
          timeoutCount = timeoutCount + 1;
          if(timeoutCount == MONITOR_TIMEOUT) begin
            `uvm_fatal("Monitor", "Monitor timeout reached after a L2 request, no l2 response seen!");
          end
        end

        if(l2RspPhaseDone) begin
          timeoutCount = 0;
          l2RspPhaseDone = 0;
          l2ReqPhaseDone = 0;

          `uvm_info(this.get_name(), "New l2 result sent to checker", UVM_LOW);
          newTx.copy(tx);
          check_ap.write(tx);
           // Wait for l2 reqest to go low
          // Note: This makes the assumption that the req will go low for at least 1 cycle before the next one
          // This is okay since it will take at least 1 cycle for bus_ctrl to send response to l1s in fastest scenario
          // Meaning we should get > 1 cycle of low request
          while(vif.l2REN | vif.l2WEN) begin
            @(posedge vif.clk);
            timeoutCount = timeoutCount + 1;
            if(timeoutCount == 5) begin
              `uvm_fatal("l2_monitor Monitor", "Monitor timeout waiting for l2REN and l2WEN to go low after l2 trans complete!");
            end
        end
        timeoutCount = 0;
        end
    end
endtask : run_phase

endclass : l2_monitor

`endif
