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
*   Filename:     base_sequence.svh
*
*   Created by:   Mitch Arndt
*   Email:        arndt20@purdue.edu
*   Date Created: 04/03/2022
*   Description:  Base sequence class to abstract N for random sequencing
*/

`ifndef BASE_SEQUENCE_SVH
`define BASE_SEQUENCE_SVH

import uvm_pkg::*;
import rv32i_types_pkg::*;

`include "uvm_macros.svh"

`include "cpu_transaction.svh"

/** Sequence to test read after writes to the same location */
class base_sequence extends uvm_sequence #(cpu_transaction);
  `uvm_object_utils(base_sequence)
  function new(string name = "");
    super.new(name);
  endfunction : new

  rand int N;  // total number of processor side transactions

endclass : base_sequence
`endif
