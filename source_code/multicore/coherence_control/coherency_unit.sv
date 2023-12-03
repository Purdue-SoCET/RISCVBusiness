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
    parameter CPUS = 2,
    parameter ADDR_WIDTH = 32,
    parameter CACHE_LINES = 256
)(
    input logic CLK, nRST,
    bus_ctrl_if.cc ccif
);

    // Coherency states
    typedef enum logic [1:0] {MODIFIED, EXCLUSIVE, SHARED, INVALID} cache_state_t;
    cache_state_t cache_states[1<<ADDR_WIDTH];

    logic [ADDR_WIDTH-1:0] snoop_address; // Used to store the current address being snooped
    logic [CPUS-1:0] cache_request; // cache miss
    logic [CPUS-1:0] cache_write; // there is a write request
  
always_ff @(posedge CLK or negedge nRST) begin
    if (!nRST) begin
        for (int i = 0; i < (1<<ADDR_WIDTH); i++) begin
            cache_states[i] = INVALID;
        end
    end else begin
        for (int cpu = 0; cpu < CPUS; cpu++) begin
            cache_request[cpu] = ccif.dREN[cpu] && !ccif.dwait[cpu];
            cache_write[cpu] = ccif.ccwrite[cpu];
            
            if (cache_request[cpu] || cache_write[cpu]) begin
                int line = ccif.daddr[cpu];
                case (cache_states[line])
                    INVALID: handleInvalidState(line, cpu);
                    SHARED: handleSharedState(line, cpu);
                    EXCLUSIVE: handleExclusiveState(line, cpu);
                    MODIFIED: handleModifiedState(line, cpu);
                endcase
            end
        end
    end
end

always_comb begin
    ccif.ccwait = '0;
    ccif.ccinv = '0;
    ccif.ccsnoopaddr = '0;
    ccif.dwait = '0;
    ccif.l2WEN = '0;
    ccif.l2REN = '0;
    ccif.ccexclusive = '0;

    for (int cpu = 0; cpu < CPUS; cpu++) begin
        int line = ccif.daddr[cpu];

        case (cache_states[line])
            INVALID: begin
                if (ccif.dREN[cpu]) begin
                    // Read request from the CPU
                    ccif.l2REN = 1; // Enable read from L2 cache
                    ccif.l2addr = ccif.daddr[cpu];
                    ccif.dwait[cpu] = 1; // CPU should wait for the data

                    // Broadcast snoop address to check if other caches have the data
                    ccif.ccsnoopaddr = {CPUS{ccif.daddr[cpu]}};

                    // Set ccexclusive high if no other cache reports having this data
                    ccif.ccexclusive[cpu] = ~|ccif.ccsnoophit;
                end
                if (ccif.dWEN[cpu]) begin
                    // Write request from the CPU
                    // Initiate snoop to check if other caches hold this data
                    ccif.ccsnoopaddr = {CPUS{ccif.daddr[cpu]}};
                    ccif.dwait[cpu] = 1; //Dwait logic needs to happen somewhere else
                    for (int i = 0; i < CPUS; i++) begin
                        if (i != cpu) begin
                            ccif.ccinv[i] = 1;
                        end
                    end
                end
            end
            SHARED: begin
                // If there's a read request from this CPU
                if (ccif.dREN[cpu]) begin
                    ccif.dwait[cpu] = 0; //Dwait logic needs to happen somewhere else

                    // If there's a write request, initiate invalidation to transition to M
                    if (ccif.ccwrite[cpu]) begin
                        // Set signals to initiate the invalidation process
                        ccif.ccinv = '1 & ~(1 << cpu); // Invalidate in all caches except this one
                        ccif.ccsnoopaddr[cpu] = ccif.daddr[cpu]; // Broadcast snoop address
                        ccif.ccwait[cpu] = 1; // CPU should wait until invalidation is complete
                    end
                end
                // Handle snooping requests from other CPUs
                for (int other_cpu = 0; other_cpu < CPUS; other_cpu++) begin
                    if (other_cpu != cpu && ccif.ccsnoopaddr[other_cpu] == ccif.daddr[cpu]) begin
                        ccif.ccsnoopdone[other_cpu] = 1; // Indicate snooping is complete
                    end
                end
            end
            EXCLUSIVE: begin
                // When a cache line is EXCLUSIVE
                if (ccif.dREN[cpu]) begin
                    // If there's a read request
                    ccif.dwait[cpu] = 0; //Dwait logic needs to happen somewhere else
                    // If a write occurs, prepare to transition to MODIFIED state
                    if (ccif.ccwrite[cpu]) begin
                        // Invalidate other copies if present (though, in EXCLUSIVE, there shouldn't be any)
                        ccif.ccinv = '1 & ~(1 << cpu);
                        ccif.ccsnoopaddr[cpu] = ccif.daddr[cpu];
                        ccif.ccwait[cpu] = 1;
                        // Transition to M
                    end
                end
                // Handle other CPU's snoop requests
                for (int other_cpu = 0; other_cpu < CPUS; other_cpu++) begin
                    if (other_cpu != cpu && ccif.ccsnoopaddr[other_cpu] == ccif.daddr[cpu]) begin
                        ccif.ccsnoopdone[other_cpu] = 1; // Indicate snooping complete
                    end
                end
            end
            MODIFIED: begin
                if (ccif.dWEN[cpu]) begin
                    // Write-back request from the CPU
                    ccif.l2WEN = 1; // Enable write to L2 cache
                    ccif.l2addr = ccif.daddr[cpu]; // Address to write to L2
                    ccif.l2store = ccif.dstore[cpu]; // Data to write back to L2
                end
                // Handle other CPU's snoop requests
                for (int other_cpu = 0; other_cpu < CPUS; other_cpu++) begin
                    if (other_cpu != cpu && ccif.ccsnoopaddr[other_cpu] == ccif.daddr[cpu]) begin
                        // Respond to the snooping request
                        ccif.ccsnoopdone[other_cpu] = 1; // Indicate snooping is complete
                        ccif.ccsnoophit[other_cpu] = 1; // Indicate that the data is present and modified
                    end
                end
            end
        endcase
    end
