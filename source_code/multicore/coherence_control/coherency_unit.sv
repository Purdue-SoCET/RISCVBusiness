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
  
module coherency_unit #(
    parameter ADDR_WIDTH = 32, // Address width for cache lines
    parameter CPUS = 2         // Number of CPUs
)(
    input logic CLK, nRST,
    bus_ctrl_if.cc bcif,            // Bus Controller Interface
    cache_coherence_if.coherency_unit ccif_cache, // Cache Coherence Interface
    generic_bus_if.generic_bus cache_data_if //Bus from cache
);

typedef logic [ADDR_WIDTH-1:0] cache_line_t;
typedef enum logic [1:0] {MODIFIED, EXCLUSIVE, SHARED, INVALID} cache_state_t;

cache_state_t current_state, next_state;
cache_line_t snoop_address;

always_ff @(posedge CLK or negedge nRST) begin
    if (!nRST) begin
        current_state <= INVALID;
    end else begin
        current_state <= next_state;
    end
end

/*
always_comb begin
    next_state = current_state;

    if (!ccif_cache.valid) begin
        next_state = INVALID;
    end else if (ccif_cache.dirty) begin
        next_state = MODIFIED;
    end else if (ccif_cache.exclusive) begin
        next_state = EXCLUSIVE;
    end else begin
        next_state = SHARED;
    end

    if (bcif.cctrans[find_requesting_cpu()]) begin
        int cpu = find_requesting_cpu();
        cache_line_t line = bcif.daddr[cpu];

        case (next_state)
            INVALID: handleInvalidState(line, cpu);
            SHARED: handleSharedState(line, cpu);
            EXCLUSIVE: handleExclusiveState(line, cpu);
            MODIFIED: handleModifiedState(line, cpu);
        endcase
    end
end
*/

/*
function int find_requesting_cpu();
    // Loop through the caches to find which one is making a current request
    for (int i = 0; i < CPUS; i++) begin
        // Look for the transition signals
        if (bcif.cctrans[i]) begin
            find_requesting_cpu = i;
            return i;
        end
    end
    find_requesting_cpu = -1; //default return value
    return -1;
endfunction
*/
localparam int NUM_SET_BITS = $clog2(N_SETS);

function int get_set(cache_line_t line);
    get_set = line[NUM_SET_BITS-1:0]; // Extract the set bits from the address
endfunction

task handleInvalidState(cache_line_t line, int cpu);
    ccif_cache.set_sel = get_set(line); // Set the cache set selector
    snoop_address = bcif.daddr[cpu];
    bcif.ccsnoopaddr = {CPUS{snoop_address}};

    if (bcif.dWEN[cpu]) begin
        // Processor 'cpu' write miss
        bcif.ccinv = ~bcif.ccsnoophit;
        bcif.ccwait = bcif.ccinv;
        //next_state = MODIFIED;
        //ccif_cache.state_transfer = MODIFIED;
        ccif_cache.responder_data = bcif.dstore[!cpu];
    end else if (bcif.dREN[cpu]) begin
        // Processor 'cpu' read miss
        if (!bcif.ccIsPresent[cpu]) begin
            //next_state = EXCLUSIVE;
            //ccif_cache.state_transfer = EXCLUSIVE;
        end else begin
            //next_state = SHARED;
            //ccif_cache.state_transfer = SHARED;
        end
        bcif.ccwait[cpu] = ~bcif.ccsnoopdone[cpu];
    end
    bcif.dload[cpu] = bcif.l2load; 
endtask

task handleSharedState(int line, int cpu);
    // Write request -> eviction (S -> I)
    if (bcif.dWEN[cpu] && !bcif.ccwrite[cpu]) begin
        // Processor i read/write, cache miss. Wait for dwait to go low.
        bcif.dwait[cpu] = 0; //Dwait logic needs to happen somewhere else
        bcif.l2addr = bcif.daddr[cpu]; // Prepare to writeback to L2
        bcif.l2WEN = 1; // Write enable to L2
        // Transition to WB in bus controller
        //next_state = INVALID; // Update cache line state
    end
    // Handle bus invalidation (S -> I)
    else if (bcif.ccinv[cpu]) begin
        // Bus invalidation scenario
        bcif.ccsnoopaddr = bcif.daddr[cpu]; // Broadcast snoop address
        bcif.ccwait = ~bcif.ccsnoopdone; // Wait for all snoops to complete
            //next_state = INVALID; // Invalidate cache line
    end
    // Write Miss (S -> M)
    else if (bcif.dREN[cpu] && bcif.ccwrite[cpu]) begin
        // Processor i write, cache miss. Wait for dwait to go low.
        bcif.dwait[cpu] = 0; //Dwait logic needs to happen somewhere else
        bcif.ccsnoopaddr[cpu] = bcif.daddr[cpu]; // Set snoop address
        bcif.ccwait = ~bcif.ccsnoopdone; // Wait for snooping to complete
        bcif.ccinv = '1 & ~(1 << cpu); // Invalidate all except the requester
        
        // Wait for all caches to acknowledge the invalidation
        //next_state = MODIFIED; // Transition to Modified state
    end
