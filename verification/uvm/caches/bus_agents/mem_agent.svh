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
*   Filename:     mem_agent.svh
*
*   Created by:   Mitch Arndt
*   Email:        arndt20@purdue.edu
*   Date Created: 03/27/2022
*   Description:  UVM Agent to stand in for the memory side of the caches
*/

`ifndef MEM_AGENT_SHV
`define MEM_AGENT_SHV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "bus_monitor.svh"

// typedef bus_monitor#(0, "l2_cif", "mem_bus_if") mem_monitor;

class mem_agent extends bus_agent;
  `uvm_component_utils(mem_agent)

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    mon = bus_monitor::type_id::create("MEM_MON", this);
    mon.set_precedence(0);
    mon.set_cif_str("l2_cif");
    mon.set_bus_if_str("mem_bus_if");
    `uvm_info(this.get_name(), $sformatf("Created <%s>", mon.get_name()), UVM_FULL)
  endfunction

endclass : mem_agent

`endif