end

// Transition from Invalid State
task automatic handleInvalidState(int line, int cpu);
    // Processor read miss, set the snoop address for all other CPUs
    snoop_address = ccif.daddr[cpu];
    ccif.ccsnoopaddr = {CPUS{snoop_address}};
    
    if (cache_write[cpu]) begin
        // Processor i write, cache miss
        ccif.ccinv = ~ccif.ccsnoophit; // Invalidate if no other cache has a clean copy
        ccif.ccwait = ccif.ccinv; // Wait for invalidation to complete
        cache_states[line] = MODIFIED; // Transition to Modified State
    end else begin
        // Processor i read, cache miss
        if (!ccif.ccIsPresent) begin
            // Clean copy does not exist in another cache
            cache_states[line] = EXCLUSIVE;
        end else begin
            // Clean copy exists in another cache
            cache_states[line] = SHARED;
        end
        ccif.ccwait = ~ccif.ccsnoopdone; // Wait for snooping to complete
    end
    // Set the dload to bring data to the cache
    ccif.dload[cpu] = ccif.l2load;
endtask

task automatic handleSharedState(int line, int cpu);
    // Write request -> eviction (S -> I)
    if (ccif.dWEN[cpu] && !ccif.ccwrite[cpu]) begin
        // Processor i read/write, cache miss. Wait for dwait to go low.
        ccif.dwait[cpu] = 0; //Dwait logic needs to happen somewhere else
        ccif.l2addr = ccif.daddr[cpu]; // Prepare to writeback to L2
        ccif.l2load = ccif.dload[cpu]; // Data to write back
        ccif.l2WEN = 1; // Write enable to L2
        // Transition to WB in bus controller
        cache_states[line] = INVALID; // Update cache line state
    end
    // Handle bus invalidation (S -> I)
    else if (ccif.BusState == GRANT_RX && ccif.ccinv[cpu]) begin
        // Bus invalidation scenario
        ccif.ccsnoopaddr = ccif.daddr[cpu]; // Broadcast snoop address
        ccif.ccwait = ~ccif.ccsnoopdone; // Wait for all snoops to complete
        if (all_caches_snooped()) begin
            cache_states[line] = INVALID; // Invalidate cache line
        end
    end
    // Write Miss (S -> M)
    else if (ccif.dREN[cpu] && ccif.ccwrite[cpu]) begin
        // Processor i write, cache miss. Wait for dwait to go low.
        ccif.dwait[cpu] = 0; //Dwait logic needs to happen somewhere else
        ccif.ccsnoopaddr[cpu] = ccif.daddr[cpu]; // Set snoop address
        ccif.ccwait = ~ccif.ccsnoopdone; // Wait for snooping to complete
        ccif.ccinv = '1 & ~(1 << cpu); // Invalidate all except the requester
        
        // Wait for all caches to acknowledge the invalidation
        if (all_caches_snooped_except(cpu)) begin
            cache_states[line] = MODIFIED; // Transition to Modified state
        end
    end
endtask

