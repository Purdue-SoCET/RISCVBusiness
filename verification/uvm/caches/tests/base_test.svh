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
*   Filename:     base_test.svh
*
*   Created by:   Mitch Arndt
*   Email:        arndt20@purdue.edu
*   Date Created: 03/27/2022
*   Description:  UVM Test with default settings/configurations
*/

`ifndef BASE_TEST_SVH
`define BASE_TEST_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "cache_env.svh"
`include "cache_env_config.svh"

`include "generic_bus_if.vh"
`include "cache_if.svh"

class base_test #(
    type   sequence_type = nominal_sequence,
    string sequence_name = "BASE_TEST"
) extends uvm_test;
  `uvm_component_utils(base_test)

  sequence_type seq;

  cache_env_config env_config;
  cache_env env;
  virtual cache_if d_cif;
  virtual cache_if i_cif;
  virtual cache_if l2_cif;

  virtual generic_bus_if d_cpu_bus_if;
  virtual generic_bus_if i_cpu_bus_if;

  virtual generic_bus_if d_l1_arb_bus_if;
  virtual generic_bus_if i_l1_arb_bus_if;

  virtual generic_bus_if arb_l2_bus_if;
  virtual generic_bus_if mem_bus_if;

  function new(string name = "", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    env_config = cache_env_config::type_id::create("ENV_CONFIG", this);
    if (!env_config.randomize()) begin
      `uvm_fatal("Randomize Error", "not able to randomize")
    end

    env = cache_env::type_id::create("ENV", this);
    env.env_config = env_config;

    seq = sequence_type::type_id::create(sequence_name);

    // get interfaces from db
    if (!uvm_config_db#(virtual cache_if)::get(this, "", "d_cif", d_cif)) begin
      // check if interface is correctly set in testbench top level
      `uvm_fatal("Base/d_cif", "No virtual interface specified for this test instance")
    end
    if (!uvm_config_db#(virtual cache_if)::get(this, "", "i_cif", i_cif)) begin
      // check if interface is correctly set in testbench top level
      `uvm_fatal("Base/i_cif", "No virtual interface specified for this test instance")
    end
    if (!uvm_config_db#(virtual cache_if)::get(this, "", "l2_cif", l2_cif)) begin
      // check if interface is correctly set in testbench top level
      `uvm_fatal("Base/l2_cif", "No virtual interface specified for this test instance")
    end

    if (!uvm_config_db#(virtual generic_bus_if)::get(this, "", "d_cpu_bus_if", d_cpu_bus_if)) begin
      // check if interface is correctly set in testbench top level
      `uvm_fatal("Base/d_cpu_bus_if", "No virtual interface specified for this test instance")
    end
    if (!uvm_config_db#(virtual generic_bus_if)::get(this, "", "i_cpu_bus_if", i_cpu_bus_if)) begin
      // check if interface is correctly set in testbench top level
      `uvm_fatal("Base/i_cpu_bus_if", "No virtual interface specified for this test instance")
    end

    if (!uvm_config_db#(virtual generic_bus_if)::get(
            this, "", "d_l1_arb_bus_if", d_l1_arb_bus_if
        )) begin
      // check if interface is correctly set in testbench top level
      `uvm_fatal("Base/d_l1_arb_bus_if", "No virtual interface specified for this test instance")
    end
    if (!uvm_config_db#(virtual generic_bus_if)::get(
            this, "", "i_l1_arb_bus_if", i_l1_arb_bus_if
        )) begin
      // check if interface is correctly set in testbench top level
      `uvm_fatal("Base/i_l1_arb_bus_if", "No virtual interface specified for this test instance")
    end

    if (!uvm_config_db#(virtual generic_bus_if)::get(
            this, "", "arb_l2_bus_if", arb_l2_bus_if
        )) begin
      // check if interface is correctly set in testbench top level
      `uvm_fatal("Base/arb_l2_bus_if", "No virtual interface specified for this test instance")
    end

    if (!uvm_config_db#(virtual generic_bus_if)::get(this, "", "mem_bus_if", mem_bus_if)) begin
      // check if interface is correctly set in testbench top level
      `uvm_fatal("Base/mem_bus_if", "No virtual interface specified for this test instance")
    end

    // send the interfaces down
    //TODO: SHOULD I NARROW THE SCOPE OF THE ENV_CONFIG?
    uvm_config_db#(cache_env_config)::set(this, "*", "env_config", env_config);

    uvm_config_db#(virtual cache_if)::set(this, "env.agt*", "i_cif", i_cif);
    uvm_config_db#(virtual cache_if)::set(this, "env.agt*", "d_cif", d_cif);
    uvm_config_db#(virtual cache_if)::set(this, "env.agt*", "l2_cif", l2_cif);

    uvm_config_db#(virtual generic_bus_if)::set(this, "env.agt*", "d_cpu_bus_if", d_cpu_bus_if);
    uvm_config_db#(virtual generic_bus_if)::set(this, "env.agt*", "i_cpu_bus_if", i_cpu_bus_if);

    uvm_config_db#(virtual generic_bus_if)::set(this, "env.agt*", "d_l1_arb_bus_if",
                                                d_l1_arb_bus_if);
    uvm_config_db#(virtual generic_bus_if)::set(this, "env.agt*", "i_l1_arb_bus_if",
                                                i_l1_arb_bus_if);

    uvm_config_db#(virtual generic_bus_if)::set(this, "env.agt*", "arb_l2_bus_if", arb_l2_bus_if);

    uvm_config_db#(virtual generic_bus_if)::set(this, "env.agt*", "mem_bus_if", mem_bus_if);
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    phase.raise_objection(this, $sformatf("Starting <%s> in main phase", sequence_name));
    if (!seq.randomize() with {
          if (env_config.iterations > 0) {
            N == env_config.iterations;  //command line request for iterations
          } else {
            N inside {[20 : 100]};  //default number of memory accesses
          }
        }) begin
      `uvm_fatal("Randomize Error", "not able to randomize")
    end

`ifdef TB_L1_CONFIG
    seq.start(env.cpu_agt.sqr);
`endif

`ifdef TB_L2_CONFIG
    seq.start(env.mem_arb_agt.sqr);
`endif

`ifdef TB_FULL_CONFIG
    seq.start(env.d_cpu_agt.sqr);
`endif
    #5ns;
    phase.drop_objection(this, $sformatf("Finished <%s> in main phase", sequence_name));
  endtask

endclass : base_test

`endif
