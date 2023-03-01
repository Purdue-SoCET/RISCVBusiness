`ifndef BUS_CHECKER
`define BUS_CHECKER

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "bus_transaction.svh"
`include "dut_params.svh"


class bus_checker extends uvm_subscriber #(ahb_bus_transaction);
  `uvm_component_utils(bus_checker)

  uvm_analysis_export #(ahb_bus_transaction) l2_export;
  uvm_analysis_export #(ahb_bus_transaction) snp_rsp_export;
  uvm_analysis_export #(ahb_bus_transaction) l1_req_export;
  uvm_tlm_analysis_fifo #(ahb_bus_transaction) l2_fifo;
  uvm_tlm_analysis_fifo #(ahb_bus_transaction) snp_rsp_fifo;
  uvm_tlm_analysis_fifo #(ahb_bus_transaction) l1_req_fifo;

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
  endfunction

  function void connect_phase(uvm_phase phase);
   l2_export.connect(l2_fifo.analysis_export); 
   l1_req_export.connect(l1_rsp_fifo.analysis_export); 
   snp_rsp_export.connect(snp_rsp_fifo.analysis_export); 
  endfunction

  task run_phase(uvm_phase phase);
    bus_transaction reqTx;
    bus_transaction l2Tx;
    bus_transaction snpRspTx;

    bit snpRspPresent;
    bit l2TxPresent;
    m_matches = 0;
    m_mismatches = 0;
    bit errorFlag;

    forever begin
      // get the l1_req/rsp packet and fill this into the completed transaction array
      l1_rsp_fifo.get(reqTx); // This is a blocking transaction I think
      errorFlag = 0;

      // get the snp_rsp_packet if there is one
      // Since the l1_rsp packet doesn't get sent until the transaction is complete
      // We know that there isn't a snoop if this is empty at this time here
      if(snp_rsp_fifo.is_empty()) begin
        snpRspPresent = 0;
      end else begin
        snpRspPresent = 1;
        snp_rsp_fifo.get(snpRspTx);
      end

      // Now get the l2 response! 
      // done with similar logic to the above snoop response
      if(l2_fifo.is_empty()) begin
        l2TxPresent = 0;
      end
        l2TxPresent = 1;
        l2_fifo.get(l2Tx);
      end

      if(snpRspPresent) begin
        if(reqTx.procReqAddr != snpRspTx.snoopReqAddr) begin
          `uvm_report_error("Checker", "Processor request address and snoop request address don't match!");
        end

        case(reqTx.procReqType)
          0: begin
               if(snpRspTx.snoopReqInvalidate) begin
                 `uvm_report_error("Checker", "Snoop request invalidate on read request!");
                 errorFlag = 1;
               end
             end
          1: begin
               if(~snpRspTx.snoopReqInvalidate) begin
                 `uvm_report_error("Checker", "No snoop request invalidate on busRdX!");
                 errorFlag = 1;
               end
             end
          2: begin
               `uvm_report_error("Checker", "Snoop request on a busWrite request!"); 
               errorFlag = 1;
             end
        endcase
      end else begin 
        case(reqTx.procReqType)
          0: begin
               `uvm_report_error("Checker", "No snoop request on busRead!");
               errorFlag = 1;
             end
          1: begin
               `uvm_report_error("Checker", "No snoop request on busReadX!");
               errorFlag = 1;
             end
        endcase
      end

      if(l2TxPresent && ~errorFlag) begin
        if(reqTx.procReqAddr != l2Tx.l2ReqAddr) begin
          `uvm_report_error("Checker", "Processor request address and l2 request address don't match!");
        end

        if(snpRspPresent) begin
          case(snpRspTx.snoopRspType)
            0: begin
                 if(l2Tx.l2_rw) begin
                   `uvm_report_error("Checker", "L2 write on a no hit snoop response");
                   errorFlag = 1;
                 end
               end
            1: begin
                 `uvm_report_error("Checker", "L2 request on a snoop hit S/E!");
                 errorFlag = 1;
               end
            2: begin
                 if(!l2Tx.l2_rw) begin
                   `uvm_report_error("Checker", "L2 read on a snoop hit M");
                   errorFlag = 1;
                 end

                 if(l2Tx.l2StoreData != snpRspTx.snoopRspData) begin
                   `uvm_report_error("Checker", "L2 write data does not match the snoop response data");
                   errorFlag = 1;
                 end
          endcase
        end else begin // if we don't see a snoop request we can assume this a processor write, this is checked above in the snoop section
          if(~l2Tx.l2_rw) begin
            `uvm_report_error("Checker", "L2 read on a processor write request");
            errorFlag = 1;
          end
          
          if(l2Tx.l2StoreData != reqTx.procReq_dstore) begin
            `uvm_report_error("Checker", "L2 store data doesn't match data being stored by L1 requester");
            errorFlag = 1;
          end
        end
      end else if(~errorFlag) begin
        `uvm_report_error("Checker", "No l2 TX seen on a l1 req/rsp TX!");
        errorFlag = 1;
      end else begin
        `uvm_info("Checker", "No l2 checks done because of bad snoop request", UVM_LOW);
      end

      // Lastly check up on the data given back to the processor
      if(errorFlag) begin
        `uvm_info("Checker", "No L1 bus_ctrl response checks done because of bad snoop and/or L2 Tx");
      end else if(snpRspPresent) begin // we only need to check stuff on a snoop b/c otherwise it was a processor write which has no data returned
        case(snpRspTx.snoopRspType)
            0: begin
                 if(l2Tx.l2RspData != reqTx.busCtrlRsp_dload) begin
                   `uvm_report_error("Checker", "Snoop no hit, L2 response data doesn't match dload");
                   errorFlag = 1;
                 end
                 if(~reqTx.busCtrlRsp_exclusive) begin
                   `uvm_report_error("Checker", "Snoop no hit, no exclusive state given by bus_ctrl to L1 requester");
                   errorFlag = 1;
                 end
               end
            1: begin
                 if(snpRspTx.snoopRspData != reqTx.busCtrlRsp_dload) begin
                   `uvm_report_error("Checker", "Snoop hit S/E, snoop response data doesn't match dload");
                   errorFlag = 1;
                 end
                 if(reqTx.busCtrlRsp_exclusive) begin
                   `uvm_report_error("Checker", "Snoop hit S/E, exclusive state (when shouldn't) given by bus_ctrl to L1 requester");
                   errorFlag = 1;
                 end
               end
            2: begin
                 if(snpRspTx.snoopRspData != reqTx.busCtrlRsp_dload) begin
                   `uvm_report_error("Checker", "Snoop hit M, snoop response data doesn't match dload");
                   errorFlag = 1;
                 end
                 if(reqTx.busCtrlRsp_exclusive) begin
                   `uvm_report_error("Checker", "Snoop hit M, exclusive state (when shouldn't) given by bus_ctrl to L1 requester");
                   errorFlag = 1;
                 end
          endcase
      end

    end // forever
  endtask


endclass : bus_checker

`endif
