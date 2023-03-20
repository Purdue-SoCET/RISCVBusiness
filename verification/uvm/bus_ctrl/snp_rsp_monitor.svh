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
  int reqTimeoutCount;

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
    //super.run_phase(phase);
    bus_transaction tx;
    bus_transaction newTx;
    bit [dut_params::NUM_CPUS_USED-1:0] snoopReqPhaseDone = '0;
    bit [dut_params::NUM_CPUS_USED-1:0] snoopRspPhaseDone = '0;
    bit addrSet = 0;
    int reqL1 = -1; // this is the L1 that should be recieving the data at the end!
    int i;

    timeoutCount = 0;
    reqTimeoutCount = 0;
    // captures activity between the driver and DUT
    tx = bus_transaction::type_id::create("tx");
    newTx = bus_transaction::type_id::create("newTx");

    // zero out everything
    tx = zeroTrans(tx);


    forever begin
        @(posedge vif.clk);
        #2;
        // Check for new snoop requests
        if(|vif.ccwait && !(&snoopReqPhaseDone)) begin
           for(i = 0; i < dut_params::NUM_CPUS_USED; i++) begin
             if(vif.ccwait[i] == 0) begin // we aren't snooping into this one so it must be the requester
               snoopReqPhaseDone[i] = 1;
               if(|snoopRspPhaseDone) begin // if one of the snpRspPhaseDone is set then we have multiple that are not being snooped, this is fatal
                 `uvm_fatal("snp_rsp monitor", "Multiple L1s were not snooped on a snoop request!");
               end
               snoopRspPhaseDone[i] = 1; // flag requester as done in the done vector
             end else begin
                snoopReqPhaseDone[i] = 1;
                if(addrSet) begin // this menas we had someone else being snooped too
                  if(tx.snoopReq != vif.ccwait[i]) begin
                    `uvm_fatal("snp_rsp_monitor", "Different snp reqs on same trans for ccwait!\n");
                  end
                  if(tx.snoopReqAddr != vif.ccsnoopaddr[i]) begin
                    `uvm_fatal("snp_rsp_monitor", "Different snp reqs on same trans for snpAddr!\n");
                  end
                  if(tx.snoopReqInvalidate != vif.ccinv[i]) begin
                    `uvm_fatal("snp_rsp_monitor", "Different snp reqs on same trans for ccinv!\n");
                  end
                end else begin
                    tx.snoopReq = vif.ccwait[i];
                    tx.snoopReqAddr = vif.ccsnoopaddr[i];
                    tx.snoopReqInvalidate = vif.ccinv[i];
                    `uvm_info("snp_rsp_monitor", $sformatf("Req addr is %0h\n", tx.snoopReqAddr), UVM_DEBUG);
                end
             end
           end
        end
        
        if(|snoopReqPhaseDone && ~(&snoopReqPhaseDone)) begin
          reqTimeoutCount = reqTimeoutCount + 1;
          if(reqTimeoutCount == MONITOR_TIMEOUT) begin
            `uvm_fatal("snp_rsp Monitor", "Monitor timeout reached after first snoop request, bus_ctrl didn't make all required requests!");
          end
        end

       // Check to see if there are snoop responses without a snoop request, this would be bad if it happened
       foreach(vif.ccsnoopdone[i]) begin
         if(~snoopReqPhaseDone[i] && vif.ccsnoopdone[i]) begin
           `uvm_fatal("snp_rsp Monitor", $sformatf("Some snoop rsp for l1 #%0d without a snoop request!", i));
         end
       end

       // Check for new snoop responses 
       if((!(&snoopRspPhaseDone)) && |vif.ccsnoopdone)  begin // if we see a snoop done signal
         for(i = 0; i < dut_params::NUM_CPUS_USED; i++) begin
           if(vif.ccsnoopdone[i]) begin
             if(~vif.ccwait[i]) begin // shouldn't see a response if not ccwait high (if there is not a req)
                `uvm_fatal("snp_rsp Monitor", $sformatf("Snoop response on requester l1 #%0d, not allowed!\n", i));
             end
             tx.snoopRsp = 1;
             tx.snoopRspType = vif.ccsnoophit[i] ?
                                                   vif.ccdirty[i] ? 2 : 1
                                                  : 0;
             snoopRspPhaseDone[i] = 1;
           end
         end
       end

        if(&snoopReqPhaseDone) begin
          timeoutCount = timeoutCount + 1;
          if(timeoutCount == MONITOR_TIMEOUT) begin
            `uvm_fatal("snp_rsp Monitor", "Monitor timeout reached after a snoop request, no snoop response seen!");
          end
        end

        if(&snoopRspPhaseDone) begin
          timeoutCount = 0;
          reqTimeoutCount = 0;
          addrSet = 0;
          snoopRspPhaseDone = '0;
          snoopReqPhaseDone = 0;

          `uvm_info(this.get_name(), "New snp_rsp result sent to checker", UVM_LOW);

          //`uvm_info("snp_rsp_monitor", $sformatf("Req addr is %0h\n", tx.snoopReqAddr), UVM_DEBUG);
          check_ap.write(tx);

          // Wait for ccwait to go low for all
          // Note: This makes the assumption that ccwait will go low for all l1s before the next snoop request
          // This is okay since it will take at least 1 cycle for bus_ctrl to send response to l1s in fastest scenario
          // Meaning we should get at least 2 cycles of low ccwait in worst case fastest scenario
          while(|vif.ccwait) begin
            //`uvm_info("snp_rsp Monitor", "WAITED!\n", UVM_DEBUG);
            @(posedge vif.clk);
            timeoutCount = timeoutCount + 1;
            if(timeoutCount == 5) begin
              `uvm_fatal("snp_rsp Monitor", "Monitor timeout waiting for ccwait to go low after snoop trans complete!");
            end
        end
        timeoutCount = 0;
        newTx.copy(tx);
        tx = newTx;
        tx = zeroTrans(tx);
        end
    end
endtask : run_phase

endclass : snp_rsp_monitor

`endif
