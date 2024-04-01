/*
*	Copyright 2023 Purdue University
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
*	Filename:     coherency_unit.sv
*
*	Created by:   Burkay Sahin
*	Email:        sahin0@purdue.edu
*	Date Created: 11/20/2023
*	Description:  Coherency unit for MESI Coherence
*/

`include "generic_bus_if.vh"
`include "cache_coherence_if.vh"
`include "bus_ctrl_if.vh"

module coherency_unit #(
    parameter ADDR_WIDTH = 32, // Address width for cache lines
    parameter BLOCK_SIZE = 2,
    parameter CPUID = 0
) (
    input logic CLK, nRST,
    bus_ctrl_if.tb bcif,            // Bus Controller Interface
    cache_coherence_if.coherency_unit ccif, // Cache Coherence Interface
    generic_bus_if.generic_bus gbif, //Bus from cache
    output cache_coherence_statistics_t coherence_statistics
);
    localparam CACHE_SIZE         = 1024;
    localparam ASSOC              = 1;
    localparam N_TOTAL_BYTES      = CACHE_SIZE / 8;
    localparam N_TOTAL_WORDS      = N_TOTAL_BYTES / 4;
    localparam N_TOTAL_FRAMES     = N_TOTAL_WORDS / BLOCK_SIZE;
    localparam N_SETS             = N_TOTAL_FRAMES / ASSOC;

    typedef enum logic [2:0] {IDLE, WRITE_REQ, READ_REQ, RESP_CHKTAG, RESP_SEND, RESP_FAIL, RESP_INV, WRITEBACK} state_type; //States for Coherency Unit
    state_type state, next_state;
    cache_coherence_statistics_t next_coherence_statistics;

    typedef enum logic[1:0] {  
        MODIFIED,
        EXCLUSIVE,
        SHARED,
        INVALID
    } cc_end_state;

    always_ff @(posedge CLK or negedge nRST) begin
        if (!nRST) begin
            state <=  IDLE;
            coherence_statistics <= '{default: 0};
        end else begin
            state <= next_state;
            coherence_statistics <= next_coherence_statistics;
        end
    end

    always_comb begin
        next_state = state;
        case(state)
            IDLE: begin
                if (bcif.ccwait[CPUID]) begin
                    next_state = RESP_CHKTAG;
                end else if (ccif.dWEN && gbif.wen) begin
                    next_state = state_type'(WRITEBACK);
                end else if (gbif.wen) begin
                    next_state = WRITE_REQ;
                end else if (gbif.ren) begin
                    next_state = READ_REQ;
                end
            end
            RESP_CHKTAG: begin
                if (!ccif.snoop_busy) begin
                    next_state = ccif.snoop_hit ? RESP_SEND : RESP_FAIL;
                end
            end
            RESP_FAIL: begin
                if (!bcif.ccwait[CPUID]) begin
                    next_state = IDLE;
                end
            end
            RESP_SEND: begin
                if (!bcif.ccwait[CPUID]) begin
                    next_state = IDLE;
                end
            end
            WRITE_REQ: begin //handle S -> M, I -> M here
                if (bcif.ccwait[CPUID]) begin
                    next_state = RESP_CHKTAG;
                end else if (!bcif.dwait[CPUID]) begin
                    next_state = IDLE;
                end
            end
            READ_REQ: begin //dren = 1, daddr = ..., final_state = ccexc ? E : S, handle I -> E and I -> S here
                if (bcif.ccwait[CPUID]) begin
                    next_state = RESP_CHKTAG;
                end
                else if (!bcif.dwait[CPUID]) begin
                    next_state = IDLE;
                end
            end
            WRITEBACK: begin
                if (bcif.ccwait[CPUID]) begin
                    next_state = RESP_CHKTAG;
                end
                else if (!bcif.dwait[CPUID]) begin
                    next_state = IDLE;
                end
            end
            default : next_state = IDLE; 
        endcase
    end

    always_comb begin: OUTPUTLOGIC
        next_coherence_statistics = coherence_statistics;
        gbif.rdata = 32'hBAD1BAD1;
        gbif.busy = 1'b1;
        bcif.ccdirty[CPUID] = 1'b0;
        bcif.ccsnoopdone[CPUID] = 1'b0;
        bcif.ccsnoophit[CPUID] = 1'b0;
        bcif.ccwrite[CPUID] = 1'b0;
        bcif.dstore[CPUID] = {(BLOCK_SIZE*32){1'b0}};
        bcif.daddr[CPUID] = 32'b0;
        bcif.dWEN[CPUID] = 1'b0;
        bcif.dREN[CPUID] = 1'b0;
        ccif.addr = 32'hBAD1BAD1;
        ccif.state_transfer = cc_end_state'(INVALID);
        ccif.snoop_req = 1'b0;
        ccif.snoop_complete = 1'b0;

        case(state)
            IDLE: begin
            end
            RESP_CHKTAG: begin
                ccif.addr = bcif.ccsnoopaddr[CPUID];
                ccif.snoop_req = 1'b1;
                //bcif.ccsnoopdone[CPUID] = 1'b1;
                bcif.ccsnoopdone[CPUID] = !ccif.snoop_busy & !ccif.snoop_hit;
                //bcif.ccsnoophit[CPUID] = ccif.snoop_hit;
            end
            RESP_SEND: begin
                ccif.addr = bcif.ccsnoopaddr[CPUID];
                ccif.snoop_req = 1'b1;
                bcif.dstore[CPUID] =  ccif.requested_data;
                bcif.ccsnoophit[CPUID] = 1'b1;
                bcif.ccsnoopdone[CPUID] = 1'b1; //debateable
                gbif.busy = bcif.ccwait[CPUID];
                //ccif.snoop_complete = !bcif.ccwait[CPUID]; 
                if (bcif.ccinv[CPUID]) begin  //Anything -> I
                    ccif.state_transfer = cc_end_state'(INVALID); 
                    if (!bcif.ccwait[CPUID]) next_coherence_statistics.to_i_transitions += 1;
                end else begin //Anything -> S
                    ccif.state_transfer = cc_end_state'(SHARED); 
                    if (!bcif.ccwait[CPUID]) next_coherence_statistics.to_s_transitions += 1;
                end
                if (ccif.dirty) begin
                    bcif.ccdirty[CPUID] = 1'b1;
                end
             end
            RESP_FAIL : begin
                bcif.ccsnoophit[CPUID] = 1'b0;
                bcif.ccsnoopdone[CPUID] = 1'b1;
            end
            WRITE_REQ: begin //handle S -> M, I -> M here
                bcif.daddr[CPUID] = gbif.addr;
                bcif.dREN[CPUID] = 1'b1;
                bcif.ccwrite[CPUID] = 1'b1;
                bcif.dstore[CPUID] = ccif.requested_data; //set dstore[supplier] to needed data
                gbif.rdata = bcif.dload[CPUID];
                gbif.busy = bcif.dwait[CPUID];
                ccif.state_transfer = cc_end_state'(MODIFIED); 
            end
            READ_REQ: begin //dren = 1, daddr = ..., final_state = ccexc ? E : S, handle I -> E and I -> S here
                bcif.dREN[CPUID] = 1'b1;
                bcif.daddr[CPUID] = gbif.addr;
                if (bcif.ccexclusive[CPUID]) begin //I -> E
                    ccif.state_transfer = cc_end_state'(EXCLUSIVE); 
                    if (!bcif.dwait[CPUID]) next_coherence_statistics.to_e_transitions += 1;
                end else begin //I -> S
                    ccif.state_transfer = cc_end_state'(SHARED);
                    if (!bcif.dwait[CPUID]) next_coherence_statistics.to_s_transitions += 1;
                end
                if (!bcif.dwait[CPUID]) begin
                    gbif.rdata = bcif.dload[CPUID];
                    gbif.busy = 1'b0;
                end
            end
            WRITEBACK: begin
                bcif.dWEN[CPUID] = 1'b1;
                bcif.daddr[CPUID] = gbif.addr;
                bcif.dstore[CPUID] = gbif.wdata;
                gbif.busy = bcif.dwait[CPUID];
            end
            default : begin end
        endcase
    end

    assign bcif.ccIsPresent[CPUID] = bcif.ccsnoophit[CPUID];

    //Function to calculate the set index
    function logic [$clog2(N_SETS)-1:0] calculate_set_index(logic [31:0] address);
        return (address >> $clog2(BLOCK_SIZE)) & ((1 << $clog2(N_SETS)) - 1);;
    endfunction
endmodule
