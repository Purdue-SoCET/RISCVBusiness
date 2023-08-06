/*
*   Copyright 2016 Purdue University
*
*   Licensed under the Apache License, Version 2.0 (the "License");
*   you may not use this file except in compliance with the License.
*   You may obtain a copy of the License at
*
*       http://www.apache.org/licenses/LICENSE-2.0
*
*   Unless required by applicable law or agreed to in writing, software
*   distributed under the License is distributed on an "AS IS" BASIS,
*   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*   See the License for the specific language governing permissions and
*   limitations under the License.
*
*
*   Filename:     l1_cache.sv
*
*   Created by:   Rufat Imanov, Aedan Frazier, Dhruv Gupta
*   Email:        rimanov@purdue.edu
*   Date Created: 06/20/2021
*   Description:  L1 Cache. The following are configurable:
*                   - Cache Size
*                   - Non-Cacheable start address
*                   - Block Size | max 8
*	            - ASSOC | either 1 or 2
*/

module l1_cache #(
    parameter CACHE_SIZE          = 1024, // must be power of 2, in bytes, max 4k - 4 * 2^10
    parameter BLOCK_SIZE          = 2, // must be power of 2, max 8
    parameter ASSOC               = 1, // dont set this to 0
    parameter NONCACHE_START_ADDR = 32'h8000_0000 // sh/sb still have issues when uncached; not sure whats up with that still tbh
)
(
    input logic CLK, nRST,
    input logic clear, flush,
    output logic clear_done, flush_done,
    bus_if.request mem_bus_if,
    bus_if.response proc_bus_if
);
    import rv32i_types_pkg::*;
    
    // local parameters
    localparam N_TOTAL_BYTES      = CACHE_SIZE / 8;
    localparam N_TOTAL_WORDS      = N_TOTAL_BYTES / 4;
    localparam N_TOTAL_FRAMES     = N_TOTAL_WORDS / BLOCK_SIZE;
    localparam N_SETS             = N_TOTAL_FRAMES / ASSOC;
    localparam N_FRAME_BITS       = $clog2(ASSOC) + (ASSOC == 1);
    localparam N_SET_BITS         = $clog2(N_SETS) + (N_SETS == 1);
    localparam N_BLOCK_BITS       = $clog2(BLOCK_SIZE) + (BLOCK_SIZE == 1);
    localparam N_TAG_BITS         = WORD_SIZE - N_SET_BITS - N_BLOCK_BITS - 2;
    localparam FRAME_SIZE         = WORD_SIZE * BLOCK_SIZE + N_TAG_BITS + 2; // in bits
    localparam SRAM_W             = FRAME_SIZE * ASSOC;                      // sram parameters

    typedef struct packed {
        logic valid;
        logic dirty;
        logic [N_TAG_BITS - 1:0] tag;
        word_t [BLOCK_SIZE - 1:0] data;
    } cache_frame_t;    // cache frame

    typedef struct packed {
        cache_frame_t [ASSOC - 1:0] frames;
    } cache_set_t;      // cache set

    typedef struct packed {
        logic [N_TAG_BITS-1:0] tag_bits;
        logic [N_SET_BITS-1:0] idx_bits;
        logic [N_BLOCK_BITS-1:0] block_bits;
        logic [1:0] byte_bits;
    } decoded_cache_addr_t;   // cache address type

    typedef struct packed {
        logic finish;
        logic [N_SET_BITS-1:0] set_num;
        logic [N_FRAME_BITS-1:0] frame_num; // assoc
        logic [N_BLOCK_BITS-1:0] word_num;
    } flush_idx_t;             // flush counter type

    typedef enum {
       IDLE, HIT, FETCH, WB, FLUSH_CACHE, CLEAR_CACHE
    } cache_fsm_t;            // cache state machine
    
    // counter signals
    flush_idx_t flush_idx, next_flush_idx;
    logic   [N_BLOCK_BITS:0] word_num, next_word_num;
    logic   enable_word_count, clear_word_count, 
            clear_flush_count, enable_flush_count, enable_flush_count_nowb;
    logic   word_count_done;
    // States
    cache_fsm_t state, next_state;
    // lru
    logic [N_FRAME_BITS-1:0] ridx;
    logic [N_SETS-1:0] last_used;
    logic [N_SETS-1:0] next_last_used;
    // address
    word_t data_addr;
    bus_pkg::trans_t data_trans;
    decoded_cache_addr_t decoded_addr;
    // Cache Hit
    logic hit, pass_through;
    word_t [BLOCK_SIZE-1:0] hit_data;
    logic [N_FRAME_BITS-1:0] hit_idx;
    // sram signals
    cache_set_t sramWrite, sramRead, sramMask;
    logic sramWEN; // no need for REN
    logic [N_SET_BITS-1:0] sramSEL;
    // flush reg
    logic flush_req, nflush_req;
    logic idle_done;

    // error handling
    assign proc_bus_if.error = mem_bus_if.error;

    // sram instance
    assign sramSEL = (state == FLUSH_CACHE || state == IDLE) ? flush_idx.set_num : decoded_addr.idx_bits;
    sram #(.SRAM_WR_SIZE(SRAM_W), .SRAM_HEIGHT(N_SETS)) 
        SRAM(CLK, nRST, sramWrite, sramRead, 1'b1, sramWEN, sramSEL, sramMask);

    // flip flops
    always_ff @ (posedge CLK, negedge nRST) begin
        if(~nRST) begin
            state <= IDLE;
            flush_idx <= 0;
            word_num <= 0;
            last_used <= 0;
            data_trans <= bus_pkg::IDLE;
            data_addr <= 0;
            flush_req <= 0;
        end
        else begin
            state <= next_state;                        // cache state machine
            flush_idx <= next_flush_idx;                // index for flushing the cache entries
            word_num <= next_word_num;                  // word counter for fetching/writing back
            last_used <= next_last_used;                // MRU index

            data_trans <= mem_bus_if.trans;
            data_addr <= mem_bus_if.addr;               // cache address to provide to memory

            flush_req <= nflush_req;                    // flush requested by core
        end
    end
    
    // counters
    always_comb begin
        next_word_num = word_num;
        next_flush_idx = flush_idx;
        word_count_done = ~mem_bus_if.busy && (BLOCK_SIZE - 1) == word_num;
        // word counter logic
        if (clear_word_count)
            next_word_num = 0;
        else if (enable_word_count)
            next_word_num = word_num + 1;

        // flush counter logic
        if (clear_flush_count)
            next_flush_idx = 0;
        else if (enable_flush_count_nowb)
            next_flush_idx = flush_idx + BLOCK_SIZE;
        else if (enable_flush_count)
            next_flush_idx = flush_idx + 1;

        // correction for non-powers of 2 or 1
        if (next_flush_idx.set_num == N_SETS)
            next_flush_idx = {1'b1, (N_SET_BITS + N_FRAME_BITS + N_BLOCK_BITS)'('0)};
        if (next_flush_idx.frame_num == ASSOC)
            next_flush_idx = {({flush_idx.finish, flush_idx.set_num} + 1'b1), (N_FRAME_BITS + N_BLOCK_BITS)'('0)};
        if (next_flush_idx.word_num == BLOCK_SIZE)
            next_flush_idx = {({flush_idx.finish, flush_idx.set_num, flush_idx.frame_num} + 1'b1), N_BLOCK_BITS'('0)};
    end

    // decoded address conversion
    assign decoded_addr = decoded_cache_addr_t'(proc_bus_if.addr);

    // hit logic with pass through
    always_comb begin
        hit 	        = 0;
        hit_idx         = 0;
        hit_data        = 0;
        pass_through    = proc_bus_if.addr >= NONCACHE_START_ADDR;

        if (~pass_through) begin
            for(int i = 0; i < ASSOC; i++) begin
                if(sramRead.frames[i].tag == decoded_addr.tag_bits && sramRead.frames[i].valid) begin
                    hit       = 1'b1;
                    hit_data  = sramRead.frames[i].data;
                    hit_idx   = i;
                end
            end
        end
    end

    // cache output logic
    // Outputs: counter control signals, cache, signals to memory, signals to processor
    always_comb begin
        sramWEN                 = 0;
        sramWrite               = 0;
        sramMask                = '1;
        proc_bus_if.busy        = '1;
        proc_bus_if.rdata       = 0; // TODO: Can this be optimized?
        mem_bus_if.write_enable = 0;
        mem_bus_if.addr         = 0; 
        mem_bus_if.wdata        = 0; 
        mem_bus_if.size         = bus_pkg::WORD;
        enable_flush_count      = 0;
        enable_word_count       = 0;
        enable_flush_count_nowb = 0;
        clear_flush_count       = 0;
        clear_word_count        = 0;
        flush_done 	            = 0;
        idle_done               = 0;
        clear_done 	            = 0;
        //next_data_addr          = data_addr;
        next_last_used          = last_used;
        
        // associativity, using NRU
        if (ASSOC == 1 || (last_used[decoded_addr.idx_bits] == (ASSOC - 1)))
            ridx = 0;
        else
            ridx = last_used[decoded_addr.idx_bits] + 1;

        // state dependent output logic
        casez(state)
            IDLE: begin
                // clear out caches with flush
                sramWEN = 1;
    	        sramWrite.frames[flush_idx.frame_num] = '0;
                sramMask.frames[flush_idx.frame_num] = '0;
                enable_flush_count_nowb = 1;
                // flag the completion of flush
                if (flush_idx.finish) begin
                    clear_flush_count  = 1;
                    idle_done 	       = 1;
                end
            end
            HIT: begin
                //next_data_addr = decoded_addr;
                clear_word_count = 1;
                // if there's a clear
                if(flush || flush_req) begin
                    mem_bus_if.trans            = bus_pkg::NONSEQ;
                end if(clear) begin
                    if(sramRead.frames[ridx].dirty && ~pass_through) begin
                        mem_bus_if.write_enable = 1'b1;
                        mem_bus_if.trans        = bus_pkg::NONSEQ;
                        mem_bus_if.addr         = {sramRead.frames[ridx].tag, decoded_addr.idx_bits, N_BLOCK_BITS'('0), 2'b00}; 
                        mem_bus_if.wdata        = sramRead.frames[ridx].data[word_num];
                    end else begin
                        sramWEN = 1;
                        sramWrite.frames[flush_idx.frame_num] = 0;
                        sramMask.frames[flush_idx.frame_num] = 0;
                        clear_done = 1'b1;
                    end
                    // if there's a transaction
                end if(proc_bus_if.trans == bus_pkg::NONSEQ || proc_bus_if.trans == bus_pkg::SEQ) begin
                    if(hit) begin // if it's a hit
                        if(proc_bus_if.write_enable) begin // if it's a write
                            proc_bus_if.busy = 0;

                            sramWEN = 1;
                            sramMask.frames[hit_idx].data[decoded_addr.block_bits] = ~({proc_bus_if.size[1] ? 16'hFFFF : 16'h0, |proc_bus_if.size[1:0] ? 8'hFF : 8'h0, 8'hFF } << 8*(decoded_addr.byte_bits >> proc_bus_if.size));
                            sramMask.frames[hit_idx].dirty = 0;														   				   
                            sramWrite.frames[hit_idx].data[decoded_addr.block_bits] = proc_bus_if.wdata;
                            sramWrite.frames[hit_idx].dirty = 1;
                            next_last_used[decoded_addr.idx_bits] = hit_idx;
                        end else begin // if it's a read
                            proc_bus_if.busy = 0;

                            proc_bus_if.rdata = hit_data[decoded_addr.block_bits];
                            next_last_used[decoded_addr.idx_bits] = hit_idx;
                        end
                    end else if(pass_through) begin // passthrough
                        mem_bus_if.trans        = proc_bus_if.trans;
                        mem_bus_if.addr         = proc_bus_if.addr;
                        mem_bus_if.size         = proc_bus_if.size;
                        proc_bus_if.busy        = mem_bus_if.busy;
                        proc_bus_if.rdata       = mem_bus_if.rdata;
                        if(proc_bus_if.write_enable) begin
                            mem_bus_if.wdata = proc_bus_if.wdata & ({proc_bus_if.size[1] ? 16'hFFFF : 16'h0, |proc_bus_if.size[1:0] ? 8'hFF : 8'h0, 8'hFF } << 8*(decoded_addr.byte_bits >> proc_bus_if.size));
                        end 
                    end else if(~hit && ~sramRead.frames[ridx].dirty && ~pass_through) begin // cache miss on a clean block -> FETCH
                        mem_bus_if.trans    = bus_pkg::NONSEQ;
                        mem_bus_if.addr     = proc_bus_if.addr;
                        sramMask.frames[ridx].valid = 0;
                        sramWrite.frames[ridx].valid = 0; 
                    end else if(~hit && sramRead.frames[ridx].dirty && ~pass_through) begin // cache miss on a dirty block -> WRITEBACK
                        mem_bus_if.write_enable = 1'b1;
                        mem_bus_if.trans    = bus_pkg::NONSEQ;
                        mem_bus_if.addr = {sramRead.frames[ridx].tag, decoded_addr.idx_bits, N_BLOCK_BITS'('0), 2'b00}; 
                        mem_bus_if.wdata = sramRead.frames[ridx].data[word_num];
                        //next_decoded_req_addr = decoded_addr;
                        //next_data_addr  =  ;
                    end
                end
            end 
            FETCH: begin
                mem_bus_if.trans = data_trans;
                mem_bus_if.addr = data_addr;

                // fill data
                if(~mem_bus_if.busy && (data_trans == bus_pkg::NONSEQ || data_trans == bus_pkg::SEQ)) begin
                    
                    mem_bus_if.trans                           = bus_pkg::SEQ;
                    sramWEN                                    = 1'b1;
                    enable_word_count                          = 1'b1;
                    mem_bus_if.addr 						   = data_addr + 4;
                    sramWrite.frames[ridx].data[word_num]      = mem_bus_if.rdata;
                    sramMask.frames[ridx].data[word_num]       = 1'b0;

                end
                // complete fetch transaction from memory
                if(word_count_done) begin
                    sramWEN = 1;
                    clear_word_count 					    = 1'b1;
                    sramWrite.frames[ridx].valid            = 1'b1;
                    //sramWrite.frames[ridx].tag 	            = decoded_req_addr.tag_bits;
                    sramWrite.frames[ridx].tag 	            = decoded_addr.tag_bits;
                    sramMask.frames[ridx].valid             = 1'b0;
                    sramMask.frames[ridx].tag               = 1'b0;
                end
            end
            WB: begin
                // set stim for eviction
                mem_bus_if.write_enable = 1'b1;
                mem_bus_if.trans = data_trans;
                mem_bus_if.addr = data_addr; 
                mem_bus_if.wdata = sramRead.frames[ridx].data[word_num];
                // increment eviction word counter
                if(~mem_bus_if.busy) begin
                    mem_bus_if.trans = bus_pkg::SEQ;
                    enable_word_count = 1;
                    mem_bus_if.addr = data_addr + 4;
                end
                // invalidate when eviction is complete
                if(word_count_done) begin
                    mem_bus_if.write_enable = 1'b0;
                    mem_bus_if.trans = bus_pkg::NONSEQ;
                    mem_bus_if.addr = proc_bus_if.addr; 

                    sramWEN = 1;
                    clear_word_count = 1;
                    sramWrite.frames[ridx].dirty = 0;
                    sramMask.frames[ridx].dirty = 0;
                    sramWrite.frames[ridx].valid = 0;
                    sramMask.frames[ridx].valid = 0;
                end
            end
            FLUSH_CACHE: begin
                // flush to memory if valid & dirty
                    
                if (sramRead.frames[flush_idx.frame_num].valid && sramRead.frames[flush_idx.frame_num].dirty) begin
                    
                    mem_bus_if.write_enable    = 1'b1;
                    mem_bus_if.addr   = {sramRead.frames[flush_idx.frame_num].tag, flush_idx.set_num, flush_idx.word_num, 2'b00};
                    mem_bus_if.wdata  = sramRead.frames[flush_idx.frame_num].data[flush_idx.word_num];
                    // increment to next word when flush of word is done
                    if (~mem_bus_if.busy) begin
                        enable_flush_count = 1;
                        // clears entry when flushed
                        if (flush_idx.word_num == (BLOCK_SIZE - 1)) begin
                            sramWEN = 1;
	    	                sramWrite.frames[flush_idx.frame_num] = 0;
                            sramMask.frames[flush_idx.frame_num] = 0;
                        end
                    end
                end
                // else clears entry, moves to next frame
                else begin
                    sramWEN = 1;
	    	        sramWrite.frames[flush_idx.frame_num] = 0;
                    sramMask.frames[flush_idx.frame_num] = 0;
                    enable_flush_count_nowb = 1;
                end
                // flag the completion of flush
                if (flush_idx.finish) begin
                    clear_flush_count  = 1;
                    flush_done 	       = 1;
                end
            end
            CLEAR_CACHE: begin
                // clear to memory if valid & dirty
                mem_bus_if.write_enable    = 1'b1;
                mem_bus_if.trans           = data_trans;
                mem_bus_if.addr            = data_addr;
                mem_bus_if.wdata           = sramRead.frames[ridx].data[word_num];

                if(~mem_bus_if.busy) begin
                    enable_word_count = 1;
                    mem_bus_if.trans    = bus_pkg::SEQ;
                    mem_bus_if.addr     = data_addr + 4;
                end

                if(word_count_done) begin
                    sramWEN = 1;
                    clear_word_count = 1;
                    clear_done = 1;
                    sramWrite.frames[ridx].dirty = 0;
                    sramMask.frames[ridx].dirty = 0;
                    sramWrite.frames[ridx].valid = 0;
                    sramMask.frames[ridx].valid = 0;
                end
            end
        endcase
    end

    // next state logic
    always_comb begin
	    next_state = state;
	    casez(state)
            IDLE: begin        
                if (idle_done)
                    next_state = HIT;
	        end
	        HIT: begin                    
                if ((proc_bus_if.trans == bus_pkg::NONSEQ || proc_bus_if.trans == bus_pkg::NONSEQ) && ~hit && sramRead.frames[ridx].dirty && ~pass_through) 
                    next_state = WB;
                else if ((proc_bus_if.trans == bus_pkg::NONSEQ || proc_bus_if.trans == bus_pkg::NONSEQ) && ~hit && ~sramRead.frames[ridx].dirty && ~pass_through)
                    next_state = FETCH;
                if (flush || flush_req)  
                    next_state = FLUSH_CACHE;
                if (clear)
                    next_state = CLEAR_CACHE;
	        end
	        FETCH: begin
                //if (mem_bus_if.error || decoded_addr != decoded_req_addr || proc_bus_if.trans == bus_pkg::IDLE)
                if (mem_bus_if.error || word_count_done || proc_bus_if.trans == bus_pkg::IDLE)
                    next_state = HIT; 
	        end
	        WB: begin
                //if (mem_bus_if.error || decoded_addr != decoded_req_addr || proc_bus_if.trans == bus_pkg::IDLE)
                if (mem_bus_if.error || word_count_done)
                    next_state = HIT; 
                else if (word_count_done)
                    next_state = FETCH;
	        end
	        FLUSH_CACHE: begin        
                if (flush_done) next_state = HIT;
	        end
            CLEAR_CACHE: begin
                if(clear_done) next_state = HIT;
            end
	    endcase
    end

    // flush saver
    always_comb begin
        nflush_req = flush_req;
        if (flush)
            nflush_req = 1;
        if (state == FLUSH_CACHE)
            nflush_req = 0;
    end

endmodule
