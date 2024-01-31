`ifndef CACHE_COHERENCE_IF_VH
`define CACHE_COHERENCE_IF_VH

typedef enum logic[1:0] {  
    MODIFIED,
    EXCLUSIVE,
    SHARED,
    INVALID
} cc_end_state;

localparam CACHE_SIZE         = 1024;
localparam ASSOC              = 1;
localparam N_TOTAL_BYTES      = CACHE_SIZE / 8;
localparam N_TOTAL_WORDS      = N_TOTAL_BYTES / 4;
localparam N_TOTAL_FRAMES     = N_TOTAL_WORDS / BLOCK_SIZE;
localparam N_SETS             = N_TOTAL_FRAMES / ASSOC;

typedef logic [31:0] word_t;

interface cache_coherence_if;
    cc_end_state state_transfer;
    logic [$clog2(N_SETS)-1:0] set_sel;
    word_t requested_data;
    logic valid, exclusive, dirty;

    modport cache(
        input  set_sel, state_transfer,
        output valid, exclusive, dirty, requested_data
    );

    modport coherency_unit(
        output set_sel, state_transfer, requested_data,
        input  valid, exclusive, dirty
    );
endinterface
`endif // CACHE_COHERENCE_IF_VH
