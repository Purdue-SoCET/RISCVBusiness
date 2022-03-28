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
`include "l1_cache_wrapper_if.svh"
`include "dut_params.svh"

class bus_monitor extends uvm_monitor;
  `uvm_component_utils(bus_monitor)

  virtual l1_cache_wrapper_if cif;
  virtual generic_bus_if bus_if;

  cache_env_config env_config;

  uvm_analysis_port #(cpu_transaction) req_ap;
  uvm_analysis_port #(cpu_transaction) resp_ap;

  int cycle; // number of clock cycles that have elapsed
  
  function new(string name, uvm_component parent = null);
    super.new(name, parent);
    req_ap = new("req_ap", this);
    resp_ap = new("resp_ap", this);
    cycle = 0;
  endfunction: new

  // Build Phase - Get handle to virtual if from config_db
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // NOTE: extended classes must get interfaces from db
    
    // get config from database
    if( !uvm_config_db#(cache_env_config)::get(this, "", "env_config", env_config) ) begin
      `uvm_fatal(this.get_name(), "env config not registered to db")
		end
  endfunction: build_phase

  virtual task run_phase(uvm_phase phase);
    //TODO: DO I NEED TO WORRY ABOUT INTEGER OVERFLOW FOR CYCLE?
    super.run_phase(phase);

    forever begin
      cpu_transaction tx;
      int timeout_lim;

      @(posedge cif.CLK);
      cycle++;

      if (bus_if.ren || bus_if.wen) begin
        // captures activity between the driver and DUT
        tx = cpu_transaction::type_id::create("tx");

        tx.addr = bus_if.addr;
        tx.byte_sel = bus_if.byte_en;

        if (bus_if.ren) begin
          tx.rw = '0; // 0 -> read; 1 -> write
          tx.data = 'x; //fill with garbage data
        end else if (bus_if.wen) begin
          tx.rw = '1; // 0 -> read; 1 -> write
          tx.data = bus_if.wdata;
        end

        tx.cycle = cycle;
        `uvm_info(this.get_name(), $sformatf("Writing Req AP:\nReq Ap:\n%s", tx.sprint()), UVM_FULL)
        req_ap.write(tx);

        timeout_lim = cycle + env_config.mem_timeout; 
        while (bus_if.busy) begin
          @(posedge cif.CLK);
          cycle++; //wait for memory to return
          if (cycle > timeout_lim) begin
            `uvm_fatal(this.get_name(), "memory timeout reached")
          end
        end

        if (bus_if.ren) begin
          tx.data = bus_if.rdata;
        end

        tx.cycle = cycle;
        `uvm_info(this.get_name(), $sformatf("Writing Resp AP:\nReq Ap:\n%s", tx.sprint()), UVM_FULL)
        resp_ap.write(tx);
      end
    end
  endtask: run_phase

endclass: bus_monitor

`endif