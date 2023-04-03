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

localparam SRAM_WR_SIZE = 128;
localparam SRAM_HEIGHT = 128;

module l1_cache #(
    parameter CACHE_SIZE          = 1024, // must be power of 2, in bytes, max 4k - 4 * 2^10
    parameter BLOCK_SIZE          = 2, // must be power of 2, max 8
    parameter ASSOC               = 1, // 1 or 2 so far
    parameter NONCACHE_START_ADDR = 32'hF000_0000 // sh/sb still have issues when uncached; not sure whats up with that still tbh
)
(
    input logic CLK, nRST,
    input logic clear, flush,
    output logic clear_done, flush_done,
    generic_bus_if.cpu mem_gen_bus_if,
    generic_bus_if.generic_bus proc_gen_bus_if
);

    // TODO:
    // 2. Implement Flush & Clear functunality
    // 6. Test for ASSOC = 1

    // FIXME:
    // 1. see all FIXME notes through file
    // 2. there is a difference between the 4 addr for read miss and block WB
    //      check that you start incrementing your next_read_addr + 4 from the proper base offset

    import rv32i_types_pkg::*;
    
    // local parameters
    localparam N_TOTAL_BYTES      = CACHE_SIZE / 8;
    localparam N_TOTAL_WORDS      = N_TOTAL_BYTES / 4;
    localparam N_TOTAL_FRAMES     = N_TOTAL_WORDS / (BLOCK_SIZE);
    localparam N_SETS             = N_TOTAL_FRAMES / ASSOC;
    localparam N_FRAME_BITS       = $clog2(ASSOC);
    localparam N_SET_BITS         = $clog2(N_SETS);
    localparam N_BLOCK_BITS       = $clog2(BLOCK_SIZE);
    localparam N_TAG_BITS         = WORD_SIZE - N_SET_BITS - N_BLOCK_BITS - 2;
    localparam FRAME_SIZE         = WORD_SIZE * BLOCK_SIZE + N_TAG_BITS + 2; // in bits

    // sram parameters
    localparam SRAM_W = FRAME_SIZE * ASSOC; // add size from the multicore later smile 

    // cache frame type
    typedef struct packed {
        logic valid;
        logic dirty;
        logic [N_TAG_BITS - 1:0] tag;
        word_t [BLOCK_SIZE - 1:0] data;
    } cache_frame_t;

    typedef struct packed {
        cache_frame_t [ASSOC - 1:0] frames;
    } cache_set_t;
    
    cache_set_t sramWrite, sramRead, sramMask;
    logic sramREN, sramWEN; 
    logic [N_SET_BITS-1:0] sramSEL;
    sram #(.SRAM_WR_SIZE(SRAM_W), .SRAM_HEIGHT(N_SETS)) 
        SRAM(CLK, nRST, sramWrite, sramRead, sramREN, sramWEN, sramSEL, sramMask);

    // FSM type
    typedef enum {
       IDLE, FETCH, WB, FLUSH_CACHE, FLUSH_SET, FLUSH_FRAME
    } fsm_t;

    // Cache address decode type
    typedef struct packed {
        logic [N_TAG_BITS - 1:0] tag_bits;
        logic [N_SET_BITS - 1:0] idx_bits;
        logic [N_BLOCK_BITS - 1:0] block_bits;
        logic [1:0] byte_bits;
    } decoded_addr_t;

    // Set Counter
    logic [12:0] set_num, next_set_num;
    logic en_set_ctr, clr_set_ctr;

    // Frame(way) Counter - either 1 or 2 frames in a set 
    logic [1:0] frame_num, next_frame_num;
    logic en_frame_ctr, clr_frame_ctr;

    // Word Counter
    logic [3:0] word_num, next_word_num;
    logic en_word_ctr, clr_word_ctr;

    // Counter Finish flags
    logic finish_word, finish_frame, finish_set;

    // States
    fsm_t state, next_state;

     // cache replacement policy variables // Do we need 2 bits for the replacement policy?
    logic ridx;
    logic [N_SETS - 1:0] last_used;
    logic [N_SETS - 1:0] next_last_used;

    // Read Address
    word_t read_addr, next_read_addr; // remember read addr. at IDLE to increment by 4 later when fetching

    // output address
    decoded_addr_t decoded_req_addr;
    decoded_addr_t next_decoded_req_addr;

    // Decode incoming addr. to cache config. bits
    decoded_addr_t decoded_addr;

    //ABORT 
    logic abort;

    // flip flops
    always_ff @ (posedge CLK, negedge nRST) begin
        if(~nRST) begin
            // counter variables for flushing
            set_num   <= '0;
            frame_num <= '0;
            word_num  <= '0;        // need to rename
            /* cache registers */
            last_used <= '0;
            state <= IDLE;
            /* idk what these are */
            read_addr <= '0;
            decoded_req_addr <= '0;
        end
        else begin
            set_num   <= next_set_num;
            frame_num <= next_frame_num;
            word_num  <= next_word_num;
            last_used <= next_last_used;
            state <= next_state;
            read_addr <= next_read_addr;
            decoded_req_addr <= next_decoded_req_addr;
        end
    end
    
    // Comb. logic for counters
    always_comb begin
        next_set_num 	= set_num;
        next_frame_num 	= frame_num;
        next_word_num 	= word_num;

        if(clr_set_ctr)
            next_set_num = '0;
        else if(en_set_ctr)
            next_set_num = set_num + 1'b1;

        if(clr_frame_ctr)
            next_frame_num = '0;
        else if(en_frame_ctr)
            next_frame_num = frame_num + 1'b1;

        if(clr_word_ctr)
            next_word_num = '0;
        else if(en_word_ctr)
            next_word_num = word_num + 1'b1;
    end

    // Comb. output logic for counter finish flags
    assign finish_set   = (set_num == N_SETS);
    assign finish_frame = (frame_num == ASSOC);
    assign finish_word 	= (word_num == BLOCK_SIZE);
   
    assign decoded_addr = decoded_addr_t'(proc_gen_bus_if.addr);

    // Cache Hit
    logic hit, pass_through;
    word_t [BLOCK_SIZE - 1:0] hit_data;
    logic hit_idx;

    // hit logic with pass through
    always_comb begin
        hit 	        = '0;
        hit_idx         = '0;
        hit_data        = '0;
        pass_through    = '0;

        if(proc_gen_bus_if.addr >= NONCACHE_START_ADDR) begin
            pass_through = 1'b1;
        end
        else begin
            for(int i = 0; i < ASSOC; i++) begin
                if(sramRead.frames[i].tag == decoded_addr.tag_bits && sramRead.frames[i].valid) begin
                    hit       = 1'b1;
                    hit_data  = sramRead.frames[i].data;
                    hit_idx   = i;
                end
            end
        end
    end

    assign sramREN = 1;
    logic flushing;
    assign sramSEL = flushing ? set_num : decoded_addr.idx_bits;


    // Comb. logic for outputs, maybe merging this comb. block with the one above
    // could be an optmization. Hopefully, synthesizer is smart to catch it.
    // for now leave it like this for readability.
    // Outputs: counter control signals, cache, signals to memory, signals to processor
    always_comb begin
        sramWEN = 0;
        sramWrite = 0;
        sramMask = '1;
        flushing = 0;

        proc_gen_bus_if.busy    = 1'b1;
        mem_gen_bus_if.ren      = 1'b0;
        mem_gen_bus_if.wen      = 1'b0;
        mem_gen_bus_if.addr     = '0; //FIXME: THIS WAS ADDED TO THE DESIGN BY VERIFICATION
        mem_gen_bus_if.wdata    = '0; //FIXME: THIS WAS ADDED TO THE DESIGN BY VERIFICATION
        mem_gen_bus_if.byte_en  = '1; // this should totally be 1111
        next_read_addr          = read_addr;               //FIXME: THIS WAS ADDED TO THE DESIGN BY VERIFICATION
        en_set_ctr 	            = 1'b0;
        en_word_ctr 	        = 1'b0;
        en_frame_ctr 	        = 1'b0;
        clr_set_ctr 	        = 1'b0;
        clr_word_ctr 	        = 1'b0;
        clr_frame_ctr 	        = 1'b0;
        flush_done 	            = 1'b0;
        clear_done 	            = 1'b0;
        next_decoded_req_addr   = decoded_req_addr;
        next_last_used = last_used; //keep same last used

       	if(ASSOC == 1) begin
	        ridx  = 1'b0;
	    end
	    else if (ASSOC == 2) begin
	        ridx  = ~last_used[decoded_addr.idx_bits];
	    end

        casez(state)
            IDLE: begin
                next_read_addr = decoded_addr;
                if(proc_gen_bus_if.ren && hit && !flush) begin // if read enable and hit
                    proc_gen_bus_if.busy 		   = 1'b0; // Set bus to not busy
                    proc_gen_bus_if.rdata 		   = hit_data[decoded_addr.block_bits]; //
		            next_last_used[decoded_addr.idx_bits]  = hit_idx;
                end
                else if(proc_gen_bus_if.wen && hit && !flush) begin // if write enable and hit
                    proc_gen_bus_if.busy 							     = 1'b0;
                    sramWEN = 1;
                    casez (proc_gen_bus_if.byte_en)
                        4'b0001:    sramMask.frames[hit_idx].data[decoded_addr.block_bits] = 32'hFFFFFF00;
                        4'b0010:    sramMask.frames[hit_idx].data[decoded_addr.block_bits] = 32'hFFFF00FF;
                        4'b0100:    sramMask.frames[hit_idx].data[decoded_addr.block_bits] = 32'hFF00FFFF;
                        4'b1000:    sramMask.frames[hit_idx].data[decoded_addr.block_bits] = 32'h00FFFFFF;
		                4'b0011:    sramMask.frames[hit_idx].data[decoded_addr.block_bits] = 32'hFFFF0000;
		                4'b1100:    sramMask.frames[hit_idx].data[decoded_addr.block_bits] = 32'h0000FFFF;
                        default:    sramMask.frames[hit_idx].data[decoded_addr.block_bits] = 32'h0;
                    endcase
                    sramWrite.frames[hit_idx].data[decoded_addr.block_bits] = proc_gen_bus_if.wdata;
                    sramMask.frames[hit_idx].dirty 	    = 0;														   				   
		            sramWrite.frames[hit_idx].dirty 	    = 1'b1;
		            next_last_used[decoded_addr.idx_bits]   = hit_idx;
                end
                else if(pass_through)begin // Passthrough data logic
                    mem_gen_bus_if.wen      = proc_gen_bus_if.wen;
                    mem_gen_bus_if.ren      = proc_gen_bus_if.ren;
                    mem_gen_bus_if.addr     = proc_gen_bus_if.addr;
                    mem_gen_bus_if.byte_en  = proc_gen_bus_if.byte_en;
                    proc_gen_bus_if.busy    = mem_gen_bus_if.busy;
                    proc_gen_bus_if.rdata   = mem_gen_bus_if.rdata;
                    if(proc_gen_bus_if.wen)begin // kinda sus
                        casez (proc_gen_bus_if.byte_en) // Case statement for byte enable
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
		        else if((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && ~sramRead.frames[ridx].dirty && ~pass_through) begin // FETCH
                    next_decoded_req_addr = decoded_addr;
                	next_read_addr =  {decoded_addr.tag_bits, decoded_addr.idx_bits, N_BLOCK_BITS'('0), 2'b00}; ////////////////////// FIX FOR WB to wrong address?

			    end
			    else if((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && sramRead.frames[ridx].dirty && ~pass_through) begin // WB
                    next_decoded_req_addr = decoded_addr;
			        next_read_addr  =  {sramRead.frames[ridx].tag, decoded_addr.idx_bits, N_BLOCK_BITS'('0), 2'b00};
            	end
            end // case: IDLE
	    
            FETCH: begin
                 if(~abort)begin
                    mem_gen_bus_if.ren   = 1'b1;
                    mem_gen_bus_if.addr  = read_addr;

                    if(finish_word) begin
                        sramWEN = 1;
                        clr_word_ctr 					        = 1'b1;
                        sramWrite.frames[ridx].valid            = 1'b1;
                        sramWrite.frames[ridx].tag 	            = decoded_req_addr.tag_bits;
                        sramMask.frames[ridx].valid = 0;
                        sramMask.frames[ridx].tag = 0;
                        mem_gen_bus_if.ren 					    = 1'b0;
                    end
                    else if(~mem_gen_bus_if.busy && ~finish_word) begin
                        sramWEN = 1;
                        en_word_ctr 						   = 1'b1;
                        next_read_addr 						   = read_addr + 4;
                        sramWrite.frames[ridx].data[word_num]  = mem_gen_bus_if.rdata;
                        sramMask.frames[ridx].data[word_num] = 0;
                    end
                end
            end // case: FETCH
	    
            WB: begin
                if(~abort)begin
                    mem_gen_bus_if.wen    = 1'b1;
                    mem_gen_bus_if.addr   = read_addr; 
                    mem_gen_bus_if.wdata  = sramRead.frames[ridx].data[word_num];
    
                    if(finish_word) begin
                        sramWEN = 1;
                        clr_word_ctr 					  = 1'b1;
                        next_read_addr  =  {decoded_req_addr.tag_bits, decoded_req_addr.idx_bits, N_BLOCK_BITS'('0), 2'b00}; //TODO: CHECK THIS, ADDED BY VERIFICATION
                        sramWrite.frames[ridx].dirty = 1'b0;
                        sramMask.frames[ridx].dirty = 0;
                        mem_gen_bus_if.wen 					  = 1'b0;
                    end
                    else if(~mem_gen_bus_if.busy && ~finish_word) begin
                        en_word_ctr     = 1'b1;
                        next_read_addr  = read_addr + 4;
                    end
                end
            end // case: WB
            // Maybe: you don't even need counters, three loops is enough
            // whenever you find a frame that is dirty, goto state FLUSH_WB
            // write back, un-dirty and then come back to FLUSH_CACHE
            // then re-loop to search for dirty frame
            FLUSH_CACHE: begin
                flushing = 1;
                if(finish_set) begin
                    clr_set_ctr  = 1'b1;
                    flush_done 	 = 1'b1;
                end
            end
	    
            // FLUSH_SET is not required, because we already know ASSOC is either 1 or 2
            // therefore, just checking ASSOC in FLUSH_FRAME, and deciding whether to go back to
            // FLUSH_CACHE or stay for cleaning of the another frame is sufficient
            FLUSH_SET: begin 
                flushing = 1;
                if(finish_frame) begin
                    clr_frame_ctr  = 1'b1;
                    en_set_ctr 	   = 1'b1;
                end
                if(~sramRead.frames[frame_num].valid) begin
                    en_frame_ctr  = 1'b1;
                end
            end // case: FLUSH_SET
	    
            FLUSH_FRAME: begin
                flushing = 1;
	            if (sramRead.frames[frame_num].dirty) begin
                    mem_gen_bus_if.wen    = 1'b1;
                    mem_gen_bus_if.addr   = {sramRead.frames[frame_num].tag, set_num[N_SET_BITS - 1:0], word_num[N_BLOCK_BITS - 1:0], 2'b00};
                    mem_gen_bus_if.wdata  = sramRead.frames[frame_num].data[word_num];
	            end
                if(finish_word) begin
                    sramWEN = 1;
                    clr_word_ctr 				 = 1'b1;
                    en_frame_ctr 				 = 1'b1;
                    mem_gen_bus_if.wen           = 1'b0;
	    	        sramWrite.frames[frame_num] = 0;
                    sramMask.frames[frame_num] = 0;
                end		
                if(~mem_gen_bus_if.busy || ~sramRead.frames[frame_num].dirty) begin
                    en_word_ctr  = 1'b1;
                end
            end // case: FLUSH_FRAME
        endcase // casez (state)
    end // always_comb

    // Comb. logic for next state for FSM
    always_comb begin
	    next_state = state;
        abort = 0;
	    casez(state)
	        IDLE: begin                    
                if((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && sramRead.frames[ridx].dirty && ~pass_through) 
                    next_state 	= WB;
                else if((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && ~sramRead.frames[ridx].dirty && ~pass_through)
                    next_state 	= FETCH;
                
	        end
	        FETCH: begin
                if(decoded_addr != decoded_req_addr)begin //ABORT 
                    next_state = IDLE;
                    abort = 1;
                end
                else if(finish_word) begin
                    next_state 	= IDLE;
                end
	        end
	        WB: begin
                if(decoded_addr != decoded_req_addr)begin //ABORT
                    next_state = IDLE; 
                    abort = 1;
                end
                else if(finish_word) begin
                    next_state 	= FETCH;
                end
	        end
	        FLUSH_CACHE: begin
                next_state  = FLUSH_SET;
        
                if(finish_set) begin
                    next_state 	= IDLE;
                end
	        end
	        FLUSH_SET: begin
                if(finish_frame) begin
                    next_state 	= FLUSH_CACHE;
                end
                else if(sramRead.frames[frame_num].valid) begin
                    next_state = FLUSH_FRAME;
                end
	        end
	        FLUSH_FRAME: begin
                if(finish_word)
	                next_state = FLUSH_SET;
	        end
	    endcase // casez (state)
        if(flush)  
            next_state 	= FLUSH_CACHE;
    end // always_comb

endmodule // l1_cache