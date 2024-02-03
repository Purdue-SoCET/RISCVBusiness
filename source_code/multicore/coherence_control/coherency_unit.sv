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
    cache_coherence_if.coherency_unit ccif_cache // Cache Coherence Interface
);

    // Define cache_line_t based on ADDR_WIDTH
    typedef logic [ADDR_WIDTH-1:0] cache_line_t;

    // Coherency state for the selected cache set
    typedef enum logic [1:0] {MODIFIED, EXCLUSIVE, SHARED, INVALID} cache_state_t;
    cache_state_t current_state = INVALID;

    cache_line_t snoop_address;

    always_ff @(posedge CLK or negedge nRST) begin
        if (!nRST) begin
            current_state = INVALID;
        end else begin
            if (!ccif_cache.valid) begin
                current_state = INVALID;
            end else if (ccif_cache.dirty) begin
                current_state = MODIFIED;
            end else if (ccif_cache.exclusive) begin
                current_state = EXCLUSIVE;
            end else begin
                current_state = SHARED;
            end
        end
    end

    always_comb begin
        if (bcif.cctrans[find_requesting_cpu()]) begin
            int cpu = find_requesting_cpu(); // Find the cpu who is doing the transfer
            cache_line_t line = bcif.daddr[cpu]; // Get the cache line being accessed

            case (current_state)
                INVALID: handleInvalidState(line, cpu);
                SHARED: handleSharedState(line, cpu);
                EXCLUSIVE: handleExclusiveState(line, cpu);
                MODIFIED: handleModifiedState(line, cpu);
            endcase
        end
    end
end

function int find_requesting_cpu();
    // Loop through the caches to find which one is making a current request
    for (int i = 0; i < CPUS; i++) begin
        // Look for the transition signals
        if (bcif.cctrans[i]) begin
            find_requesting_cpu = i;
            return;
        end
    end
    find_requesting_cpu = -1; //default return value
endfunction

function int get_set(cache_line_t line);
        // Calculate set index from the line
        int num_set_bits = $clog2(N_SETS);
        get_set = line[num_set_bits-1:0];
endfunction

task handleInvalidState(cache_line_t line, int cpu);
    ccif_cache.set_sel = get_set(line); // Set the cache set selector
    snoop_address = bcif.daddr[cpu];
    bcif.ccsnoopaddr = {CPUS{snoop_address}};

    if (bcif.dWEN[cpu]) begin
        // Processor 'cpu' write miss
        bcif.ccinv = ~bcif.ccsnoophit;
        bcif.ccwait = bcif.ccinv;
        current_state = MODIFIED;
        ccif_cache.state_transfer = MODIFIED;
        ccif_cache.requested_data = bcif.dstore[!cpu];
    end else if (bcif.dREN[cpu]) begin
        // Processor 'cpu' read miss
        if (!bcif.ccIsPresent[cpu]) begin
            current_state = EXCLUSIVE;
            ccif_cache.state_transfer = EXCLUSIVE;
        end else begin
            current_state = SHARED;
            ccif_cache.state_transfer = SHARED;
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
        bcif.l2load = bcif.dload[cpu]; // Data to write back
        bcif.l2WEN = 1; // Write enable to L2
        // Transition to WB in bus controller
        cache_states[line] = INVALID; // Update cache line state
    end
    // Handle bus invalidation (S -> I)
    else if (bcif.BusState == GRANT_RX && bcif.ccinv[cpu]) begin
        // Bus invalidation scenario
        bcif.ccsnoopaddr = bcif.daddr[cpu]; // Broadcast snoop address
        bcif.ccwait = ~bcif.ccsnoopdone; // Wait for all snoops to complete
        if (all_caches_snooped()) begin
            cache_states[line] = INVALID; // Invalidate cache line
        end
    end
    // Write Miss (S -> M)
    else if (bcif.dREN[cpu] && bcif.ccwrite[cpu]) begin
        // Processor i write, cache miss. Wait for dwait to go low.
        bcif.dwait[cpu] = 0; //Dwait logic needs to happen somewhere else
        bcif.ccsnoopaddr[cpu] = bcif.daddr[cpu]; // Set snoop address
        bcif.ccwait = ~bcif.ccsnoopdone; // Wait for snooping to complete
        bcif.ccinv = '1 & ~(1 << cpu); // Invalidate all except the requester
        
        // Wait for all caches to acknowledge the invalidation
        if (all_caches_snooped_except(cpu)) begin
            cache_states[line] = MODIFIED; // Transition to Modified state
        end
    end
