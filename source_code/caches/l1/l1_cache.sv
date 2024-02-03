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

`include "generic_bus_if.vh"
`include "cache_coherence_if.vh"

module l1_cache #(
    parameter CACHE_SIZE          = 1024, // must be power of 2, in bytes, max 4k - 4 * 2^10
    parameter BLOCK_SIZE          = 2, // must be power of 2, max 8
    parameter ASSOC               = 1, // dont set this to 0
    parameter NONCACHE_START_ADDR = 32'hF000_0000, // sh/sb still have issues when uncached; not sure whats up with that still tbh
    parameter CPUS = 1
)
(
    input logic CLK, nRST,
    input logic clear, flush, reserve, exclusive,
    output logic clear_done, flush_done, abort_bus,
    generic_bus_if.cpu mem_gen_bus_if,
    generic_bus_if.generic_bus proc_gen_bus_if,
    cache_coherence_if.cache ccif //Coherency interface, connected to coherency unit
);
    import rv32i_types_pkg::*;
    
    // local parameters
    localparam N_TOTAL_BYTES      = CACHE_SIZE / 8;
    localparam N_TOTAL_WORDS      = N_TOTAL_BYTES / 4;
    localparam N_TOTAL_FRAMES     = N_TOTAL_WORDS / BLOCK_SIZE;
    localparam N_SETS             = N_TOTAL_FRAMES / ASSOC;
    localparam N_FRAME_BITS       = $clog2(ASSOC);// + (ASSOC == 1);
    localparam N_SET_BITS         = $clog2(N_SETS);// + (N_SETS == 1);
    localparam N_BLOCK_BITS       = $clog2(BLOCK_SIZE);// + (BLOCK_SIZE == 1);
    localparam N_TAG_BITS         = WORD_SIZE - N_SET_BITS - N_BLOCK_BITS - 2;
    localparam FRAME_SIZE         = WORD_SIZE * BLOCK_SIZE + N_TAG_BITS + 2 + 1; // in bits (+1 for exclusive bit)
    localparam SRAM_W             = FRAME_SIZE * ASSOC;                      // sram parameters
    localparam SRAM_TAG_W         = (N_TAG_BITS + 3) * ASSOC; // +3 for valid, dirty, and exclusive

    //typedef enum logic[1:0] {INVALID=0, EXCLUSIVE, SHARED, MODIFIED} frame_state_t;

    typedef struct packed {
        logic exclusive;
        logic valid;
        logic dirty;
        logic [N_TAG_BITS-1:0] tag_bits;
    } cache_tag_t;

    typedef struct packed{
        //frame_state_t mesi_state;
        cache_tag_t tag;
        word_t [BLOCK_SIZE - 1:0] data;
    } cache_frame_t;    // cache frame

    typedef struct packed {
        cache_frame_t [ASSOC - 1:0] frames;
    } cache_set_t;      // cache set

    typedef struct packed {
        logic [N_TAG_BITS-1:0] tag_bits;
        logic [N_SET_BITS-1:0] idx_bits;
        logic [N_BLOCK_BITS-1:0] block_bits;
    } decoded_cache_idx_t;

    typedef struct packed {
        decoded_cache_idx_t idx;
        logic [1:0] byte_bits;
    } decoded_cache_addr_t;   // cache address type

    typedef struct packed {
        logic finish;
        logic [N_SET_BITS-1:0] set_num;
        logic [N_FRAME_BITS-1:0] frame_num; // assoc
        logic [N_BLOCK_BITS-1:0] word_num;
    } flush_idx_t;             // flush counter type

    typedef enum {
       IDLE, HIT, FETCH, WB, FLUSH_CACHE, SNOOP
    } cache_fsm_t;            // cache state machine

    // TODO rename `valid` to `reserved` and use `exclusive` bit from tag
    typedef struct packed {
        decoded_cache_idx_t idx;
        logic valid;
        logic exclusive;
    } reservation_set_t;
    
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
    word_t read_addr, next_read_addr;
    decoded_cache_addr_t decoded_req_addr, next_decoded_req_addr;
    decoded_cache_addr_t decoded_addr, decoded_snoop_addr;
    // Cache Hit
    logic hit, pass_through;
    word_t [BLOCK_SIZE-1:0] hit_data;
    logic [N_FRAME_BITS-1:0] hit_idx;
    // sram signals
    cache_set_t sramWrite, sramRead, sramMask, sramBus;
    cache_tag_t [ASSOC-1:0] sramTags;
    logic sramWEN; // no need for REN
    logic [N_SET_BITS-1:0] sramSEL, sramSNOOPSEL;
    // flush reg
    logic flush_req, nflush_req;
    logic idle_done;
    // Reservation tracking
    reservation_set_t reservation_set, next_reservation_set;
    logic addr_is_reserved, addr_is_exclusive;

    // error handling
    assign proc_gen_bus_if.error = mem_gen_bus_if.error;

    // sram instance
    assign sramSEL = (state == FLUSH_CACHE || state == IDLE) ? flush_idx.set_num : decoded_addr.idx.idx_bits;
    assign sramSNOOPSEL =  decoded_snoop_addr.idx.idx_bits;
    sram #(.SRAM_WR_SIZE(SRAM_W), .SRAM_HEIGHT(N_SETS)) 
        CPU_SRAM(.CLK(CLK), .nRST(nRST), .wVal(sramWrite), .rVal(sramRead), .REN(1'b1), .WEN(sramWEN), .SEL(sramSEL), .wMask(sramMask));
    sram #(.SRAM_WR_SIZE(SRAM_TAG_W), .SRAM_HEIGHT(N_SETS))
        BUS_SRAM(.CLK(CLK), .nRST(nRST), .wVal(sramTags), .rVal(ccif.frame_tag), .REN(1'b1), .WEN(sramWEN), .SEL(ccif.set_sel), .wMask(sramMask));

    // TODO: Update this with valid, dirty, exclusive bits
    // assign ccif.frame_state = sramBus[SRAM_W-1:SRAM_W-2];

    // flip flops
    always_ff @ (posedge CLK, negedge nRST) begin
        if(~nRST) begin
            state <= IDLE;
            flush_idx <= 0;
            word_num <= 0;
            last_used <= 0;
            read_addr <= 0;
            decoded_req_addr <= 0;
            flush_req <= 0;
            abort_bus <= 0;
            reservation_set <= 0;
        end
        else begin
            state <= next_state;                        // cache state machine
            flush_idx <= next_flush_idx;                // index for flushing the cache entries
            word_num <= next_word_num;                  // word counter for fetching/writing back
            last_used <= next_last_used;                // MRU index
            read_addr <= next_read_addr;                // cache address to provide to memory
            decoded_req_addr <= next_decoded_req_addr;  // cache address requested by core
            flush_req <= nflush_req;                    // flush requested by core
            abort_bus <= !proc_gen_bus_if.ren;
            reservation_set <= next_reservation_set;
        end
    end
    
    // counters
    always_comb begin
        next_word_num = word_num;
        next_flush_idx = flush_idx;
        word_count_done = ~mem_gen_bus_if.busy && (BLOCK_SIZE - 1) == word_num;
        // word counter logic
        if (clear_word_count)
            next_word_num = 0;
        else if (enable_word_count)
            next_word_num = word_num + 1;

        // flush counter logic
        if (clear_flush_count)
            next_flush_idx = 0;
        else if (enable_flush_count_nowb && BLOCK_SIZE != 1) // kinda sus
            next_flush_idx = flush_idx + BLOCK_SIZE; 
        else if (enable_flush_count || enable_flush_count_nowb)
            next_flush_idx = flush_idx + 1;

        // correction for non-powers of 2
        if (next_flush_idx.set_num == N_SETS) begin
            next_flush_idx.finish = 1;
            next_flush_idx.set_num = 0;
            next_flush_idx.frame_num = 0;
            next_flush_idx.word_num = 0;
        end
        else if (next_flush_idx.frame_num == ASSOC) begin
            next_flush_idx.set_num = flush_idx.set_num + 1;
            next_flush_idx.frame_num = 0;
            next_flush_idx.word_num = 0;
        end
        // should be rewritten to be more concise
        else if (next_flush_idx.word_num == BLOCK_SIZE) begin
            if (ASSOC == 1) begin
                next_flush_idx.set_num = flush_idx.set_num + 1;
                next_flush_idx.frame_num = 0;
                next_flush_idx.word_num = 0;
            end
            else begin
                next_flush_idx.frame_num = flush_idx.frame_num + 1;
                next_flush_idx.word_num = 0;
            end
        end

        // FOR ASSOC == 1 FINISH FLAG
        if (next_flush_idx.set_num == 0 && flush_idx.set_num == N_SETS - 1) begin
            next_flush_idx.finish = 1;
            next_flush_idx.set_num = 0;
            next_flush_idx.frame_num = 0;
            next_flush_idx.word_num = 0;
        end
    end

    // decoded address conversion
    assign decoded_addr = decoded_cache_addr_t'(proc_gen_bus_if.addr);
    // TODO: update this with idx_bits
    // assign decoded_snoop_addr = decoded_cache_addr_t'(ccif.ccsnoopaddr);

    // hit logic with pass through
    always_comb begin
        hit 	        = 0;
        hit_idx         = 0;
        hit_data        = 0;
        pass_through    = proc_gen_bus_if.addr >= NONCACHE_START_ADDR;

        if (!pass_through) begin
            for(int i = 0; i < ASSOC; i++) begin
                if(sramRead.frames[i].tag.tag_bits == decoded_addr.idx.tag_bits && sramRead.frames[i].tag.valid) begin
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
<<<<<<< HEAD
        sramWEN                 = 0;
        sramWrite               = 0;
        sramMask                = '1;
        proc_gen_bus_if.busy    = 1;
        proc_gen_bus_if.rdata   = 0; // TODO: Can this be optimized?
        mem_gen_bus_if.ren      = 0;
        mem_gen_bus_if.wen      = 0;
        mem_gen_bus_if.addr     = 0; 
        mem_gen_bus_if.wdata    = 0; 
        mem_gen_bus_if.byte_en  = '1; // set this to all 1s for evictions
        enable_flush_count      = 0;
        enable_word_count       = 0;
        enable_flush_count_nowb = 0;
        clear_flush_count       = 0;
        clear_word_count        = 0;
        flush_done 	            = 0;
        idle_done               = 0;
        clear_done 	            = 0;
        next_read_addr          = read_addr;
        next_decoded_req_addr   = decoded_req_addr;
        next_last_used          = last_used;
        
        // associativity, using NRU
        if (ASSOC == 1 || (last_used[decoded_addr.idx.idx_bits] == (ASSOC - 1)))
            ridx = 0;
        else
            ridx = last_used[decoded_addr.idx.idx_bits] + 1;

        // state dependent output logic
=======
        proc_gen_bus_if.busy    = 1'b1;
        mem_gen_bus_if.ren      = 1'b0;
        mem_gen_bus_if.wen      = 1'b0;
        mem_gen_bus_if.addr     = '0; //FIXME: THIS WAS ADDED TO THE DESIGN BY VERIFICATION
        mem_gen_bus_if.wdata    = '0; //FIXME: THIS WAS ADDED TO THE DESIGN BY VERIFICATION
        mem_gen_bus_if.byte_en  = proc_gen_bus_if.byte_en; //FIXME: THIS WAS ADDED TO THE DESIGN BY VERIFICATION
        next_read_addr          = read_addr;               //FIXME: THIS WAS ADDED TO THE DESIGN BY VERIFICATION
        en_set_ctr 	            = 1'b0;
        en_word_ctr 	        = 1'b0;
        en_frame_ctr 	        = 1'b0;
        clr_set_ctr 	        = 1'b0;
        clr_word_ctr 	        = 1'b0;
        clr_frame_ctr 	        = 1'b0;
        flush_done 	            = 1'b0;
        // flush_done 	            = 1'b0; //Duplicated?

       	if(ASSOC == 1) begin
	        ridx  = 1'b0;
	    end
	    else if (ASSOC == 2) begin
	        ridx  = ~last_used[decoded_addr.set_bits];
	    end
       
        for(int i = 0; i < N_SETS; i++) begin // next = orginal Use blocking to go through array?
            for(int j = 0; j < ASSOC; j++) begin
                next_cache[i].frames[j].data   = cache[i].frames[j].data;
                next_cache[i].frames[j].tag    = cache[i].frames[j].tag;
                next_cache[i].frames[j].valid  = cache[i].frames[j].valid;
                next_cache[i].frames[j].dirty  = cache[i].frames[j].dirty;
            end // for (int j = 0; j < ASSOC; j++)
	    next_last_used[i] = last_used[i]; //keep same last used
        end

>>>>>>> e238035a... testbench running without stall
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
                next_read_addr = decoded_addr;
                clear_word_count = 1;
                // cache hit on a processor read
                if(proc_gen_bus_if.ren && hit && !flush) begin
                    proc_gen_bus_if.busy = 0; 
                    proc_gen_bus_if.rdata = hit_data[decoded_addr.idx.block_bits];
                    next_last_used[decoded_addr.idx.idx_bits] = hit_idx;
                end
                // cache hit on a processor write
                else if(proc_gen_bus_if.wen && hit && !flush) begin
                    proc_gen_bus_if.busy = 0;
                    sramWEN = 1;
                    casez (proc_gen_bus_if.byte_en)
                        4'b0001:    sramMask.frames[hit_idx].data[decoded_addr.idx.block_bits] = 32'hFFFFFF00;
                        4'b0010:    sramMask.frames[hit_idx].data[decoded_addr.idx.block_bits] = 32'hFFFF00FF;
                        4'b0100:    sramMask.frames[hit_idx].data[decoded_addr.idx.block_bits] = 32'hFF00FFFF;
                        4'b1000:    sramMask.frames[hit_idx].data[decoded_addr.idx.block_bits] = 32'h00FFFFFF;
                        4'b0011:    sramMask.frames[hit_idx].data[decoded_addr.idx.block_bits] = 32'hFFFF0000;
                        4'b1100:    sramMask.frames[hit_idx].data[decoded_addr.idx.block_bits] = 32'h0000FFFF;
                        default:    sramMask.frames[hit_idx].data[decoded_addr.idx.block_bits] = 32'h0;
                    endcase
                    sramMask.frames[hit_idx].tag.dirty = 0;
                    sramWrite.frames[hit_idx].data[decoded_addr.idx.block_bits] = proc_gen_bus_if.wdata;
                    sramWrite.frames[hit_idx].tag.dirty = 1;
                    next_last_used[decoded_addr.idx.idx_bits] = hit_idx;
                    if (reserve) begin
                        // 0 is success, 1 is failure
                        proc_gen_bus_if.rdata = {31'b0, ~addr_is_reserved};
                    end
                end
                // passthrough
                else if(pass_through && (proc_gen_bus_if.wen || proc_gen_bus_if.ren)) begin
                    mem_gen_bus_if.wen      = proc_gen_bus_if.wen;
                    mem_gen_bus_if.ren      = proc_gen_bus_if.ren;
                    mem_gen_bus_if.addr     = proc_gen_bus_if.addr;
                    mem_gen_bus_if.byte_en  = proc_gen_bus_if.byte_en;
                    proc_gen_bus_if.busy    = mem_gen_bus_if.busy;
                    proc_gen_bus_if.rdata   = mem_gen_bus_if.rdata;
                    if(proc_gen_bus_if.wen) begin
                        casez (proc_gen_bus_if.byte_en)
                            4'b0001:    mem_gen_bus_if.wdata  = {24'd0, proc_gen_bus_if.wdata[7:0]};
                            4'b0010:    mem_gen_bus_if.wdata  = {16'd0,proc_gen_bus_if.wdata[15:8],8'd0};
                            4'b0100:    mem_gen_bus_if.wdata  = {8'd0, proc_gen_bus_if.wdata[23:16], 16'd0};
                            4'b1000:    mem_gen_bus_if.wdata  = {proc_gen_bus_if.wdata[31:24], 24'd0};
                            4'b0011:    mem_gen_bus_if.wdata  = {16'd0, proc_gen_bus_if.wdata[15:0]};
                            4'b1100:    mem_gen_bus_if.wdata  = {proc_gen_bus_if.wdata[31:16],16'd0};
                            default:    mem_gen_bus_if.wdata  = proc_gen_bus_if.wdata;
                        endcase
                    end 
                end
                // Cache miss of sc
                else if (proc_gen_bus_if.wen && reserve && ~hit && ~pass_through) begin
                    proc_gen_bus_if.busy = 0;
                    proc_gen_bus_if.rdata = 32'b1;
                end
                // cache miss on a clean block
		        else if((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && ~sramRead.frames[ridx].tag.dirty && ~pass_through) begin
                    next_decoded_req_addr = decoded_addr;
                    next_read_addr =  {decoded_addr.idx.tag_bits, decoded_addr.idx.idx_bits, (N_BLOCK_BITS + 2)'('0)};
			    end
                // cache miss on a dirty block
			    else if((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && sramRead.frames[ridx].tag.dirty && ~pass_through) begin
                    next_decoded_req_addr = decoded_addr;
                    next_read_addr  =  {sramRead.frames[ridx].tag.tag_bits, decoded_addr.idx.idx_bits, (N_BLOCK_BITS + 2)'('0)};
            	end
            end 
            FETCH: begin
                // set cache to be invalid before cache completes fetch
                mem_gen_bus_if.ren = 1;
                mem_gen_bus_if.addr = read_addr;
                sramMask.frames[ridx].tag.valid = 0;
                sramWrite.frames[ridx].tag.valid = 0;
                // fill data
                if(~mem_gen_bus_if.busy) begin
                    sramWEN                                = 1'b1;
                    enable_word_count                      = 1'b1;
                    next_read_addr 						   = read_addr + 4;
                    sramWrite.frames[ridx].data[word_num]  = mem_gen_bus_if.rdata;
                    sramMask.frames[ridx].data[word_num]   = 1'b0;
                end
                // complete fetch transaction from memory
                if(word_count_done) begin
                    sramWEN = 1;
                    clear_word_count                        = 1'b1;
                    sramWrite.frames[ridx].tag.valid        = 1'b1;
                    sramWrite.frames[ridx].tag.tag_bits     = decoded_req_addr.idx.tag_bits;
                    sramMask.frames[ridx].tag.valid         = 1'b0;
                    sramMask.frames[ridx].tag.tag_bits      = 1'b0;
                end
            end
            WB: begin
                // set stim for eviction
                mem_gen_bus_if.wen = 1'b1;
                mem_gen_bus_if.addr = read_addr; 
                mem_gen_bus_if.wdata = sramRead.frames[ridx].data[word_num];
                // increment eviction word counter
                if(~mem_gen_bus_if.busy) begin
                    enable_word_count = 1;
                    next_read_addr    = read_addr + 4;
                end
                // invalidate when eviction is complete
                if(word_count_done) begin
                    sramWEN = 1;
                    clear_word_count = 1;
                    sramWrite.frames[ridx].tag.dirty = 0;
                    sramMask.frames[ridx].tag.dirty = 0;
                    sramWrite.frames[ridx].tag.valid = 0;
                    sramMask.frames[ridx].tag.valid = 0;
                    next_read_addr = {decoded_addr.idx.tag_bits, decoded_addr.idx.idx_bits, (N_BLOCK_BITS + 2)'('0)};
                end
            end
            FLUSH_CACHE: begin
                // flush to memory if valid & dirty
                if (sramRead.frames[flush_idx.frame_num].tag.valid && sramRead.frames[flush_idx.frame_num].tag.dirty) begin
                    mem_gen_bus_if.wen    = 1'b1;
                    mem_gen_bus_if.addr   = {sramRead.frames[flush_idx.frame_num].tag.tag_bits, flush_idx.set_num, flush_idx.word_num, 2'b00};
                    mem_gen_bus_if.wdata  = sramRead.frames[flush_idx.frame_num].data[flush_idx.word_num];
                    // increment to next word when flush of word is done
                    if (~mem_gen_bus_if.busy) begin
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
        endcase

        for (int i = 0; i < ASSOC; i++) begin
            sramTags[i] = sramWrite.frames[i].tag;
        end
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
                if (proc_gen_bus_if.wen && reserve && ~hit) // Don't transition on a failed sc
                    next_state = state;
                else if ((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && sramRead.frames[ridx].tag.dirty && ~pass_through)
                    next_state = WB;
                else if ((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && ~sramRead.frames[ridx].tag.dirty && ~pass_through)
                    next_state = FETCH;
                if (flush || flush_req)  
                    next_state = FLUSH_CACHE;
	        end
	        FETCH: begin
                if (mem_gen_bus_if.error || decoded_addr != decoded_req_addr || !(proc_gen_bus_if.ren || proc_gen_bus_if.wen))
                    next_state = HIT; 
                else if (word_count_done)
                    next_state = HIT;
	        end
	        WB: begin
                if (mem_gen_bus_if.error || decoded_addr != decoded_req_addr || !(proc_gen_bus_if.ren || proc_gen_bus_if.wen))
                    next_state = HIT; 
                else if (word_count_done)
                    next_state = FETCH;
	        end
	        FLUSH_CACHE: begin        
                if (flush_done)
                    next_state = HIT;
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

    // Reservation tracking logic
    always_comb begin
        next_reservation_set = reservation_set;
        if (proc_gen_bus_if.ren && reserve) begin
            next_reservation_set.idx = decoded_addr.idx;
            next_reservation_set.valid = 1'b1;
            next_reservation_set.exclusive = exclusive;
        end else if (proc_gen_bus_if.ren || proc_gen_bus_if.wen || clear || flush) begin
            next_reservation_set.valid = 1'b0;
        end
        addr_is_reserved = reservation_set.valid && reservation_set.idx == decoded_addr.idx;
        addr_is_exclusive = addr_is_reserved && reservation_set.exclusive;
    end
endmodule
