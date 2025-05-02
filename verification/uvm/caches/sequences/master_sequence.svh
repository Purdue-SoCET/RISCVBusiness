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
*   Filename:     master_sequence.svh
*
*   Created by:   Mitch Arndt
*   Email:        arndt20@purdue.edu
*   Date Created: 03/27/2022
*   Description:  Sequence that randomly interleaves all other sequences
*/

`ifndef MASTER_SEQUENCE_SVH
`define MASTER_SEQUENCE_SVH

import uvm_pkg::*;
import rv32i_types_pkg::*;

`include "uvm_macros.svh"

`include "dut_params.svh"

`include "nominal_sequence.svh"
`include "index_sequence.svh"
`include "evict_sequence.svh"
`include "mmio_sequence.svh"
`include "flush_sequence.svh"
`include "base_sequence.svh"

`include "cpu_transaction.svh"


class bounds;
  rand int upper;
  int lower;

  constraint ub {upper > lower;}

  function new(int _lower);
    lower = _lower;
  endfunction : new

  function string sprint();
    return $sformatf("(%0d, %0d)", lower, upper);
  endfunction : sprint
endclass : bounds

class sub_master_sequence;
  rand bounds nom_bounds;
  rand bounds evt_bounds;
  rand bounds idx_bounds;
  rand bounds mmio_bounds;
  rand bounds flush_bounds;

  constraint nom {nom_bounds.upper < 10;}
  constraint evt {evt_bounds.upper < 10;}
  constraint idx {idx_bounds.upper < 10;}
  constraint mmio {mmio_bounds.upper < 10;}
  constraint flush {flush_bounds.upper < 10;}

  function new();
    nom_bounds   = new(1);
    evt_bounds   = new(`L1_ASSOC + 1);
    idx_bounds   = new(`L1_BLOCK_SIZE);
    mmio_bounds  = new(1);
    flush_bounds = new(1);
  endfunction : new

  function void show();
    `uvm_info(
        "sub_master_seq",
        $sformatf(
            "evt_bounds: %s, idx_bounds: %s, nom_bounds: %s, mmio_bounds: %s, flush_bounds: %s",
            evt_bounds.sprint(), idx_bounds.sprint(), nom_bounds.sprint(), mmio_bounds.sprint(),
            flush_bounds.sprint()), UVM_LOW);
  endfunction
endclass : sub_master_sequence

class master_sequence extends base_sequence;
  `uvm_object_utils(master_sequence)
  `uvm_declare_p_sequencer(cpu_sequencer)

  sub_master_sequence seq_param;

  nominal_sequence nom_seq;
  index_sequence idx_seq;
  evict_sequence evt_seq;
  mmio_sequence mmio_seq;
  flush_sequence flush_seq;

  function new(string name = "");
    super.new(name);
    nom_seq   = nominal_sequence::type_id::create("nom_seq");
    idx_seq   = index_sequence::type_id::create("idx_seq");
    evt_seq   = evict_sequence::type_id::create("evt_seq");
    mmio_seq  = mmio_sequence::type_id::create("mmio_seq");
    flush_seq = flush_sequence::type_id::create("flush_seq");
    seq_param = new();
  endfunction : new

  function void sub_randomize();
    //randomize sub-sequences
    if (!nom_seq.randomize() with {
          N inside {[seq_param.nom_bounds.lower : seq_param.nom_bounds.upper]};
        }) begin
      `uvm_fatal("Randomize Error", "not able to randomize")
    end

    if (!idx_seq.randomize() with {
          N inside {[seq_param.idx_bounds.lower : seq_param.idx_bounds.upper]};
        }) begin
      `uvm_fatal("Randomize Error", "not able to randomize")
    end

    if (!evt_seq.randomize() with {
          N inside {[seq_param.evt_bounds.lower : seq_param.evt_bounds.upper]};
        }) begin
      `uvm_fatal("Randomize Error", "not able to randomize")
    end

    if (!mmio_seq.randomize() with {
          N inside {[seq_param.mmio_bounds.lower : seq_param.mmio_bounds.upper]};
        }) begin
      `uvm_fatal("Randomize Error", "not able to randomize")
    end

    if (!flush_seq.randomize() with {
          N inside {[seq_param.flush_bounds.lower : seq_param.flush_bounds.upper]};
        }) begin
      `uvm_fatal("Randomize Error", "not able to randomize")
    end
  endfunction

  task body();
    cpu_transaction req_item;
    base_sequence   seq_list [$];
    seq_list.push_back(nom_seq);
    seq_list.push_back(idx_seq);
    seq_list.push_back(evt_seq);
    seq_list.push_back(mmio_seq);
    seq_list.push_back(flush_seq);

    `uvm_info(this.get_name(), $sformatf("running %0d iterations", N), UVM_LOW)

    while (N > 0) begin
      if (!seq_param.randomize()) begin
        `uvm_fatal("Randomize Error", "not able to randomize")
      end
      seq_param.show();  // display sequence parameters
      sub_randomize();  // randomize sub sequences

      seq_list.shuffle();  // reorder list elements to get random ordering

      for (int i = 0; i < seq_list.size(); i++) begin
        seq_list[i].start(p_sequencer);
        N -= seq_list[i].N;
      end
    end
  endtask : body
endclass : master_sequence

`endif
