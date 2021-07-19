import uvm_pkg::*;
`include "uvm_macros.svh"
`include "bus_transaction.svh"
`include "dut_params.svh"
`include "sequence.svh"

class dual_access_overlapping extends uvm_sequence #(bus_transaction);
  `uvm_object_utils(single_access_sequence)
  function new(string name = "");
    super.new(name);
  endfunction : new

  task body();
    bus_transaction req_item;
    req_item = bus_transaction::type_id::create("req_item");
    rand bit overlap;

    repeat (5) begin
      start_item(req_item);
      if (!req_item.randomize() with {
            req_item.numTransactions < 3;
            req_item.idle == 0;
            overlap dist {
            1 := 1,
            0 := 1
            };  //force a 50/50 distribution of overlapping and non-overlapping transactions
            foreach (req_item.daddr[0][i]) {
              if (overlap) begin
                req_item.daddr[0][i][dut_params::WORD_W - 1:3] == req_item.daddr[1][i][dut_params::WORD_W - 1:3]; // don't compare the lower 3 bits since addresses are truncated to the nearest word
              end else begin
                req_item.daddr[0][i][dut_params::WORD_W - 1:3] != req_item.daddr[1][i][dut_params::WORD_W - 1:3]; // don't compare the lower 3 bits since addresses are truncated to the nearest word
              end
            }
          }) begin
        // if the transaction is unable to be randomized, send a fatal message
        `uvm_fatal("sequence", "not able to randomize")
      end

      finish_item(req_item);
    end
  endtask : body
endclass  //dual access overlapping sequence