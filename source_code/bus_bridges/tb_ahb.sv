`include "ahb.sv"
import uvm_pkg::*;


module tb_ahb ();
  logic clk;
  logic n_rst;
  
  // generate clock
  initial begin
    clk = 0;
    forever #10 clk = !clk;
	end

  ahb_if ahbif(clk);
  generic_bus_if bus_if(clk);

  ahb DUT(.CLK(), .nRST(n_rst), .ahb_m(ahbif.ahb_m), .out_gen_bus_if(bus_if.generic_bus));

  initial begin
    @(posedge clk);
    n_rst = 0;
    @(posedge clk);
    @(posedge clk);
    n_rst = 1;

    uvm_config_db#(virtual ahbif)::set( null, "", "ahb_vif", ahbif);
    uvm_config_db#(virtual generic_bus_if)::set( null, "", "bus_vif", bus_if);

    run_test("test"); // initiate test component

  end

endmodule

class ahb_test extends uvm_test;
  `uvm_component_utils(ahb_test)

  ahb_env env;
  ahb_seq seq;

  function new(string name = "ahb_test", uvm_component parent);
		super.new(name, parent);
	endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
		env = ahb_env::type_id::create("env",this);
    seq = ahb_seq::type_id::create("seq");
  endfunction: build_phase

  task run_phase(uvm_phase phase);
    phase.raise_objection( this, "Starting sequence in main phase" );
		$display("%t Starting sequence run_phase",$time);
 		seq.start(env.agt.sqr);
		#100ns;
		phase.drop_objection( this , "Finished in main phase" );
  endtask

endclass //ahb_test

class ahb_env extends uvm_env;
  `uvm_component_utils(environment)
  ahb_agent agt;
  comparator comp; // scoreboard
  sim_mem mem;

  function new(string name = "env", uvm_component parent = null);
		super.new(name, parent);
	endfunction

  function void build_phase(uvm_phase phase);
    // instantiate all the components through factory method
    agt = ahb_agent::type_id::create("agt", this);
    comp = comparator::type_id::create("comp", this);
    mem = new();
    if(!mem.randomize()) begin
      `uvm_fatal("environment", "not able to randomize mem")
    end
  endfunction

  //TODO
  function void connect_phase(uvm_phase phase);
    agt.mon.counter_ap.connect(pred.analysis_export); // connect monitor to predictor
    pred.pred_ap.connect(comp.expected_export); // connect predictor to comparator
    agt.mon.result_ap.connect(comp.actual_export); // connect monitor to comparator
  endfunction

endclass //ahb_env

class sim_mem;
  parameter SIZE = 32;
  rand logic [7:0] [SIZE - 1:0] registers;
  
  function void write_byte(logic[SIZE - 1:0] addr, logic[31:0] HWDATA);
    registers[addr] = HWDATA[7:0];
  endfunction

  function void write_half(logic[SIZE - 1:0] addr, logic[31:0] HWDATA);
    registers[addr++] = HWDATA[7:0];
    registers[addr] = HWDATA[7:0];
  endfunction

  function void write_word(logic[SIZE - 1:0] addr, logic[31:0] HWDATA);
    registers[addr++] = HWDATA[7:0];
    registers[addr++] = HWDATA[7:0];
    registers[addr++] = HWDATA[7:0];
    registers[addr] = HWDATA[7:0];
  endfunction

  function logic[31:0] read_byte(logic[SIZE - 1:0] addr);
    logic[31:0] result;
    result = '0;
    result[7:0] = registers[addr];
    return result;
  endfunction

  function logic[31:0] read_half(logic[SIZE - 1:0] addr);
    logic[31:0] result;
    result = '0;
    result[7:0] = registers[addr++];
    result[15:8] = registers[addr];
    return result;
  endfunction

  function logic[31:0] read_word(logic[SIZE - 1:0] addr);
    logic[31:0] result;
    result = '0;
    result[7:0] = registers[addr++];
    result[15:8] = registers[addr++];
    result[23:16] = registers[addr++];
    result[31:24] = registers[addr];
    return result;
  endfunction
endclass //sim_mem

