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
*   Filename:     bus_agent.svh
*
*   Created by:   Mitch Arndt
*   Email:        arndt20@purdue.edu
*   Date Created: 04/04/2022
*   Description:  Generic UVM Agent to for a generic_bus_if
*/

`ifndef BUS_AGENT_SVH
`define BUS_AGENT_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "nominal_sequence.svh"
`include "index_sequence.svh"
`include "evict_sequence.svh"
`include "mmio_sequence.svh"
`include "cpu_driver.svh"
`include "bus_monitor.svh"
`include "cpu_sequencer.svh"

class null_driver;
endclass

class bus_agent #(
    type driver = null_driver
) extends uvm_agent;
  `uvm_component_param_utils(bus_agent#(driver))
  cpu_sequencer sqr;
  driver drv;
  bus_monitor mon;

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction

endclass : bus_agent

`endif
