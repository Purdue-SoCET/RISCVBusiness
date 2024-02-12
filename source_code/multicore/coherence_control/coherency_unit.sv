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

/* Bus Controller Interface: To connect the coherency unit to the bus
    modport cc(
        input   dREN, dWEN, daddr, dstore, 
                cctrans, ccwrite, ccsnoophit, ccIsPresent, ccdirty, ccsnoopdone,
                l2load, l2state, frame_state,
        output  dwait, dload, 
                ccwait, ccinv, ccsnoopaddr, ccexclusive, 
                l2addr, l2store, l2REN, l2WEN
    ); 
*/

/* To respond back to the cache
modport coherency_unit(
        output  set_sel, state_transfer, write_req, snoop_hit, frame_tag, responder_data, snoop_req,
        input valid, exclusive, dirty, requested_data
    );
*/

/*  modport generic_bus ( //To connect the cache to the coherency unit
    input addr, ren, wen, wdata, byte_en,
    output rdata, busy
  );
*/

`include "generic_bus_if.vh"
`include "cache_coherence_if.vh"
`include "bus_ctrl_if.vh"

module coherency_unit #(
    parameter ADDR_WIDTH = 32, // Address width for cache lines
    parameter CPUS = 2        // Number of CPUs
)

(
    input logic CLK, nRST, cpuid,
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

typedef enum logic [2:0] {IDLE, WRITE_REQ, READ_REQ, RESP_CHKTAG, RESP_SEND, RESP_INV, WRITE_BACK} state_type; //States for Coherency Unit
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
            if (bcif.ccwait[cpuid]) begin 
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
            if (!bcif.ccwait[cpuid]) begin
                next_state = IDLE;
            end
        end
        WRITE_REQ: begin //handle S -> M, I -> M here
            if (bcif.ccwait[cpuid]) begin 
                next_state = RESP_CHKTAG;
            end
            else if (!bcif.dwait[cpuid]) begin
                next_state = IDLE;
            end
        end
        READ_REQ: begin //dren = 1, daddr = ..., final_state = ccexc ? E : S, handle I -> E and I -> S here
            if (bcif.ccwait[cpuid]) begin 
                next_state = RESP_CHKTAG;
            end
            else if (!bcif.dwait[cpuid]) begin
                next_state = IDLE;
            end
        end
        WRITE_BACK: begin
            if (bcif.ccwait[cpuid]) begin 
                next_state = RESP_CHKTAG;
            end
            else if (!bcif.dwait[cpuid]) begin
                next_state = IDLE;
            end
        end
    endcase
end

always_comb begin: OUTPUTLOGIC
    case(state)
        IDLE: begin
        end
        RESP_CHKTAG: begin
            ccif.set_sel = calculate_set_index(bcif.ccsnoopaddr);
            ccif.snoop_req = 1'b1;
            bcif.ccsnoopdone[cpuid] = 1'b1;
            bcif.ccsnoophit[cpuid] = ccif.snoop_hit;
        end 
        RESP_SEND: begin
            ccif.snoop_req = 1'b1;
            bcif.dstore[cpuid] =  ccif.requested_data;
            bcif.ccsnoophit[cpuid] = 1'b1;
            bcif.ccsnoopdone[cpuid] = 1'b1; //debateable
            if (bcif.ccinv[cpuid]) begin  //Anything -> I
                ccif.state_transfer = cc_end_state'(INVALID); 
            end else begin //Anything -> S
                ccif.state_transfer = cc_end_state'(SHARED); 
            end
            if (ccif.dirty) begin
                bcif.ccdirty[cpuid] = 1'b1;
            end
         end
        WRITE_REQ: begin //handle S -> M, I -> M here
            bcif.ccwrite[cpuid] = 1'b1;
            bcif.daddr[cpuid] = gbif.addr;
            bcif.dstore[cpuid] = ccif.requested_data; //set dstore[supplier] to needed data
            ccif.responder_data = bcif.dload[cpuid];
            ccif.state_transfer = cc_end_state'(MODIFIED); 
        end
        READ_REQ: begin //dren = 1, daddr = ..., final_state = ccexc ? E : S, handle I -> E and I -> S here
            bcif.dREN[cpuid] = 1'b1;
            bcif.daddr[cpuid] = gbif.addr;
            if (bcif.ccexclusive[cpuid]) begin //I -> E
                ccif.state_transfer = cc_end_state'(EXCLUSIVE); 
            end else begin //I -> S
                ccif.state_transfer = cc_end_state'(SHARED);
            end
        end
        WRITE_BACK: begin
            bcif.dWEN[cpuid] = 1'b1;
            bcif.dstore[cpuid] = gbif.wdata;
        end
    endcase
end

//Function to calculate the set index
function logic [$clog2(N_SETS)-1:0] calculate_set_index(logic [31:0] address);
    return (address >> $clog2(BLOCK_SIZE)) & ((1 << $clog2(N_SETS)) - 1);;
endfunction

endmodule
