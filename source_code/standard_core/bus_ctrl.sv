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
*	Filename:     bus_ctrl.sv
*
*	Created by:   Jimmy Mingze Jin
*	Email:        jin357@purdue.edu
*	Date Created: 10/24/2022
*	Description:  Bus controller for MESI cache coherence
*/

`include "bus_ctrl_if.vh"

module bus_ctrl #( 
    parameter BLOCK_SIZE = 2,
    parameter CPUS = 4
)(  
    input logic CLK, nRST, 
    bus_ctrl_if.cc ccif,
    input logic abort_bus
);  
    // localparams/imports
    localparam CLEAR_LENGTH = $clog2(BLOCK_SIZE) + 2;
    localparam CPU_ID_LENGTH = $clog2(CPUS);
    localparam BLOCK_CYCLES = 2; // TEMP
    // states
    bus_state_t state, nstate;
    // requester/supplier
    logic [CPU_ID_LENGTH-1:0] requester_cpu, nrequester_cpu;
    logic [CPU_ID_LENGTH-1:0] supplier_cpu, nsupplier_cpu;
    // internal register next signals
    bus_word_t [CPUS-1:0] nccsnoopaddr, nl2_addr;
    logic [CPUS-1:0] nccwait, nccinv;
    transfer_width_t ndload, nl2_store;
    // stores whether we need to update requester to exclusive or if WRITEBACK is needed after transfer
    logic exclusiveUpdate, nexclusiveUpdate;
    logic [$clog2(BLOCK_CYCLES):0] block_count, nblock_count;
    logic block_count_done;
    logic hit_delay;

    always_ff @(posedge CLK, negedge nRST) begin
        if (!nRST) begin
            requester_cpu <= '0;
            supplier_cpu <= '0;
            exclusiveUpdate <= 0;
            state <= IDLE; 
            ccif.ccsnoopaddr <= '0;
            ccif.dload <= '0;
            ccif.l2store <= '0;
            ccif.l2addr <= '0;
            block_count <= 0;
            hit_delay <= '0;
        end
        else begin
            requester_cpu <= nrequester_cpu;        // requester
            supplier_cpu <= nsupplier_cpu;          // supplier
            state <= nstate;                        // current bus controller state
            exclusiveUpdate <= nexclusiveUpdate;    // whether to update to exclusive
            ccif.ccsnoopaddr <= nccsnoopaddr;       // snoopaddr to other l1 caches
            ccif.dload[requester_cpu] <= ndload;    // bus to requester
            ccif.l2store <= nl2_store;              // l2 store value
            ccif.l2addr <= nl2_addr;                // l2 addr to store at
            block_count <= nblock_count;            // temp to deal with current cache block setup
            hit_delay <= ccif.l2state == L2_ACCESS;
        end
    end

    // next state logic for bus FSM
    always_comb begin 
        nstate = state;
        casez (state)
            IDLE:  begin
                if (|ccif.dWEN)
                    nstate = GRANT_EVICT;
                else if (|(ccif.dREN & ccif.ccwrite))                  
                    nstate = GRANT_RX;
                else if (|ccif.dREN)                  
                    nstate = GRANT_R;
                else if (|ccif.ccwrite)
                    nstate = GRANT_INV;
            end
            GRANT_R:            nstate = SNOOP_R;
            GRANT_RX:           nstate = SNOOP_RX;
            GRANT_EVICT:        nstate = WRITEBACK;
            GRANT_INV:          nstate = SNOOP_INV;
            SNOOP_R:            nstate = snoopStatus(requester_cpu, ccif.ccsnoopdone) ? (|ccif.ccsnoophit ? TRANSFER_R : READ_L2) : state;
            SNOOP_RX:           nstate = snoopStatus(requester_cpu, ccif.ccsnoopdone) ? (|ccif.ccsnoophit ? TRANSFER_RX : READ_L2) : state;
            SNOOP_INV:          nstate = snoopStatus(requester_cpu, ccif.ccsnoopdone) ? INVALIDATE : state;
            // TRANSFER_R:         nstate = ccif.ccdirty[supplier_cpu] ? WRITEBACK_MS : BUS_TO_CACHE;
            // TRANSFER_RX:        nstate = BUS_TO_CACHE;
            // READ_L2:            nstate = (ccif.l2state == L2_ACCESS) ? BUS_TO_CACHE : state;
            // WRITEBACK_MS:       nstate = (ccif.l2state == L2_ACCESS) ? IDLE : WRITEBACK;
            // WRITEBACK:          nstate = (ccif.l2state == L2_ACCESS) ? IDLE : state;
            // BUS_TO_CACHE:       nstate = IDLE;
            TRANSFER_R:         nstate = ccif.ccdirty[supplier_cpu] && block_count_done ? WRITEBACK_MS : BUS_TO_CACHE;
            TRANSFER_RX:        nstate = block_count_done ? IDLE : state;
            READ_L2:            nstate = block_count_done ? BUS_TO_CACHE : state;
            WRITEBACK_MS:       nstate = block_count_done ? IDLE : WRITEBACK;
            WRITEBACK:          nstate = block_count_done ? IDLE : state;
            BUS_TO_CACHE:       nstate = block_count_done ? IDLE : state;
            INVALIDATE:         nstate = IDLE;
        endcase
        // handle exception
        if (abort_bus)
            nstate = IDLE;
    end
    
    // output logic for bus FSM
    always_comb begin
        // defaults
        nccsnoopaddr = ccif.ccsnoopaddr;
        ccif.dwait = '1; 
        ccif.ccwait = '0; 
        nl2_addr = ccif.l2addr; 
        nl2_store = ccif.l2store; 
        ccif.l2REN = '0; 
        ccif.l2WEN = '0; 
        ccif.ccexclusive = '0;
        ccif.ccinv = '0;
        ndload = ccif.dload[requester_cpu];
        nexclusiveUpdate = exclusiveUpdate;
        nrequester_cpu = requester_cpu;
        nsupplier_cpu = supplier_cpu;
        nblock_count = 0;
        block_count_done = 0;
        casez(state)
            IDLE: begin // obtain the requester CPU id
                if (|ccif.dWEN)
                    nrequester_cpu = priorityEncode(ccif.dWEN);
                else if (|(ccif.dREN & ccif.ccwrite))                  
                    nrequester_cpu = priorityEncode((ccif.dREN & ccif.ccwrite));
                else if (|ccif.dREN)                  
                    nrequester_cpu = priorityEncode(ccif.dREN);
                else if (|ccif.ccwrite)
                    nrequester_cpu = priorityEncode(ccif.ccwrite);
            end
            GRANT_R, GRANT_RX, GRANT_INV: begin // set the stimulus for snooping
                for (int i = 0; i < CPUS; i++) begin
                    if (requester_cpu != i)
                        nccsnoopaddr[i] = ccif.daddr[requester_cpu] & ~(CLEAR_LENGTH'('1));
                end
            end
            GRANT_EVICT: begin  // set the stimulus to WRITEBACK to L2
                // nl2_store = ccif.dstore[requester_cpu]; 
                nl2_addr = ccif.daddr[requester_cpu] & ~(CLEAR_LENGTH'('1));
                ccif.dwait[requester_cpu] = 0;

                if (block_count == 0) begin
                    nblock_count = 1;
                    nl2_store = ccif.dstore[requester_cpu];
                end
                else begin
                    block_count_done = 1;
                    nl2_store[63:32] = ccif.dstore[requester_cpu]; // probably fine
                end
            end
            SNOOP_R: begin  // determine what to do on busRD
                nexclusiveUpdate = !(|ccif.ccIsPresent);
                ccif.ccwait = nonRequesterEnable(requester_cpu);
                nsupplier_cpu = priorityEncode(ccif.ccsnoophit);
                nl2_addr = ccif.daddr[requester_cpu] & ~(CLEAR_LENGTH'('1));
            end
            SNOOP_RX: begin // determine what to do on busRDX
                nexclusiveUpdate = !(|ccif.ccIsPresent);
                ccif.ccinv = nonRequesterEnable(requester_cpu);
                ccif.ccwait = nonRequesterEnable(requester_cpu);
                nsupplier_cpu = priorityEncode(ccif.ccsnoophit);
                nl2_addr = ccif.daddr[requester_cpu] & ~(CLEAR_LENGTH'('1));
            end
            SNOOP_INV: begin // snoop and invalidate non_requesters
                ccif.ccinv = nonRequesterEnable(requester_cpu);
                ccif.ccwait = nonRequesterEnable(requester_cpu);
            end
            READ_L2: begin // reads data into bus from l2
                nblock_count = block_count;
                ccif.l2REN = 1; 
                    
                if (block_count == 0) begin
                    nblock_count = ccif.l2state == L2_ACCESS;
                    nl2_addr = ccif.l2addr + 4;
                    if (ccif.l2state == L2_ACCESS)
                        ndload = ccif.l2load;
                end
                else begin
                    block_count_done = ccif.l2state == L2_ACCESS;
                    ndload[63:32] = ccif.l2load;
                end
            end
            TRANSFER_R: begin // move data from cache to bus
                
                ccif.ccwait = nonRequesterEnable(requester_cpu);
                
                if (block_count == 0) begin
                    nblock_count = 1;
                    nl2_store = ccif.dstore[supplier_cpu];
                    ndload = ccif.dstore[supplier_cpu];
                end
                else begin
                    block_count_done = 1;
                    nl2_addr = ccif.daddr[requester_cpu] & ~(CLEAR_LENGTH'('1));
                    nl2_store[63:32] = ccif.dstore[supplier_cpu];
                    ndload[63:32] = ccif.dstore[supplier_cpu]; 
                end
            end
            TRANSFER_RX: begin // move data from cache to bus
                
                ccif.ccwait = nonRequesterEnable(requester_cpu);

                if (block_count == 0) begin
                    nblock_count = 1;
                    ndload = ccif.dstore[supplier_cpu];
                end
                else begin
                    block_count_done = 1;
                    ndload[63:32] = ccif.dstore[supplier_cpu];
                end
            end
            BUS_TO_CACHE: begin // move data from bus to cache (upwards or downwards); alert requester
                ccif.dwait[requester_cpu] = 0;
                ccif.ccexclusive[requester_cpu] = exclusiveUpdate;
                if (block_count == 0) begin
                    nblock_count = 1;
                    ndload = ccif.dload[requester_cpu] >> 32;
                end
                else begin
                    block_count_done = 1;
                end
            end
            WRITEBACK_MS: begin // writeback to 
                ccif.l2WEN = 1;
                ccif.ccexclusive[requester_cpu] = exclusiveUpdate;
                nblock_count = block_count;
                if (block_count == 0) begin
                    nblock_count = (ccif.l2state == L2_ACCESS);
                    ccif.dwait[requester_cpu] = (ccif.l2state == L2_ACCESS);
                    nl2_addr = ccif.l2addr + 4 * (ccif.l2state == L2_ACCESS);
                end
                else begin
                    block_count_done = (ccif.l2state == L2_ACCESS);
                    ccif.dwait[requester_cpu] = (ccif.l2state == L2_ACCESS);
                end
            end
            WRITEBACK: begin
                ccif.l2WEN = 1;
                nblock_count = block_count;
                if (block_count == 0) begin
                    nblock_count = hit_delay;
                    nl2_addr = ccif.l2addr + 4 * hit_delay;
                end
                else begin
                    block_count_done = hit_delay;
                end
            end
            INVALIDATE:
                ccif.dwait[requester_cpu] = 0;
        endcase

        if (block_count_done)
            nblock_count = 0;
    end

    // function to obtain all non requesters
    function logic [CPUS-1:0] nonRequesterEnable;
        input [CPU_ID_LENGTH-1:0] requester_cpu;
        nonRequesterEnable = '1 & ~(1 << requester_cpu);
    endfunction
    
    // function to get snoop status
    function logic snoopStatus;
        input logic [CPU_ID_LENGTH-1:0] requester_cpu;
        input logic [CPUS-1:0] snoopDone;
        snoopStatus = &((1'b1 << requester_cpu) | snoopDone);
    endfunction 

    // function to do priority encoding to determine the requester or supplier
    function logic [CPU_ID_LENGTH-1:0] priorityEncode;
        input logic [CPUS-1:0] to_encode;
        for (int i = 0; i < CPUS; i++) begin
            if (to_encode[i])
                priorityEncode = i;
        end
    endfunction
endmodule
