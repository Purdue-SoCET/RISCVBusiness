import uvm_pkg::*;
`include "uvm_macros.svh"

`include "bus_transaction.svh"
`include "dut_params.svh"

class basic_sequence extends uvm_sequence #(bus_transaction);
  `uvm_object_utils(basic_sequence)
  function new(string name = "");
    super.new(name);
  endfunction : new

  task body();
    bus_transaction req_item;
    int i;
    req_item = bus_transaction::type_id::create("req_item");

    i = 0;

    // Do simple read requests
    repeat (dut_params::NUM_TESTS) begin
        i = i + 1;
        `uvm_info(this.get_name(), $sformatf("\n\n********************************************************************\n Running series of transactions (test#): %0d out of %0d\n********************************************************************", i, dut_params::NUM_TESTS), UVM_LOW);

      start_item(req_item);
      if (!req_item.randomize() with {
            req_item.numTransactions == dut_params::NUM_TRANS_PER_TEST;

            // if we don't allow idle then set idle to zero for all
            // the funny bussiness below is because the user sets ALLOW_IDLE_TRANS to 1 or 0
            // We can't just set idle to that so basically when ALLOW_IDLE_TRANS is 1 we say idle can be anything less
            // or equal to its max value (We let it be anything) but if ALLPW_IDLE_TRANS is 0 we say it must be 
            // Less than or equal to zero meaning that it is zero
            req_item.idle <= ({$bits(req_item.idle){1'b1}} & {$bits(req_item.idle){dut_params::ALLOW_IDLE_TRANS[0]}});
          }) begin
        // if the transaction is unable to be randomized, send a fatal message
        `uvm_fatal("sequence", "not able to randomize")
      end

      finish_item(req_item);
    end
  endtask : body
endclass  //sequence


/*
class burst_sequence extends uvm_sequence #(ahb_bus_transaction_v2);
  `uvm_object_utils(burst_sequence)
  function new(string name = "");
    super.new(name);
  endfunction : new

  task body();
    ahb_bus_transaction_v2 req_item;
    req_item = ahb_bus_transaction_v2::type_id::create("req_item");

    repeat (10000) begin
      start_item(req_item);
      if (!req_item.randomize() with {
            req_item.hsize == 3'b010;
            foreach (req_item.haddr[i]) {
              req_item.haddr[i] < `AHB_NWORDS * 4;
              req_item.haddr[i][1:0] == 2'b00;
              req_item.burstSize < 3;  // burstSize of 3 is invalid so needs to be less than
            }
            req_item.errorAddrFlag == 0;
          }) begin
        // if the transaction is unable to be randomized, send a fatal message
        `uvm_fatal("sequence", "not able to randomize")
      end

      req_item.hsel = 1;

      finish_item(req_item);
    end
  endtask : body
endclass  //sequence

class outOfBounds_sequence extends uvm_sequence #(ahb_bus_transaction_v2);
  `uvm_object_utils(outOfBounds_sequence)
  function new(string name = "");
    super.new(name);
  endfunction : new

  task body();
    ahb_bus_transaction_v2 req_item;
    req_item = ahb_bus_transaction_v2::type_id::create("req_item");

    repeat (1000) begin
      start_item(req_item);
      if (!req_item.randomize() with {
            req_item.hsize == 3'b010;
            foreach (req_item.haddr[i]) {
              req_item.haddr[i] >= `AHB_NWORDS * 4;
              req_item.haddr[i][1:0] == 2'b00;
              req_item.burstSize < 3;  // burstSize of 3 is invalid so needs to be less than
            }
            req_item.errorAddrFlag == 0;
            req_item.waitAddrFlag == 0;
          }) begin
        // if the transaction is unable to be randomized, send a fatal message
        `uvm_fatal("sequence", "not able to randomize")
      end

      req_item.hsel = 1;

      finish_item(req_item);
    end
  endtask : body
endclass  //sequence

class unaligned_sequence extends uvm_sequence #(ahb_bus_transaction_v2);
  `uvm_object_utils(unaligned_sequence)
  function new(string name = "");
    super.new(name);
  endfunction : new

  task body();
    ahb_bus_transaction_v2 req_item;
    req_item = ahb_bus_transaction_v2::type_id::create("req_item");

    repeat (1000) begin
      start_item(req_item);
      if (!req_item.randomize() with {
            req_item.hsize == 3'b010;
            foreach (req_item.haddr[i]) {
              req_item.haddr[i] < `AHB_NWORDS * 4;
              req_item.haddr[i][1:0] != 2'b00;
              req_item.burstSize < 3;  // burstSize of 3 is invalid so needs to be less than
            }
            req_item.errorAddrFlag == 0;
          }) begin
        // if the transaction is unable to be randomized, send a fatal message
        `uvm_fatal("sequence", "not able to randomize")
      end

      req_item.hsel = 1;

      finish_item(req_item);
    end
  endtask : body
endclass  //sequence

class errorAddr_sequence extends uvm_sequence #(ahb_bus_transaction_v2);
  `uvm_object_utils(errorAddr_sequence)
  function new(string name = "");
    super.new(name);
  endfunction : new

  task body();
    ahb_bus_transaction_v2 req_item;
    req_item = ahb_bus_transaction_v2::type_id::create("req_item");

    repeat (1000) begin
      start_item(req_item);
      if (!req_item.randomize() with {
            req_item.hsize == 3'b010;
            req_item.errorAddrFlag == 1;
            req_item.haddr[0][1:0] == 2'b00;
            req_item.burstSize < 3;  // burstSize of 3 is invalid so needs to be less than
            req_item.burstType == 3;
            req_item.idle != 1;
          }) begin
        // if the transaction is unable to be randomized, send a fatal message
        `uvm_fatal("sequence", "not able to randomize")
      end

      req_item.hsel = 1;

      finish_item(req_item);
    end
  endtask : body
endclass  //sequence

class waitAddr_sequence extends uvm_sequence #(ahb_bus_transaction_v2);
  `uvm_object_utils(waitAddr_sequence)
  function new(string name = "");
    super.new(name);
  endfunction : new

  task body();
    ahb_bus_transaction_v2 req_item;
    req_item = ahb_bus_transaction_v2::type_id::create("req_item");

    repeat (1000) begin
      start_item(req_item);
      if (!req_item.randomize() with {
            req_item.hsize == 3'b010;
            req_item.waitAddrFlag == 1;
            req_item.errorAddrFlag == 0;
            req_item.haddr[0][1:0] == 2'b00;
            req_item.burstSize < 3;  // burstSize of 3 is invalid so needs to be less than
            req_item.burstType == 3;
            req_item.idle != 1;
          }) begin
        // if the transaction is unable to be randomized, send a fatal message
        `uvm_fatal("sequence", "not able to randomize")
      end

      req_item.hsel = 1;

      finish_item(req_item);
    end
  endtask : body
endclass  //sequence
*/
class sequencer extends uvm_sequencer #(bus_transaction);
  `uvm_component_utils(sequencer)

  function new(input string name = "sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new
endclass : sequencer

