/*
*   Copyright 2016 Purdue University
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
*   Filename:     tb_page_perm_check.sv
*
*   Created by:   William Cunningham
*   Email:        wrcunnin@purdue.edu
*   Date Created: 2/4/2025
*   Description:  Testbench for page permission checks
*
*                 Test cases include (to be done initially with check off, then on):
*                 All:
*                 - Fault    -> Invalid page
*                 - Fault    -> Not readable, but writeable
*                 - Fault    -> Reserved bits are set
*                 - Fault    -> Level == 0 and no RWX bits are set
*                 - Fault    -> U = 1, in S-Mode, and mstatus.sum = 0
*                 - Fault    -> U = 0, in U-Mode
*                 - No Fault -> Level != 0, sv32 = 0, should NEVER EVER happen in RV32
*                 - Fault    -> Level != 0, sv32 = 1, pte_sv32.ppn[9:0] != 0
*                 - Fault    -> Access bit not set
*                 - No Fault -> U = 1, in S-Mode, and mstatus.sum = 1
*                 - No Fault -> U = 1, in U-Mode
*                 - No Fault -> Level != 0, sv32 = 1, pte_sv32.ppn[9:0] == 0
*                 Loads:
*                 - Fault    -> R = 0, W = 0, X = 0, mstatus.mxr = 0
*                 - Fault    -> R = 0, W = 0, X = 0, mstatus.mxr = 1
*                 - Fault    -> R = 0, W = 0, X = 1, mstatus.mxr = 0
*                 - No Fault -> R = 0, W = 0, X = 1, mstatus.mxr = 1
*                 - Fault    -> R = 0, W = 1, X = 0, mstatus.mxr = 0
*                 - Fault    -> R = 0, W = 1, X = 0, mstatus.mxr = 1
*                 - Fault    -> R = 0, W = 1, X = 1, mstatus.mxr = 0
*                 - Fault    -> R = 0, W = 1, X = 1, mstatus.mxr = 1
*                 - No Fault -> R = 1, W = 0, X = 0
*                 - No Fault -> R = 1, W = 0, X = 1
*                 - No Fault -> R = 1, W = 1, X = 0
*                 - No Fault -> R = 1, W = 1, X = 1
*                 Stores:
*                 - Fault    -> R = 0, W = 0, X = 0
*                 - Fault    -> R = 0, W = 0, X = 1
*                 - Fault    -> R = 0, W = 1, X = 0
*                 - Fault    -> R = 0, W = 1, X = 1
*                 - Fault    -> R = 1, W = 0, X = 0
*                 - Fault    -> R = 1, W = 0, X = 1
*                 - No Fault -> R = 1, W = 1, X = 0
*                 - No Fault -> R = 1, W = 1, X = 1
*                 - Fault    -> Dirty bit not set
*                 Instructions:
*                 - Fault    -> R = 0, W = 0, X = 0
*                 - No Fault -> R = 0, W = 0, X = 1
*                 - Fault    -> R = 0, W = 1, X = 0
*                 - Fault    -> R = 0, W = 1, X = 1
*                 - Fault    -> R = 1, W = 0, X = 0
*                 - No Fault -> R = 1, W = 0, X = 1
*                 - Fault    -> R = 1, W = 1, X = 0
*                 - No Fault -> R = 1, W = 1, X = 1
*/

`include "prv_pipeline_if.vh"
`include "address_translation_if.vh"

import rv32i_types_pkg::*;
import machine_mode_types_1_13_pkg::*;