endtask

task handleExclusiveState(int line, int cpu);
    // E -> I (Data Eviction) or (Bus Invalidation)
    if (bcif.dWEN[cpu] || (bcif.state == GRANT_RX && bcif.ccinv[cpu])) begin
        // Processor i read/write, cache miss. Wait for dwait to go low.
        bcif.dwait[cpu] = 0;
        bcif.l2addr[cpu] = bcif.daddr[cpu]; // Writeback address to L2
        bcif.l2load[cpu] = bcif.dload[cpu]; // Writeback data to L2
        bcif.l2WEN = 1; // Write enable to L2
        cache_states[line] = INVALID; // Invalidate cache line
    end
    // E -> S (Bus snooping)
    else if (bcif.state == GRANT_R && bcif.dREN[cpu]) begin
        bcif.ccsnoopaddr = {CPUS{bcif.daddr[cpu]}}; // Snoop address broadcast
        bcif.ccwait = '1; // Set wait high for all
        
        // All non-requester CPUs raise ccsnoopdone after snooping
        if (&bcif.ccsnoopdone) begin // All have snooped
            int supplier = find_supplier(cpu);
            if (supplier != -1) begin
                // At least one cache has a copy and it's the supplier
                bcif.dload[cpu] = bcif.dstore[supplier]; // Data from supplier
                bcif.l2store = bcif.dstore[supplier]; // Prepare to writeback to L2
                
                // Supplier cache writes back dirty data to L2
                bcif.l2WEN = 1; // Write enable to L2
                bcif.l2addr = bcif.daddr[cpu]; // Address to write back
            end
            
            // All caches with snoophit clear exclusive flag
            for (int i = 0; i < CPUS; i++) begin
                if (bcif.ccsnoophit[i]) begin
                    cache_states[bcif.daddr[i]] = SHARED; // Set state to Shared
                    bcif.ccexclusive[i] = 0; // Clear exclusive flag
                end
            end
            
            // Clear wait signals after transfers are complete
            bcif.dwait[cpu] = 0;
            bcif.ccwait = '0;
        end
    end
endtask

task handleModifiedState(int line, int cpu);
    // M -> I (Data Eviction) or (Bus Invalidation)
    if ((bcif.dWEN[cpu] && !bcif.ccwrite[cpu]) || 
        (bcif.state == GRANT_RX && bcif.ccinv[cpu])) begin
        // Processor i read/write, cache miss. Wait for dwait to go low.
        bcif.dwait[cpu] = 0;
        
        // Transition to writeback state in bus controller
        bcif.l2addr[cpu] = bcif.daddr[cpu]; // Writeback address to L2
        bcif.l2load[cpu] = bcif.dload[cpu]; // Writeback data to L2
        bcif.l2WEN = 1; // Write enable to L2
        
        // Update cache line state
        cache_states[line] = INVALID; // Invalidate cache line
    end
    // M -> S (Bus snooping)
    else if (bcif.state == GRANT_R && bcif.dREN[cpu]) begin
        // Bus sets snoop address and waits high for all non-requester CPUs
        bcif.ccsnoopaddr = {CPUS{bcif.daddr[cpu]}}; // Snoop address broadcast
        bcif.ccwait = '1; // Set wait high for all
        
        // All non-requester CPUs raise ccsnoopdone after snooping
        if (&bcif.ccsnoopdone) begin // All have snooped
            int supplier = find_supplier(cpu);
            if (supplier != -1) begin
                bcif.dload[cpu] = bcif.dstore[supplier]; // Data from supplier
                bcif.l2store = bcif.dstore[supplier]; // Prepare to writeback to L2
                
                // Supplier cache writes back dirty data to L2
                bcif.l2WEN = 1; // Write enable to L2
                bcif.l2addr = bcif.daddr[cpu]; // Address to write back
            end
            
            // All caches with snoophit clear exclusive flag
            for (int i = 0; i < CPUS; i++) begin
                if (bcif.ccsnoophit[i]) begin
                    cache_states[bcif.daddr[i]] = SHARED; // Set state to Shared
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
