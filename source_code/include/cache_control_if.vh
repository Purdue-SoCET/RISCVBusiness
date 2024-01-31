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
*   Filename:     cache_control_if.vh
*   
*   Created by:   John Skubic	
*   Email:        jjs.skubic@gmail.com
*   Date Created: 06/29/2017
*   Description:  Interface between the Pipeline, caches, and memory system
*                 Any actions that control the cache are relayed through this if.
*                 Events that may cause activity on this interface:
*                   - Memory Fences
*                   - Coherence Operations 
*/

`ifndef CACHE_CONTROL_IF_VH
`define CACHE_CONTROL_IF_VH

`include "bus_ctrl_if.vh"

interface cache_control_if;

  logic icache_clear, icache_flush, iclear_done, iflush_done;
  logic dcache_clear, dcache_flush, dclear_done, dflush_done;
  // Used to signal that instruction depends on state of reservation set.
  // Reservation should always be lost after this goes high.
  logic dcache_reserve;
  // Used to signal that cache line should be locked.
  logic dcache_exclusive;

  // Cache coherency signals for MESI, taken from bus_ctrl_if
  // L1 generic control signals
  logic               [CPUS-1:0] dREN, dWEN, dwait; 
  transfer_width_t    [CPUS-1:0] dload, dstore, snoop_dstore, driver_dstore;
  bus_word_t          [CPUS-1:0] daddr;
  // L1 coherence INPUTS to bus 
  logic               [CPUS-1:0] cctrans;     // indicates that the requester is undergoing a miss
  logic               [CPUS-1:0] ccwrite;     // indicates that the requester is attempting to go to M
  logic               [CPUS-1:0] ccsnoophit;  // indicates that the responder has the data
  logic               [CPUS-1:0] ccsnoopdone; // indicates that the responder has the data
  logic               [CPUS-1:0] ccIsPresent; // indicates that nonrequesters have the data valid
  logic               [CPUS-1:0] ccdirty;     // indicates that we have [I -> S, M -> S]
  // L1 coherence OUTPUTS
  logic               [CPUS-1:0] ccwait;      // indicates a potential snoophit wait request
  logic               [CPUS-1:0] ccinv;       // indicates an invalidation request
  logic               [CPUS-1:0] ccexclusive; // indicates an exclusivity update
  bus_word_t          [CPUS-1:0] ccsnoopaddr; 
  // L2 signals
  l2_state_t l2state; 
  transfer_width_t l2load, l2store; 
  logic l2WEN, l2REN; 
  bus_word_t l2addr; 





  modport pipeline (
    output icache_clear, icache_flush, dcache_clear, dcache_flush, dcache_reserve, dcache_exclusive,
    input iclear_done, iflush_done, dclear_done, dflush_done
  );

  modport caches (
    input icache_clear, icache_flush, dcache_clear, dcache_flush, dcache_reserve, dcache_exclusive,
    output iclear_done, iflush_done, dclear_done, dflush_done
  );
  
  modport icache (
    input icache_clear, icache_flush,
    output iclear_done, iflush_done
  );

  modport dcache ( 
    input dcache_clear, dcache_flush, dcache_reserve, dcache_exclusive,
    output dclear_done, dflush_done,

    //Inserted from bus_ctrl_if.tb modport
    input   dwait, dload, 
            ccwait, ccinv, ccsnoopaddr, ccexclusive, 
            l2addr, l2store, l2REN, l2WEN,

    output  dREN, dWEN, daddr, dstore, 
            cctrans, ccwrite, ccsnoophit, ccIsPresent, ccdirty, ccsnoopdone,
            l2load, l2state
  );

endinterface
`endif //CACHE_CONTROL_IF
