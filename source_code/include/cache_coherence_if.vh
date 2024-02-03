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
//localparam N_TAG_BITS         = WORD_SIZE - N_SET_BITS - N_BLOCK_BITS - 2; //Will add later for tag IO
typedef logic [31:0] word_t;

interface cache_coherence_if;
    cc_end_state state_transfer;
    logic [$clog2(N_SETS)-1:0] set_sel;
    word_t requested_data, responder_data;
    logic valid, exclusive, dirty;
    logic write_req; //Cache signifies a read or write miss
    logic snoop_req; //Signifies the bus is trying to snoop
    logic snoop_hit; //Bus signifies if tag from SRAM array matches a snoop
    word_t frame_tag; //Tag from SRAM array in cache, compare it with the snoop tag

    modport cache(
        input  set_sel, state_transfer, write_req, snoop_hit, frame_tag, responder_data, snoop_req,
        output valid, exclusive, dirty, requested_data,
    );

    modport coherency_unit(
        output  set_sel, state_transfer, write_req, snoop_hit, frame_tag, responder_data, snoop_req,
        input valid, exclusive, dirty, requested_data,
    );
endinterface
`endif // CACHE_COHERENCE_IF_VH
