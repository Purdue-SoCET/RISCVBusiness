module cache_stress_wrapper (
    input logic CLK,
    input logic nRST,
    // Flushing logic
    input logic cache0_flush,
    output logic cache0_flush_done,
    input logic cache1_flush,
    output logic cache1_flush_done,
    // cache0
    input logic [31:0] cache0_addr,
    input logic [31:0] cache0_wdata,
    input logic cache0_ren,
    input logic cache0_wen,
    output logic [31:0] cache0_rdata,
    output logic cache0_busy,
    // cache1
    input logic [31:0] cache1_addr,
    input logic [31:0] cache1_wdata,
    input logic cache1_ren,
    input logic cache1_wen,
    output logic [31:0] cache1_rdata,
    output logic cache1_busy,
    // Outputs to main memory
    output logic [31:0] memory_addr,
    output logic [31:0] memory_wdata,
    output logic memory_ren,
    output logic memory_wen,
    input logic [31:0] memory_rdata,
    input logic memory_busy,

    output integer cache0_to_i, cache0_to_s, cache0_to_e,
                   cache1_to_i, cache1_to_s, cache1_to_e
);
    generic_bus_if cache0_proc_gen_bus_if();
    generic_bus_if cache1_proc_gen_bus_if();
    cache_control_if c0c_if();
    cache_control_if c1c_if();
    generic_bus_if #(.BLOCK_SIZE(2)) cache0_mem_gen_bus_if();
    generic_bus_if #(.BLOCK_SIZE(2)) cache1_mem_gen_bus_if();
    cache_coherence_if cache0_coherency_if();
    cache_coherence_if cache1_coherency_if();
    bus_ctrl_if bus_ctrl_if();

    cache_coherence_statistics_t cache0_stats, cache1_stats;

    always_comb begin
        c0c_if.dcache_flush = cache0_flush;
        cache0_flush_done = c0c_if.dflush_done;
        c1c_if.dcache_flush = cache1_flush;
        cache1_flush_done = c1c_if.dflush_done;

        out_gen_bus_if.rdata = memory_rdata;
        out_gen_bus_if.busy = memory_busy;
        out_gen_bus_if.byte_en = 'hf;

        cache0_proc_gen_bus_if.addr = cache0_addr;
        cache0_proc_gen_bus_if.wdata = cache0_wdata;
        cache0_proc_gen_bus_if.ren = cache0_ren;
        cache0_proc_gen_bus_if.wen = cache0_wen;
        cache0_rdata = cache0_proc_gen_bus_if.rdata;
        cache0_busy = cache0_proc_gen_bus_if.busy;
        cache0_proc_gen_bus_if.byte_en = 'hf;

        cache1_proc_gen_bus_if.addr = cache1_addr;
        cache1_proc_gen_bus_if.wdata = cache1_wdata;
        cache1_proc_gen_bus_if.ren = cache1_ren;
        cache1_proc_gen_bus_if.wen = cache1_wen;
        cache1_rdata = cache1_proc_gen_bus_if.rdata;
        cache1_busy = cache1_proc_gen_bus_if.busy;
        cache1_proc_gen_bus_if.byte_en = 'hf;

        out_gen_bus_if.addr = bus_ctrl_if.l2addr;
        out_gen_bus_if.ren = bus_ctrl_if.l2REN;
        out_gen_bus_if.wen = bus_ctrl_if.l2WEN;
        out_gen_bus_if.wdata = bus_ctrl_if.l2store;

        bus_ctrl_if.l2load = out_gen_bus_if.rdata;
        bus_ctrl_if.l2state = out_gen_bus_if.busy ? L2_BUSY : L2_ACCESS;

        memory_addr = out_gen_bus_if.addr;
        memory_wdata = out_gen_bus_if.wdata;
        memory_ren = out_gen_bus_if.ren;
        memory_wen = out_gen_bus_if.wen;

        cache0_to_i = cache0_stats.to_i_transitions;
        cache0_to_s = cache0_stats.to_s_transitions;
        cache0_to_e = cache0_stats.to_e_transitions;
        cache1_to_i = cache1_stats.to_i_transitions;
        cache1_to_s = cache1_stats.to_s_transitions;
        cache1_to_e = cache1_stats.to_e_transitions;
    end

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
        .ccif(cache0_coherency_if),
        .abort_bus()
    );

    coherency_unit #(
        .CPUID(0)
    ) cache0_coherency (
        .CLK(CLK),
        .nRST(nRST),
        .ccif(cache0_coherency_if),
        .bcif(bus_ctrl_if),
        .gbif(cache0_mem_gen_bus_if),
        .coherence_statistics(cache0_stats)
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
        .ccif(cache1_coherency_if),
        .abort_bus()
    );

    coherency_unit #(
        .CPUID(1)
    ) cache1_coherency (
        .CLK(CLK),
        .nRST(nRST),
        .ccif(cache1_coherency_if),
        .bcif(bus_ctrl_if),
        .gbif(cache1_mem_gen_bus_if),
        .coherence_statistics(cache1_stats)
    );

    bus_ctrl #(
        .CPUS(2)
    ) bus (
        .CLK(CLK),
        .nRST(nRST),
        .ccif(bus_ctrl_if),
        .abort_bus(1'b0)
    );

    generic_bus_if out_gen_bus_if();
endmodule
