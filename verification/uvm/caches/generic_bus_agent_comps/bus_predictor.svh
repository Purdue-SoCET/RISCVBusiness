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
*   Filename:     bus_predictor.svh
*
*   Created by:   Mitch Arndt
*   Email:        arndt20@purdue.edu
*   Date Created: 03/27/2022
*   Description:  UVM subscriber class for predicting the operation of a generic_bus_if
*/

`ifndef BUS_PREDICTOR_SHV
`define BUS_PREDICTOR_SHV

import uvm_pkg::*;
import rv32i_types_pkg::*;

`include "uvm_macros.svh"
`include "cpu_transaction.svh"
`include "cache_model.svh"

class bus_predictor extends uvm_subscriber #(cpu_transaction);
  `uvm_component_utils(bus_predictor)

  uvm_analysis_port #(cpu_transaction) pred_ap;
  cpu_transaction pred_tx;

  cache_env_config env_config;

  cache_model cache;  //software cache

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);

    pred_ap = new("pred_ap", this);

    // get config from database
    if (!uvm_config_db#(cache_env_config)::get(this, "", "env_config", env_config)) begin
      `uvm_fatal(this.get_name(), "env config not registered to db")
    end

  endfunction

  function void write(cpu_transaction t);
    // t is the transaction sent from monitor
    pred_tx = cpu_transaction::type_id::create("pred_tx", this);
    pred_tx.copy(t);

    `uvm_info(this.get_name(), $sformatf("Recevied Transaction:\n%s", pred_tx.sprint()), UVM_HIGH)

    `uvm_info(this.get_name(), $sformatf("cache before:\n%s", cache.sprint()), UVM_HIGH)

    if (pred_tx.flush) begin
      pred_ap.write(pred_tx);  // flush doesn't return any data
      // don't update cache model because we need reads to return same data as was written
    end else begin
      // no cache flush
      if (pred_tx.rw) begin
        // 1 -> write
        if (pred_tx.addr < `NONCACHE_START_ADDR) begin
          if (cache.exists(pred_tx.addr)) begin
            cache.update(pred_tx.addr, pred_tx.data, pred_tx.byte_en);
          end else begin
            cache.insert(pred_tx.addr, pred_tx.data, pred_tx.byte_en);
          end
        end
      end else begin
        // 0 -> read
        if (pred_tx.addr < `NONCACHE_START_ADDR) begin
          // cache/cache responds
          pred_tx.data = cache.read(pred_tx.addr);
        end else begin
          // mmio responds
          pred_tx.data = {env_config.mmio_tag, pred_tx.addr[15:0]};
          `uvm_info(
              this.get_name(), $sformatf(
              "Reading from Memory Mapped Address Space, Defaulting to value <%h>", pred_tx.data),
              UVM_MEDIUM)
        end
      end
      // after prediction, the expected output send to the scoreboard 
      pred_ap.write(pred_tx);
    end

    `uvm_info(this.get_name(), $sformatf("cache after:\n%s", cache.sprint()), UVM_HIGH)
  endfunction : write

endclass : bus_predictor

`endif
