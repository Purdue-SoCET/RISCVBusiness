// Written by: Burkay Sahin
// Last updated: 2/14/24
//
// Module Summary:
//   A testbench that combines an L1 cache and a coherency unit.
//   Designed to test bus requests and responses

`include "generic_bus_if.vh"
`include "cache_control_if.vh"
`include "cache_coherency_if.vh"
`include "bus_ctrl_if.vh"

`timescale 1ns/100ps

module tb_cache_coherency();
    parameter PERIOD = 10;
    logic CLK = 0, nRST;
    // clock
    always #(PERIOD/2) CLK++; 

    generic_bus_if.generic_bus proc_gen_bus_if(); //Processor to cache
    cache_control_if.dcache cc_if(); //Processor to cache
    generic_bus_if.cpu mem_gen_bus_if(); //Cache to coherency unit
    cache_coherence_if d_cache_coherency_if (); //Cache to coherency unit
    bus_ctrl_if bus_ctrl_if(); //Coherency unit to bus

  // test program
  test PROG (CLK, nRST, proc_gen_bus_if, cc_if, mem_gen_bus_if, d_cache_coherency_if, bus_ctrl_if);
  // DUT
  cache_coh_wrapper DUT(CLK, nRST, proc_gen_bus_if, cc_if, mem_gen_bus_if, d_cache_coherency_if, bus_ctrl_if);


endmodule


program test
(
    input CLK, nRST,
    generic_bus_if.generic_bus gbif, //Processor to cache
    cache_control_if.dcache ccif, //Processor to cache
    generic_bus_if.cpu mbif, //Cache to coherency unit
    cache_coherence_if dcif, //Cache to coherency unit
    bus_ctrl_if bcif  //Coherency unit to bus
);
integer tb_test_num;
string tb_test_case;

initial begin
    //Test case 1: Transition I -> E
    tb_test_num = 1;
    tb_test_case = "Transition I -> E";

    //Reset to isolate each test case
    nRST = 1'b0;
    @(posedge CLK);
    nRST = 1'b1;
    @(posedge CLK);

    gbif.addr = 32'h33311133; 
    gbif.ren = 1'b1; //Coherency unit should go to READ_REQ state
    wait (dcif.dwait == 1'b0); // Wait for dwait to go low

    // Cache sets dREN[I] high
    wait(ccif.dREN = 1'b1);

    // Bus transitions IDLE -> GRANT_R
    bcif.ccsnoopaddr = gbif.daddr;
    bcif.ccwait[1] = 1'b1; // Assert ccwait for all non-requester CPUs
    #(10); //Some time to pass for snooping

    wait(dcif.ccsnoopdone[1] = 1'b1); // All non-requester CPUs raise ccsnoopdone
    wait(dcif.ccsnoophit[1] = 1'b0); // None raise ccsnoophit

    // Transition SNOOP_R -> READ_L2
    bcif.l2REN = 1; // Bus sets l2REN high
    wait(ccif.dload = bcif.l2load); // Cache loads data from L2

    // Transition BUS_TO_CACHE
    wait(dcif.dwait = 0); // Bus sets dwait low
    wait(dcif.ccexclusive = 1); // Bus sets ccexclusive high

    // Transition back to IDLE, de-assert signals
    bcif.ccwait = 0; // De-assert ccwait signals
    @(posedge CLK); // Wait for the changes to propagate

    //Look at the coherency unit outputs
    assert(dcif.cache_transfer == EXCLUSIVE) $display("Cache transfer state correct");
    else $error("Cache transfer state incorrect")

end

endprogram