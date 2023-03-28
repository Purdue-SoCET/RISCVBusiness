`ifndef BUS_CHECKER
`define BUS_CHECKER

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "bus_transaction.svh"
`include "dut_params.svh"


class bus_checker extends uvm_scoreboard;
  `uvm_component_utils(bus_checker)

  uvm_analysis_export #(bus_transaction) l2_export;
  uvm_analysis_export #(bus_transaction) snp_rsp_export;
  uvm_analysis_export #(bus_transaction) l1_req_export;
  uvm_tlm_analysis_fifo #(bus_transaction) l2_fifo;
  uvm_tlm_analysis_fifo #(bus_transaction) snp_rsp_fifo;
  uvm_tlm_analysis_fifo #(bus_transaction) l1_req_fifo;

  virtual bus_ctrl_if vif;

  int m_matches, m_mismatches;  // records number of matches and mismatches
  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    l2_export = new("check_export", this);
    snp_rsp_export = new("snp_rsp_export", this);
    l1_req_export = new("l1_req_export", this);
    l2_fifo = new("l2_fifo", this);
    snp_rsp_fifo = new("snp_rsp_fifo", this);
    l1_req_fifo = new("l1_req_fifo", this);

    if (!uvm_config_db#(virtual bus_ctrl_if)::get(this, "", "bus_ctrl_vif", vif)) begin
      // if the interface was not correctly set, raise a fatal message
      `uvm_fatal("Driver", "No virtual interface specified for this test instance");
    end
  endfunction

  function void connect_phase(uvm_phase phase);
   l2_export.connect(l2_fifo.analysis_export); 
   l1_req_export.connect(l1_req_fifo.analysis_export); 
   snp_rsp_export.connect(snp_rsp_fifo.analysis_export); 
  endfunction

  task run_phase(uvm_phase phase);
    bus_transaction reqTx;
    bus_transaction l2Tx;
    bus_transaction snpRspTx;
    bit [dut_params::WORD_W-1:0] mask;
    int timeout = 0;

    bit snpRspPresent;
    bit l2TxPresent;
    bit errorFlag;
    m_matches = 0;
    m_mismatches = 0;

    forever begin
      // get the l1_req/rsp packet and fill this into the completed transaction array
      l1_req_fifo.get(reqTx); // This is a blocking transaction I think
      errorFlag = 0;
      timeout = 0;

      // get the snp_rsp_packet if there is one
      // Since the l1_rsp packet doesn't get sent until the transaction is complete
      // We know that there isn't a snoop if this is empty at this time here
      if(snp_rsp_fifo.is_empty()) begin
        snpRspPresent = 0;
      end else begin
        snpRspPresent = 1;
        snp_rsp_fifo.get(snpRspTx);
        //`uvm_info(this.get_name(), $sformatf("Received new snpRsp trans:\n%s", snpRspTx.sprint()), UVM_DEBUG);
      end
      

      if(snpRspTx.snoopRspType != 1) begin // If the snoop was dirty then the L2 happens after the L1 gets low dwait, we must wait for the L2 trans to happen before checking everything
       while(timeout < dut_params::BUS_CHECKER_TIMEOUT && l2_fifo.is_empty()) begin
        @(posedge vif.clk);
        #2;
        timeout = timeout + 1;
       end
      end

      // Now get the l2 response! 
      // done with similar logic to the above snoop response
      if(l2_fifo.is_empty()) begin
        l2TxPresent = 0;
      end else begin
        l2TxPresent = 1;
        l2_fifo.get(l2Tx);
      end


      //`uvm_info("Checker", $sformatf("L2 present flag is %0d\n", l2TxPresent), UVM_DEBUG);
      //`uvm_info("Checker", $sformatf("Snp present flag is %0d\n", snpRspPresent), UVM_DEBUG);



      if(snpRspPresent) begin
        mask = ~(31'd0 | {($clog2(4*dut_params::BLOCK_SIZE_WORDS)){1'b1}});
        if((reqTx.procReqAddr & mask) != snpRspTx.snoopReqAddr) begin
          uvm_report_error("Checker", "Processor request address and snoop request address don't match!");
          `uvm_info("Checker", $sformatf("L1 req addr unmasked: %0h L1 req addr masked: %0h Snp req addr unmasked: %0h\n", reqTx.procReqAddr, (reqTx.procReqAddr & mask), snpRspTx.snoopReqAddr), UVM_DEBUG);
        end

        case(reqTx.procReqType)
          0: begin
               if(snpRspTx.snoopReqInvalidate) begin
                 uvm_report_error("Checker", "Snoop request invalidate on read request!");
                 errorFlag = 1;
               end
             end
          1: begin
               if(~snpRspTx.snoopReqInvalidate) begin
                 uvm_report_error("Checker", "No snoop request invalidate on busRdX!");
                 errorFlag = 1;
               end
             end
          2: begin
               uvm_report_error("Checker", "Snoop request on a busWrite request!"); 
               errorFlag = 1;
             end
        endcase
      end else begin 
        case(reqTx.procReqType)
          0: begin
               uvm_report_error("Checker", "No snoop request on busRead!");
               errorFlag = 1;
             end
          1: begin
               uvm_report_error("Checker", "No snoop request on busReadX!");
               errorFlag = 1;
             end
        endcase
      end

      if(l2TxPresent && ~errorFlag) begin
        if((reqTx.procReqAddr & mask) != l2Tx.l2ReqAddr) begin
          uvm_report_error("Checker", "Processor request address and l2 request address don't match!");
          `uvm_info("Checker", $sformatf("L1 req addr unmasked: %0h L1 req addr masked: %0h L2 req addr unmasked: %0h\n", reqTx.procReqAddr, (reqTx.procReqAddr & mask), l2Tx.l2ReqAddr), UVM_DEBUG);
          errorFlag = 1;
        end

        if(snpRspPresent) begin
          case(snpRspTx.snoopRspType)
            0: begin
                 if(l2Tx.l2_rw) begin
                   uvm_report_error("Checker", "L2 write on a no hit snoop response");
                   errorFlag = 1;
                 end
               end
            1: begin
                 uvm_report_error("Checker", "L2 request on a snoop hit S/E!");
                 errorFlag = 1;
               end
            2: begin
                 if(!l2Tx.l2_rw) begin
                   uvm_report_error("Checker", "L2 read on a snoop hit M");
                   errorFlag = 1;
                 end

                 if(l2Tx.l2StoreData != snpRspTx.snoopRspData) begin
                   uvm_report_error("Checker", "L2 write data does not match the snoop response data");
                   errorFlag = 1;
                 end
               end
          endcase
        end else begin // if we don't see a snoop request we can assume this a processor write, this is checked above in the snoop section
          if(~l2Tx.l2_rw) begin
            uvm_report_error("Checker", "L2 read on a processor write request");
            errorFlag = 1;
          end
          
          if(l2Tx.l2StoreData != reqTx.procReq_dstore) begin
            uvm_report_error("Checker", "L2 store data doesn't match data being stored by L1 requester");
            errorFlag = 1;
          end
        end
      end else if(~errorFlag && (snpRspTx.snoopRspType != 1 || reqTx.procReqType == 2)) begin
        uvm_report_error("Checker", "No l2 TX seen on a l1 write/snoop response invalid/dirty!");
        errorFlag = 1;
      end else begin
        `uvm_info("Checker", "No l2 checks done because of bad snoop request", UVM_LOW);
      end

      // Lastly check up on the data given back to the processor
      if(errorFlag) begin
        `uvm_info("Checker", "No L1 bus_ctrl response checks done because of bad snoop and/or L2 Tx", UVM_LOW);
      end else if(snpRspPresent) begin // we only need to check stuff on a snoop b/c otherwise it was a processor write which has no data returned
        case(snpRspTx.snoopRspType)
            0: begin
                 if(l2Tx.l2RspData != reqTx.busCtrlRsp_dload) begin
                   uvm_report_error("Checker", "Snoop no hit, L2 response data doesn't match dload");
                   errorFlag = 1;
                 end
                 if(~reqTx.busCtrlRsp_exclusive) begin
                   uvm_report_error("Checker", "Snoop no hit, no exclusive state given by bus_ctrl to L1 requester");
                   errorFlag = 1;
                 end
               end
            1: begin
                 if(snpRspTx.snoopRspData != reqTx.busCtrlRsp_dload) begin
                   uvm_report_error("Checker", "Snoop hit S/E, snoop response data doesn't match dload");
                   errorFlag = 1;
                 end
                 if(reqTx.busCtrlRsp_exclusive) begin
                   uvm_report_error("Checker", "Snoop hit S/E, exclusive state (when shouldn't) given by bus_ctrl to L1 requester");
                   errorFlag = 1;
                 end
               end
            2: begin
                 if(snpRspTx.snoopRspData != reqTx.busCtrlRsp_dload) begin
                   uvm_report_error("Checker", "Snoop hit M, snoop response data doesn't match dload");
                   errorFlag = 1;
                 end
                 if(reqTx.busCtrlRsp_exclusive) begin
                   uvm_report_error("Checker", "Snoop hit M, exclusive state (when shouldn't) given by bus_ctrl to L1 requester");
                   errorFlag = 1;
                 end
              end
          endcase
      end

    if(errorFlag) begin 
      `uvm_info("Checker", "Error flag seen!\n", UVM_DEBUG);
      `uvm_info("Checker", $sformatf("L1 req trans is %s\n", reqTx.sprint()), UVM_DEBUG);
      `uvm_info("Checker", $sformatf("Snp trans is %s\n", snpRspTx.sprint()), UVM_DEBUG);
      `uvm_info("Checker", $sformatf("L2 trans is %s\n", l2Tx.sprint()), UVM_DEBUG);
      m_mismatches = m_mismatches + 1;
    end else m_matches = m_matches + 1;

    end // forever
  endtask

  function void report_phase(uvm_phase phase);
    uvm_report_info("Checker", $sformatf("Matches:    %0d", m_matches));
    uvm_report_info("Checker", $sformatf("Mismatches: %0d", m_mismatches));
  endfunction


endclass : bus_checker

`endif
