`include "uvm_macros.svh"
import uvm_pkg::*;
`include "bus_tx.svh"

//simulated cpu which uses DUT (ahb master) to communicate with the simulated slave
class sim_cpu extends uvm_driver#(transaction);
  `uvm_component_utils(sim_cpu)

  virtual generic_bus_if bus_if;

  uvm_analysis_port #(transaction) cpu_ap; //writes addr phase transaction to predictor
  uvm_analysis_port #(transaction) response_ap; //writes data phase READ transaction to comparator

  function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cpu_ap = new("cpu_ap", this);
    response_ap = new("response_ap", this);

    // get interface from database
    if( !uvm_config_db#(virtual generic_bus_if)::get(this, "", "bus_vif", bus_if) ) begin
      // if the interface was not correctly set, raise a fatal message
      `uvm_fatal("simulated cpu", "No virtual interface specified for this test instance");
		end
    
  endfunction: build_phase

  task run_phase(uvm_phase phase);
    transaction req_item;
    transaction prev; //previous addr phase transaction
    transaction response; //data phase response
    bit busy_wait = 0; //whether there is or not a wait within addr phase of this transaction
    
    prev = transaction::type_id::create("prev");
    response = transaction::type_id::create("response");

    forever begin
      seq_item_port.get_next_item(req_item);
      
      //if there was an wait in previous loop
      //then remove an extra wait and clear busy_wait
      if(!busy_wait)
        @(posedge bus_if.clk); 
      else
        busy_wait = 0;

      //at the start of the simulation, do not sending void transaction
      if(prev.addr !== 'x) 
        cpu_ap.write(prev);

      //addr phase
      if(req_item.trans == req_item.IDLE) begin
        bus_if.ren = 0;
        bus_if.wen = 0;
        // bus_if.addr = req_item.addr;
        // bus_if.wdata = req_item.wdata;
        // bus_if.byte_en = req_item.byte_en;
      end
      else if(req_item.trans == req_item.READ) begin
        bus_if.ren = 1;
        bus_if.wen = 0;
        bus_if.addr = req_item.addr;
        // bus_if.wdata = req_item.wdata;
        bus_if.byte_en = req_item.byte_en;
      end
      else if(req_item.trans == req_item.WRITE) begin
        bus_if.ren = 0;
        bus_if.wen = 1;
        bus_if.addr = req_item.addr;
        // bus_if.wdata = req_item.wdata;
        bus_if.byte_en = req_item.byte_en;
      end
      
      //data phase
      if(prev.trans == prev.WRITE) begin
        bus_if.wdata = prev.wdata;
      end

      #1;
      if(!bus_if.busy) begin
        if(prev.trans == req_item.READ) begin
          response.copy(prev);
          response.wdata = bus_if.rdata;
          response_ap.write(response);
        end
      end


      //if busy is asserted by the slave, wait until busy is cleared
      while (bus_if.busy) begin
        @(posedge bus_if.clk); 
        busy_wait = 1;
        if(prev.trans == req_item.READ) begin
          #1;
          if(!bus_if.busy) begin
            // $info("CPU DEBUG rear busy reading point"); //DEBUG
            response.copy(prev);
            response.wdata = bus_if.rdata;
            response_ap.write(response);
            @(posedge bus_if.clk); 
          end
        end
      end
      prev.copy(req_item);
      seq_item_port.item_done();
    end
  endtask

endclass //sim_cpu