task automatic handleExclusiveState(int line, int cpu);
    // E -> I (Data Eviction) or (Bus Invalidation)
    if (ccif.dWEN[cpu] || (ccif.state == GRANT_RX && ccif.ccinv[cpu])) begin
        // Processor i read/write, cache miss. Wait for dwait to go low.
        ccif.dwait[cpu] = 0;
        ccif.l2addr[cpu] = ccif.daddr[cpu]; // Writeback address to L2
        ccif.l2load[cpu] = ccif.dload[cpu]; // Writeback data to L2
        ccif.l2WEN = 1; // Write enable to L2
        cache_states[line] = INVALID; // Invalidate cache line
    end
    // E -> S (Bus snooping)
    else if (ccif.state == GRANT_R && ccif.dREN[cpu]) begin
        ccif.ccsnoopaddr = {CPUS{ccif.daddr[cpu]}}; // Snoop address broadcast
        ccif.ccwait = '1; // Set wait high for all
        
        // All non-requester CPUs raise ccsnoopdone after snooping
        if (&ccif.ccsnoopdone) begin // All have snooped
            int supplier = find_supplier(cpu);
            if (supplier != -1) begin
                // At least one cache has a copy and it's the supplier
                ccif.dload[cpu] = ccif.dstore[supplier]; // Data from supplier
                ccif.l2store = ccif.dstore[supplier]; // Prepare to writeback to L2
                
                // Supplier cache writes back dirty data to L2
                ccif.l2WEN = 1; // Write enable to L2
                ccif.l2addr = ccif.daddr[cpu]; // Address to write back
            end
            
            // All caches with snoophit clear exclusive flag
            for (int i = 0; i < CPUS; i++) begin
                if (ccif.ccsnoophit[i]) begin
                    cache_states[ccif.daddr[i]] = SHARED; // Set state to Shared
                    ccif.ccexclusive[i] = 0; // Clear exclusive flag
                end
            end
            
            // Clear wait signals after transfers are complete
            ccif.dwait[cpu] = 0;
            ccif.ccwait = '0;
        end
    end
endtask

task automatic handleModifiedState(int line, int cpu);
    // M -> I (Data Eviction) or (Bus Invalidation)
    if ((ccif.dWEN[cpu] && !ccif.ccwrite[cpu]) || 
        (ccif.state == GRANT_RX && ccif.ccinv[cpu])) begin
        // Processor i read/write, cache miss. Wait for dwait to go low.
        ccif.dwait[cpu] = 0;
        
        // Transition to writeback state in bus controller
        ccif.l2addr[cpu] = ccif.daddr[cpu]; // Writeback address to L2
        ccif.l2load[cpu] = ccif.dload[cpu]; // Writeback data to L2
        ccif.l2WEN = 1; // Write enable to L2
        
        // Update cache line state
        cache_states[line] = INVALID; // Invalidate cache line
    end
    // M -> S (Bus snooping)
    else if (ccif.state == GRANT_R && ccif.dREN[cpu]) begin
        // Bus sets snoop address and waits high for all non-requester CPUs
        ccif.ccsnoopaddr = {CPUS{ccif.daddr[cpu]}}; // Snoop address broadcast
        ccif.ccwait = '1; // Set wait high for all
        
        // All non-requester CPUs raise ccsnoopdone after snooping
        if (&ccif.ccsnoopdone) begin // All have snooped
            int supplier = find_supplier(cpu);
            if (supplier != -1) begin
                ccif.dload[cpu] = ccif.dstore[supplier]; // Data from supplier
                ccif.l2store = ccif.dstore[supplier]; // Prepare to writeback to L2
                
                // Supplier cache writes back dirty data to L2
                ccif.l2WEN = 1; // Write enable to L2
                ccif.l2addr = ccif.daddr[cpu]; // Address to write back
            end
            
            // All caches with snoophit clear exclusive flag
            for (int i = 0; i < CPUS; i++) begin
                if (ccif.ccsnoophit[i]) begin
                    cache_states[ccif.daddr[i]] = SHARED; // Set state to Shared
                    ccif.ccexclusive[i] = 0; // Clear exclusive flag
                end
            end
            
            // Clear wait signals after transfers are complete
            ccif.dwait[cpu] = 0; // Clear wait for requester
            ccif.ccwait = '0; // Clear all wait signals
        end
    end
endtask

// Utility function to find which cache has the copy of the data
function int find_supplier(int requester);
    for (int i = 0; i < CPUS; i++) begin
        if (i != requester && ccif.ccsnoophit[i]) begin
            return i; // Found the supplier
        end
    end
  return -1; // No supplier found
endfunction

// Check if any other cache has raised a snoop hit
function logic any_cache_has_hit();
    return |ccif.ccsnoophit;
endfunction

// Check if all caches except the requester have raised ccsnoopdone
function logic all_caches_snooped_except(int cpu);
    logic [CPUS-1:0] all_except_requester;
    all_except_requester = ~ccif.ccsnoopdone & ~(1 << cpu);
return &all_except_requester;
endfunction

endmodule