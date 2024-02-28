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

task reset_snoop_signals;
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
    bcif.ccsnoopdone[1] = 1'b0;
    bcif.ccsnoophit[1] = 1'b0;
    bcif.ccwrite[1] = 1'b0;
    bcif.dstore[1] = 64'b0;
    bcif.daddr[1] = 32'b0;
    bcif.dWEN[1] = 1'b0;
    bcif.dREN[1] = 1'b0;
    bcif.l2load = 32'b0;
    bcif.l2state = L2_FREE;
end
endtask

task init_cache;
begin
    ccif.dcache_clear = 1'b0; //What does this signal do?
    ccif.dcache_flush = 1'b0;
    ccif.dcache_reserve = 1'b0; 
    ccif.dcache_exclusive = 1'b0;
    gbif.ren = 1'b0;
    gbif.wen = 1'b0;
    gbif.wdata = 32'b0;
    gbif.addr = 32'b0;
    gbif.byte_en = 4'b0;
    reset_snoop_signals();

    nRST = 1'b0;
    @(negedge CLK);
    nRST = 1'b1;
    @(negedge CLK);
    //#(PERIOD * 335); //Must look at idle_done within cache to know when flushing is complete
    wait(ccif.dflush_done);
    
end
endtask

task read_request;
    input logic [31:0] addr;
    input logic [63:0] data;
