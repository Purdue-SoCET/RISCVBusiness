// Written by: Malcolm McClymont
// Last updated: 2/13/24
//
// Module Summary:
//   A wrapper file
// that combines an L1 cache and a coherency unit.
//   Designed to test bus requests and responses



`include "generic_bus_if.vh"
`include "cache_control_if.vh"
`include "cache_coherence_if.vh"
`include "bus_ctrl_if.vh"

`timescale 1ns/100ps

module cache_coh_wrapper(
    input logic CLK, nRST,
    generic_bus_if proc_gen_bus_if, //Processor to cache
    cache_control_if cc_if, //Processor to cache
    generic_bus_if mem_gen_bus_if, //Cache to coherency unit
    cache_coherence_if d_cache_coherency_if, //Cache to coherency unit
    bus_ctrl_if bus_ctrl_if //Coherency unit to bus
);

    l1_cache #(
        .CACHE_SIZE(1024),
        .BLOCK_SIZE(2),
        .ASSOC(1)
    )
    dcache (
        .CLK(CLK),
        .nRST(nRST),
        .mem_gen_bus_if(mem_gen_bus_if),
        .proc_gen_bus_if(proc_gen_bus_if),
        .flush(cc_if.dcache_flush),
        .clear(cc_if.dcache_clear),
        .reserve(cc_if.dcache_reserve),
        .exclusive(cc_if.dcache_exclusive),
        .flush_done(cc_if.dflush_done),
        .clear_done(cc_if.dclear_done),
        .ccif(d_cache_coherency_if)
    );


    coherency_unit #(
        .CPUID(0)
    ) d_coherence_unit (
        .CLK(CLK),
        .nRST(nRST),
        .ccif(d_cache_coherency_if),
        .bcif(bus_ctrl_if),
        .gbif(mem_gen_bus_if)
    );

    bus_ctrl #(
        .CPUS(2)
    ) bus (
        .CLK(CLK),
        .nRST(nRST),
        .ccif(bus_ctrl_if),
        .abort_bus(1'b0)
    );
endmodule

