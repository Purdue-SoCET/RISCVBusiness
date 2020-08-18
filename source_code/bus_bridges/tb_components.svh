`include "uvm_macros.svh"
import uvm_pkg::*;


class transaction extends uvm_sequence_item;
  // parameter RAM_SIZE = 256;
  localparam IDLE = '0;
  localparam READ = 2'b01;
  localparam WRITE = 2'b10;
  
  rand bit[1:0] trans;
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
                            byte_en == 4'b0011 || byte_en == 4'b1100 -> addr <= 32'hfffffffe;}
  constraint trans_constraint {trans == IDLE || trans == READ || trans == WRITE;}
  constraint addr_size {addr <= 4'hf;}
  function new(string name = "transaction");
    super.new(name);
  endfunction: new
endclass //transaction



class sim_mem extends uvm_object;
  parameter SIZE = 4;
  rand bit [7:0] registers[2 ** SIZE  - 1:0];
  
  `uvm_object_utils_begin(sim_mem)
    `uvm_field_sarray_int(registers, UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name = "sim_mem");
    super.new(name);
  endfunction: new

  function void write_byte(logic[SIZE - 1:0] addr, logic[31:0] HWDATA);
    registers[addr] = HWDATA[7:0];
  endfunction

  function void write_half(logic[SIZE - 1:0] addr, logic[31:0] HWDATA);
    registers[addr++] = HWDATA[7:0];
    registers[addr] = HWDATA[15:8];
  endfunction

  function void write_word(logic[SIZE - 1:0] addr, logic[31:0] HWDATA);
    registers[addr++] = HWDATA[7:0];
    registers[addr++] = HWDATA[15:8];
    registers[addr++] = HWDATA[23:16];
    registers[addr] = HWDATA[31:24];
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



class sim_slave extends uvm_monitor;
  `uvm_component_utils(sim_slave)
  sim_mem slave_mem;
  sim_mem input_mem;
  logic rand_ready; //randomized waite between transactions
  virtual ahb_if ahbif;
  transaction prev_tx;
  logic [2:0] prev_HSIZE;

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction: new

  task random_wait();
    // if(!rand_ready.randomize()) begin
    //   `uvm_fatal("sim_slave", "not able to randomize mem")
    // end
    rand_ready = $urandom();
    while(rand_ready) begin
      ahbif.HREADY = 0;
      @(posedge ahbif.HCLK);
      // if(!rand_ready.randomize()) begin
      // `uvm_fatal("sim_slave", "not able to randomize mem")
      // end
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

    // get sim_mem
    if (!uvm_config_db#(sim_mem)::get(this, "", "slave_mem", input_mem)) begin
      `uvm_fatal("sim_slave", "No input mem")
    end
    slave_mem.copy(input_mem);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    ahbif.HREADY = 1;

    //TODO:missing HRESP
    forever begin
      @(posedge ahbif.HCLK);
      if(prev_tx.trans == '0) begin
        ;
      end
      else if(prev_tx.trans == prev_tx.WRITE) begin
        random_wait();
        case(prev_HSIZE) 
          3'b000: slave_mem.write_byte(prev_tx.addr, prev_tx.wdata); //byte
          3'b001: slave_mem.write_half(prev_tx.addr, prev_tx.wdata); //half word
          3'b010: slave_mem.write_word(prev_tx.addr, prev_tx.wdata); //word
        endcase
      end
      else begin
        random_wait();
        case(prev_HSIZE) 
          3'b000: ahbif.HRDATA = slave_mem.read_byte(prev_tx.addr); //byte
          3'b001: ahbif.HRDATA = slave_mem.read_half(prev_tx.addr); //half word
          3'b010: ahbif.HRDATA = slave_mem.read_word(prev_tx.addr); //word
        endcase
      end

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



class sim_cpu extends uvm_driver#(transaction);
  `uvm_component_utils(sim_cpu)

  virtual generic_bus_if bus_if;

  uvm_analysis_port #(transaction) cpu_ap; 
  uvm_analysis_port #(logic[31:0]) response_ap;

  logic n_rst;

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
    transaction prev;
    logic[31:0] response;
    
    prev = transaction::type_id::create("prev");
    
    // bus_if.n_rst = 0;
    // @(posedge bus_if.clk); 
    // bus_if.n_rst = 1;

    forever begin
      seq_item_port.get_next_item(req_item);
      cpu_ap.write(req_item);
      @(posedge bus_if.clk); 
      while (bus_if.busy) begin
        @(posedge bus_if.clk); 
      end
      if(prev.trans == req_item.READ) begin
        response = bus_if.rdata;
        response_ap.write(response);
      end
      if(req_item.trans == req_item.IDLE) begin
        bus_if.ren = 0;
        bus_if.wen = 0;
      end
      else if(req_item.trans == req_item.READ) begin
        bus_if.ren = 1;
        bus_if.wen = 0;
        bus_if.addr = req_item.addr;
        bus_if.byte_en = req_item.byte_en;
      end
      else if(req_item.trans == req_item.WRITE) begin
        bus_if.ren = 0;
        bus_if.wen = 1;
        bus_if.addr = req_item.addr;
        // bus_if.wdata = req_item.wdata;
        bus_if.byte_en = req_item.byte_en;
      end
      
      if(prev.trans == prev.WRITE) begin
        bus_if.wdata = prev.wdata;
      end
      prev.copy(req_item);
      seq_item_port.item_done();
    end
  endtask

endclass //sim_cpu



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
      req_item.trans = req_item.IDLE;
    finish_item(req_item);
    // repeat(30) begin
    //   start_item(req_item);
    //   if(!req_item.randomize()) begin
    //     // if the transaction is unable to be randomized, send a fatal message
    //     `uvm_fatal("ahb_seq", "not able to randomize")
    //   end
    //   finish_item(req_item);
    // end
  endtask: body
endclass //ahb_seq



class sequencer extends uvm_sequencer#(transaction);
   `uvm_component_utils(sequencer)
   function new(input string name= "sequencer", uvm_component parent=null);
      super.new(name, parent);
   endfunction : new
endclass : sequencer



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

class predictor extends uvm_subscriber #(transaction);
  `uvm_component_utils(predictor) 
  uvm_analysis_port #(transaction) pred_ap;
  sim_mem mem;
  logic [2:0] HSIZE;

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    pred_ap = new("pred_ap", this);
  endfunction

  function void write(transaction t);
    //TODO: need to verify
    if(t.byte_en == 4'b1111)
      HSIZE = 3'b010; // word
    else if(t.byte_en == 4'b1100 || t.byte_en == 4'b0011)
      HSIZE = 3'b001; // half word
    else 
      HSIZE = 3'b000; // byte

    
    if(t.trans == t.WRITE) begin
      case(HSIZE) 
        3'b000: mem.write_byte(t.addr, t.wdata); //byte
        3'b001: mem.write_half(t.addr, t.wdata); //half word
        3'b010: mem.write_word(t.addr, t.wdata); //word
      endcase
    end
  endfunction
endclass //predictor


class ahb_env extends uvm_env;
  `uvm_component_utils(ahb_env)
  ahb_agent agt;
  // comparator comp; // scoreboard
  predictor pred;
  sim_mem mem;

  function new(string name = "env", uvm_component parent = null);
		super.new(name, parent);
	endfunction

  function void build_phase(uvm_phase phase);
    agt = ahb_agent::type_id::create("agt", this);
    // comp = comparator::type_id::create("comp", this);
    pred = predictor::type_id::create("pred", this);

    mem = new();
    if(!mem.randomize()) begin
      `uvm_fatal("environment", "not able to randomize mem")
    end
    pred.mem = mem;
    uvm_config_db#(sim_mem)::set( null, "", "slave_mem", mem);
  endfunction

  //TODO
  function void connect_phase(uvm_phase phase);
  agt.cpu.cpu_ap.connect(pred.analysis_export);
  //   agt.mon.counter_ap.connect(pred.analysis_export); // connect monitor to predictor
  //   pred.pred_ap.connect(comp.expected_export); // connect predictor to comparator
  //   agt.mon.result_ap.connect(comp.actual_export); // connect monitor to comparator
  endfunction

endclass //ahb_env



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

