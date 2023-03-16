import uvm_pkg::*;
`include "uvm_macros.svh"
`include "bus_transaction.svh"
`include "dut_params.svh"
`include "sequence.svh"

/*
 * Almost everything is left randomized except for the idle signals.
  * dWEN is left randomized since we want to test both reads and writes randomly.
*/

class rw_0_idle_1_sequence extends basic_sequence #(bus_transaction);
  `uvm_object_utils(single_access_sequence)
  function new(string name = "");
    super.new(name);
  endfunction : new

  task body();
    bus_transaction req_item;
    req_item = bus_transaction::type_id::create("req_item");

    repeat (5) begin
      start_item(req_item);
      if (!req_item.randomize() with {
            req_item.numTransactions < 3;
            foreach (req_item.idle[0][i]) {
              req_item.idle[0][i] == 0;
            } 
            foreach (req_item.idle[1][i]) {
              req_item.idle[1][i] == '1;
            }
          }) begin
        // if the transaction is unable to be randomized, send a fatal message
        `uvm_fatal("sequence", "not able to randomize")
      end

      finish_item(req_item);
    end
  endtask : body
endclass  //single access sequence

class idle_0_rw_1_sequence extends basic_sequence #(bus_transaction);
  `uvm_object_utils(single_access_sequence)
  function new(string name = "");
    super.new(name);
  endfunction : new

  task body();
    bus_transaction req_item;
    req_item = bus_transaction::type_id::create("req_item");

    repeat (5) begin
      start_item(req_item);
      if (!req_item.randomize() with {
            req_item.numTransactions < 3;
            foreach (req_item.idle[0][i]) {
              req_item.idle[0][i] == '1;
            } 
            foreach (req_item.idle[1][i]) {
              req_item.idle[1][i] == 0;
            }
          }) begin
        // if the transaction is unable to be randomized, send a fatal message
        `uvm_fatal("sequence", "not able to randomize")
      end

      finish_item(req_item);
    end
  endtask : body
endclass  //single access sequence