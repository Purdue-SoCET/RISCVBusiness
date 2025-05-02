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
*   Filename:     evict_sequence.svh
*
*   Created by:   Mitch Arndt
*   Email:        arndt20@purdue.edu
*   Date Created: 03/27/2022
*   Description:  Sequence of addresses which map to the same cache frame, forcing a cache eviction
*/

`ifndef EVICT_SEQUENCE_SVH
`define EVICT_SEQUENCE_SVH

import uvm_pkg::*;
import rv32i_types_pkg::*;

`include "uvm_macros.svh"
`include "cpu_transaction.svh"
`include "dut_params.svh"
`include "base_sequence.svh"

class evict_sequence extends base_sequence;
  `uvm_object_utils(evict_sequence)

  function new(string name = "");
    super.new(name);
  endfunction : new

  task body();
    cpu_transaction req_item;
    int N_reps; // used to back calculate proper repetitions to used when combined with inner for loop
    logic [`L1_INDEX_BITS-1:0] index;

    req_item = cpu_transaction::type_id::create("req_item");

    N_reps   = N / (`L1_ASSOC + 1);

    `uvm_info(this.get_name(), $sformatf("Requested size: %0d; Creating sequence with size N=%0d",
                                         N, N_reps * (`L1_ASSOC + 1)), UVM_LOW)

    if (N_reps <= 0) begin
      `uvm_fatal(this.get_name(),
                 $sformatf(
                     "Invalid Sequence Size: N must be at least %0d to trigger an eviction event",
                     (`L1_ASSOC + 1)))
    end

    repeat (N_reps) begin
      for (int i = 0; i < `L1_ASSOC + 1; i++) begin
        start_item(req_item);
        if (!req_item.randomize() with {
              flush == 0;  //TODO: DO WE WANT ANY FLUSH SIGNALS?
              if (i != 0) {addr[`L1_INDEX_BITS-1:0] == index;}
              rw == '1;
            }) begin
          `uvm_fatal("Randomize Error", "not able to randomize")
        end
        index = req_item.addr[`L1_INDEX_BITS:0];

        `uvm_info(this.get_name(), $sformatf("Generated New Sequence Item:\n%s", req_item.sprint()),
                  UVM_HIGH)

        finish_item(req_item);
      end
    end
  endtask : body
endclass : evict_sequence

`endif
