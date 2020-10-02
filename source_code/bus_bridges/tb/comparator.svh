`include "uvm_macros.svh"
import uvm_pkg::*;

class comparator extends uvm_scoreboard;
  `uvm_component_utils(comparator)
  uvm_analysis_export #(transaction) response_export;
  uvm_tlm_analysis_fifo #(transaction) response_fifo;
  sim_mem mem;
  logic [2:0] HSIZE;
  transaction response;
  logic [31:0] expected;
  // transactionSeq tx_seq;

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
      uvm_report_info("Comparator", "Data Match");
    end else begin
      m_mismatches++;
      uvm_report_error("Comparator", "Error: Data Mismatch");

      $display("comparator");
      $info("response: %h", response.wdata);
      $display("expected addr:%h  value: %h  size: %h  byte_en: %b", response.addr , expected, HSIZE, response.byte_en);

      // error_tx_time = tx_seq.search_time(response.addr);
      $info("error transaction happens at %d", error_tx_time);
    end
  end
  endtask

  function void report_phase(uvm_phase phase);
    uvm_report_info("Comparator", $sformatf("Matches:    %0d", m_matches));
    uvm_report_info("Comparator", $sformatf("Mismatches: %0d", m_mismatches));
  endfunction

endclass //comparator

