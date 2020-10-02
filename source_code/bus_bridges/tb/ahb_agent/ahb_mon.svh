`include "uvm_macros.svh"
import uvm_pkg::*;
`include "bus_tx.svh"
`include "sim_mem.svh"


// simulated slave interface
class sim_slave extends uvm_monitor;
  `uvm_component_utils(sim_slave)
  sim_mem slave_mem;
  sim_mem input_mem; //simulated memory from ahb_env
  logic rand_ready; //randomized wait between transactions
  virtual ahb_if ahbif;
  transaction prev_tx; //transaction in the previous clk cycle
  logic [2:0] prev_HSIZE; //HSIZE in the previous clk cycle

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction: new

  //randomly generate a slave busy of random length
  task random_wait();
    rand_ready = $urandom();
    while(rand_ready) begin
      ahbif.HREADY = 0;
      @(posedge ahbif.HCLK);
      rand_ready = $urandom();
    end
    ahbif.HREADY = 1;
  endtask

  virtual function void build_phase(uvm_phase phase);
    slave_mem = sim_mem::type_id::create("slave_mem");
    prev_tx = transaction::type_id::create("prev_tx");
    
    // get interface
    if (!uvm_config_db#(virtual ahb_if)::get(this, "", "ahb_vif", ahbif)) begin
      `uvm_fatal("sim_slave", "No virtual interface specified for this monitor instance")
    end

    // get sim_mem from ahb_slave
    if (!uvm_config_db#(sim_mem)::get(this, "", "slave_mem", input_mem)) begin
      `uvm_fatal("sim_slave", "No input mem")
    end
    //copy so that they will have the same initial value
    slave_mem.copy(input_mem);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    ahbif.HREADY = 1;

    //TODO:missing HRESP
    forever begin
      @(posedge ahbif.HCLK);
      // $info("SLAVE DEBUG prev trans: %h  addr: %h", prev_tx.trans, prev_tx.addr);

      //data phase: responses from the slave
      if(prev_tx.trans == '0) begin //if previous transaction is IDLE, do nothing
        ;
      end else if(prev_tx.trans == prev_tx.WRITE) begin //if previous transaction is WRITE, write HWDATA to mem
        random_wait();
        #2; // wait two nano seconds before sample HWDATA
        // $info("SLAVE DEBUG write addr: %h    value: %h",prev_tx.addr, ahbif.HWDATA);
        case(prev_HSIZE) 
          3'b000: slave_mem.write_byte(prev_tx.addr, ahbif.HWDATA); //byte
          3'b001: slave_mem.write_half(prev_tx.addr, ahbif.HWDATA); //half word
          3'b010: slave_mem.write_word(prev_tx.addr, ahbif.HWDATA); //word
        endcase
      end else begin //if previous transaction is READ, put the data onto HRDATA
        random_wait();
        case(prev_HSIZE) 
          3'b000: ahbif.HRDATA = slave_mem.read_byte(prev_tx.addr); //byte
          3'b001: ahbif.HRDATA = slave_mem.read_half(prev_tx.addr); //half word
          3'b010: ahbif.HRDATA = slave_mem.read_word(prev_tx.addr); //word
        endcase
        // $info("SLAVE DEBUG read addr: %h    value: %h   size: %h",prev_tx.addr, ahbif.HRDATA, prev_HSIZE);
        slave_mem.print_all();
      end

      //addr phase: samples transaction details
      #2;
      if (ahbif.HTRANS == '0) begin
        prev_tx.trans = prev_tx.IDLE;
      end
      else if (ahbif.HWRITE) begin
        prev_tx.trans = prev_tx.WRITE;
      end
      else begin
        prev_tx.trans = prev_tx.READ;
      end
      prev_tx.addr = ahbif.HADDR;
      prev_tx.wdata = ahbif.HWDATA;
      prev_HSIZE = ahbif.HSIZE;

    end
  endtask

endclass //sim_slave
