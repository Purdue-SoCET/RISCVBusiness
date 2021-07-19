//By            : Zhengsen Fu
//Description   : all the UVM components needed in tb_ahb.sv
//Last Updated  : 8/21/20

`include "uvm_macros.svh"
import uvm_pkg::*;


class transaction extends uvm_sequence_item;
  // parameter RAM_SIZE = 256;
  localparam IDLE = '0;
  localparam READ = 2'b01;
  localparam WRITE = 2'b10;
  
  rand bit[1:0] trans; //trasaction type. Possible values indicated above
  rand logic [31:0] wdata;
  rand logic [31:0] addr;
  rand logic [3:0] byte_en;

  `uvm_object_utils_begin(transaction)
    `uvm_field_int(trans, UVM_DEFAULT)
    `uvm_field_int(wdata, UVM_DEFAULT)
    `uvm_field_int(addr, UVM_DEFAULT)
    `uvm_field_int(byte_en, UVM_DEFAULT)
  `uvm_object_utils_end

  constraint address_limit {byte_en == 4'b1111 -> addr <= 4'hf - 3;
                            byte_en == 4'b0011 || byte_en == 4'b1100 -> addr <= 4'hf - 1;}
  constraint trans_constraint {trans == IDLE || trans == READ || trans == WRITE;}
  constraint addr_size {addr <= 4'hf;} //testing with a simulated memory smaller than 16 registers
  
  function new(string name = "transaction");
    super.new(name);
  endfunction: new
endclass //transaction


//a queue that record all the transactions.
//search function still needs debugging
class transactionSeq; //transaction sequence
  localparam MAX_SIZE = 4000;
  transaction arr[MAX_SIZE - 1:0];
  integer time_arr[MAX_SIZE - 1:0]; //arr which recording the time that the transaction has happened
  int index; //points to most recent transactoin
  function new();
    index = -1;
  endfunction //new()

  //push one transaction into the arr
  function void push(transaction item);
    if(index == MAX_SIZE) begin //can be implemented as a queue is needed in the future
      $fatal("transactionSeq: sequence cannot hold more items"); 
    end
    index++;
    arr[index] = item;
    time_arr[index] = $time();
  endfunction

  //search for the most recent transaction that write to an addr
  function transaction search(logic[31:0] addr);
    transaction item;
    for(int lcv = index; lcv > 0; lcv--) begin
      item = arr[lcv];
      //if not WRITE, pass
      if (item.trans != item.WRITE) begin
        continue;
      end
      if(item.byte_en == 4'b1111) begin
        if (addr == item.addr || addr == (item.addr - 1) || addr == (item.addr - 2)  || addr == (item.addr - 3)) begin
          return item;
        end
      end else if(item.byte_en == 4'b1100 || item.byte_en == 4'b0011) begin
        if (addr == item.addr || addr == (item.addr - 1)) begin
          return item;
        end
      end else begin
        if (addr == item.addr) begin
          return item;
        end
      end
    end
    $fatal("transaction not found!\n");
  endfunction

  //search for the index of the most recent transaction that write to an addr 
  function int search_index(logic[31:0] addr);
    transaction item;
    for(int lcv = index; lcv > 0; lcv--) begin
      item = arr[lcv];
      //if not WRITE, pass
      if (item.trans != item.WRITE) begin
        continue;
      end
      if(item.byte_en == 4'b1111) begin
        if (addr == item.addr || addr == (item.addr - 1) || addr == (item.addr - 2)  || addr == (item.addr - 3)) begin
          return lcv;
        end
      end else if(item.byte_en == 4'b1100 || item.byte_en == 4'b0011) begin
        if (addr == item.addr || addr == (item.addr - 1)) begin
          return lcv;
        end
      end else begin
        if (addr == item.addr) begin
          return lcv;
        end
      end
    end
    $fatal("transaction not found!\n");
  endfunction

  //search for the time of the most recent transaction that write to an addr 
  function int search_time(logic[31:0] addr);
    transaction item;
    for(int lcv = index; lcv > 0; lcv--) begin
      item = arr[lcv];
      //if not WRITE, pass
      if (item.trans != item.WRITE) begin
        continue;
      end
      if(item.byte_en == 4'b1111) begin
        if (addr == item.addr || addr == (item.addr - 1) || addr == (item.addr - 2)  || addr == (item.addr - 3)) begin
          return time_arr[lcv];
        end
      end else if(item.byte_en == 4'b1100 || item.byte_en == 4'b0011) begin
        if (addr == item.addr || addr == (item.addr - 1)) begin
          return time_arr[lcv];
        end
      end else begin
        if (addr == item.addr) begin
          return time_arr[lcv];
        end
      end
    end
    // $fatal("transaction not found!\n");
  endfunction
endclass //transactionSeq



//simulated memory that is used in the simulated slave
class sim_mem extends uvm_object;
  parameter SIZE = 4; //the number of bits in the addr
  rand bit [7:0] registers[2 ** SIZE  - 1:0];
  
  `uvm_object_utils_begin(sim_mem)
    `uvm_field_sarray_int(registers, UVM_DEFAULT)
  `uvm_object_utils_end
  
  function new(string name = "sim_mem");
    super.new(name);
  endfunction: new

  //print the value in all registers for debugging purpose
  function void print_all();
    for (int lcv = 0; lcv < 2**SIZE; lcv++) begin
      $display("%h: %h",lcv, registers[lcv]);
    end
    
  endfunction

  //write the least significant byte in HWDATA to addr
  function void write_byte(logic[SIZE - 1:0] addr, logic[31:0] HWDATA);
    registers[addr] = HWDATA[7:0];
  endfunction

  //write two least significant bytes in HWDATA to addr
  function void write_half(logic[SIZE - 1:0] addr, logic[31:0] HWDATA);
    registers[addr++] = HWDATA[7:0];
    registers[addr] = HWDATA[15:8];
  endfunction

  //write four least significant bytes in HWDATA to addr
  function void write_word(logic[SIZE - 1:0] addr, logic[31:0] HWDATA);
    registers[addr++] = HWDATA[7:0];
    registers[addr++] = HWDATA[15:8];
    registers[addr++] = HWDATA[23:16];
    registers[addr] = HWDATA[31:24];
  endfunction

  //read a byte stored in addr to the least significant byte to HRDATA
  function logic[31:0] read_byte(logic[SIZE - 1:0] addr);
    logic[31:0] result;
    result = '0;
    result[7:0] = registers[addr];
    return result;
  endfunction

  //read two bytes stored in addr to the least significant byte to HRDATA
  function logic[31:0] read_half(logic[SIZE - 1:0] addr);
    logic[31:0] result;
    result = '0;
    result[7:0] = registers[addr++];
    result[15:8] = registers[addr];
    return result;
  endfunction

  //read four bytes stored in addr to the least significant byte to HRDATA
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
        // slave_mem.print_all();
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

      seq_item_port.item_done();
      //if busy is asserted by the slave, wait until busy is cleared
      while (bus_if.busy) begin
        if(req_item.trans == req_item.IDLE) begin
          break;
        end
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
    end
  endtask