class ahb_agent extends uvm_agent;
  `uvm_component_utils(ahb_agent)
  sim_cpu cpu;
  sim_slave slave;
  sequencer sqr;

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);   
    sqr = sequencer::type_id::create("sqr", this);
    slave = sim_slave::type_id::create("slave", this);
    cpu = sim_cpu::type_id::create("cpu", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    cpu.seq_item_port.connect(sqr.seq_item_export);
  endfunction
endclass //ahb_agent


class transaction extends uvm_sequence_item;
  // parameter RAM_SIZE = 256;
  typedef enum {READ, WRITE, IDLE} trans_type;
  rand trans_type trans;
  rand logic [31:0] wdata;
  rand logic [31:0] addr;
  rand logic [3:0] byte_en;

  `uvm_object_utils_begin(transaction)
    `uvm_field_int(trans, UVM_DEFAULT)
    `uvm_field_int(wdata, UVM_DEFAULT)
    `uvm_field_int(addr, UVM_DEFAULT)
    `uvm_field_int(byte_en, UVM_DEFAULT)
  `uvm_object_utils_end

  constraint address_limit {byte_en == 4'b1111 -> addr <= 32'hfffffffc;
                            byte_en == 4'b0011 || byte_en == 4'b1100 -> addr <= 32'hfffffffe}

  function new(string name = "transaction");
    super.new(name);
  endfunction: new
endclass //transaction


class sim_cpu extends uvm_driver#(transaction);
  `uvm_component_utils(sim_cpu)

  virtual generic_bus_if bus_if;

  uvm_analysis_port #(transaction) cpu_ap; 
  uvm_analysis_port #(logic[31:0]) response_ap;

  function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cpu_ap = new("cpu_ap", this);
    // get interface from database
    if( !uvm_config_db#(virtual generic_bus_if)::get(this, "", "bus_vif", bus_if) ) begin
      // if the interface was not correctly set, raise a fatal message
      `uvm_fatal("simulated cpu", "No virtual interface specified for this test instance");
		end
  endfunction: build_phase

  task run_phase(uvm_phase phase);
    transaction req_item;
    transaction prev;
    logic[31:0] response;
    
    forever begin
      seq_item_port.get_next_item(req_item);
      cpu_ap.write(req_item);
      @(posedge bus_if.clk); 
      while (bus_if.busy) begin
        @(posedge bus_if.clk); 
      end
      if(prev.trans == READ) begin
        response = bus_if.rdata;
        response_ap.write(response);
      end
      if(req_item.trans == IDLE) begin
        bus_if.ren = 0;
        bus_if.wen = 0;
        bus_if.addr = req_item.addr;
        bus_if.wdata = req_item.wdata;
        bus_if.byte_en = req_item.byte_en;
      end
      else if(req_item.trans == READ) begin
        bus_if.ren = 1;
        bus_if.wen = 0;
        bus_if.addr = req_item.addr;
        bus_if.wdata = req_item.wdata;
        bus_if.byte_en = req_item.byte_en;
      end
      else if(req_item.trans == IDLE) begin
        bus_if.ren = 0;
        bus_if.wen = 1;
        bus_if.addr = req_item.addr;
        bus_if.wdata = req_item.wdata;
        bus_if.byte_en = req_item.byte_en;
      end
      prev = req_item.clone();
      seq_item_port.item_done();
    end
  endtask

endclass //sim_cpu

class sim_slave extends uvm_monitor;
  `uvm_component_utils(monitor)
  sim_mem mem;
  rand logic rand_ready; //randomized waite between transactions
  ahb_if ahb_if;

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction: new

  task random_wait();
    if(!rand_ready.randomize()) begin
      `uvm_fatal("sim_slave", "not able to randomize mem")
    end
    while(rand_ready) begin
      ahb_if.HREADY = 0;
      @(posedge ahb_if.HCLK);
      if(!rand_ready.randomize()) begin
      `uvm_fatal("sim_slave", "not able to randomize mem")
      end
    end
    ahb_if.HREADY = 1;
  endtask

  virtual function void build_phase(uvm_phase phase);
    if (!uvm_config_db#(virtual counter_if)::get(this, "", "ahb_vif", ahb_if)) begin
      `uvm_fatal("sim_slave", "No virtual interface specified for this monitor instance")
    end
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    //TODO:missing HRESP
    forever begin
      @(posedge ahb_if.HCLK);
      if(ahb_if.HTRANS == '0) begin
        continue;
      end
      if(ahb_if.HWRITE) begin
        random_wait();
        case(HSIZE) 
          3'b000: mem.write_byte(ahb_if.HADDR, ahb_if.HWDATA); //byte
          3'b001: mem.write_half(ahb_if.HADDR, ahb_if.HWDATA); //half word
          3'b010: mem.write_word(ahb_if.HADDR, ahb_if.HWDATA); //half word
        endcase
      end
      else begin
        random_wait();
        case(HSIZE) 
          3'b000: ahb_if.HRDATA = mem.read_byte(ahb_if.HADDR); //byte
          3'b001: ahb_if.HRDATA = mem.read_half(ahb_if.HADDR); //half word
          3'b010: ahb_if.HRDATA = mem.read_word(ahb_if.HADDR); //half word
        endcase
      end

      end
    end
  endtask
  

endclass //sim_slave

