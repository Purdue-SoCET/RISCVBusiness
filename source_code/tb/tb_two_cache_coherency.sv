`include "generic_bus_if.vh"
`include "cache_control_if.vh"
`include "cache_coherence_if.vh"
`include "bus_ctrl_if.vh"

`timescale 1ns/100ps

parameter PERIOD = 10;

module tb_two_cache_coherency();
    logic CLK = 0, nRST;
    // clock
    always #(PERIOD/2) CLK++;

    generic_bus_if cache0_proc_gen_bus_if();
    generic_bus_if cache1_proc_gen_bus_if();
    cache_control_if c0c_if();
    cache_control_if c1c_if();
    generic_bus_if #(.BLOCK_SIZE(2)) cache0_mem_gen_bus_if();
    generic_bus_if #(.BLOCK_SIZE(2)) cache1_mem_gen_bus_if();
    cache_coherence_if cache0_coherency_if();
    cache_coherence_if cache1_coherency_if();
    bus_ctrl_if bus_ctrl_if();

    assign c0c_if.dcache_clear = 1'b0;
    assign c0c_if.dcache_flush = 1'b0;
    assign c0c_if.dcache_reserve = 1'b0;
    assign c0c_if.dcache_exclusive = 1'b0;
    assign c1c_if.dcache_clear = 1'b0;
    assign c1c_if.dcache_flush = 1'b0;
    assign c1c_if.dcache_reserve = 1'b0;
    assign c1c_if.dcache_exclusive = 1'b0;

    // test program
    test PROG (CLK, nRST, cache0_proc_gen_bus_if, cache1_proc_gen_bus_if, c0c_if, c1c_if);
    // DUT
    two_cache_coh_wrapper DUT(
        CLK,
        nRST,
        cache0_proc_gen_bus_if, //Processor to cache 0
        cache1_proc_gen_bus_if, //Processor to cache 1
        c0c_if, //Processor to cache
        c1c_if, //Processor to cache
        cache0_mem_gen_bus_if, //Cache0 to coherency unit
        cache1_mem_gen_bus_if, //Cache1 to coherency unit
        cache0_coherency_if, //Cache to coherency unit
        cache1_coherency_if, //Cache to coherency unit
        bus_ctrl_if //Coherency unit to bus
    );
endmodule

program test (
    input CLK, output logic nRST,
    generic_bus_if.generic_bus proc0_gbif, //Processor to cache0
    generic_bus_if.generic_bus proc1_gbif,  //Processor to cache1
    cache_control_if.pipeline c0c_if, //Processor to cache
    cache_control_if.pipeline c1c_if  //Processor to cache
);
    integer tb_test_num;
    string tb_test_case;

    task reset_buses();
    begin
        proc0_gbif.addr = 'b0;
        proc0_gbif.wen = 'b0;
        proc0_gbif.ren = 'b0;
        proc0_gbif.wdata = 'hBAD1BAD1;
        proc0_gbif.byte_en = 'h0;
        proc1_gbif.addr = 'b0;
        proc1_gbif.wen = 'b0;
        proc1_gbif.ren = 'b0;
        proc1_gbif.wdata = 'hBAD1BAD1;
        proc1_gbif.byte_en = 'h0;
    end
    endtask

`define START_READ_REQUEST(bus, bus_addr) \
    bus.addr = bus_addr;                  \
    bus.ren = 1'b1;

`define END_READ_REQUEST(bus) \
    wait(!bus.busy)           \
    bus.ren = 1'b0;

`define START_WRITE_REQUEST(bus, bus_addr, bus_data) \
    bus.addr = bus_addr;                             \
    bus.wdata = bus_data;                            \
    bus.wen = 1'b1;

`define END_WRITE_REQUEST(bus) \
    wait(bus.busy == 1'b0)     \
    #(PERIOD)                  \
    bus.wen = 1'b0;

    task reset_caches();
    begin
        reset_buses();
        nRST = 1'b0;
        #(PERIOD * 10)
        nRST = 1'b1;
        wait(c0c_if.dflush_done);
        wait(c1c_if.dflush_done);
    end
    endtask

    initial begin
        $timeformat(-9, 2, " ns");
        //Test case 1: Transition I -> E
        tb_test_num = 0;
        tb_test_case = "Cache init";

        // Test 1: Cache 0 writes, cache 1 reads after
        reset_caches();
        tb_test_num = tb_test_num + 1;
        tb_test_case = "0 writes, 1 reads after";
        `START_WRITE_REQUEST(proc0_gbif, 32'h80000000, 32'h11111111);
        #(PERIOD);
        `START_READ_REQUEST(proc1_gbif, 32'h80000000);
        `END_WRITE_REQUEST(proc0_gbif);
        `END_READ_REQUEST(proc1_gbif);
        if (proc1_gbif.rdata == 32'h11111111) begin
            $display("%s received correct data at %0t", tb_test_case, $time);
        end else begin
            $error("%s failed: Did not receive correct data at %0t, found %x", tb_test_case, $time, proc1_gbif.rdata);
        end

        // Test 1: Cache 0 writes, cache 1 reads after
        reset_caches();
        tb_test_num = tb_test_num + 1;
        tb_test_case = "0 reads then writes to both words, 1 reads after";
        `START_READ_REQUEST(proc0_gbif, 32'h80000000);
        `END_READ_REQUEST(proc0_gbif);
        if (proc1_gbif.rdata == 32'h00000000) begin
            $display("%s received correct data at %0t", tb_test_case, $time);
        end else begin
            $error("%s failed: Did not receive correct data at %0t, found %x", tb_test_case, $time, proc1_gbif.rdata);
        end
        `START_WRITE_REQUEST(proc0_gbif, 32'h80000000, 32'h11111111);
        `END_WRITE_REQUEST(proc0_gbif);
        `START_WRITE_REQUEST(proc0_gbif, 32'h80000004, 32'h22222222);
        `END_WRITE_REQUEST(proc0_gbif);
        `START_READ_REQUEST(proc1_gbif, 32'h80000000);
        `END_READ_REQUEST(proc1_gbif);
        if (proc1_gbif.rdata == 32'h11111111) begin
            $display("%s received correct data at %0t", tb_test_case, $time);
        end else begin
            $error("%s failed: Did not receive correct data at %0t, found %x", tb_test_case, $time, proc1_gbif.rdata);
        end
        #(PERIOD)
        `START_READ_REQUEST(proc1_gbif, 32'h80000004);
        `END_READ_REQUEST(proc1_gbif);
        if (proc1_gbif.rdata == 32'h22222222) begin
            $display("%s received correct data at %0t", tb_test_case, $time);
        end else begin
            $error("%s failed: Did not receive correct data at %0t, found %x", tb_test_case, $time, proc1_gbif.rdata);
        end
    end
endprogram
