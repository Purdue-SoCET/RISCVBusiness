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
*   Filename:     end2end.svh
*
*   Created by:   Mitch Arndt
*   Email:        arndt20@purdue.edu
*   Date Created: 03/27/2022
*   Description:  UVM Component for ensuring proper translation between processor and memory side of the caches
*/

`ifndef END2END_SVH
`define END2END_SVH

import uvm_pkg::*;
import rv32i_types_pkg::*;

`include "uvm_macros.svh"
`include "dut_params.svh"
`include "cpu_transaction.svh"
`include "cache_model.svh"
`include "Utils.svh"

`uvm_analysis_imp_decl(_src_req)
`uvm_analysis_imp_decl(_src_resp)
`uvm_analysis_imp_decl(_dest_resp)

class end2end extends uvm_component;
  `uvm_component_utils(end2end)

  uvm_analysis_imp_src_req #(cpu_transaction, end2end) src_req_export;  // src's request
  uvm_analysis_imp_src_resp #(cpu_transaction, end2end) src_resp_export; // dest's response to src's request
  uvm_analysis_imp_dest_resp #(cpu_transaction, end2end) dest_resp_export;  // 

  cache_model cache;  // holds values currently stored in cache

  cpu_transaction history[$];  // holds recent mem bus transactions

  int successes, errors;  // records number of matches and mismatches

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
    src_req_export   = new("src_req_ap", this);
    src_resp_export  = new("src_resp_ap", this);
    dest_resp_export = new("dest_resp_ap", this);
  endfunction : new

  function void write_src_req(cpu_transaction t);
    cpu_transaction tx = cpu_transaction::type_id::create("src_req_tx", this);
    tx.copy(t);

    `uvm_info(this.get_name(), $sformatf("Detected CPU Request @%h", tx.addr), UVM_MEDIUM);

    if (history.size() > 0) begin
      flush_history();
    end
  endfunction : write_src_req

  function void write_src_resp(cpu_transaction t);
    cpu_transaction tx = cpu_transaction::type_id::create("src_resp_tx", this);
    tx.copy(t);

    `uvm_info(this.get_name(), $sformatf("Detected CPU Response @%h", tx.addr), UVM_MEDIUM);
    `uvm_info(this.get_name(), $sformatf("cache before:\n%s", cache.sprint()), UVM_HIGH)

    if (tx.flush) begin : FLUSH
      // flush request

      flush_history();  // takes care of any dirty data WBs from flush

      if (cache.dirty()) begin
        errors++;
        `uvm_error(this.get_name(), "Error: Cache Flush -> Cache Contains Dirty Data");
        `uvm_info(this.get_name(), $sformatf("%s", cache.sprint()), UVM_LOW);
      end else begin
        successes++;
        `uvm_info(this.get_name(), "Success: Cache Flush -> No Dirty Data", UVM_LOW);
      end

      cache.flush();  // flush all entries from cache model
    end : FLUSH
    else if (tx.addr < `NONCACHE_START_ADDR) begin : CACHEABLE
      // memory request
      if (history.size() == 0) begin : QUIET_MEM_BUS
        // quiet memory bus

        if (cache.exists(tx.addr)) begin
          // data is cached
          successes++;
          `uvm_info(this.get_name(), "Success: Cache Hit -> Quiet Mem Bus", UVM_LOW);
        end else begin
          // data not in cache
          errors++;
          `uvm_error(this.get_name(), "Error: Cache Miss -> Quiet Mem Bus");
        end
      end : QUIET_MEM_BUS
      else begin : ACTIVE_MEM_BUS
        // active memory bus
        if (cache.exists(tx.addr)) begin
          // data is already cached
          errors++;
          `uvm_error(this.get_name(), "Error: Cache Hit -> Active Mem Bus");
        end else begin
          // data not in cache, need to get data from memory
          flush_history();

          if (cache.exists(tx.addr)) begin
            successes++;
            `uvm_info(this.get_name(), "Success: Cache Miss -> Active Mem Bus", UVM_LOW);
          end else begin
            errors++;
            `uvm_error(this.get_name(),
                       "Error: Data Requested by CPU is not pressent in cache after mem bus txns");
          end
        end
      end : ACTIVE_MEM_BUS

      if (tx.rw) begin
        // update cache on PrWr
        cache.update(tx.addr, tx.data, tx.byte_en);
      end
    end : CACHEABLE
    else begin : MEM_MAPPED
      // memory mapped io request

      if (history.size() == 1) begin
        cpu_transaction mapped = history.pop_front();
        //FIXME:CHECK THAT THIS IS PROPER WAY TO DEAL WITH THIS
        if (!cache.ignore_mask & tx.rw) begin
          `uvm_info(this.get_name(), "Using Byte Mask for Memory Mapped Data", UVM_LOW);
          tx.data = Utils::byte_mask(tx.byte_en) & tx.data;
        end
        if (mapped.compare(tx)) begin
          successes++;
          `uvm_info(this.get_name(), "Success: Mem Mapped I/O Pass Through Match", UVM_LOW);
        end else begin
          errors++;
          `uvm_error(this.get_name(), "Error: Mem Mapped I/O Pass Through Mismatch");
          `uvm_info(this.get_name(), $sformatf(
                    "\ncpu req:\n%s\nmem bus:\n%s", tx.sprint(), mapped.sprint()), UVM_LOW)
        end
      end else begin
        errors++;
        `uvm_error(
            this.get_name(),
            $sformatf(
                "Error: Mem Mapped I/O Pass Through Transaction Size Mismatch: expected 1, actual %0d",
                history.size()));
      end
    end : MEM_MAPPED
  endfunction : write_src_resp

  function void write_dest_resp(cpu_transaction t);
    cpu_transaction tx = cpu_transaction::type_id::create("dest_resp_tx", this);
    tx.copy(t);

    `uvm_info(this.get_name(), $sformatf("Detected Memory Response:: addr=%h", tx.addr),
              UVM_MEDIUM);

    history.push_back(tx);
  endfunction : write_dest_resp

  function void report_phase(uvm_phase phase);
    `uvm_info(this.get_name(), $sformatf("Successes:    %0d", successes), UVM_LOW);
    `uvm_info(this.get_name(), $sformatf("Errors: %0d", errors), UVM_LOW);
  endfunction

  function void handle_mem_tx(cpu_transaction mem_tx);
    if (mem_tx.rw) begin
      // write
      // writes are cache evictions
      if (cache.remove(mem_tx.addr, mem_tx.data)) begin
        successes++;
        `uvm_info(this.get_name(), $sformatf("Word sucessfully removed from cache model: 0x%h",
                                             mem_tx.addr), UVM_LOW);
      end else begin
        errors++;
        `uvm_error(this.get_name(), $sformatf("Error when removing word from cache model: 0x%h",
                                              mem_tx.addr));
      end
    end else begin
      // read
      cache.insert(mem_tx.addr, mem_tx.data, mem_tx.byte_en);
    end
  endfunction : handle_mem_tx

  function void flush_history();
    int block_idx = 0;

    if (history.size() % `L1_BLOCK_SIZE != 0) begin
      errors++;
      `uvm_error(
          this.get_name(),
          $sformatf(
              "memory word requests do not match block size: requested %0d, not evenly divisible by: %0d",
              history.size(), `L1_BLOCK_SIZE));
    end

    while (history.size() > 0) begin
      cpu_transaction t = history.pop_front();
      handle_mem_tx(t);
      block_idx++;
      if (block_idx % `L1_BLOCK_SIZE == 0) begin
        // last word of block
        if (cache.is_valid_block(t.addr)) begin
          successes++;
          `uvm_info(this.get_name(), $sformatf("Valid block txn with memory: %h", t.addr), UVM_LOW);
        end else begin
          errors++;
          `uvm_error(this.get_name(),
                     $sformatf("Invalid word addresses for block txn with memory: %h", t.addr));
          `uvm_info(this.get_name(), $sformatf("%s", cache.sprint()), UVM_LOW);
        end
      end
    end
  endfunction : flush_history

endclass : end2end

`endif
