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
*   Filename:     flush_sequence.svh
*
*   Created by:   Mitch Arndt
*   Email:        arndt20@purdue.edu
*   Date Created: 04/18/2022
*   Description:  Sequence that performs randomized flush after read/write
*/

`ifndef FLUSH_SEQUENCE_SVH
`define FLUSH_SEQUENCE_SVH

import uvm_pkg::*;
import rv32i_types_pkg::*;

`include "uvm_macros.svh"

`include "cpu_transaction.svh"
`include "base_sequence.svh"

class flush_sequence extends base_sequence;
  `uvm_object_utils(flush_sequence)
  function new(string name = "");
    super.new(name);
  endfunction : new

  task body();
    cpu_transaction req_item;
    word_t accesses[word_t];  // queue of previous reads/writes
    word_t flushes[word_t];  // queue of previous flushed addresses that need to be checked

    req_item = cpu_transaction::type_id::create("req_item");

    `uvm_info(this.get_name(), $sformatf("Creating sequence with size N=%0d", N), UVM_LOW)

    repeat (N) begin
      start_item(req_item);

      if (!req_item.randomize() with {
            flush dist {
              1 := 25,
              0 := 75
            };  //force a 25%/75% distribution of flushes 
            rw dist {
              1 := 50,
              0 := 50
            };  //force a 50%/50% distribution of reads/writes

            if (flush == 1) {
              //flush from previously accessed addr
              addr inside {accesses};
            } else
            if (flushes.size() > 0) {addr inside {flushes};}
          }) begin
        `uvm_fatal("Randomize Error", "not able to randomize")
      end

      if (req_item.flush == 0) begin
        accesses[req_item.addr] = req_item.addr;

        if (flushes.exists(req_item.addr)) begin
          flushes.delete(req_item.addr);
        end
      end else begin
        // flush
        accesses.delete(req_item.addr);
        flushes[req_item.addr] = req_item.addr;
      end

      `uvm_info(this.get_name(), $sformatf("Generated New Sequence Item:\n%s", req_item.sprint()),
                UVM_HIGH)

      finish_item(req_item);
    end
  endtask : body
endclass : flush_sequence

`endif
