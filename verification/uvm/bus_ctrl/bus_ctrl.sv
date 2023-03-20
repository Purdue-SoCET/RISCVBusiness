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
*	Description:  Bus controller for MESI cache coherence; extended from old coherence_ctrl.sv
*/

`include "bus_ctrl_if.vh"

module bus_ctrl #( 
    parameter BLOCK_SIZE = 2,
    parameter CPUS = 4
)(  
    input logic CLK, nRST, 
    bus_ctrl_if.cc ccif
);  
    // localparams/imports
    localparam CPU_ID_LENGTH = $clog2(CPUS);
    // states
    bus_state_t state, nstate;
    // requester/supplier
    logic [CPU_ID_LENGTH-1:0] requester_cpu, nrequester_cpu;
    logic [CPU_ID_LENGTH-1:0] supplier_cpu, nsupplier_cpu;
    // internal register next signals
    word_t [CPUS-1:0] nccsnoopaddr, nl2_addr;
    logic [CPUS-1:0] nccwait, nccinv;
    transfer_width_t ndload, nl2_store;
    // stores whether we need to update requester to exclusive or if WB is needed after transfer
    logic exclusiveUpdate, nexclusiveUpdate;
    logic wb_needed, nwb_needed;

    always_ff @(posedge CLK, negedge nRST) begin
        if (!nRST) begin
            requester_cpu <= '0;
            supplier_cpu <= '0;
            exclusiveUpdate <= 0;
            wb_needed <= 0;
            state <= IDLE; 
            ccif.ccsnoopaddr <= '0;
            ccif.dload <= '0;
            ccif.l2store <= '0;
            ccif.l2addr <= '0;
        end
        else begin
            requester_cpu <= nrequester_cpu;        // requester
            supplier_cpu <= nsupplier_cpu;          // supplier
            state <= nstate;                        // current bus controller state
            exclusiveUpdate <= nexclusiveUpdate;    // whether to update to exclusive
            wb_needed <= nwb_needed;                // whether WB to l2 is required
            ccif.ccsnoopaddr <= nccsnoopaddr;       // snoopaddr to other l1 caches
            ccif.dload[requester_cpu] <= ndload;    // bus to requester
            ccif.l2store <= nl2_store;              // l2 store value
            ccif.l2addr <= nl2_addr;                // l2 addr to store at
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
            TRANSFER_R:         nstate = TRANSFER_R_FIN;
            TRANSFER_RX:        nstate = BUS_TO_L1;
            TRANSFER_R_FIN:     nstate = wb_needed ? WRITEBACK : IDLE; // note: roughly translates to [I -> S, M -> S] : [I -> S, E -> S]
            READ_L2:            nstate = (ccif.l2state == L2_ACCESS) ? BUS_TO_L1 : state;
            BUS_TO_L1:          nstate = IDLE;
            WRITEBACK:          nstate = (ccif.l2state == L2_ACCESS) ? IDLE : state;
            INVALIDATE:         nstate = IDLE;
        endcase
    end
    
//     // requester arbitration
//     typedef enum logic [1:0] {
//     INVALIDATE, READ, READ_EXCLUSIVE, EVICTION 
//     } request_type_t;
    
//     request_type_t [CPUS-1: 0] request_type;
//     always_comb begin
//         request_type = 0;
//         for (int i = 0; i < CPUS; i++) begin
//             if (ccif.dWEN[i])
//                 request_type[I] = EVICTION;
//             else if (ccif.dREN[i] & ccif.ccwrite[i])                  
//                 request_type[i] = READ_EXCLUSIVE;
//             else if (ccif.dREN[i])                  
//                 request_type[i] = READ;
//             else if (ccif.ccwrite[i])
//                 request_type[i] = INVALIDATE;
//         end
//     end

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
        nwb_needed = wb_needed;
        nrequester_cpu = requester_cpu;
        nsupplier_cpu = supplier_cpu;
        casez(state)
            IDLE: begin // obtain the requester CPU id
                if (|ccif.dWEN)
                    priorityEncode(ccif.dWEN, nrequester_cpu);
                else if (|(ccif.dREN & ccif.ccwrite))                  
                    priorityEncode((ccif.dREN & ccif.ccwrite), nrequester_cpu);
                else if (|ccif.dREN)                  
                    priorityEncode(ccif.dREN, nrequester_cpu);
                else if (|ccif.ccwrite)
                    priorityEncode(ccif.ccwrite, nrequester_cpu);
            end
            GRANT_R, GRANT_RX, GRANT_INV: begin // set the stimulus for snooping
                for (int i = 0; i < CPUS; i++) begin
                    if (requester_cpu != i)
                        nccsnoopaddr[i] = ccif.daddr[requester_cpu] & ~(word_t'(3'b111));
                end
            end
            GRANT_EVICT: begin  // set the stimulus to WB to L2
                nl2_store = ccif.dstore[requester_cpu]; 
                nl2_addr = ccif.daddr[requester_cpu] & ~(word_t'(3'b111));
                ccif.dwait[requester_cpu] = 0;
            end
            SNOOP_R: begin  // determine what to do on busRD
                nexclusiveUpdate = !(|ccif.ccIsPresent);
                ccif.ccwait = nonRequesterEnable(requester_cpu);
                priorityEncode(ccif.ccsnoophit, nsupplier_cpu);
                nl2_addr = ccif.daddr[requester_cpu] & ~(word_t'(3'b111));
            end
            SNOOP_RX: begin // determine what to do on busRDX
                nexclusiveUpdate = !(|ccif.ccIsPresent);
                ccif.ccinv = nonRequesterEnable(requester_cpu);
                ccif.ccwait = nonRequesterEnable(requester_cpu);
                priorityEncode(ccif.ccsnoophit, nsupplier_cpu);
                nl2_addr = ccif.daddr[requester_cpu] & ~(word_t'(3'b111));
            end
            SNOOP_INV: begin // snoop and invalidate non_requesters
                ccif.ccinv = nonRequesterEnable(requester_cpu);
                ccif.ccwait = nonRequesterEnable(requester_cpu);
            end
            READ_L2: begin // reads data into bus from l2
                ccif.l2REN = 1; 
                ndload = ccif.l2load; 
            end
            BUS_TO_L1: begin // move data from bus to cache; alert requester
                ccif.dwait[requester_cpu] = 0;
                ccif.ccexclusive[requester_cpu] = exclusiveUpdate;
            end
            TRANSFER_R, TRANSFER_RX: begin // move data from cache to bus
                ndload = ccif.dstore[supplier_cpu];
                ccif.ccwait = nonRequesterEnable(requester_cpu);
                nwb_needed = ccif.ccdirty[supplier_cpu];
            end
            TRANSFER_R_FIN: begin // move data from bus to requester
                ccif.dwait[requester_cpu] = 0;
                ccif.ccexclusive[requester_cpu] = exclusiveUpdate;
                nl2_store = ccif.dstore[supplier_cpu]; 
                nl2_addr = ccif.daddr[supplier_cpu] & ~(word_t'(3'b111));
                ccif.dwait[supplier_cpu] = 0; 
            end
            WRITEBACK:
                ccif.l2WEN = 1;
            INVALIDATE:
                ccif.dwait[requester_cpu] = 0;
        endcase
    end

    // function to obtain all non requesters
    function logic [CPUS-1:0] nonRequesterEnable;
        input requester_cpu;
        nonRequesterEnable = '1 & ~(1 << requester_cpu);
    endfunction
    
    function logic snoopStatus;
        input logic [CPU_ID_LENGTH-1:0] requester_cpu;
        input logic [CPUS-1:0] snoopDone;
        snoopStatus = &(((1'b1 << requester_cpu) | {CPUS{1'b0}}) | snoopDone);
        //snoopStatus = &(({CPUS{1'b1}} << requester_cpu) | snoopDone);
    endfunction

    // task to do priority encoding to determine the requester or supplier
    task priorityEncode;
        input logic [CPUS-1:0] to_encode;
        output logic [CPU_ID_LENGTH-1:0] encoded;       
        for (int i = 0; i < CPUS; i++) begin
            if (to_encode[i])
                encoded = i;
        end
    endtask
endmodule
