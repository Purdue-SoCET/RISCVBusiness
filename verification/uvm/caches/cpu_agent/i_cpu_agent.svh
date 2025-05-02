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
*   Filename:     i_cpu_agent.svh
*
*   Created by:   Mitch Arndt
*   Email:        arndt20@purdue.edu
*   Date Created: 04/04/2022
*   Description:  UVM Agent to stand in for the processor side of the instruction cache
*/

`ifndef I_CPU_AGENT_SVH
`define I_CPU_AGENT_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "nominal_sequence.svh"
`include "index_sequence.svh"
`include "evict_sequence.svh"
`include "mmio_sequence.svh"
`include "cpu_driver.svh"
`include "bus_monitor.svh"
`include "bus_agent.svh"
`include "cpu_sequencer.svh"

class i_cpu_driver extends cpu_driver #("i_cif", "i_cpu_bus_if");
  `uvm_component_utils(i_cpu_driver)
  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction
endclass

class i_cpu_agent extends bus_agent #(i_cpu_driver);
  `uvm_component_utils(i_cpu_agent)

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    sqr = cpu_sequencer::type_id::create("I_CPU_SQR", this);
    drv = i_cpu_driver::type_id::create("I_CPU_DRV", this);
    mon = bus_monitor::type_id::create("I_CPU_MON", this);
    mon.set_precedence(1);
    mon.set_cif_str("i_cif");
    mon.set_bus_if_str("i_cpu_bus_if");

    `uvm_info(this.get_name(), $sformatf(
              "Created <%s>, <%s>, <%s>", drv.get_name(), sqr.get_name(), mon.get_name()), UVM_FULL)
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    drv.seq_item_port.connect(sqr.seq_item_export);
    `uvm_info(this.get_name(), $sformatf("Connected <%s> to <%s>", drv.get_name(), sqr.get_name()),
              UVM_FULL)
  endfunction

endclass : i_cpu_agent

`endif
