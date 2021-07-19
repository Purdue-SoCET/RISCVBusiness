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

// parameters
parameter CACHES = 4;
parameter BLOCK_SIZE = 2;
localparam DATA_WIDTH = 32 * BLOCK_SIZE; // 64 bit/clk memory bandwidth
localparam CACHE_ID_LENGTH = $clog2(CACHES);


// coherence bus controller states
typedef enum logic [3:0] {
    GRANT_R, GRANT_RX, GRANT_EVICT, GRANT_INV, 
    IDLE,               // determines if a request is going on
    SNOOP_R,            // sends a snoop based on busRD
    SNOOP_RX,           // sends a snoop based on busRDX
    SNOOP_INV,          // sends a invalidation request to all cores
    TRANSFER_R,         // provides cache to bus transfer
    TRANSFER_RX,        // provides cache to bus transfer, only when promoting to modified
    TRANSFER_R_FIN,     // provides bus to requester transfer
    READ_L2,            // reads from l2 to bus
    BUS_TO_L1,          // finishes transaction by providing from bus to cache
    WRITEBACK,          // evicts cache entry to L2
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
typedef logic [31:0] word_t;
typedef logic [DATA_WIDTH-1:0] transfer_width_t;
typedef logic [CACHES-1:0] cache_bitvec_t;
typedef logic [CACHE_ID_LENGTH-1:0] cacheid_t;

// modified from coherence_ctrl_if.vh
interface bus_ctrl_if;
    // L1 generic control signals
    logic               [CACHES-1:0] dREN, dWEN, dwait; 
    transfer_width_t    [CACHES-1:0] dload, dstore;
    word_t              [CACHES-1:0] daddr;
    // L1 coherence INPUTS to bus 
    logic               [CACHES-1:0] ccwrite;     // indicates that the requester is attempting to go to M
    logic               [CACHES-1:0] ccsnoophit;  // indicates that the responder has the data
    logic               [CACHES-1:0] ccsnoopdone;  // indicates that the responder has the data
    logic               [CACHES-1:0] ccIsPresent; // indicates that nonrequesters have the data valid
    logic               [CACHES-1:0] ccdirty;     // indicates that we have [I -> S, M -> S]
    // L1 coherence OUTPUTS
    logic               [CACHES-1:0] ccwait;      // indicates a potential snoophit wait request
    logic               [CACHES-1:0] ccinv;       // indicates an invalidation request
    logic               [CACHES-1:0] ccexclusive; // indicates an exclusivity update
    word_t              [CACHES-1:0] ccsnoopaddr; 
    // L2 signals
    l2_state_t l2state; 
    transfer_width_t l2load, l2store; 
    logic l2WEN, l2REN; 
    word_t l2addr; 

    // modports
    modport cc(
        input   dREN, dWEN, daddr, dstore, 
                ccwrite, ccsnoophit, ccIsPresent, ccdirty, ccsnoopdone,
                l2load, l2state, 
        output  dwait, dload, 
                ccwait, ccinv, ccsnoopaddr, ccexclusive, 
                l2addr, l2store, l2REN, l2WEN
    ); 

    modport tb(
        input   dwait, dload, 
                ccwait, ccinv, ccsnoopaddr, ccexclusive, 
                l2addr, l2store, l2REN, l2WEN,
        output  dREN, dWEN, daddr, dstore, 
                ccwrite, ccsnoophit, ccIsPresent, ccdirty, ccsnoopdone,
                l2load, l2state
    ); 

endinterface
`endif // BUS_CTRL_IF_VH
