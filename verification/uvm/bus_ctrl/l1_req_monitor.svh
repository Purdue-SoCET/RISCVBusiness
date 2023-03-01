`ifndef L1_REQ_MONITOR_SVH
`define L1_REQ_MONITOR_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "bus_ctrl_if.vh"
class l1_req_monitor extends uvm_monitor;
  `uvm_component_utils(l1_req_monitor)

  localparam TRANS_SIZE = dut_params::WORD_W * dut_params::BLOCK_SIZE_WORDS;

  virtual bus_ctrl_if vif;

  uvm_analysis_port #(bus_transaction) check_ap;
  int timeoutCount [dut_params::NUM_CPUS_USED-1:0];

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
  tx.idle = '0;
  tx.daddr = '0;
  tx.dWEN = '0;
  tx.readX = '0;
  tx.dstore = '0;
  tx.dload = '0;
  tx.exclusive = '0;
  tx.snoopHitAddr = '0;
  tx.snoopDirty = '0;
  tx.numTransactions = 0;

  tx.procReq = '0;
  tx.snoopReq = '0;
  tx.snoopRsp = '0;
  tx.busCtrlRsp = '0;
  tx.l2Req = '0;
  tx.l2Rsp = '0;
  tx.l2_rw = '0;
  tx.procReqAddr = '0;
  tx.l2ReqAddr = '0;
  tx.snoopReqAddr = '0;
  tx.snoopReqInvalidate = '0;
  tx.snoopRspType = '0;
  tx.procReqData = '0;
  tx.snoopRspData = '0;
  tx.l2RspData = '0;
  tx.l2StoreData = '0;
  tx.busCtrlRspData = '0;

  return tx;
endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      bus_transaction tx_array [dut_params::NUM_CPUS_USED-1:0];
      `zero_unpckd_array(timeoutCount);
      bit [dut_params::NUM_CPUS_USED-1:0] reqStarted = '0;
      bit transComplete = 0;
      bit busCtrlRspDone[dut_params::NUM_CPUS_USED-1:0] = 0;

      // captures activity between the driver and DUT
      for(int i = 0; i < dut_params::NUM_CPUS_USED; i++) begin
        tx_array[i] = bus_transaction::type_id::create("tx");
        tx_array[i] = zeroTrans(tx_array[i]);
      end

      @(posedge vif.clk);
        // Check for new L1 requests
        // Throw error if we have write & read or write & ccwrite OR if a new request starts before the old one ends
        if(|vif.dREN || |vif.dWEN) begin
           for(int i = 0; i < dut_params::NUM_CPUS_USED; i++) begin
             if((vif.dREN[i] && vif.dWEN[i]) || (vif.dWEN[i] && vif.ccwrite[i])) begin
                `uvm_fatal("Monitor", $sformatf("Invalid combination of CPUS requests %d", i));
             end else if(reqStarted[i]) begin // if we get a new request when there is already an outstanding request!
                `uvm_fatal("Monitor", $sformatf("req not complete before new request! proc %d", i));
             end else begin // if we have a valid request and we don't current have one for this CPU
                tx_array[i].procReq= 1;
                tx_array[i].procReq_daddr = vif.daddr[i];
                tx_array[i].procReqType = vif.dWEN[i] ? 2 
                                                        : vif.ccwrite[i] ? 1 : 0;
                reqStarted[i] = 1;
            end
           end
        end

       // Now we check for the bus_ctrl response to the l1!
       if(~(&vif.dwait) && |reqStarted) begin
         for(int i = 0; i < dut_params::NUM_CPUS_USED; i++) begin
           if(!vif.dwait[i]) begin
             if(!reqStarted[i]) begin // if we get a low dwait without first seeing a request
               `uvm_fatal("l1_req Monitor", "Low dwait without a request being started");
             end else begin
               tx_array[i].busCtrlRsp = 1;
               tx_array[i].busCtrlRsp_dload = vif.dload[i];
               tx_array[i].busCtrlRsp_exclusive = vif.ccexclusive[i];
               busCtrlRspDone[i] = 1;
             end
           end
         end
       end

       // Go through all of the l1s to see if any requests are done and if they are send them to the checker
       // Also update the timeout of all of the outstanding requests
       for(int i = 0; i < dut_params::NUM_CPUS_USED; i++) begin
         if(busCtrlRspDone[i]) begin
           `uvm_info(this.get_name(), $sformatf("New result sent to checker for l1 #%d", i), UVM_LOW);
           check_ap.write(tx_array[i]);
           busCtrlRspDone[i] = 0;
           reqStarted[i] = 0;
           timeoutCount[i] = 0;
         end
         // Keep track of timeouts for each processer
         if(reqStarted[i]) begin
           timeoutCount[i] = timeoutCount[i] + 1;
           if(timeoutCount[i] == MONITOR_TIMEOUT) begin
             `uvm_fatal("L1 req Monitor", $sformatf("Timeout reached for l1 req #%d", i));
           end
         end
       end
       
    end
  endtask : run_phase

endclass : l1_req_monitor

`endif
