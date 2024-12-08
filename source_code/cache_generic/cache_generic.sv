/*
*   Filename:     cache_generic.sv
*
*   Created by:   Puthimet Kitjaruwankul
*   Email:        pkitjaru@purdue.edu
*   Date Created: 11/17/2024
*   Description:  Generic cache module:
*                   - Cache Size
*                   - Non-Cacheable start address
*                   - Block Size | max 8
*	                - ASSOC | either 1 or 2
*   The cache uses SRAM to store the data
*/
`include "cache_generic_struct.vh"
`include "generic_bus_if.vh"
`include "cache_coherence_if.vh"

module cache_generic #(
    parameter CACHE_SIZE          = 1024,   // cache size in bits ****(or bytes)
    parameter BLOCK_SIZE          = 2,      // number of words in data in the cache frame
    parameter ASSOC               = 1,      // associativity (ways): a number of sets of caches
    parameter NONCACHE_START_ADDR = 32'hF000_0000   // **** sh/sb still have issues when uncached; not sure whats up with that still tbh
)
(
    input logic CLK,                    // Clock signal
    input logic nRST,                   // Negedge reset signal
    input logic clear,                  //
    input logic flush,                  //
    input logic reserve,                //
    input logic exclusive,              //
    output logic clear_done,            //
    output logic flush_done,            //
    generic_bus_if.cpu mem_gen_bus_if,              // bus to downstream memory, to main memory
    generic_bus_if.generic_bus proc_gen_bus_if,     // bus to upstream memory, to CPU
    cache_coherence_if.cache ccif // Coherency interface, connected to coherency unit
);
    // -------------------------------Importing relevent package------------------------------------------
    import rv32i_types_pkg::*;  // From the rv32i_types_pkg, use:
                                // paramater int WORD_SIZE = 32 -> number of bits in one word
                                // parameter RAM_ADDR_SIZE = 32 -> number of bits in ram index

    // --------------------------------Declaring the signals---------------------------------------------
    // counter signals
    flush_idx_t flush_idx;                  // asynchronous flush index, since we need to flush different index at time
    logic clear_flush_count;                // clear the flush count **
    logic enable_flush_count;               // enable the flush count **
    logic enable_flush_count_nowb;          // enable the flush count with no write-back**

    // States
    cache_fsm_t cache_state;                // cache state machine

    // sram signals
    cache_set_t sramWrite;                  // data writing to the sram
    cache_set_t sramRead;                   // data reading from the sram memory
    cache_set_t sramMask;                   // data masking for data write based on the byte_enable 
                                            // (eg. byte_en = 4'b0001 -> sramMask = 32'hFFFF_FF00)
    cache_tag_t sramTags [ASSOC-1:0]; 
    cache_tag_t sramTagsMask [ASSOC-1:0];
    logic sramWEN;                          // no need for REN
    logic [N_SET_BITS-1:0] sramSEL, sramSNOOPSEL;
    cache_tag_t read_tag_bits [ASSOC-1:0];  //Tag coming from bus

    // lru: logic that least recent used replacement policy for cache full hitting same cache index
    logic [N_FRAME_BITS-1:0] ridx;

    // address
    word_t read_addr, next_read_addr;
    decoded_cache_addr_t decoded_addr, snoop_decoded_addr;
    // decoded_cache_addr_t decoded_snoop_addr;

    // Cache Hit
    logic hit, pass_through;
    word_t [BLOCK_SIZE-1:0] hit_data;
    logic [N_FRAME_BITS-1:0] hit_idx;

    // flush reg
    logic flush_req;
    logic idle_done;

    // Reservation tracking reserve
    reservation_set_t reservation_set, next_reservation_set;
    logic addr_is_reserved;

    // Snooping signals
    logic[N_TAG_BITS-1:0] bus_frame_tag; //Tag from bus to compare

    logic coherence_hit, sc_valid_block;

    assign snoop_decoded_addr = decoded_cache_addr_t'(ccif.addr);
    assign bus_frame_tag = snoop_decoded_addr.idx.tag_bits;

    // --------------------------------Cache Module instantiation-----------------------------------------
    // cache finite state machine
    cache_sm  cache_sm0 (
        .CLK(CLK),
        .nRST(nRST),
        .idle_done(idle_done),
        .reserve(reserve),
        .sc_valid_block(sc_valid_block),
        .pass_through(pass_through),
        .hit(hit),
        .sramRead(sramRead), //** sramRead is actually cache_set_t
        .flush(flush),
        .flush_req(flush_req),
        .flush_done(flush_done),
        .mem_gen_bus_if(mem_gen_bus_if),
        .proc_gen_bus_if(proc_gen_bus_if),
        .ccif(ccif),
        .state_out(cache_state)
    );

    // cache flush handler handles the flush counter signal
    cache_flush_counter_handler flush_handler0 (
        .CLK(CLK),
        .nRST(nRST),
        .flush(flush),
        .flush_done(flush_done),
        .clear_flush_count(clear_flush_count),
        .enable_flush_count(enable_flush_count),
        .enable_flush_count_nowb(enable_flush_count_nowb),
        .flush_req(flush_req),
        .flush_idx_out(flush_idx)
    );

    // cache hit logic:
    cache_hit_logic cache_hit0 (
        .sramRead(sramRead),
        .decoded_addr(decoded_addr),
        .addr_is_reserved(addr_is_reserved),
        .state_in(state),
        .read_tag_bits(read_tag_bits),
        .bus_frame_tag(bus_frame_tag),
        .hit(hit),
        .hit_idx(hit_idx),
        .hit_data(hit_data),
        .pass_through(pass_through),
        .coherence_hit(coherence_hit),
        .sc_valid_block(sc_valid_block),
        .proc_gen_bus_if(proc_gen_bus_if),
        .ccif(ccif)
    );

    // cache control downstream: manage output signal downstream (to main memory)
    cache_control_downstream cctr_downstream0 (
        .CLK(CLK),
        .nRST(nRST),
        .hit(hit),
        .flush(flush),
        .reserve(reserve),
        .addr_is_reserved(addr_is_reserved),
        .pass_through(pass_through),
        .sc_valid_block(sc_valid_block),
        .sramRead(sramRead),
        .state_in(state),
        .ridx(ridx),
        .decoded_addr(decoded_addr),
        .flush_idx(flush_idx),
        .mem_gen_bus_if(mem_gen_bus_if),              // bus to downstream memory, to main memory
        .proc_gen_bus_if(proc_gen_bus_if),     // bus to upstream memory, to CPU
        .ccif(ccif)
    );

    // cache control upstream: manage output signal upstream (to CPU)
    cache_control_upstream cctr_upstream0 (
        .CLK(CLK),
        .nRST(nRST),
        .hit(hit),
        .flush(flush),
        .reserve(reserve),
        .addr_is_reserved(addr_is_reserved),
        .pass_through(pass_through),
        .sc_valid_block(sc_valid_block),
        .decoded_addr(decoded_addr),
        .state_in(state),
        .mem_gen_bus_if(mem_gen_bus_if),              // bus to downstream memory, to main memory
        .proc_gen_bus_if(proc_gen_bus_if)      // bus to upstream memory, to CPU
    );

    // cache control sram: manage output signal to sram module (to cache)
    cache_control_sram cctr_sram0 (
        .CLK(CLK),
        .nRST(nRST),
        .hit(hit),
        .hit_idx(hit_idx),
        .flush(flush),
        .reserve(reserve),
        .addr_is_reserved(addr_is_reserved),
        .state_in(state_in),
        .flush_idx(flush_idx),
        .snoop_decoded_addr(snoop_decoded_addr),
        .decoded_addr(decoded_addr),
        .sramRead(sramRead),  
        .sramWEN(sramWEN),
        .sramWrite(sramWrite),                              
        .sramMask(sramMask),  
        .enable_flush_count(enable_flush_count),
        .enable_flush_count_nowb(enable_flush_count_nowb),
        .idle_done(idle_done),
        .clear_done(clear_done),
        .flush_done(flush_done),
        .clear_flush_count(clear_flush_count),
        .ridx(ridx),
        .mem_gen_bus_if(mem_gen_bus_if),              // bus to downstream memory, to main memory
        .proc_gen_bus_if(proc_gen_bus_if),     // bus to upstream memory, to CPU
        .ccif(ccif)
    );

    cache_control_snoop cctr_snoop0 (
        .CLK(CLK),
        .nRst(nRst),
        .sramRead(sramRead),
        .sramWEN(sramWEN),
        .sramSEL(sramSEL),
        .sramSNOOPSEL(sramSNOOPSEL),
        .snoop_decoded_addr(snoop_decoded_addr),
        .sramTags(sramTags), 
        .sramTagsMask(sramTagsMask),
        .sramMask(sramMask),
        .sramWrite(sramWrite),
        .flush_idx(flush_idx),
        .hit_idx(hit_idx),
        .ccif(ccif)
    );

    // --------------------------------SRAM Module instantiation-------------------------------------
    // sram instance
    assign sramSEL = (state == FLUSH_CACHE || state == IDLE) ? flush_idx.set_num
                   : (state == SNOOP) ? snoop_decoded_addr.idx.idx_bits
                   : decoded_addr.idx.idx_bits;
    
    // Note: sram module write data 'wVal' to the sramMemory at 'SEL' index when 'WEN' is high,
    //       the sramMemory writing is delayed by a clock cycle.
    //       sram module read data to 'rVal' from the sramMemory of 'SEL' index when 'REN' is high,
    //       the rVal reading is purely combinational.

    // SRAM storing cache overall (data + overhead): ***not sure why it was initially named CPU_SRAM ?
    sram #(
        .SRAM_WR_SIZE(SRAM_W), 
        .SRAM_HEIGHT(N_SETS)
    ) CPU_SRAM (
        .CLK(CLK), 
        .nRST(nRST), 
        .wVal(sramWrite), 
        .rVal(sramRead), 
        .REN(1'b1), 
        .WEN(sramWEN), 
        .SEL(sramSEL), 
        .wMask(sramMask)
    );
    
    // SRAM storing cache overhead (tag, cache status, etc.): ***not sure why it was initially named BUS_SRAM ?
    // *** also not sure why we have this sram storing overhead when we have the one that stores both data and overhead already ?
    sram #(
        .SRAM_WR_SIZE(SRAM_TAG_W), 
        .SRAM_HEIGHT(N_SETS)
    ) BUS_SRAM (
        .CLK(CLK), 
        .nRST(nRST), 
        .wVal(sramTags), 
        .rVal(read_tag_bits), 
        .REN(1'b1), 
        .WEN(sramWEN), 
        .SEL(sramSNOOPSEL), 
        .wMask(sramTagsMask)
    );

//************************************************************************************************

    // flip flops
    always_ff @ (posedge CLK, negedge nRST) begin
        if(~nRST) begin
            reservation_set <= 0;
        end
        else begin
            reservation_set <= next_reservation_set;
        end
    end

    // // Reservation tracking logic
    // // TODO: Remove exclusive signal
    always_comb begin
        next_reservation_set = reservation_set;
        if (proc_gen_bus_if.ren && reserve && hit) begin
            next_reservation_set.idx = decoded_addr.idx;
            next_reservation_set.reserved = 1'b1;
        end else if (((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && !proc_gen_bus_if.busy) || clear || flush) begin
            next_reservation_set.reserved = 1'b0;
        end
        addr_is_reserved = reservation_set.idx == decoded_addr.idx && reservation_set.reserved;
    end
endmodule
