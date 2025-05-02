

module l1_wrapper();

    generic_bus_if mem_gen_bus_if();
    generic_bus_if proc_gen_bus_if();

    logic CLK, nRST, clear, flush, clear_done, flush_done;

    l1_cache DUT(.*);

endmodule
