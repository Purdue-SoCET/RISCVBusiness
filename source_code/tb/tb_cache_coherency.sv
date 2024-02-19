// Written by: Burkay Sahin
// Last updated: 2/14/24
//
// Module Summary:
//   A testbench that combines an L1 cache and a coherency unit.
//   Designed to test bus requests and responses

`include "generic_bus_if.vh"
`include "cache_control_if.vh"
`include "cache_coherence_if.vh"
`include "bus_ctrl_if.vh"

`timescale 1ns/100ps

parameter PERIOD = 10;

module tb_cache_coherency();
    logic CLK = 0, nRST;
    // clock
    always #(PERIOD/2) CLK++; 

    generic_bus_if proc_gen_bus_if(); //Processor to cache
    cache_control_if cc_if(); //Processor to cache
    generic_bus_if #(.BLOCK_SIZE(2)) mem_gen_bus_if(); //Cache to coherency unit
    cache_coherence_if d_cache_coherency_if (); //Cache to coherency unit
    bus_ctrl_if bus_ctrl_if(); //Coherency unit to bus

  // test program
  test PROG (CLK, nRST, proc_gen_bus_if, cc_if, mem_gen_bus_if, d_cache_coherency_if, bus_ctrl_if);
  // DUT
  cache_coh_wrapper DUT(CLK, nRST, proc_gen_bus_if, cc_if, mem_gen_bus_if, d_cache_coherency_if, bus_ctrl_if);


endmodule

program test
(
    input CLK, output logic nRST,
    generic_bus_if.generic_bus gbif, //Processor to cache
    cache_control_if.dcache ccif, //Processor to cache, L1 doesn't contain cache_control_if currently
    generic_bus_if.cpu mbif, //Cache to coherency unit
    cache_coherence_if dcif, //Cache to coherency unit
    bus_ctrl_if bcif  //Coherency unit to bus
);

task init_cache;
begin
    ccif.dcache_clear = 1'b0;
    ccif.dcache_flush = 1'b0;
    ccif.dcache_reserve = 1'b0;
    ccif.dcache_exclusive = 1'b0;
    gbif.ren = 1'b0;
    gbif.wen = 1'b0;
    gbif.wdata = 32'b0;
    gbif.addr = 32'b0;
    gbif.byte_en = 4'b0;
    bcif.ccIsPresent[1] = 1'b0;
    bcif.ccdirty[1] = 1'b0;
    bcif.ccsnoopdone[1] = 1'b1;
    bcif.ccsnoophit[1] = 1'b0;
    bcif.ccwrite[1] = 1'b0;
    bcif.dstore[1] = 64'b0;
    bcif.daddr[1] = 32'b0;
    bcif.dWEN[1] = 1'b0;
    bcif.dREN[1] = 1'b0;
    bcif.l2load = 32'b0;
    bcif.l2state = L2_FREE;

    nRST = 1'b0;
    @(negedge CLK);
    nRST = 1'b1;
    @(negedge CLK);
end
endtask

task read_request;
    input logic [31:0] addr;
    input logic [63:0] data;
begin
    gbif.ren = 1'b1;
    gbif.addr = addr;

    bcif.l2state = L2_BUSY;
    wait(bcif.l2REN);
    #(PERIOD);
    bcif.l2load = data[31:0];
    bcif.l2state = L2_ACCESS;
    #(PERIOD);
    bcif.l2state = L2_BUSY;
    wait(bcif.l2REN);
    bcif.l2load = data[63:32];
    bcif.l2state = L2_ACCESS;
    #(PERIOD);
    bcif.l2state = L2_FREE;

    wait(gbif.busy == 1'b0);
    @(negedge CLK)

    gbif.ren = 1'b0;
end
endtask

integer tb_test_num;
string tb_test_case;

initial begin
//Test case 1: Transition I -> E
    tb_test_num = 1;
    tb_test_case = "Transition I -> E";

    //Reset to isolate each test case
    init_cache();
    read_request(32'h80000000, 64'hCAFECAFECAFECAFE);

    // Cache sets dREN[I] high
    wait(bcif.dREN == 1'b1);

    // Bus transitions IDLE -> GRANT_R
    #(10 * PERIOD); //Some time to pass for snooping

    wait(bcif.ccsnoopdone[1] == 1'b1); // All non-requester CPUs raise ccsnoopdone
    wait(bcif.ccsnoophit[1] == 1'b0); // None raise ccsnoophit

    // Transition SNOOP_R -> READ_L2
    wait(bcif.dload == bcif.l2load); // Cache loads data from L2

    // Transition BUS_TO_CACHE
    wait(bcif.dwait == 0); // Bus sets dwait low
    wait(bcif.ccexclusive == 1); // Bus sets ccexclusive high

    // Transition back to IDLE, de-assert signals
    @(negedge CLK); // Wait for the changes to propagate

    //Look at the coherency unit outputs
    if (dcif.state_transfer == EXCLUSIVE) begin // Assuming 'state' correctly reflects the cache state
        $display("%s passed", tb_test_case);
    end else begin
         $error("Cache transfer state incorrect");
    end

    gbif.ren = 1'b0; //Turn off read request from processor

// Test case 2: Transition I -> S
    #(50);
    tb_test_num = tb_test_num + 1;
    tb_test_case = "Transition I -> S";

    // Reset to isolate each test case
    nRST = 1'b0;
    @(negedge CLK);
    nRST = 1'b1;
    @(negedge CLK);

    // Processor i read, cache miss.
    gbif.addr = 32'h44422244;
    gbif.ren = 1'b1; // Coherency unit should go to READ_REQ
    wait (gbif.busy == 1'b0); 

    // Wait for the cache to recognize the read request
    wait(bcif.dREN == 1'b1); // Assuming dREN goes high indicating a read request to the cache

    // Bus transitions IDLE -> GRANT_R
    bcif.ccsnoopaddr = gbif.addr;
    #(10); // Allow time for state change and snooping

    bcif.ccsnoopdone[1] = 1'b1; // Snooping complete in the other CPU
    bcif.ccsnoophit[1] = 1'b1; // Clean copy exists in the other Cache

    // Transition SNOOP_R -> TRANSFER_R
    bcif.dstore[1] = {8{32'hA5A5A5A5}}; 

    // BUS_TO_CACHE transfer
    wait(bcif.dload == bcif.dstore[1]); 
    wait(bcif.l2store == bcif.dstore[1]); 

    // Transition to IDLE after data transfer
    wait(bcif.dwait == 0); // Check if the bus transaction is completed
    wait(bcif.ccexclusive[1] == 0); // Check that it is not exclusive 

    // De-assert signals to return to IDLE state
    @(negedge CLK);

    if (dcif.state_transfer == SHARED) begin // Assuming 'state' correctly reflects the cache state
        $display("%s passed", tb_test_case);
    end else begin
        $error("%s failed: Cache did not transition to SHARED state", tb_test_case);
    end

    gbif.ren = 1'b0; // Reset read request from the processor

// Test case 3: Transition I -> M
    #(50);
    tb_test_num = tb_test_num + 1;
    tb_test_case = "Transition I -> M";

    // Reset to isolate each test case
    nRST = 1'b0;
    @(negedge CLK);
    nRST = 1'b1;
    @(negedge CLK);

    // Processor i read, cache miss. Set up the read request
    gbif.addr = 32'hAA551343;
    gbif.wen = 1'b1; // Coherency unit should go to WRITE_REQ
    wait (gbif.busy == 1'b0); 

    // Wait for the cache to acknowledge the write request
    wait(bcif.dREN == 1'b1 && bcif.ccwrite == 1'b1); // Ensure dREN and ccwrite are asserted

    // Bus transitions IDLE -> GRANT_RX
    if (bcif.ccinv[1] == 1'b1) begin
        $display("%s received correct ccinv", tb_test_case);
    end else begin
        $error("%s failed: did not receive correct ccinv", tb_test_case);
    end
    #(10); // Allow time for snooping and invalidation

    bcif.ccsnoopdone[1] = 1'b1; // Indicate that snooping has completed
    bcif.ccsnoophit[1] = 1'b1; // Indicate that a clean copy was found in another cache

    // Transition SNOOP_RX -> TRANSFER_RX
    bcif.dstore[1] = 32'hB5B5B5B5;

    // Simulate BUS_TO_CACHE transfer
    wait(bcif.dload == bcif.dstore[1]); 

    #(10); // Wait to simulate time for other caches to invalidate their blocks
    if (bcif.ccinv[1] == 1'b0) begin
        $display("%s received correct ccinv", tb_test_case);
    end else begin
        $error("%s failed: did not receive correct ccinv", tb_test_case);
    end

    // Transition to IDLE after data transfer
    wait(bcif.dwait == 0); // Check if the bus transaction is completed
    wait(bcif.ccexclusive[1] == 0); // Check that it's not exclusive access

    // De-assert signals to return to IDLE state
    @(negedge CLK);

    // Validate final state
    if (dcif.state_transfer == MODIFIED) begin // Assuming 'state' correctly reflects the cache state
        $display("%s passed", tb_test_case);
    end else begin
        $error("%s failed: Cache did not transition to MODIFIED state", tb_test_case);
    end

    gbif.wen = 1'b0; // Reset write request from the processor

//Test case 4: M -> S
    #(50);
    tb_test_num = tb_test_num + 1;
    tb_test_case = "Transition M -> S";

    // Reset to isolate each test case
    nRST = 1'b0;
    @(negedge CLK);
    nRST = 1'b1;
    @(negedge CLK);

    bcif.ccsnoopaddr = 32'hDDEE11FF;

    #(10);

    wait(bcif.ccsnoopdone[0] == {CPUS{1'b1}}); // All non-requester CPUs have finished snooping
    wait(bcif.ccsnoophit[0] == 1'b1); // This CPU has the data (others would be 0)
    wait(bcif.dstore[1] == dcif.requested_data);
    wait(bcif.ccdirty[0] == 1'b1);

    // bcif.l2WEN = 1'b1;
    // bcif.l2addr = bcif.ccsnoopaddr; 
    bcif.l2load = bcif.dstore;
    #(20);
    if (bcif.l2WEN == 1'b1) begin
        $display("%s received correct l2WEN", tb_test_case);
    end else begin
        $error("%s failed: Did not receive correct l2WEN", tb_test_case);
    end
    if (bcif.l2store == /* TODO */ 1'b1) begin
        $display("%s received correct l2store", tb_test_case);
    end else begin
        $error("%s failed: Did not receive correct l2store", tb_test_case);
    end


    wait(bcif.ccdirty[0] == 1'b0); // Clear the dirty flag 

    // The bus updates after the writeback and sharing process
    // bcif.ccexclusive = 1'b0; // Exclusive flag is cleared as the data is now shared
    // bcif.dwait[0] = 1'b0; // Clear the wait signal for the requester to proceed

    if (dcif.state_transfer != SHARED) begin
        $error("%s failed: Cache did not transition to SHARED state after snooping", tb_test_case);
    end else begin
        $display("%s passed", tb_test_case);
    end

//Test case 5: S -> I (Data Eviction)
    #(50);
    tb_test_num = tb_test_num + 1;
    tb_test_case = "Transition S -> I (Data Eviction)";

    // Reset to isolate each test case
    init_cache();

    // Processor initiates a read/write, causing a cache miss
    gbif.addr = 32'h77788899;
    gbif.ren = 1'b1;
    wait (bcif.dwait[0] == 1'b0); // Wait for dwait to go low

    // Cache initiates eviction due to the miss
    ccif.dWEN = 1'b1; // Indicate data eviction
    ccif.ccwrite = 1'b0; // this is an eviction, not a processor WB

    // Bus reacts to eviction request
    bcif.l2addr[0] = gbif.addr; // Set L2 address for writeback to match the evicted cache line address
    wait(ccif.dload); 
    bcif.l2load[0] = ccif.dload; 
    bcif.l2WEN[0] = 1'b1;

    // After writeback, ensure the cache line is invalidated
    #(10);
    ccif.dWEN = 1'b0; 
    bcif.dwait = 'b0; 
    bcif.l2WEN = 'b0; 

    if (dcif.state_transfer != INVALID) begin
        $error("%s failed: Cache did not transition to INVALID state after eviction", tb_test_case);
    end else begin
        $display("%s passed", tb_test_case);
    end

    gbif.ren = 1'b0;
    gbif.addr = 32'b0;
    
//Test case 6: S -> I (Bus Invalidation)
    #(50);
    tb_test_num = tb_test_num + 1;
    tb_test_case = "Transition S -> I (Bus Invalidation)";

    // Reset to isolate each test case
    init_cache();

    // Setting up the bus to simulate a read-exclusive action
    bcif.ccsnoopaddr = 32'h888999AA;
    bcif.ccwait[0] = 1'b1;
    bcif.ccinv[0] = 1'b1;

    // Simulate the snoop responses from non-requester CPUs
    #(10 * PERIOD);
    // Assume CPU 1 is the supplier which has the data
    bcif.ccsnoopdone[1] = 1'b1;
    bcif.ccsnoophit[1] = 1'b1;
    ccif.dstore = 64'hDEADBEEFDEADBEEF; // Set needed data from the supplier

    // Transition from SNOOP_RX to TRANSFER_RX
    bcif.dstore[1] = ccif.dstore; // Transfer data from supplier cache to the bus

    // All caches with snoophit invalidate their block once ccinv goes low
    #(10 * PERIOD);
    bcif.ccinv[0] = 1'b0; // End of invalidation 

    if (dcif.state_transfer != INVALID) begin
        $error("%s failed: Cache did not transition to INVALID state after bus invalidation", tb_test_case);
    end else begin
        $display("%s passed", tb_test_case);
    end

    bcif.ccwait = 'b0;
    bcif.ccsnoopdone = 'b0;
    bcif.ccsnoophit = 'b0;


end

endprogram