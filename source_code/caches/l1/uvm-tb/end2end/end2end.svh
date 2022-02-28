`ifndef END2END_SVH
`define END2END_SVH

import uvm_pkg::*;
import rv32i_types_pkg::*;

`include "uvm_macros.svh"
`include "cpu_transaction.svh"

class end2end extends uvm_scoreboard;
  `uvm_component_utils(end2end) 

  uvm_analysis_export #(cpu_transaction) cpu_export;
  uvm_analysis_export #(cpu_transaction) mem_export;

  uvm_tlm_analysis_fifo #(cpu_transaction) cpu_fifo;
  uvm_tlm_analysis_fifo #(cpu_transaction) mem_fifo;

  word_t cache[word_t]; // holds values currently stored in cache

  int m_matches, m_mismatches; // records number of matches and mismatches

 
  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    cpu_export = new("cpu_export", this);
    mem_export = new("mem_export", this);

    cpu_fifo = new("cpu_fifo", this);
    mem_fifo = new("mem_fifo", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    cpu_export.connect(cpu_fifo.analysis_export);
    mem_export.connect(mem_fifo.analysis_export);
  endfunction

  task run_phase(uvm_phase phase);
    cpu_transaction cpu_tx;
    cpu_transaction mem_tx;

    forever begin
      cpu_fifo.get(cpu_tx);
      `uvm_info(this.get_name(), $sformatf("Recieved new cpu value:\n%s", cpu_tx.sprint()), UVM_HIGH);
  
      if (mem_fifo.is_empty()) begin
        // quiet memory bus
        if (cache.exists(cpu_tx.addr)) begin
          // data is cached
          m_matches++;
          `uvm_info(this.get_name(), "Success: Cache Hit -> Quiet Mem Bus", UVM_LOW);
        end else begin
          // data not in cache
          m_mismatches++;
          `uvm_error(this.get_name(), "Error: Cache Miss -> Quiet Mem Bus");
        end
        
        `uvm_info(this.get_name(), $sformatf("\nInitiated by CPU Transaction:\n%s", cpu_tx.sprint()), UVM_MEDIUM);
      end else begin
        // active memory bus

        mem_fifo.get(mem_tx);
        `uvm_info(this.get_name(), $sformatf("Recieved new mem value:\n%s", mem_tx.sprint()), UVM_HIGH);
        
        if (cache.exists(cpu_tx.addr)) begin
          // data is cached
          m_mismatches++;
          `uvm_error(this.get_name(), "Error: Cache Hit -> Active Mem Bus");
        end else begin
          // data not in cache
          m_matches++;
          `uvm_info(this.get_name(), "Success: Cache Miss -> Active Mem Bus", UVM_LOW);
          cache[mem_tx.addr] = mem_tx.data;
        end

        `uvm_info(this.get_name(), $sformatf("\nInitiated by CPU Transaction:\n%s", cpu_tx.sprint()), UVM_MEDIUM);
      end

      while(!mem_fifo.is_empty()) begin
        mem_fifo.get(mem_tx); //clear mem fifo
      end
     
    end
  endtask

  function void report_phase(uvm_phase phase);
    `uvm_info($sformatf("%s", this.get_name()), $sformatf("Matches:    %0d", m_matches), UVM_LOW);
    `uvm_info($sformatf("%s", this.get_name()), $sformatf("Mismatches: %0d", m_mismatches), UVM_LOW);
  endfunction

endclass: end2end

`endif