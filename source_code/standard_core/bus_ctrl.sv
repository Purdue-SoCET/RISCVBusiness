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

`include "component_selection_defines.vh"
`include "bus_ctrl_if.vh"

module bus_ctrl #(
    parameter BLOCK_SIZE = 2,
    parameter CPUS = 2
)(
    input logic CLK, nRST,
    bus_ctrl_if.cc ccif
);
    // localparams/imports
    localparam CLEAR_LENGTH = $clog2(BLOCK_SIZE) + 2;
    localparam CPU_ID_LENGTH = $clog2(CPUS);
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
    logic [$clog2(BLOCK_SIZE):0] block_count, nblock_count;
    logic block_count_done, nblock_count_done;
    logic hit_delay;
    logic pass_through, should_abort;

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
            block_count_done <= 0;
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
            block_count_done <= nblock_count_done;
            hit_delay <= ccif.l2state == L2_ACCESS;
        end
    end

    assign should_abort = ccif.ccabort[requester_cpu] && state_can_abort(state);

    // next state logic for bus FSM
    always_comb begin
        nstate = state;
        casez (state)
            IDLE:  begin
                if (|(ccif.dWEN & ~ccif.ccabort))
                    nstate = GRANT_EVICT;
                else if (|(ccif.dREN & ccif.ccwrite & ~ccif.ccabort))
                    nstate = GRANT_RX;
                else if (|(ccif.dREN & ~ccif.ccabort))
                    nstate = GRANT_R;
                else if (|(ccif.ccwrite & ~ccif.ccabort))
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
            TRANSFER_R:         nstate = ccif.ccdirty[supplier_cpu] ? WRITEBACK_MS : BUS_TO_CACHE;
            TRANSFER_RX:        nstate = BUS_TO_CACHE;
            READ_L2:            nstate = ccif.l2error ? IDLE :
                                         block_count_done ? BUS_TO_CACHE : state;
            WRITEBACK_MS:       nstate = block_count_done ? IDLE : state;
            WRITEBACK:          nstate = block_count_done ? IDLE : state;
            BUS_TO_CACHE:       nstate = IDLE;
            INVALIDATE:         nstate = IDLE;
        endcase
        // handle exception
        if (should_abort)
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
        ccif.derror = '0;
        ndload = ccif.dload[requester_cpu];
        nexclusiveUpdate = exclusiveUpdate;
        nrequester_cpu = requester_cpu;
        nsupplier_cpu = supplier_cpu;
        nblock_count = block_count;
        pass_through = ccif.daddr[requester_cpu] >= NONCACHE_START_ADDR;

        casez(state)
            IDLE: begin // obtain the requester CPU id
                nblock_count = 0;
                if (|(ccif.dWEN & ~ccif.ccabort))
                    nrequester_cpu = priorityEncode(ccif.dWEN & ~ccif.ccabort);
                else if (|(ccif.dREN & ccif.ccwrite & ~ccif.ccabort))
                    nrequester_cpu = priorityEncode((ccif.dREN & ccif.ccwrite & ~ccif.ccabort));
                else if (|(ccif.dREN & ~ccif.ccabort))
                    nrequester_cpu = priorityEncode(ccif.dREN & ~ccif.ccabort);
                else if (|(ccif.ccwrite & ~ccif.ccabort))
                    nrequester_cpu = priorityEncode(ccif.ccwrite & ~ccif.ccabort);
            end
            GRANT_R, GRANT_RX, GRANT_INV: begin // set the stimulus for snooping
                for (int i = 0; i < CPUS; i++) begin
                    if (requester_cpu != i)
                        nccsnoopaddr[i] = ccif.daddr[requester_cpu] & ~(CLEAR_LENGTH'('1));
                end
            end
            GRANT_EVICT: begin  // set the stimulus to WRITEBACK to L2
                // nl2_store = ccif.dstore[requester_cpu];
                nl2_addr = pass_through ? ccif.daddr[requester_cpu] : ccif.daddr[requester_cpu] & ~(CLEAR_LENGTH'('1));
                //Cache waits until its block is completely written back
                //Could optimize to have bus latch cache value and let the cache run?
                ccif.dwait[requester_cpu] = 1; 

                nl2_store = ccif.dstore[requester_cpu][31:0];
            end
            SNOOP_R: begin  // determine what to do on busRD
                nexclusiveUpdate = !(|ccif.ccsnoophit);
                ccif.ccwait = nonRequesterEnable(requester_cpu);
                nsupplier_cpu = priorityEncode(ccif.ccsnoophit);
                nl2_addr = pass_through ? ccif.daddr[requester_cpu] : ccif.daddr[requester_cpu] & ~(CLEAR_LENGTH'('1));
            end
            SNOOP_RX: begin // determine what to do on busRDX
                nexclusiveUpdate = !(|ccif.ccsnoophit);
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
                ccif.l2REN = !block_count_done;

                if (ccif.l2error) begin
                    ccif.derror[requester_cpu] = 1;
                end if (ccif.l2state == L2_ACCESS) begin
                    ccif.l2REN = 0;
                    nblock_count = block_count + 1;
                    if (!pass_through && block_count < BLOCK_SIZE - 1) begin
                        ndload[block_count * 32+:32] = ccif.l2load;
                        nl2_addr = ccif.l2addr + ((block_count + 1) * 4);
                    end else begin
                        ndload[block_count * 32+:32] = ccif.l2load;
                    end
                end
            end
            TRANSFER_R: begin // move data from cache to bus
                ccif.ccwait = nonRequesterEnable(requester_cpu);

                nl2_store = ccif.dstore[supplier_cpu];
                ndload = ccif.dstore[supplier_cpu];
            end
            TRANSFER_RX: begin // move data from cache to bus
                ccif.ccwait = nonRequesterEnable(requester_cpu);
                //While snooping, sometimes may reach this state before cache hits SNOOP state
                ccif.ccinv = nonRequesterEnable(requester_cpu);
                ndload = ccif.dstore[supplier_cpu];
            end
            BUS_TO_CACHE: begin // move data from bus to cache (upwards or downwards); alert requester
                ccif.dwait[requester_cpu] = 0;
                ccif.ccexclusive[requester_cpu] = exclusiveUpdate;
                ndload = ccif.dload[requester_cpu];
                //Need to keep sending invalidations if prev transfer was a TRANSFER_RX
                if(|ccif.ccwrite) begin
                    ccif.ccinv = nonRequesterEnable(requester_cpu);
                end
            end
            WRITEBACK_MS: begin // writeback using supplier while also doing cache to cache transfer
                ccif.ccwait = nonRequesterEnable(requester_cpu);
                ccif.dwait[requester_cpu] = !block_count_done;
                ccif.ccexclusive[requester_cpu] = exclusiveUpdate;

                ccif.l2WEN = !block_count_done;
                nblock_count = block_count;
                if (ccif.l2state == L2_ACCESS) begin
                    ccif.l2WEN = 0;
                    nblock_count = block_count + 1;
                    if (block_count < BLOCK_SIZE - 1) begin
                        nl2_addr = ccif.l2addr + (nblock_count * 4);
                        nl2_store = ccif.dstore[supplier_cpu][(nblock_count * 32)+:32];
                    end
                end
            end
            WRITEBACK: begin
                ccif.l2WEN = !block_count_done;
                nblock_count = block_count;
                ccif.dwait[requester_cpu] = !block_count_done; //Writeback complete

                if (ccif.l2state == L2_ACCESS) begin
                    ccif.l2WEN = 0;
                    nblock_count = block_count + 1;
                    if (!pass_through && block_count < BLOCK_SIZE - 1) begin
                        nl2_addr = ccif.l2addr + (nblock_count * 4);
                        nl2_store = ccif.dstore[requester_cpu][(nblock_count * 32)+:32];
                    end
                end
            end
            INVALIDATE:
                ccif.dwait[requester_cpu] = 0;
        endcase

        if (block_count_done)
            nblock_count = 0;
        nblock_count_done = (nblock_count == BLOCK_SIZE) || (pass_through && ccif.l2state == L2_ACCESS);

        ccif.l2_byte_en = pass_through ? ccif.dbyte_en[requester_cpu] : 'hF;

        // Handle bus controller aborting
        if (should_abort) begin
            ccif.dwait[requester_cpu] = 0;
        end
        // Handle non-bus controller aborting
        for (int i = 0; i < CPUS; i++) begin
            if (ccif.ccabort[i] && (requester_cpu != i))
                ccif.dwait[i] = 0;
        end
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

    // Helper function to determine whether requester_cpu is properly set and
    // can be used for abort purposes
    function logic state_can_abort(bus_state_t state);
    return state == GRANT_R ||
        state == GRANT_RX ||
        state == SNOOP_R ||
        state == SNOOP_RX;
    endfunction
endmodule