endtask

task handleExclusiveState(int line, int cpu);
    // E -> I (Data Eviction) or (Bus Invalidation)
    if (bcif.dWEN[cpu] || (/* bcif.state == GRANT_RX && */ bcif.ccinv[cpu])) begin
        // Processor i read/write, cache miss. Wait for dwait to go low.
        bcif.dwait[cpu] = 0;
        bcif.l2addr[cpu] = bcif.daddr[cpu]; // Writeback address to L2
        bcif.l2WEN = 1; // Write enable to L2
        //next_state = INVALID; // Invalidate cache line
    end
    // E -> S (Bus snooping)
    else if (/*bcif.state == GRANT_R && */bcif.dREN[cpu]) begin
        bcif.ccsnoopaddr = {CPUS{bcif.daddr[cpu]}}; // Snoop address broadcast
        bcif.ccwait = '1; // Set wait high for all
        
        // All non-requester CPUs raise ccsnoopdone after snooping
        /* if (&bcif.ccsnoopdone) begin // All have snooped
            int supplier = find_supplier(cpu);
            if (supplier != -1) begin
                // At least one cache has a copy and it's the supplier
                bcif.dload[cpu] = bcif.dstore[supplier]; // Data from supplier
                bcif.l2store = bcif.dstore[supplier]; // Prepare to writeback to L2
                
                // Supplier cache writes back dirty data to L2
                bcif.l2WEN = 1; // Write enable to L2
                bcif.l2addr = bcif.daddr[cpu]; // Address to write back
            end
            */
            // All caches with snoophit clear exclusive flag
            for (int i = 0; i < CPUS; i++) begin
                if (bcif.ccsnoophit[i]) begin
                    //next_state = SHARED; // Set state to Shared
                    bcif.ccexclusive[i] = 0; // Clear exclusive flag
                end
            end
            
            // Clear wait signals after transfers are complete
            bcif.dwait[cpu] = 0;
            bcif.ccwait = '0;
        end
endtask

task handleModifiedState(int line, int cpu);
    // M -> I (Data Eviction) or (Bus Invalidation)
    if ((bcif.dWEN[cpu] && !bcif.ccwrite[cpu]) || 
        (/* bcif.state == GRANT_RX && */bcif.ccinv[cpu])) begin
        // Processor i read/write, cache miss. Wait for dwait to go low.
        bcif.dwait[cpu] = 0;
        
        // Transition to writeback state in bus controller
        bcif.l2addr[cpu] = bcif.daddr[cpu]; // Writeback address to L2
        bcif.l2WEN = 1; // Write enable to L2
        
        // Update cache line state
        //next_state = INVALID; // Invalidate cache line
    end
    // M -> S (Bus snooping)
    else if (/*bcif.state == GRANT_R && */bcif.dREN[cpu]) begin
        // Bus sets snoop address and waits high for all non-requester CPUs
        bcif.ccsnoopaddr = {CPUS{bcif.daddr[cpu]}}; // Snoop address broadcast
        bcif.ccwait = '1; // Set wait high for all
        
        // All non-requester CPUs raise ccsnoopdone after snooping
        if (&bcif.ccsnoopdone) begin // All have snooped
           /*  int supplier = find_supplier(cpu);
            if (supplier != -1) begin
                bcif.dload[cpu] = bcif.dstore[supplier]; // Data from supplier
                bcif.l2store = bcif.dstore[supplier]; // Prepare to writeback to L2
                
                // Supplier cache writes back dirty data to L2
                bcif.l2WEN = 1; // Write enable to L2
                bcif.l2addr = bcif.daddr[cpu]; // Address to write back
            end */
            
            // All caches with snoophit clear exclusive flag
            for (int i = 0; i < CPUS; i++) begin
                if (bcif.ccsnoophit[i]) begin
                    //next_state = SHARED; // Set state to Shared
                    bcif.ccexclusive[i] = 0; // Clear exclusive flag
                end
            end
            
            // Clear wait signals after transfers are complete
            bcif.dwait[cpu] = 0; // Clear wait for requester
            bcif.ccwait = '0; // Clear all wait signals
        end
    end
endtask

endmodule
