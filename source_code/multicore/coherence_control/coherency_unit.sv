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
    parameter CPUS = 2,        // Number of CPUs
    parameter BLOCK_SIZE = 2,
    parameter CPUID = 0
) (
    input logic CLK, nRST,
    bus_ctrl_if.tb bcif,            // Bus Controller Interface
    cache_coherence_if.coherency_unit ccif, // Cache Coherence Interface
    generic_bus_if.generic_bus gbif //Bus from cache
);
    localparam CACHE_SIZE         = 1024;
    localparam ASSOC              = 1;
    localparam N_TOTAL_BYTES      = CACHE_SIZE / 8;
    localparam N_TOTAL_WORDS      = N_TOTAL_BYTES / 4;
    localparam N_TOTAL_FRAMES     = N_TOTAL_WORDS / BLOCK_SIZE;
    localparam N_SETS             = N_TOTAL_FRAMES / ASSOC;

    typedef enum logic [2:0] {IDLE, WRITE_REQ, READ_REQ, RESP_CHKTAG, RESP_SEND, RESP_INV, WRITEBACK} state_type; //States for Coherency Unit
    state_type state, next_state;

    typedef enum logic[1:0] {  
        MODIFIED,
        EXCLUSIVE,
        SHARED,
        INVALID
    } cc_end_state;

    always_ff @(posedge CLK or negedge nRST) begin
        if (!nRST) begin
            state <=  IDLE;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        next_state = state;
        case(state)
            IDLE: begin
                if (bcif.ccwait[CPUID]) begin
                    next_state = RESP_CHKTAG;
                end else if (gbif.wen) begin
                    next_state = WRITE_REQ;
                end else if (gbif.ren) begin
                    next_state = READ_REQ;
                end else if (ccif.dWEN) begin 
                    next_state = state_type'(WRITEBACK);
                end
            end
            RESP_CHKTAG: begin
                if (ccif.snoop_hit) begin
                    next_state = RESP_SEND;
                end else begin
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
                end
                else if (!bcif.dwait[CPUID]) begin
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
        endcase
    end

    always_comb begin: OUTPUTLOGIC
        gbif.rdata = 32'hBAD1BAD1;
        gbif.busy = 1'b1;
        bcif.ccIsPresent[CPUID] = 1'b0;
        bcif.ccdirty[CPUID] = 1'b0;
        bcif.ccsnoopdone[CPUID] = 1'b0;
        bcif.ccsnoophit[CPUID] = 1'b0;
        bcif.ccwrite[CPUID] = 1'b0;
        bcif.dstore[CPUID] = {(BLOCK_SIZE*32){1'b0}};
        bcif.daddr[CPUID] = 32'b0;
        bcif.dWEN[CPUID] = 1'b0;
        bcif.dREN[CPUID] = 1'b0;

        case(state)
            IDLE: begin
            end
            RESP_CHKTAG: begin
                ccif.set_sel = bcif.ccsnoopaddr[($clog2(N_SETS) - 1): 0];
                ccif.snoop_req = 1'b1;
                bcif.ccsnoopdone[CPUID] = 1'b1;
                bcif.ccsnoophit[CPUID] = ccif.snoop_hit;
            end
            RESP_SEND: begin
                ccif.snoop_req = 1'b1;
                bcif.dstore[CPUID] =  ccif.requested_data;
                bcif.ccsnoophit[CPUID] = 1'b1;
                bcif.ccsnoopdone[CPUID] = 1'b1; //debateable
                if (bcif.ccinv[CPUID]) begin  //Anything -> I
                    ccif.state_transfer = cc_end_state'(INVALID); 
                end else begin //Anything -> S
                    ccif.state_transfer = cc_end_state'(SHARED); 
                end
                if (ccif.dirty) begin
                    bcif.ccdirty[CPUID] = 1'b1;
                end
             end
            WRITE_REQ: begin //handle S -> M, I -> M here
                bcif.ccwrite[CPUID] = 1'b1;
                bcif.daddr[CPUID] = gbif.addr;
                bcif.dstore[CPUID] = ccif.requested_data; //set dstore[supplier] to needed data
                ccif.responder_data = bcif.dload[CPUID];
                ccif.state_transfer = cc_end_state'(MODIFIED); 
            end
            READ_REQ: begin //dren = 1, daddr = ..., final_state = ccexc ? E : S, handle I -> E and I -> S here
                bcif.dREN[CPUID] = 1'b1;
                bcif.daddr[CPUID] = gbif.addr;
                if (bcif.ccexclusive[CPUID]) begin //I -> E
                    ccif.state_transfer = cc_end_state'(EXCLUSIVE); 
                end else begin //I -> S
                    ccif.state_transfer = cc_end_state'(SHARED);
                end
                if (!bcif.dwait[CPUID]) begin
                    gbif.rdata = bcif.dload[CPUID];
                    gbif.busy = 1'b0;
                end
            end
            WRITEBACK: begin
                bcif.dWEN[CPUID] = 1'b1;
                bcif.dstore[CPUID] = gbif.wdata;
            end
        endcase
    end

    //Function to calculate the set index
    function logic [$clog2(N_SETS)-1:0] calculate_set_index(logic [31:0] address);
        return (address >> $clog2(BLOCK_SIZE)) & ((1 << $clog2(N_SETS)) - 1);;
    endfunction
endmodule
