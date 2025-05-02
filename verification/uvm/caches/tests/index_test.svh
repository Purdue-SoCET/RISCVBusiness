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
*   Filename:     index_test.svh
*
*   Created by:   Mitch Arndt
*   Email:        arndt20@purdue.edu
*   Date Created: 03/27/2022
*   Description:  UVM Test for index_sequence
*/

`ifndef INDEX_TEST_SVH
`define INDEX_TEST_SVH

import uvm_pkg::*;
`include "base_test.svh"
`include "uvm_macros.svh"
`include "index_sequence.svh"

class index_test extends base_test #(index_sequence, "INDEX_SEQ");
  `uvm_component_utils(index_test)

  function new(string name = "", uvm_component parent);
    super.new(name, parent);
  endfunction : new

endclass : index_test

`endif
