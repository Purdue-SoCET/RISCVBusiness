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
*   Filename:     index_sequence.svh
*
*   Created by:   Mitch Arndt
*   Email:        arndt20@purdue.edu
*   Date Created: 03/27/2022
*   Description:  Sequence that reads/writes to the same cache block to ensure proper word indexing inside a block
*/

`ifndef INDEX_SEQUENCE_SVH
`define INDEX_SEQUENCE_SVH

import uvm_pkg::*;
import rv32i_types_pkg::*;

`include "uvm_macros.svh"
`include "cpu_transaction.svh"
`include "dut_params.svh"
`include "base_sequence.svh"

class index_sequence extends base_sequence;
  `uvm_object_utils(index_sequence)

  function new(string name = "");
    super.new(name);
  endfunction : new

  task body();
    cpu_transaction req_item;
    int N_reps; // used to back calculate proper repetitions to used when combined with inner for loop

    logic [`L1_ADDR_IDX_SIZE-1:0] index;
    word_t block_words[word_t];

    req_item = cpu_transaction::type_id::create("req_item");

    N_reps   = N / (`L1_BLOCK_SIZE);

    `uvm_info(this.get_name(), $sformatf("Requested size: %0d; Creating sequence with size N=%0d",
                                         N, N_reps * (`L1_BLOCK_SIZE)), UVM_LOW)

    if (N_reps <= 0) begin
      `uvm_fatal(this.get_name(),
                 $sformatf(
                     "Invalid Sequence Size: N must be at least %0d to touch all words of a block",
                     (`L1_BLOCK_SIZE)))
    end

    repeat (N_reps) begin
      for (int i = 0; i < `L1_BLOCK_SIZE; i++) begin
        start_item(req_item);
        if (!req_item.randomize() with {
              flush == 0;  //TODO: DO WE WANT ANY FLUSH SIGNALS?
              if (i != 0) {
                // first iteration is completely random txn
                addr[31:`L1_ADDR_IDX_END] == index;
                addr inside {block_words};
              }
            }) begin
          `uvm_fatal("Randomize Error", "not able to randomize")
        end
        index = req_item.addr[31:`L1_ADDR_IDX_END];

        if (i == 0) begin
          // initialize block words arrays
          for (int j = 0; j < `L1_BLOCK_SIZE * 4; j += 4) begin
            word_t temp = {index, j[`L1_ADDR_IDX_END-1:0]};
            block_words[temp] = temp;
          end
        end

        block_words.delete(req_item.addr);  // remove from list of addresses to r/w

        `uvm_info(this.get_name(), $sformatf("Generated New Sequence Item:\n%s", req_item.sprint()),
                  UVM_HIGH)

        finish_item(req_item);
      end
    end
  endtask : body
endclass : index_sequence

`endif