begin
    gbif.ren = 1'b1;
    gbif.addr = addr;

    send_data_from_ram(data);

    wait(gbif.busy == 1'b0);
    @(negedge CLK)

    gbif.ren = 1'b0;
end
endtask

task write_request;
    input logic [31:0] addr;
    input logic [63:0] data;
begin
    gbif.wen = 1'b1;
    gbif.addr = addr;
    gbif.wdata = data;

    wait(gbif.busy == 1'b0);
    @(negedge CLK)

    gbif.wen = 1'b0;
end
endtask

task send_data_from_ram;
    input logic [63:0] data;
begin
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
end
endtask

task check_state_transfer;
    input cc_end_state expected;
begin
    if (dcif.state_transfer == expected) begin // Assuming 'state' correctly reflects the cache state
        $display("%s correct state transfer at %0t", tb_test_case, $time);
    end else begin
         $error("Cache transfer state incorrect at %0t, found %s", $time, dcif.state_transfer);
    end
end
endtask

integer tb_test_num;
string tb_test_case;

initial begin
    $timeformat(-9, 2, " ns");
//Test case 1: Transition I -> E
    tb_test_num = 0;
    tb_test_case = "Cache init";

    //Reset to isolate each test case
    init_cache();

    tb_test_num = 1;
    tb_test_case = "Transition I -> E";

    begin
        gbif.ren = 1'b1;
        gbif.addr = 32'h80000000;

        bcif.ccsnoopdone[1] = 1'b1;
        bcif.ccsnoophit[1] = 1'b0;

        send_data_from_ram(64'hBEEFBEEFCAFECAFE);

        wait(mbif.busy == 1'b0);

        //Look at the coherency unit outputs
        check_state_transfer(EXCLUSIVE);

        wait(gbif.busy == 1'b0);

        //Look at the coherency unit outputs
        if (gbif.rdata == 32'hCAFECAFE) begin
            $display("%s: Got correct data as %0t", tb_test_case, $time);
        end else begin
             $error("%s: Got incorrect data: %h at %0t", tb_test_case, gbif.rdata, $time);
        end

        @(negedge CLK)

        gbif.ren = 1'b0;
    end

    // Test case 2: Transition I -> S
    #(50);
    tb_test_num = tb_test_num + 1;
    tb_test_case = "Transition I -> S";

    // Reset to isolate each test case
    nRST = 1'b0;
    @(negedge CLK);
    nRST = 1'b1;
    @(negedge CLK);
    init_cache();

    // Processor i read, cache miss.
    gbif.addr = 32'h44422244;
    gbif.ren = 1'b1; // Coherency unit should go to READ_REQ

    // Wait for the cache to recognize the read request
    wait(bcif.dREN == 1'b1); // Assuming dREN goes high indicating a read request to the cache

    // Bus transitions IDLE -> GRANT_R
    bcif.ccsnoopdone[1] = 1'b1; // Snooping complete in the other CPU
    bcif.ccsnoophit[1] = 1'b1; // Clean copy exists in the other Cache
    bcif.ccIsPresent[1] = 1'b1;

    // Transition SNOOP_R -> TRANSFER_R
    bcif.dstore[1] = 64'h5A5A5A5AA5A5A5A5; 

    // BUS_TO_CACHE transfer
    wait(bcif.dload[0] == bcif.dstore[1]); 
    wait(bcif.l2store == bcif.dstore[1][31:0]);

    // Transition to IDLE after data transfer
    wait(bcif.dwait[0] == 0); // Check if the bus transaction is completed
    wait(bcif.ccexclusive[0] == 0); // Check that it is not exclusive 

    wait(!mbif.busy);

    check_state_transfer(SHARED);

    wait(!gbif.busy);

    if (gbif.rdata == 32'h5A5A5A5A) begin
        $display("%s: Got correct data %0t", tb_test_case, $time);
    end else begin
         $error("%s: Got incorrect data: %h at %0t", tb_test_case, gbif.rdata, $time);
    end


    gbif.ren = 1'b0; // Reset read request from the processor
    reset_snoop_signals();

    // Test case 3: Transition I -> M
    #(50);
    tb_test_num = tb_test_num + 1;
    tb_test_case = "Transition I -> M";

    // Reset to isolate each test case
    nRST = 1'b0;
    @(negedge CLK);
    nRST = 1'b1;
    @(negedge CLK);

    begin
        gbif.wen = 1'b1;
        gbif.addr = 32'h80000000;
        gbif.wdata = 32'hBEEFBEEF;

        bcif.ccsnoopdone[1] = 1'b1;
        bcif.ccsnoophit[1] = 1'b0;

        wait(bcif.l2REN);

        send_data_from_ram(64'hBEEFBEEFCAFECAFE);

        wait(mbif.busy == 1'b0);

        //Look at the coherency unit outputs
        check_state_transfer(MODIFIED);

        wait(gbif.busy == 1'b0);
        #(PERIOD);
        gbif.wen = 1'b0;
        #(PERIOD);
    end

    wait(gbif.busy == 1'b1);

    #(PERIOD)

    gbif.ren = 1'b1;

    #(PERIOD)

    wait(!gbif.busy);

    if (gbif.rdata == 32'hBEEFBEEF) begin
        $display("%s: Got correct data %0t", tb_test_case, $time);
    end else begin
         $error("%s: Got incorrect data: %h at %0t", tb_test_case, gbif.rdata, $time);
    end

    gbif.ren = 1'b0;

    //Test case 4: M -> S
    #(50);
    tb_test_num = tb_test_num + 1;
    tb_test_case = "Transition M -> S";

    // Reset to isolate each test case
    nRST = 1'b0;
    @(negedge CLK);
    nRST = 1'b1;
    @(negedge CLK);

    // Get to M state
    begin
        gbif.wen = 1'b1;
        gbif.addr = 32'h80000000;
        gbif.wdata = 32'hBEEFBEEF;

        bcif.ccsnoopdone[1] = 1'b1;
        bcif.ccsnoophit[1] = 1'b0;

        wait(bcif.l2REN);

        send_data_from_ram(64'hBEEFBEEFCAFECAFE);

        wait(mbif.busy == 1'b0);

        //Look at the coherency unit outputs
        check_state_transfer(MODIFIED);

        wait(gbif.busy == 1'b0);
        #(PERIOD);
        gbif.wen = 1'b0;
        #(PERIOD);
    end

    bcif.daddr[1] = 32'h80000000;
    bcif.dREN[1] = 1'h1;

    wait(!bcif.dwait[1])
    if (bcif.dload[1] == 64'hBEEFBEEFBEEFBEEF) begin
        $display("%s received correct dload at %0t", tb_test_case, $time);
    end else begin
        $error("%s failed: Did not receive correct dload at %0t, found %x", tb_test_case, $time, bcif.dload[1]);
    end

    wait(!bcif.ccwait[0]);
    check_state_transfer(SHARED);

    bcif.l2state = L2_BUSY;
    wait(bcif.l2WEN);

    bcif.l2state = L2_ACCESS;
    if (bcif.l2store == 32'hBEEFBEEF) begin
        $display("%s received correct l2store at %0t", tb_test_case, $time);
    end else begin
        $error("%s failed: Did not receive correct l2store at %0t, found %x", tb_test_case, $time, bcif.l2store);
    end

    #(PERIOD);

    if (bcif.l2store == 32'hBEEFBEEF) begin
        $display("%s received correct l2store at %0t", tb_test_case, $time);
    end else begin
        $error("%s failed: Did not receive correct l2store at %0t, found %x", tb_test_case, $time, bcif.l2store);
    end

    #(PERIOD);

    if (bcif.l2WEN == 1'b0) begin
        $display("%s received correct l2WEN at %0t", tb_test_case, $time);
    end else begin
        $error("%s failed: Did not receive correct l2WEN at %0t", tb_test_case, $time);
    end

    wait(!bcif.dwait[1]);

    //Test case 5: S -> I (Data Eviction)
    #(50);
    tb_test_num = tb_test_num + 1;
    tb_test_case = "Transition S -> I (Data Eviction)";

    // Reset to isolate each test case
    init_cache();
    read_request(32'h80000000, 64'hCAFECAFECAFECAFE);
    read_request(32'h80000000, 64'hDEADBEEFDEADBEEF);
    read_request(32'h80000000, 64'h11FF11FF11FF1FFF);
    read_request(32'h80000000, 64'hABDCDEF123456789);
    read_request(32'h80000000, 64'hFEEFDEADFEEFDEAD);

    // Processor initiates a read/write, causing a cache miss
    gbif.addr = 32'h81000000;
    gbif.ren = 1'b1;
    wait (bcif.dwait[0] == 1'b0); // Wait for dwait to go low

    // Cache initiates eviction due to the miss
    //ccif.dWEN = 1'b1; // Indicate data eviction
    //ccif.ccwrite = 1'b0; // this is an eviction, not a processor WB

    // Bus reacts to eviction request
    //bcif.l2addr = gbif.addr; // Set L2 address for writeback to match the evicted cache line address
    //wait(ccif.dload); 
    //bcif.l2load = ccif.dload; 
    //bcif.l2WEN = 1'b1;

    // After writeback, ensure the cache line is invalidated
    #(10);
    ccif.dWEN = 1'b0; 
    //bcif.dwait = 'b0; 
    //bcif.l2WEN = 'b0; 

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

    //Do a initial processor request from CPU0
    gbif.addr = 32'h888999AA;
    gbif.ren = 1'b1;
    #(10 * PERIOD);
    // Do a write request from Dcache1, which should send a INV request.
    bcif.ccsnoopaddr[1] = 32'h888999AA;
    bcif.ccwrite[1] = 1'b1;

    // Simulate the snoop responses from non-requester CPUs
    #(10 * PERIOD);
    // Assume CPU 1 is the supplier which has the data
    //bcif.ccsnoopdone[0] = 1'b1; this should happen in Coh unit anyway
    //bcif.ccsnoophit[0] = 1'b1;
    // ccif.dstore = 64'hDEADBEEFDEADBEEF; // Set needed data from the supplier

    // Transition from SNOOP_RX to TRANSFER_RX
    //bcif.dstore[1] = ccif.dstore; // Transfer data from supplier cache to the bus

    // All caches with snoophit invalidate their block once ccinv goes low
    #(10 * PERIOD);
    //bcif.ccinv[0] = 1'b0; // End of invalidation 

    if (dcif.state_transfer != INVALID) begin
        $error("%s failed: Cache did not transition to INVALID state after bus invalidation", tb_test_case);
    end else begin
        $display("%s passed", tb_test_case);
    end

    //bcif.ccwait = 'b0;
    bcif.ccsnoopdone = 'b0;
    bcif.ccsnoophit = 'b0;


end

endprogram
