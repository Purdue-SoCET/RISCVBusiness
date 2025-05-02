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
*   Filename:     nominal_sequence.svh
*
*   Created by:   Mitch Arndt
*   Email:        arndt20@purdue.edu
*   Date Created: 03/27/2022
*   Description:  Sequence that performs randomized read after writes
*/

`ifndef NOMINAL_SEQUENCE_SVH
`define NOMINAL_SEQUENCE_SVH

import uvm_pkg::*;
import rv32i_types_pkg::*;

`include "uvm_macros.svh"

`include "cpu_transaction.svh"
`include "base_sequence.svh"

class nominal_sequence extends base_sequence;
  `uvm_object_utils(nominal_sequence)
  function new(string name = "");
    super.new(name);
  endfunction : new

  task body();
    cpu_transaction req_item;
    int write_count;  // current number of writes
    word_t writes[word_t];  // queue of write addresses

    req_item = cpu_transaction::type_id::create("req_item");

    write_count = 0;

    `uvm_info(this.get_name(), $sformatf("Creating sequence with size N=%0d", N), UVM_LOW)

    repeat (N) begin
      start_item(req_item);

      if (!req_item.randomize() with {
            flush == 0;  //TODO: DO WE WANT ANY FLUSH SIGNALS IN NOMINAL OPPERATION?
            rw dist {
              1 := 1,
              0 := 1
            };  //force a 50/50 distribution of reads/writes
            if (write_count > N / 2) {
              //only reads allowed
              rw == 0;
            }
            if (rw == 0) {
              //read from previously written addr
              addr inside {writes};
            }
          }) begin
        `uvm_fatal("Randomize Error", "not able to randomize")
      end

      if (req_item.rw) begin
        // write
        write_count++;
        writes[req_item.addr] = req_item.addr;
      end else begin
        // read
        writes.delete(req_item.addr);
      end

      `uvm_info(this.get_name(), $sformatf("Generated New Sequence Item:\n%s", req_item.sprint()),
                UVM_HIGH)

      finish_item(req_item);
    end
  endtask : body
endclass : nominal_sequence

`endif
