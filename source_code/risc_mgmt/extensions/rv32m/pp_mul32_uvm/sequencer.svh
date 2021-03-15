  
import uvm_pkg::*;
`include "uvm_macros.svh"

`include "transaction.svh"

typedef uvm_sequencer #(transaction) sequencer;



class mult_sequence extends uvm_sequence #(transaction);
    `uvm_object_utils(counter_sequence)
    function new(string name = "");
      super.new(name);
    endfunction: new

    task body();
        forever
        begin
          transaction tx;
          tx = transaction::type_id::create("tx");
          start_item(tx);
          assert(tx.randomize());
          finish_item(tx);
        end
    endtask:body
endclass:counter_sequence


class sequencer extends uvm_sequence #(transaction);
    `uvm_object_utils(mult_sequence)
    function new(string name = "sequencer", uvm_component parent=null);
      super.new(name);
    endfunction: new
endclass: mult_sequencer
