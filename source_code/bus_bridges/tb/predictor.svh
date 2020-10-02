`include "uvm_macros.svh"
import uvm_pkg::*;

class predictor extends uvm_subscriber #(transaction);
  `uvm_component_utils(predictor) 
  uvm_analysis_port #(transaction) pred_ap;
  sim_mem mem;
  logic [2:0] HSIZE;
  // transactionSeq tx_seq;

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    pred_ap = new("pred_ap", this);
  endfunction

  function void write(transaction t);
    // tx_seq.push(t);
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
      
      $display("predictor");
      $display("predictor mem");
      mem.print_all();
      $display("");
    end
  endfunction
endclass //predictor
