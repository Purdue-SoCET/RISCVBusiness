/*
*   Copyright 2022 Purdue University
*
*   Licensed under the Apache License, Version 2.0 (the "License");
*   you may not use this file except in compliance with the License.
*   You may obtain a copy of the License at
*
*       http://www.apache.org/licenses/LICENSE-2.0
*
*   Unless required by applicable law or agreed to in writing, software
*   distributed under the License is distributed on an "AS IS" BASIS,
*   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*   See the License for the specific language governing permissions and
*   limitations under the License.
*
*
*   Filename:     bus_scoreboard.svh
*
*   Created by:   Mitch Arndt
*   Email:        arndt20@purdue.edu
*   Date Created: 03/27/2022
*   Description:  UVM Scoreboard class for checking the operation of a generic_bus_if
*/

`ifndef BUS_SCOREBOARD_SVH
`define BUS_SCOREBOARD_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"

class bus_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(bus_scoreboard)
  uvm_analysis_export #(cpu_transaction) expected_export;  // receive result from predictor
  uvm_analysis_export #(cpu_transaction) actual_export;  // receive result from DUT
  uvm_tlm_analysis_fifo #(cpu_transaction) expected_fifo;
  uvm_tlm_analysis_fifo #(cpu_transaction) actual_fifo;

  int m_matches, m_mismatches;  // records number of matches and mismatches

  function new(string name, uvm_component parent);
    super.new(name, parent);
    m_matches = 0;
    m_mismatches = 0;
  endfunction

  function void build_phase(uvm_phase phase);
    expected_export = new("expected_export", this);
    actual_export = new("actual_export", this);
    expected_fifo = new("expected_fifo", this);
    actual_fifo = new("actual_fifo", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    expected_export.connect(expected_fifo.analysis_export);
    actual_export.connect(actual_fifo.analysis_export);
  endfunction

  task run_phase(uvm_phase phase);
    cpu_transaction expected_tx;  //transaction from predictor
    cpu_transaction actual_tx;  //transaction from DUT
    forever begin
      expected_fifo.get(expected_tx);
      `uvm_info(this.get_name(), $sformatf("Recieved new expected value:\n%s",
                                           expected_tx.sprint()), UVM_HIGH);

      actual_fifo.get(actual_tx);
      `uvm_info(this.get_name(), $sformatf("Recieved new actual value:\n%s", actual_tx.sprint()),
                UVM_HIGH);

      if (expected_tx.compare(actual_tx)) begin
        m_matches++;
        `uvm_info(this.get_name(), "Success: Data Match", UVM_LOW);
        `uvm_info(this.get_name(), $sformatf("\nExpected:\n%s\nReceived:\n%s",
                                             expected_tx.sprint(), actual_tx.sprint()), UVM_MEDIUM)
      end else begin
        m_mismatches++;
        `uvm_error(this.get_name(), "Error: Data Mismatch");
        `uvm_info(this.get_name(), $sformatf(
                  "\nExpected:\n%s\nReceived:\n%s", expected_tx.sprint(), actual_tx.sprint()),
                  UVM_LOW)
      end
    end
  endtask



  function void report_phase(uvm_phase phase);
    `uvm_info($sformatf("%s", this.get_name()), $sformatf("Matches:    %0d", m_matches), UVM_LOW);
    `uvm_info($sformatf("%s", this.get_name()), $sformatf("Mismatches: %0d", m_mismatches),
              UVM_LOW);
    `uvm_info($sformatf("%s", this.get_name()), $sformatf("TXN_Total: %0d",
                                                          m_matches + m_mismatches), UVM_LOW);
  endfunction

endclass : bus_scoreboard

`endif