`timescale 1ns/10ps

module tb_page_perm_check ();

logic CLK = 0;

// clock
always #(PERIOD/2) CLK++;

// inputs to page perm check
logic check;
logic [2:0] level;
access_t access;
pte_sv32_t pte_sv32;

// outputs from page perm check
logic fault_load_page, fault_store_page, fault_insn_page, leaf_pte;

// interfaces to page perm check
prv_pipeline_if        prv_pipe_if ();
address_translation_if at_if       ();

// DUT
page_perm_check DUT (.check(check),
                     .level(level),
                     .access(access),
                     .pte_sv32(pte_sv32),
                     .fault_load_page(fault_load_page),
                     .fault_store_page(fault_store_page),
                     .fault_insn_page(fault_insn_page),
                     .leaf_pte(leaf_pte),
                     .prv_pipe_if(prv_pipe_if),
                     .at_if(at_if));

test_page_perm_check PROG (.CLK(CLK),
           .check(check),
           .level(level),
           .access(access),
           .pte_sv32(pte_sv32),
           .fault_load_page(fault_load_page),
           .fault_store_page(fault_store_page),
           .fault_insn_page(fault_insn_page),
           .leaf_pte(leaf_pte),
           .prv_pipe_if(prv_pipe_if),
           .at_if(at_if));

// connect address translation signals
assign at_if.sv32 = prv_pipe_if.satp.mode == 1;
assign at_if.sv39 = 0; // prv_pipe_if.satp.mode == 8
assign at_if.sv48 = 0; // prv_pipe_if.satp.mode == 9
assign at_if.sv57 = 0; // prv_pipe_if.satp.mode == 10
assign at_if.sv64 = 0; // prv_pipe_if.satp.mode == 11
assign at_if.addr_trans_on = (at_if.sv32 | at_if.sv39 | at_if.sv48 | at_if.sv57 | at_if.sv64) && (prv_pipe_if.curr_privilege_level == S_MODE || prv_pipe_if.curr_privilege_level == U_MODE);

endmodule

program test_page_perm_check (
  input logic CLK, fault_load_page, fault_store_page, fault_insn_page, leaf_pte,
  output logic check,
  output logic [2:0] level,
  output access_t access,
  output pte_sv32_t pte_sv32,
  prv_pipeline_if prv_pipe_if,
  address_translation_if at_if
);

string test_type;
string test_case;

integer error_cnt;
logic error, error_load, error_store, error_insn;

initial begin : MAIN
  $dumpfile("waveform.fst");
  $dumpvars(0, tb_tlb_directmapped);

  // initialize all values
  reset_all();

  /**************************
  All:
  Fault -> Invalid page
  **************************/
  begin_test("All", "Fault -> Invalid page");

  // non test related inputs
  set_level('0);
  set_satp(1, '1, '1);
  set_priv_level(S_MODE);

  // test related inputs
  set_pte('1, PAGE_PERM_READ | PAGE_PERM_WRITE | PAGE_PERM_EXECUTE);

  // check outputs
  check_all_fault();

  complete_test();


  /**************************
  * Fault -> Not readable, but writeable
  **************************/
  begin_test("All", "Fault -> Not readable, but writeable");

  // non test related inputs
  set_level('0);
  set_satp(1, '1, '1);
  set_priv_level(S_MODE);

  // test related inputs
  set_pte('1, PAGE_PERM_WRITE | PAGE_PERM_VALID);

  // check outputs
  check_all_fault();

  complete_test();


  /**************************
  * Fault -> Reserved bits are set
  **************************/
  begin_test("All", "Fault -> Reserved bits are set");

  // non test related inputs
  set_level('0);
  set_satp(1, '1, '1);
  set_priv_level(S_MODE);

  // test rsw[0] set
  set_pte('1, RWXV_PERMS | PAGE_PERM_RSW_0);
  // check outputs
  check_all_fault();

  // test rsw[1] set
  set_pte('1, RWXV_PERMS | PAGE_PERM_RSW_1);
  // check outputs
  check_all_fault();

  // test rsw[1:0] set
  set_pte('1, RWXV_PERMS | PAGE_PERM_RSW_1 | PAGE_PERM_RSW_0);
  // check outputs
  check_all_fault();

  complete_test();


  /**************************
  * Fault -> Level == 0 and no RWX bits are set
  **************************/
  begin_test("All", "Fault -> Level == 0 and no RWX bits are set");

  // non test related inputs
  set_level('0);
  set_satp(1, '1, '1);
  set_priv_level(S_MODE);

  // test related inputs
  set_pte('1, PAGE_PERM_VALID);

  // check outputs
  check_all_fault();

  complete_test();



  /**************************
  * Fault -> U = 1, in S-Mode, and mstatus.sum = 0
  **************************/
  begin_test("All", "Fault -> U = 1, in S-Mode, and mstatus.sum = 0");

  // non test related inputs
  set_level('0);
  set_satp(1, '1, '1);
  set_priv_level(S_MODE);

  // test related inputs
  set_mstatus_sum(0);
  set_pte('1, RWXV_PERMS | PAGE_PERM_USER);

  // check outputs
  check_all_fault();

  complete_test();


  /**************************
  * Fault -> U = 0, in U-Mode
  **************************/
  begin_test("All", "Fault -> U = 0, in U-Mode");

  // non test related inputs
  set_level('0);
  set_satp(1, '1, '1);
  set_priv_level(U_MODE);

  // test related inputs
  set_mstatus_sum(0);
  set_pte('1, RWXV_PERMS);

  // check outputs
  check_all_fault();

  complete_test();


  /**************************
  * No Fault -> Level != 0, sv32 = 0, should NEVER EVER happen in RV32
  **************************/
  begin_test("All", "No Fault -> Level != 0, sv32 = 0, should NEVER EVER happen in RV32");

  // non test related inputs
  set_priv_level(S_MODE);

  // test related inputs
  set_level(1);
  set_satp(0, '1, '1);
  set_pte(22'b111111111000000000, RWXV_PERMS);

  // check outputs
  check_all_nofault();

  complete_test();


  /**************************
  * Fault -> Level != 0, sv32 = 1, pte_sv32.ppn[9:0] != 0
  **************************/
  begin_test("All", "Fault -> Level != 0, sv32 = 1, pte_sv32.ppn[9:0] != 0");

  // non test related inputs
  set_satp(1, '1, '1);
  set_priv_level(S_MODE);

  // test related inputs
  set_level(1);
  set_pte('1, RWXV_PERMS);

  // check outputs
  check_all_fault();

  complete_test();


  /**************************
  * Fault -> Access bit not set
  **************************/
  begin_test("All", "Fault -> Access bit not set");

  // non test related inputs
  set_level('0);
  set_satp(1, '1, '1);
  set_priv_level(S_MODE);

  // test related inputs
  set_pte('1, RWXV_PERMS, 0, 1);

  // check outputs
  check_all_fault();

  complete_test();


  /**************************
  * No Fault -> U = 1, in S-Mode, and mstatus.sum = 1
  **************************/
  begin_test("All", "No Fault -> U = 1, in S-Mode, and mstatus.sum = 1");

  // non test related inputs
  set_level('0);
  set_satp(1, '1, '1);
  set_priv_level(S_MODE);

  // test related inputs
  set_mstatus_sum(1);
  set_pte('1, RWXV_PERMS | PAGE_PERM_USER);

  // check outputs
  check_all_nofault();

  complete_test();


  /**************************
  * No Fault -> U = 1, in U-Mode
  **************************/
  begin_test("All", "No Fault -> U = 1, in U-Mode");

  // non test related inputs
  set_level('0);
  set_satp(1, '1, '1);
  set_priv_level(U_MODE);

  // test related inputs
  set_mstatus_sum(0);
  set_pte('1, RWXV_PERMS | PAGE_PERM_USER);

  // check outputs
  check_all_nofault();

  complete_test();


  /**************************
  * No Fault -> Level != 0, sv32 = 1, pte_sv32.ppn[9:0] == 0
  **************************/
  begin_test("All", "No Fault -> Level != 0, sv32 = 1, pte_sv32.ppn[9:0] == 0");

  // non test related inputs
  set_priv_level(S_MODE);

  // test related inputs
  set_level(1);
  set_satp(1, '1, '1);
  set_pte(22'b0011111111110000000000, RWXV_PERMS);

  // check outputs
  check_all_nofault();

  complete_test();


  /**************************
  * Loads:
  * Fault -> R = 0, W = 0, X = 0, mstatus.mxr = 0
  **************************/
  begin_test("Loads", "Fault -> R = 0, W = 0, X = 0, mstatus.mxr = 0");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_mstatus_mxr(0);
  set_pte('1, PAGE_PERM_VALID);

  // check outputs
  check_load_fault();

  complete_test();

  /**************************
  * Fault -> R = 0, W = 0, X = 0, mstatus.mxr = 1
  **************************/
  begin_test("Loads", "Fault -> R = 0, W = 0, X = 0, mstatus.mxr = 1");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_mstatus_mxr(1);
  set_pte('1, PAGE_PERM_VALID);

  // check outputs
  check_load_fault();

  complete_test();


  /**************************
  * Fault -> R = 0, W = 0, X = 1, mstatus.mxr = 0
  **************************/
  begin_test("Loads", "Fault -> R = 0, W = 0, X = 1, mstatus.mxr = 0");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_mstatus_mxr(0);
  set_pte('1, PAGE_PERM_VALID | PAGE_PERM_EXECUTE);

  // check outputs
  check_load_fault();

  complete_test();


  /**************************
  * No Fault -> R = 0, W = 0, X = 1, mstatus.mxr = 1
  **************************/
  begin_test("Loads", "Fault -> R = 0, W = 0, X = 1, mstatus.mxr = 1");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_mstatus_mxr(1);
  set_pte('1, PAGE_PERM_VALID | PAGE_PERM_EXECUTE);

  // check outputs
  check_load_nofault();

  complete_test();


  /**************************
  * Fault -> R = 0, W = 1, X = 0, mstatus.mxr = 0
  **************************/
  begin_test("Loads", "Fault -> R = 0, W = 1, X = 0, mstatus.mxr = 0");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_mstatus_mxr(0);
  set_pte('1, PAGE_PERM_VALID | PAGE_PERM_WRITE);

  // check outputs
  check_load_fault();

  complete_test();


  /**************************
  * Fault -> R = 0, W = 1, X = 0, mstatus.mxr = 1
  **************************/
  begin_test("Loads", "Fault -> R = 0, W = 1, X = 0, mstatus.mxr = 1");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_mstatus_mxr(1);
  set_pte('1, PAGE_PERM_VALID | PAGE_PERM_WRITE);

  // check outputs
  check_load_fault();

  complete_test();


  /**************************
  * Fault -> R = 0, W = 1, X = 1, mstatus.mxr = 0
  **************************/
  begin_test("Loads", "Fault -> R = 0, W = 1, X = 1, mstatus.mxr = 0");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_mstatus_mxr(0);
  set_pte('1, PAGE_PERM_VALID | PAGE_PERM_WRITE | PAGE_PERM_EXECUTE);

  // check outputs
  check_load_fault();

  complete_test();


  /**************************
  * Fault -> R = 0, W = 1, X = 1, mstatus.mxr = 1
  **************************/
  begin_test("Loads", "Fault -> R = 0, W = 1, X = 1, mstatus.mxr = 0");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_mstatus_mxr(1);
  set_pte('1, PAGE_PERM_VALID | PAGE_PERM_WRITE | PAGE_PERM_EXECUTE);

  // check outputs
  check_load_fault();

  complete_test();


  /**************************
  * No Fault -> R = 1, W = 0, X = 0
  **************************/
  begin_test("Loads", "No Fault -> R = 1, W = 0, X = 0");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_pte('1, PAGE_PERM_VALID | PAGE_PERM_READ);

  // check outputs
  check_load_nofault();

  complete_test();


  /**************************
  * No Fault -> R = 1, W = 0, X = 1
  **************************/
  begin_test("Loads", "No Fault -> R = 1, W = 0, X = 1");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_pte('1, PAGE_PERM_VALID | PAGE_PERM_READ | PAGE_PERM_EXECUTE);

  // check outputs
  check_load_nofault();

  complete_test();


  /**************************
  * No Fault -> R = 1, W = 1, X = 0
  **************************/
  begin_test("Loads", "No Fault -> R = 1, W = 1, X = 0");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_pte('1, PAGE_PERM_VALID | PAGE_PERM_READ | PAGE_PERM_WRITE);

  // check outputs
  check_load_nofault();

  complete_test();


  /**************************
  * No Fault -> R = 1, W = 1, X = 1
  **************************/
  begin_test("Loads", "No Fault -> R = 1, W = 1, X = 1");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_pte('1, PAGE_PERM_VALID | PAGE_PERM_READ | PAGE_PERM_WRITE | PAGE_PERM_EXECUTE);

  // check outputs
  check_load_nofault();

  complete_test();


  /**************************
  * Stores:
  * Fault -> R = 0, W = 0, X = 0
  **************************/
  begin_test("Stores", "Fault -> R = 0, W = 0, X = 0");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_pte('1, PAGE_PERM_VALID);

  // check outputs
  check_store_fault();

  complete_test();


  /**************************
  * Fault -> R = 0, W = 0, X = 1
  **************************/
  begin_test("Stores", "Fault -> R = 0, W = 0, X = 1");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_pte('1, PAGE_PERM_VALID | PAGE_PERM_EXECUTE);

  // check outputs
  check_store_fault();

  complete_test();


  /**************************
  * Fault -> R = 0, W = 1, X = 0
  **************************/
  begin_test("Stores", "Fault -> R = 0, W = 1, X = 0");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_pte('1, PAGE_PERM_VALID | PAGE_PERM_WRITE);

  // check outputs
  check_store_fault();

  complete_test();


  /**************************
  * Fault -> R = 0, W = 1, X = 1
  **************************/
  begin_test("Stores", "Fault -> R = 0, W = 1, X = 1");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_pte('1, PAGE_PERM_VALID | PAGE_PERM_WRITE | PAGE_PERM_EXECUTE);

  // check outputs
  check_store_fault();

  complete_test();


  /**************************
  * Fault -> R = 1, W = 0, X = 0
  **************************/
  begin_test("Stores", "Fault -> R = 1, W = 0, X = 0");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_pte('1, PAGE_PERM_VALID | PAGE_PERM_READ);

  // check outputs
  check_store_fault();

  complete_test();


  /**************************
  * Fault -> R = 1, W = 0, X = 1
  **************************/
  begin_test("Stores", "Fault -> R = 1, W = 0, X = 1");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_pte('1, PAGE_PERM_VALID | PAGE_PERM_READ | PAGE_PERM_EXECUTE);

  // check outputs
  check_store_fault();

  complete_test();


  /**************************
  * No Fault -> R = 1, W = 1, X = 0
  **************************/
  begin_test("Stores", "No Fault -> R = 1, W = 1, X = 0");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_pte('1, PAGE_PERM_VALID | PAGE_PERM_READ | PAGE_PERM_WRITE);

  // check outputs
  check_store_nofault();

  complete_test();


  /**************************
  * No Fault -> R = 1, W = 1, X = 1
  **************************/
  begin_test("Stores", "No Fault -> R = 1, W = 1, X = 1");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_pte('1, PAGE_PERM_VALID | PAGE_PERM_READ | PAGE_PERM_WRITE | PAGE_PERM_EXECUTE);

  // check outputs
  check_store_nofault();

  complete_test();


  /**************************
  * Fault -> Dirty bit not set
  **************************/
  begin_test("Stores", "Fault -> Dirty bit not set");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_pte('1, PAGE_PERM_VALID | PAGE_PERM_READ | PAGE_PERM_WRITE | PAGE_PERM_EXECUTE, 1, 0);

  // check outputs
  check_store_fault();

  complete_test();


  /**************************
  * Instructions:
  * Fault -> R = 0, W = 0, X = 0
  **************************/
  begin_test("Instructions", "Fault -> R = 0, W = 0, X = 0");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_pte('1, PAGE_PERM_VALID);

  // check outputs
  check_insn_fault();

  complete_test();


  /**************************
  * No Fault -> R = 0, W = 0, X = 1
  **************************/
  begin_test("Instructions", "No Fault -> R = 0, W = 0, X = 1");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_pte('1, PAGE_PERM_VALID | PAGE_PERM_EXECUTE);

  // check outputs
  check_insn_nofault();

  complete_test();


  /**************************
  * Fault -> R = 0, W = 1, X = 0
  **************************/
  begin_test("Instructions", "Fault -> R = 0, W = 1, X = 0");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_pte('1, PAGE_PERM_VALID | PAGE_PERM_WRITE);

  // check outputs
  check_insn_fault();

  complete_test();


  /***************************
  * Fault -> R = 0, W = 1, X = 1
  **************************/
  begin_test("Instructions", "Fault -> R = 0, W = 1, X = 1");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_pte('1, PAGE_PERM_VALID | PAGE_PERM_WRITE | PAGE_PERM_EXECUTE);

  // check outputs
  check_insn_fault();

  complete_test();


  /**************************
  * Fault -> R = 1, W = 0, X = 0
  **************************/
  begin_test("Instructions", "Fault -> R = 1, W = 0, X = 0");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_pte('1, PAGE_PERM_VALID | PAGE_PERM_READ);

  // check outputs
  check_insn_fault();

  complete_test();


  /**************************
  * No Fault -> R = 1, W = 0, X = 1
  **************************/
  begin_test("Instructions", "No Fault -> R = 1, W = 0, X = 1");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_pte('1, PAGE_PERM_VALID | PAGE_PERM_READ | PAGE_PERM_EXECUTE);

  // check outputs
  check_insn_nofault();

  complete_test();


  /**************************
  * Fault -> R = 1, W = 1, X = 0
  **************************/
  begin_test("Instructions", "Fault -> R = 1, W = 1, X = 0");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_pte('1, PAGE_PERM_VALID | PAGE_PERM_READ | PAGE_PERM_WRITE);

  // check outputs
  check_insn_fault();

  complete_test();


  /**************************
  * No Fault -> R = 1, W = 1, X = 1
  **************************/
  begin_test("Instructions", "No Fault -> R = 1, W = 1, X = 1");

  // non test related inputs
  set_priv_level(S_MODE);
  set_level(0);
  set_satp(1, '1, '1);

  // test related inputs
  set_pte('1, PAGE_PERM_VALID | PAGE_PERM_READ | PAGE_PERM_WRITE | PAGE_PERM_EXECUTE);

  // check outputs
  check_insn_nofault();

  complete_test();


  $display("\n---------- Testing Completed ---------\n");

  if (error_cnt == 0) begin
    $display("\nAll tests passed!\n");
  end else begin
    $display("\nTests Failed: %0d\n", error_cnt);
  end

  $finish;

end

task begin_test;
  input string new_test_type;
  input string new_test_case;
  test_type = new_test_type;
  test_case = new_test_case;
  $display("\n---------- %s: %s ---------\n", test_type, test_case);
endtask

task complete_test;
  reset_all();
  // $display("--------------------------------------------------\n");
  // $fflush(); // unfortunately does not work with v-rilator
endtask

task set_check;
  input logic new_check;
  check = new_check;
endtask

task set_level;
  input logic [2:0] new_level;
  level = new_level;
endtask

task set_access;
  input access_t new_access;
  access = new_access;
endtask

task set_pte (
  input logic [SV32_PPNLEN-1:0] new_ppn,
  input logic [9:0]             new_perms,
  input logic set_accessed = 1,
  input logic set_dirty = 1
);
  
  pte_sv32.ppn = new_ppn;
  pte_sv32.perms = pte_perms_t'(new_perms | (set_accessed ? PAGE_PERM_ACCESSED : 0) | (set_dirty ? PAGE_PERM_DIRTY : 0));
endtask

task set_priv_level;
  input priv_level_t new_priv_level;
  prv_pipe_if.curr_privilege_level = new_priv_level;
endtask

task set_satp;
  input logic new_mode;
  input logic [ASID_LENGTH-1:0] new_asid;
  input logic [PPNLEN-1:0] new_ppn;
  prv_pipe_if.satp.mode = new_mode;
  prv_pipe_if.satp.asid = new_asid;
  prv_pipe_if.satp.ppn  = new_ppn;
endtask

task set_mstatus_sum;
  input logic new_sum;
  prv_pipe_if.mstatus.sum = new_sum;
endtask

task set_mstatus_mxr;
  input logic new_mxr;
  prv_pipe_if.mstatus.mxr = new_mxr;
endtask

task check_outputs;
  input logic expected_load_fault, expected_store_fault, expected_insn_fault;

  error = 0;
  error_load = 0;
  error_store = 0;
  error_insn = 0;

  // sanity check, making sure check signal works!
  assert(fault_load_page == 0);
  assert(fault_store_page == 0);
  assert(fault_insn_page == 0);

  // set check high and go a clock signal
  set_check(1);
  @(posedge CLK);

  if (expected_load_fault != fault_load_page) begin
    error_cnt++;
    error_load = 1;
    $display("Incorrect value for fault_load_page: expected %0d, received %d", expected_load_fault, fault_load_page);
  end

  if (expected_store_fault != fault_store_page) begin
    error_cnt++;
    error_store = 1;
    $display("Incorrect value for fault_store_page: expected %0d, received %d", expected_store_fault, fault_store_page);
  end

  if (expected_insn_fault != fault_insn_page) begin
    error_cnt++;
    error_insn = 1;
    $display("Incorrect value for fault_insn_page: expected %0d, received %d", expected_insn_fault, fault_insn_page);
  end

  error = error_load | error_store | error_insn;

  // set check low and go a clock signal
  set_check(0);
  @(posedge CLK);
  error = 0;
  error_load = 0;
  error_store = 0;
  error_insn = 0;
endtask

task check_all_fault;
  // test loads
  check_load_fault();
  
  // test stores
  check_store_fault();
  
  // test instructions
  check_insn_fault();
endtask

task check_load_fault;
  // test loads
  set_access(ACCESS_LOAD);
  check_outputs(1, 0, 0);
endtask

task check_store_fault;
  // test stores
  set_access(ACCESS_STORE);
  check_outputs(0, 1, 0);
endtask

task check_insn_fault;
  // test instructions
  set_access(ACCESS_INSN);
  check_outputs(0, 0, 1);
endtask

task check_all_nofault;
  // test loads
  check_load_nofault();
  
  // test stores
  check_store_nofault();
  
  // test instructions
  check_insn_nofault();
endtask

task check_load_nofault;
  // test loads
  set_access(ACCESS_LOAD);
  check_outputs(0, 0, 0);
endtask

task check_store_nofault;
  // test stores
  set_access(ACCESS_STORE);
  check_outputs(0, 0, 0);
endtask

task check_insn_nofault;
  // test instructions
  set_access(ACCESS_INSN);
  check_outputs(0, 0, 0);
endtask

task reset_all;
  set_level('0);
  set_satp(0, '0, '0);
  set_priv_level(M_MODE);
  set_mstatus_sum(0);
  set_mstatus_mxr(0);
  set_access(ACCESS_NONE);
  set_pte('0, '0);
  set_check(0);
endtask

endprogram