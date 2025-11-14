/*
*	Copyright 2022 Purdue University
*		
*	Licensed under the Apache License, Version 2.0 (the "License");
*	you may not use this file except in compliance with the License.
*	You may obtain a copy of the License at
*		
*	    http://www.apache.org/licenses/LICENSE-2.0
*		
*	Unless required by applicable law or agreed to in writing, software
*	distributed under the License is distributed on an "AS IS" BASIS,
*	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*	See the License for the specific language governing permissions and
*	limitations under the License.
*
*
*	Filename:     bus_ctrl_if.vh
*
*	Created by:   Jimmy Mingze Jin
*	Email:        jin357@purdue.edu
*	Date Created: 10/31/2022
*	Description:  Bus controller connections
*/

`ifndef BUS_CTRL_IF_VH
`define BUS_CTRL_IF_VH

`include "component_selection_defines.vh"

// parameters
parameter CPUS = NUM_HARTS * 2;
parameter BLOCK_SIZE = DCACHE_BLOCK_SIZE > ICACHE_BLOCK_SIZE ? DCACHE_BLOCK_SIZE : ICACHE_BLOCK_SIZE;
localparam DATA_WIDTH = 32 * BLOCK_SIZE; // 64 bit/clk memory bandwidth

// coherence bus controller states
typedef enum {
    GRANT_R, GRANT_RX, GRANT_EVICT, GRANT_INV,
    IDLE,               // determines if a request is going on
    SNOOP_R,            // sends a snoop based on busRD
    SNOOP_RX,           // sends a snoop based on busRDX
    SNOOP_INV,          // sends a invalidation request to all cores
    TRANSFER_R,         // provides cache to bus transfer
    TRANSFER_RX,        // provides cache to bus transfer, only when promoting to modified
    READ_L2,            // reads from l2 to bus
    BUS_TO_CACHE,       // finishes transaction by providing from bus to cache
    WRITEBACK,          // evicts cache entry to L2
    WRITEBACK_MS,       // evicts cache entry to L2 and sets some signals for L1
    INVALIDATE          // invalidates non requester entries and updates requester S -> M
} bus_state_t;

/*
* dummy l2 states
* FREE -> IDLE
* BUSY -> IN TRANSITIONS
* ACCESS -> HIT
* ERROR -> yikes
*/
typedef enum logic [1:0] {
    L2_FREE, L2_BUSY, L2_ACCESS, L2_ERROR
} l2_state_t;

// taken from coherence_ctrl_if.vh
typedef logic [31:0] bus_word_t;
typedef logic [DATA_WIDTH-1:0] transfer_width_t;

interface front_side_bus_if();
    logic            dREN, dWEN, dwait, derror;
    transfer_width_t dload, dstore, snoop_dstore, driver_dstore;
    bus_word_t       daddr;
    logic [3:0]      dbyte_en;
    // L1 coherence INPUTS to bus
    logic            ccwrite;     // indicates that the requester is attempting to go to M
    logic            ccsnoophit;  // indicates that the responder has the data
    logic            ccsnoopdone; // indicates that the responder has the data
    logic            ccdirty;     // indicates that we have [I -> S, M -> S]
    // L1 coherence OUTPUTS
    logic            ccwait;      // indicates a potential snoophit wait request
    logic            ccinv;       // indicates an invalidation request
    logic            ccexclusive; // indicates an exclusivity update
    bus_word_t       ccsnoopaddr;
    logic            ccabort;

    modport cache(
        input dwait, dload, derror, ccwait, ccinv, ccsnoopaddr, ccexclusive,
        output dREN, dWEN, daddr, dstore, dbyte_en, ccwrite, ccsnoophit, ccdirty, ccsnoopdone
    );
endinterface

interface back_side_bus_if#(
    parameter int CPUS
)();
    // L1 generic control signals
    logic               [CPUS-1:0] dREN, dWEN, dwait, derror;
    transfer_width_t    [CPUS-1:0] dload, dstore, snoop_dstore, driver_dstore;
    bus_word_t          [CPUS-1:0] daddr;
    logic         [CPUS-1:0] [3:0] dbyte_en;
    // L1 coherence INPUTS to bus
    logic               [CPUS-1:0] ccwrite;     // indicates that the requester is attempting to go to M
    logic               [CPUS-1:0] ccsnoophit;  // indicates that the responder has the data
    logic               [CPUS-1:0] ccsnoopdone; // indicates that the responder has the data
    logic               [CPUS-1:0] ccdirty;     // indicates that we have [I -> S, M -> S]
    // L1 coherence OUTPUTS
    logic               [CPUS-1:0] ccwait;      // indicates a potential snoophit wait request
    logic               [CPUS-1:0] ccinv;       // indicates an invalidation request
    logic               [CPUS-1:0] ccexclusive; // indicates an exclusivity update
    bus_word_t          [CPUS-1:0] ccsnoopaddr;
    // L2 signals
    l2_state_t l2state;
    bus_word_t l2load, l2store;
    logic l2WEN, l2REN, l2error;
    bus_word_t l2addr; 
    logic [3:0] l2_byte_en;
    // Core outputs
    logic               [CPUS-1:0] ccabort;

    // modports
    modport cc(
        input   dREN, dWEN, daddr, dstore, dbyte_en,
                ccwrite, ccsnoophit, ccdirty, ccsnoopdone,
                l2load, l2state, l2error, ccabort,
        output  dwait, dload, derror,
                ccwait, ccinv, ccsnoopaddr, ccexclusive, 
                l2addr, l2store, l2REN, l2WEN, l2_byte_en
    ); 

    modport tb(
        input   dwait, dload,
                ccwait, ccinv, ccsnoopaddr, ccexclusive,
                l2addr, l2store, l2REN, l2WEN, l2_byte_en,
        output  dREN, dWEN, daddr, dstore, dbyte_en,
                ccwrite, ccsnoophit, ccdirty, ccsnoopdone,
                l2load, l2state, ccabort
    );
endinterface
`endif // BUS_CTRL_IF_VH
