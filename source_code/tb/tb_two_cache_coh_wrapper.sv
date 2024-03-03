`include "generic_bus_if.vh"
`include "cache_control_if.vh"
`include "cache_coherence_if.vh"
`include "bus_ctrl_if.vh"

module two_cache_coh_wrapper(
    input logic CLK, nRST,
    generic_bus_if cache0_proc_gen_bus_if, //Processor to cache 0
    generic_bus_if cache1_proc_gen_bus_if, //Processor to cache 1
    cache_control_if c0c_if, //Processor to cache
    cache_control_if c1c_if, //Processor to cache
    generic_bus_if cache0_mem_gen_bus_if, //Cache0 to coherency unit
    generic_bus_if cache1_mem_gen_bus_if, //Cache1 to coherency unit
    cache_coherence_if cache0_coherency_if, //Cache to coherency unit
    cache_coherence_if cache1_coherency_if, //Cache to coherency unit
    bus_ctrl_if bus_ctrl_if //Coherency unit to bus
);
    l1_cache #(
        .CACHE_SIZE(1024),
        .BLOCK_SIZE(2),
        .ASSOC(1),
        .NONCACHE_START_ADDR(32'hF000_0000)
    ) cache0 (
        .CLK(CLK),
        .nRST(nRST),
        .mem_gen_bus_if(cache0_mem_gen_bus_if),
        .proc_gen_bus_if(cache0_proc_gen_bus_if),
        .flush(c0c_if.dcache_flush),
        .clear(c0c_if.dcache_clear),
        .reserve(c0c_if.dcache_reserve),
        .exclusive(c0c_if.dcache_exclusive),
        .flush_done(c0c_if.dflush_done),
        .clear_done(c0c_if.dclear_done),
        .ccif(cache0_coherency_if)
    );

    coherency_unit #(
        .CPUID(0)
    ) cache0_coherency (
        .CLK(CLK),
        .nRST(nRST),
        .ccif(cache0_coherency_if),
        .bcif(bus_ctrl_if),
        .gbif(cache0_mem_gen_bus_if)
    );

    l1_cache #(
        .CACHE_SIZE(1024),
        .BLOCK_SIZE(2),
        .ASSOC(1),
        .NONCACHE_START_ADDR(32'hF000_0000)
    ) cache1 (
        .CLK(CLK),
        .nRST(nRST),
        .mem_gen_bus_if(cache1_mem_gen_bus_if),
        .proc_gen_bus_if(cache1_proc_gen_bus_if),
        .flush(c1c_if.dcache_flush),
        .clear(c1c_if.dcache_clear),
        .reserve(c1c_if.dcache_reserve),
        .exclusive(c1c_if.dcache_exclusive),
        .flush_done(c1c_if.dflush_done),
        .clear_done(c1c_if.dclear_done),
        .ccif(cache1_coherency_if)
    );

    coherency_unit #(
        .CPUID(1)
    ) cache1_coherency (
        .CLK(CLK),
        .nRST(nRST),
        .ccif(cache1_coherency_if),
        .bcif(bus_ctrl_if),
        .gbif(cache1_mem_gen_bus_if)
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


