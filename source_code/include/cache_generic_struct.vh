`ifndef RV32I_TYPES_PKG_SV
`define RV32I_TYPES_PKG_SV

// local parameters
parameter N_TOTAL_BYTES      = CACHE_SIZE / 8;                                 // cache size in bytes
parameter N_TOTAL_WORDS      = N_TOTAL_BYTES / (WORD_SIZE / 8);                // number of words in cache  
parameter N_TOTAL_FRAMES     = N_TOTAL_WORDS / BLOCK_SIZE;                     // number of frame in cache
parameter N_SETS             = N_TOTAL_FRAMES / ASSOC;                         // number of frame per set (ASSOC = set of cache)
parameter N_FRAME_BITS       = $clog2(ASSOC) + (ASSOC == 1);                   // number of bits in cache index indicating set of cache
parameter N_SET_BITS         = $clog2(N_SETS) + (N_SETS == 1);                 // number of bits in cache index indicating frame index within that set of cache
// Note: N_FRAME_BITS and N_SET_BITS may be swapped
parameter N_BLOCK_BITS       = $clog2(BLOCK_SIZE) + (BLOCK_SIZE == 1);         // number of bits in cache index indicating word/block index within the frame of cache
parameter N_TAG_BITS         = WORD_SIZE - N_SET_BITS - N_BLOCK_BITS;          // ** (what is -2 in the original code?) number of bits in cache that will be a tag bit 
parameter FRAME_SIZE         = WORD_SIZE * BLOCK_SIZE + N_TAG_BITS + 3;        // number of bits per frame in cache (includes overhead,  tag_bits + cache_status_bits)
parameter SRAM_W             = FRAME_SIZE * ASSOC;                             // number of bits of caches with overhead included of all sets combined
parameter SRAM_TAG_W         = (N_TAG_BITS + 3) * ASSOC;                       // number of bits of only the overhead of the caches of all sets combined
parameter CLEAR_LENGTH       = $clog2(BLOCK_SIZE) + 2;                         // ** number of bits in cache index indicating blocksize + 2
parameter NUM_STATE          = 7;                                              // number of cache states
parameter N_STATE_BITS         = $clog2(NUM_STATE);                              // number of bits for cache state logic
// Note: overhead refer to tag_bit + cache_status_bit (3) for dirty, valid, exclusive bit

// struct declaration
// cache tag: overhead of the cache 
typedef struct packed {
    logic exclusive;
    logic valid;
    logic dirty;
    logic [N_TAG_BITS-1:0] tag_bits;
} cache_tag_t;

// cache frame: overhead of the cache + the data
typedef struct packed{
    cache_tag_t tag;
    word_t [BLOCK_SIZE - 1:0] data;
} cache_frame_t;

// cache set: cache frame of the all associativity (all different sets) with the same cache tag
typedef struct packed {
    cache_frame_t [ASSOC - 1:0] frames;
} cache_set_t;

// decode the main memory address into tag_bits, index_bits, and block_bits
typedef struct packed {
    logic [N_TAG_BITS-1:0] tag_bits;
    logic [N_SET_BITS-1:0] idx_bits;
    logic [N_BLOCK_BITS-1:0] block_bits;
} decoded_cache_idx_t;

// flush counter type
typedef struct packed {
    logic finish;                       // status whether the flush is done (...)
    logic [N_SET_BITS-1:0] set_num;     // select the frame within the set
    logic [N_FRAME_BITS-1:0] frame_num; // assoc, select which set to flush
} flush_idx_t;

typedef struct packed {
    decoded_cache_idx_t idx;
    logic [1:0] byte_bits;
} decoded_cache_addr_t;   // cache address type

// cache state machine
typedef enum {
    IDLE,        // *** ...
    HIT,         // check the tag and cache status with the request and it hit
    FETCH,       // load the data from the main memory to cache
    WB,          // write-back the data to cache without writing to the main memory (set the dirty bit to one)
    FLUSH_CACHE, // write the cached data back to main memory (when cache is full or replacement policy)  
    SNOOP,       // *** cache coherency protocol
    CANCEL_REQ   // *** ...
} cache_fsm_t;            

// reservation (...explanation...)
typedef struct packed {
    decoded_cache_idx_t idx;
    logic reserved;
} reservation_set_t;

// cache state machine
typedef enum logic [STATE_BITS - 1:0] {
    IDLE,        // *** ...
    HIT,         // check the tag and cache status with the request and it hit
    FETCH,       // load the data from the main memory to cache
    WB,          // write-back the data to cache without writing to the main memory (set the dirty bit to one)
    FLUSH_CACHE, // write the cached data back to main memory (when cache is full or replacement policy)  
    SNOOP,       // *** cache coherency protocol
    CANCEL_REQ   // *** ...
} cache_fsm_t;

`endif
