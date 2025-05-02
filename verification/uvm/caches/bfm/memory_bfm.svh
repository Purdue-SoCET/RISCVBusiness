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
*   Filename:     memory_bfm.svh
*
*   Created by:   Mitch Arndt
*   Email:        arndt20@purdue.edu
*   Date Created: 03/27/2022
*   Description:  Bus Functional Model (BFM) for the memory bus, including memory mapped I/O
*/

`ifndef MEMORY_BFM_SVH
`define MEMORY_BFM_SVH

`include "cache_env_config.svh"

`include "uvm_macros.svh"

`include "dut_params.svh"

`include "Utils.svh"

import uvm_pkg::*;
import rv32i_types_pkg::*;

class memory_bfm extends uvm_component;
  `uvm_component_utils(memory_bfm)

  virtual cache_if cif;
  virtual generic_bus_if bus_if;

  cache_env_config env_config;

  word_t mem[word_t];  // initialized memory array
  word_t mmio[word_t];  // initialized memory mapped array

  function new(string name = "memory_bfm", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    string bus_if_str;
    super.build_phase(phase);

    // get config from database
    if (!uvm_config_db#(cache_env_config)::get(this, "", "env_config", env_config)) begin
      `uvm_fatal(this.get_name(), "env config not registered to db")
    end

    // get interface from database
    if (!uvm_config_db#(virtual cache_if)::get(this, "", "d_cif", cif)) begin
      `uvm_fatal($sformatf("%s/d_cif", this.get_name()),
                 "No virtual interface specified for this test instance");
    end
    `uvm_info(this.get_name(), "pulled <d_cif> from db", UVM_FULL)

    if (!uvm_config_db#(virtual generic_bus_if)::get(this, "", "mem_bus_if", bus_if)) begin
      `uvm_fatal($sformatf("%s/mem_bus_if", this.get_name()),
                 "No virtual interface specified for this test instance");
    end
    `uvm_info(this.get_name(), "pulled <mem_bus_if> from db", UVM_FULL)
  endfunction : build_phase

  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge cif.CLK);
      `PROPAGATION_DELAY

      // default values on bus
      bus_if.busy  = '0;
      bus_if.rdata = 32'hbad0_bad0;

      if (bus_if.addr < `NONCACHE_START_ADDR) begin
        if (bus_if.ren) begin
          mem_read();
        end else if (bus_if.wen) begin
          mem_write();
        end
      end else if (bus_if.addr >= `NONCACHE_START_ADDR) begin
        if (bus_if.ren) begin
          mmio_read();
        end else if (bus_if.wen) begin
          mmio_write();
        end
      end
    end
  endtask : run_phase

  task mem_read();
    int count;

    bus_if.busy = '1;
    count = 1;
    while (count < env_config.mem_latency && bus_if.ren) begin
      @(posedge cif.CLK);
      `PROPAGATION_DELAY
      count++;
    end

    bus_if.rdata = read(bus_if.addr);
    bus_if.busy  = '0;
  endtask : mem_read

  task mem_write();
    int count;

    bus_if.busy = '1;
    count = 1;
    while (count < env_config.mem_latency) begin
      @(posedge cif.CLK);
      `PROPAGATION_DELAY
      count++;
    end

    mem[bus_if.addr] = bus_if.wdata;

    bus_if.busy = '0;
  endtask : mem_write

  task mmio_read();
    int count;
    bus_if.busy = '1;
    //TODO: COME UP WITH SOME MEANINGFUL DATA TO PUT FOR MMIO, MAYBE SIMULATE A PERIFERAL REGISTER

    count = 1;
    while (count < env_config.mmio_latency && bus_if.ren) begin
      @(posedge cif.CLK);
      `PROPAGATION_DELAY
      count++;
    end

    bus_if.rdata = {env_config.mmio_tag, bus_if.addr[15:0]};
    bus_if.busy  = '0;
  endtask : mmio_read

  task mmio_write();
    int count;
    bus_if.busy = '1;

    count = 1;
    while (count < env_config.mmio_latency && bus_if.wen) begin
      @(posedge cif.CLK);
      `PROPAGATION_DELAY
      count++;
    end

    // mmio[bus_if.addr] = bus_if.wdata; //TODO: DO SOMETHING MORE MEANINGFUL FOR WRITING TO MMIO, REGISTER MODEL?
    bus_if.busy = '0;
  endtask : mmio_write

  function word_t read(word_t addr);
    if (mem.exists(bus_if.addr)) begin
      return mem[bus_if.addr];
    end else begin
      return {env_config.mem_tag, addr[15:0]};  // return non-initialized data
    end
  endfunction : read

endclass : memory_bfm

`endif
