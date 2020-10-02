`include "uvm_macros.svh"
import uvm_pkg::*;

class ahb_seq extends uvm_sequence #(transaction);
  `uvm_object_utils(ahb_seq)
  function new(string name = "");
    super.new(name);
  endfunction: new

  task body();
    transaction req_item;
    req_item = transaction::type_id::create("req_item");
    
    start_item(req_item);
      if(!req_item.randomize()) begin
        // if the transaction is unable to be randomized, send a fatal message
        `uvm_fatal("ahb_seq", "not able to randomize")
      end
      req_item.trans = req_item.READ;
    finish_item(req_item);

    start_item(req_item);
      if(!req_item.randomize()) begin
        // if the transaction is unable to be randomized, send a fatal message
        `uvm_fatal("ahb_seq", "not able to randomize")
      end
      req_item.trans = req_item.WRITE;
    finish_item(req_item);

    start_item(req_item);
      if(!req_item.randomize()) begin
        // if the transaction is unable to be randomized, send a fatal message
        `uvm_fatal("ahb_seq", "not able to randomize")
      end
      req_item.trans = req_item.WRITE;
    finish_item(req_item);

    start_item(req_item);
      if(!req_item.randomize()) begin
        // if the transaction is unable to be randomized, send a fatal message
        `uvm_fatal("ahb_seq", "not able to randomize")
      end
      req_item.trans = req_item.IDLE;
    finish_item(req_item);

    start_item(req_item);
      if(!req_item.randomize()) begin
        // if the transaction is unable to be randomized, send a fatal message
        `uvm_fatal("ahb_seq", "not able to randomize")
      end
      req_item.trans = req_item.WRITE;
    finish_item(req_item);

    start_item(req_item);
      if(!req_item.randomize()) begin
        // if the transaction is unable to be randomized, send a fatal message
        `uvm_fatal("ahb_seq", "not able to randomize")
      end
      req_item.trans = req_item.READ;
    finish_item(req_item);

    start_item(req_item);
      if(!req_item.randomize()) begin
        // if the transaction is unable to be randomized, send a fatal message
        `uvm_fatal("ahb_seq", "not able to randomize")
      end
      req_item.trans = req_item.READ;
    finish_item(req_item);

    start_item(req_item);
      if(!req_item.randomize()) begin
        // if the transaction is unable to be randomized, send a fatal message
        `uvm_fatal("ahb_seq", "not able to randomize")
      end
      req_item.trans = req_item.IDLE;
    finish_item(req_item);

    repeat(30) begin
      start_item(req_item);
      if(!req_item.randomize()) begin
        // if the transaction is unable to be randomized, send a fatal message
        `uvm_fatal("ahb_seq", "not able to randomize")
      end
      finish_item(req_item);
    end
  endtask: body
endclass //ahb_seq
