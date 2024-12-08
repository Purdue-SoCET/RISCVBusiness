`include "cache_generic_struct.sv"
`include "generic_bus_if.vh"
`include "cache_coherence_if.vh"

module tb_cache_generic ();
    import rv32i_types_pkg::*;

    logic tb_CLK;
    logic tb_nRST;
    logic tb_clear;
    logic tb_flush;
    logic tb_reserve;
    logic tb_exclusive;
    logic tb_clear_done;
    logic tb_flush_done;
    generic_bus_if.cpu tb_mem_gen_bus_if;
    generic_bus_if.generic_bus tb_proc_gen_bus_if;
    cache_coherence_if.cache tb_ccif;

    cache_generic #(
        .CACHE_SIZE()
        .BLOCK_SIZE()
        .ASSOC()
        .NONCACHE_START_ADDR()
    ) DUT_cache_generic (
        .CLK(tb_CLK),                    // Clock signal
        .nRST(tb_nRST),                   // Negedge reset signal
        .clear(tb_clear),                  //
        .flush(tb_flush),                  //
        .reserve(tb_reserve),                //
        .exclusive(tb_exclusive),              //
        .clear_done(tb_clear_done),            //
        .flush_done(tb_flush_done),            //
        .mem_gen_bus_if(tb_mem_gen_bus_if),              // bus to downstream memory, to main memory
        .proc_gen_bus_if(tb_proc_gen_bus_if),     // bus to upstream memory, to CPU
        .ccif(tb_ccif) // Coherency interface, connected to coherency unit
    );
    
endmodule