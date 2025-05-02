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
*   Filename:     cpu_transaction.svh
*
*   Created by:   Mitch Arndt
*   Email:        arndt20@purdue.edu
*   Date Created: 03/27/2022
*   Description:  Abstracted memory request transaction
*/

`ifndef CPU_TRANSACTION_SVH
`define CPU_TRANSACTION_SVH

import uvm_pkg::*;
import rv32i_types_pkg::*;
`include "uvm_macros.svh"
`include "cache_env.svh"
`include "dut_params.svh"

class cpu_transaction extends uvm_sequence_item;

  rand bit rw;  // 0 -> read; 1 -> write
  rand word_t addr;
  rand word_t data;

  rand logic [3:0] byte_en;

  rand bit flush;
  //TODO: ADD CLEAR

  `uvm_object_utils_begin(cpu_transaction)
    `uvm_field_int(rw, UVM_ALL_ON)
    `uvm_field_int(addr, UVM_ALL_ON)
    `uvm_field_int(data, UVM_ALL_ON)
    `uvm_field_int(byte_en, UVM_ALL_ON)
    `uvm_field_int(flush, UVM_ALL_ON)
  `uvm_object_utils_end

  constraint valid_addr {
    addr >= '0;
    soft addr < `NONCACHE_START_ADDR;
    addr[1:0] == '0;
  }

  constraint usable_byte_en {
    byte_en inside {4'b0001, 4'b0010, 4'b0100, 4'b1000, 4'b0011, 4'b1100, 4'b1111};
  }

  function new(string name = "cpu_transaction");
    super.new(name);
  endfunction : new

endclass : cpu_transaction

`endif
