import uvm_pkg::*;
`include "uvm_macros.svh"

`include "transaction.svh"

typedef uvm_sequencer#(transaction) sequencer;

class cache_sequence extends uvm_sequence #(transaction);
  `uvm_object_utils(cache_sequence)
  function new(string name = "");
    super.new(name);
  endfunction: new

  task body();
    transaction req_item;
    req_item = transaction#(4)::type_id::create("req_item");
    
    // repeat twenty randomized test cases
    repeat(20) begin
      start_item(req_item);
      if(!req_item.randomize()) begin
        // if the transaction is unable to be randomized, send a fatal message
        `uvm_fatal("sequence", "not able to randomize")
      end
      finish_item(req_item);
    end
  endtask: body
endclass: cache_sequence
