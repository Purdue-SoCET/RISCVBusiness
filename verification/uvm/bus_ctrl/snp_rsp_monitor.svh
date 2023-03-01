`ifndef SNP_RSP_MONITOR_SVH
`define SNP_RSP_MONITOR_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "bus_ctrl_if.vh"
class snp_rsp_monitor extends uvm_monitor;
  `uvm_component_utils(snp_rsp_monitor)

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
        bus_transaction tx;
        timeoutCount = 0;
        bit snoopReqPhaseDone = 0;
        bit [dut_params::NUM_CPUS_USED-1:0] snoopRspPhaseDone = 0;
        int reqL1 = -1; // this is the L1 that should be recieving the data at the end!


        // captures activity between the driver and DUT
        tx = bus_transaction::type_id::create("tx");

        // zero out everything
        tx = zeroTrans(tx);

        @(posedge vif.clk);
        // Check for new snoop requests
        if(|vif.ccwait && !(&snoopReqPhaseDone)) begin
           for(int i = 0; i < dut_params::NUM_CPUS_USED; i++) begin
             tx.snoopReq[i] = vif.ccwait[i];
             tx.snoopReqAddr[i] = vif.ccsnoopaddr[i];
             tx.snoopReqInvalidate[i] = vif.ccinv[i];
             if(vif.ccwait[i] == 0) begin // we aren't snooping into this one so it must be the requester
               if(|snoopRspPhaseDone) begin // if one of the snpRspPhaseDone is set then we have multiple that are not being snooped, this is fatal
                 `uvm_fatal("snp_rsp monitor", "Multiple L1s were not snooped on a snoop request!");
               end
               snoopRspPhaseDone[i] = 1;
             end
           end
           snoopReqPhaseDone = 1;
        end

       // Check to see if there are snoop responses without a snoop request, this would be bad if it happened
       if(|vif.snoopDone && ~snoopReqPhaseDone) begin // if we haven't had a snoop req yet
         `uvm_fatal("snp_rsp Monitor", "Some snoop rsp without a snoop request!");
       end

       // Check for new snoop responses 
       if((!(&snoopRspPhaseDone)) && |vif.snoopdone)  begin // if we see a snoop done signal
         for(int i = 0; i < dut_params::NUM_CPUS_USED; i++) begin
           if(vif.ccnoopdone[i]) begin
             tx.snoopRsp[i] = 1;
             tx.snoopRspType = vif.ccsnoophit[i] ?
                                                   vif.ccdirty[i] ? 2 : 1
                                                  : 0;
             snoopRspPhaseDone[i] = 1;
           end
         end
       end

        if(snoopReqPhaseDone) begin
          timeoutCount = timeoutCount + 1;
          if(timeoutCount == MONITOR_TIMEOUT) begin
            `uvm_fatal("snp_rsp Monitor", "Monitor timeout reached after a snoop request, no snoop response seen!");
          end
        end

        if(&snoopRspPhaseDone) begin
          timeoutCount = 0;
          snoopRspPhaseDone = '0;
          snoopReqPhaseDone = 0;

          `uvm_info(this.get_name(), "New snp_rsp result sent to checker", UVM_LOW);
          check_ap.write(tx);
        end
    end
endtask : run_phase

endclass : snp_rsp_monitor