endclass //sim_cpu



class ahb_seq extends uvm_sequence #(transaction);
  `uvm_object_utils(ahb_seq)

  int number;

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


    number = 0;
    repeat(3000) begin
      start_item(req_item);
      if(!req_item.randomize()) begin
        // if the transaction is unable to be randomized, send a fatal message
        `uvm_fatal("ahb_seq", "not able to randomize")
      end
      number++;
      $info("DEBUG: item sent! %d", number);

      finish_item(req_item);
    end
    $info("DEBUG: reached end");
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
  transactionSeq tx_seq;

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    pred_ap = new("pred_ap", this);
  endfunction

  function void write(transaction t);
    tx_seq.push(t);
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

      // $info("PREDICTOR DEBUG write addr: %h    value: %h  size: %h",t.addr, t.wdata, HSIZE);
      
      // $display("predictor");
      // $display("predictor mem");
      // mem.print_all();
      // $display("");
    end
  endfunction
endclass //predictor



class comparator extends uvm_scoreboard;
  `uvm_component_utils(comparator)
  uvm_analysis_export #(transaction) response_export;
  uvm_tlm_analysis_fifo #(transaction) response_fifo;
  sim_mem mem;
  logic [2:0] HSIZE;
  transaction response;
  logic [31:0] expected;
  transactionSeq tx_seq;

  int m_matches, m_mismatches; // records number of matches and mismatches

  function new( string name , uvm_component parent) ;
		super.new( name , parent );
	  	m_matches = 0;
	  	m_mismatches = 0;
 	endfunction

  function void connect_phase(uvm_phase phase);
    response_export.connect(response_fifo.analysis_export);
  endfunction

  function void build_phase( uvm_phase phase );
    response_export = new("response_export", this);
    response_fifo = new("response_fifo", this);
	endfunction

  task run_phase(uvm_phase phase);
  int error_tx_time; //time that error write transaction happens
  forever begin
    response_fifo.get(response);
    if(response.byte_en == 4'b1111)
      HSIZE = 3'b010; // word
    else if(response.byte_en == 4'b1100 || response.byte_en == 4'b0011)
      HSIZE = 3'b001; // half word
    else 
      HSIZE = 3'b000; // byte
    
    case(HSIZE) 
        3'b000: expected = mem.read_byte(response.addr); //byte
        3'b001: expected = mem.read_half(response.addr); //half word
        3'b010: expected = mem.read_word(response.addr); //word
    endcase
    
    if(expected == response.wdata) begin
      m_matches++;
      `uvm_info("Comparator", "Data Match", UVM_LOW);
    end else begin
      m_mismatches++;
      `uvm_error("Comparator", "Error: Data Mismatch");

      $display("comparator");
      $info("response: %h", response.wdata);
      $display("expected addr:%h  value: %h  size: %h  byte_en: %b", response.addr , expected, HSIZE, response.byte_en);

      error_tx_time = tx_seq.search_time(response.addr);
      $info("error transaction happens at %d", error_tx_time);
    end
  end
  endtask

  function void report_phase(uvm_phase phase);
    `uvm_info("Comparator", $sformatf("Matches:    %0d", m_matches), UVM_LOW);
    `uvm_info("Comparator", $sformatf("Mismatches: %0d", m_mismatches), UVM_LOW);
  endfunction

endclass //comparator

class ahb_env extends uvm_env;
  `uvm_component_utils(ahb_env)
  ahb_agent agt;
  comparator comp; // scoreboard
  predictor pred;
  sim_mem mem;
  transactionSeq tx_seq; //to record and lookup transactions

  function new(string name = "env", uvm_component parent = null);
		super.new(name, parent);
	endfunction

  function void build_phase(uvm_phase phase);
    agt = ahb_agent::type_id::create("agt", this);
    comp = comparator::type_id::create("comp", this);
    pred = predictor::type_id::create("pred", this);
    tx_seq = new();
    mem = new();
    if(!mem.randomize()) begin
      `uvm_fatal("environment", "not able to randomize mem")
    end
    pred.mem = mem;
    comp.mem = mem;
    uvm_config_db#(sim_mem)::set( null, "", "slave_mem", mem);
    pred.tx_seq = tx_seq;
    comp.tx_seq = tx_seq;
  endfunction

  function void connect_phase(uvm_phase phase);
    agt.cpu.cpu_ap.connect(pred.analysis_export);
    agt.cpu.response_ap.connect(comp.response_export);
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

