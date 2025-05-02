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
*   Filename:     bus_monitor.svh
*
*   Created by:   Mitch Arndt
*   Email:        arndt20@purdue.edu
*   Date Created: 03/27/2022
*   Description:  UVM Monitor class for monitoring a generic_bus_if
*/

`ifndef BUS_MONITOR_SVH
`define BUS_MONITOR_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "generic_bus_if.vh"
`include "cache_if.svh"
`include "dut_params.svh"

class bus_monitor extends uvm_monitor;
  // precedence breaks ties for transactions that come during the same tick (lower is higher precedence)
  // TODO: change precedence to using uvm_wait_for_nba_region()
  `uvm_component_utils(bus_monitor)

  virtual cache_if cif;
  virtual generic_bus_if bus_if;

  cache_env_config env_config;

  uvm_analysis_port #(cpu_transaction) req_ap;
  uvm_analysis_port #(cpu_transaction) resp_ap;

  int cycle;  // number of clock cycles that have elapsed

  int precedence;
  string cif_str;
  string bus_if_str;

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
    req_ap = new("req_ap", this);
    resp_ap = new("resp_ap", this);
    precedence = 0;
    cif_str = "";
    bus_if_str = "";
  endfunction : new

  function void set_cif_str(string str);
    this.cif_str = str;
  endfunction : set_cif_str

  function void set_bus_if_str(string str);
    this.bus_if_str = str;
  endfunction : set_bus_if_str

  function void set_precedence(int p);
    this.precedence = p;
  endfunction : set_precedence

  // Build Phase - Get handle to virtual if from config_db
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // get config from database
    if (!uvm_config_db#(cache_env_config)::get(this, "", "env_config", env_config)) begin
      `uvm_fatal(this.get_name(), "env config not registered to db")
    end
    `uvm_info(this.get_name(), "pulled <env_config> from db", UVM_FULL)

    if (!uvm_config_db#(virtual cache_if)::get(this, "", cif_str, cif)) begin
      `uvm_fatal($sformatf("%s/%s", this.get_name(), cif_str),
                 "No virtual interface specified for this test instance");
    end
    `uvm_info(this.get_name(), $sformatf("pulled <%s> from db", cif_str), UVM_FULL)

    if (!uvm_config_db#(virtual generic_bus_if)::get(this, "", bus_if_str, bus_if)) begin
      `uvm_fatal($sformatf("%s/%s", this.get_name(), bus_if_str),
                 "No virtual interface specified for this test instance");
    end
    `uvm_info(this.get_name(), $sformatf("pulled <%s> from db", bus_if_str), UVM_FULL)
  endfunction : build_phase

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    forever begin
      cpu_transaction tx;

      @(posedge cif.CLK);
      `MONITOR_DELAY  // delay to pick up new value from bus

      if (cif.flush) begin
        tx = cpu_transaction::type_id::create("tx");
        tx.addr = bus_if.addr;
        tx.data = 'x;
        tx.byte_en = bus_if.byte_en;
        tx.flush = cif.flush;

        `uvm_info(this.get_name(), $sformatf("Writing Req AP:\nReq Ap:\n%s", tx.sprint()), UVM_FULL)
        req_ap.write(tx);

        mem_wait(1'b1, cif.flush_done);

        `uvm_info(this.get_name(), $sformatf("Writing Resp AP:\nReq Ap:\n%s", tx.sprint()),
                  UVM_FULL)
        resp_ap.write(tx);
      end else if (bus_if.ren || bus_if.wen) begin
        // captures activity between the driver and DUT
        tx = cpu_transaction::type_id::create("tx");

        tx.addr = bus_if.addr;
        tx.byte_en = bus_if.byte_en;
        tx.flush = cif.flush;

        if (bus_if.ren) begin
          tx.rw   = '0;  // 0 -> read; 1 -> write
          tx.data = 'x;  //fill with garbage data
        end else if (bus_if.wen) begin
          tx.rw   = '1;  // 0 -> read; 1 -> write
          tx.data = bus_if.wdata;
        end

        `uvm_info(this.get_name(), $sformatf("Writing Req AP:\nReq Ap:\n%s", tx.sprint()), UVM_FULL)
        req_ap.write(tx);

        mem_wait(1'b0, bus_if.busy);

        if (bus_if.ren) begin
          tx.data = bus_if.rdata;
        end

        #(precedence);
        `uvm_info(this.get_name(), $sformatf("Writing Resp AP:\nReq Ap:\n%s", tx.sprint()),
                  UVM_FULL)
        resp_ap.write(tx);
      end
    end
  endtask : run_phase

  task mem_wait(logic clear, const ref logic flag);
    int cycle = 0;
    while (flag != clear) begin
      @(posedge cif.CLK);
      `MONITOR_DELAY  // delay to pick up new value from bus
      cycle++;  //wait for memory to return
      if (cycle > env_config.mem_timeout) begin
        `uvm_fatal(this.get_name(), "memory timeout reached")
      end
    end
  endtask : mem_wait

endclass : bus_monitor

`endif
