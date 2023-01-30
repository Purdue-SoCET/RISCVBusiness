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

module l1_cache #(
    parameter CACHE_SIZE          = 1024, // must be power of 2, in bytes, max 4k - 4 * 2^10
    parameter BLOCK_SIZE          = 2, // must be power of 2, max 8
    parameter ASSOC               = 1, // 1 or 2 so far
    parameter NONCACHE_START_ADDR = 32'h8000_0000
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

    // cache frame type
    typedef struct packed {
        logic valid;
        logic dirty;
        logic [N_TAG_BITS - 1:0] tag;
        word_t [BLOCK_SIZE - 1:0] data;
    } cache_frame;

    typedef struct packed {
        cache_frame [ASSOC - 1:0] frames;
    } cache_sets;

    // FSM type
    typedef enum {
       IDLE, FETCH, WB, FLUSH_CACHE, FLUSH_SET, FLUSH_FRAME
    } fsm_t;

    // Cache address decode type
    typedef struct packed {
        logic [N_TAG_BITS - 1:0] tag_bits;
        logic [N_SET_BITS - 1:0] set_bits;
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

    // cache blocks, indexing cache chooses a set
    cache_sets cache [N_SETS - 1:0];
    cache_sets next_cache [N_SETS - 1:0];

     // cache replacement policy variables // Do we need 2 bits for the replacement policy?
    logic ridx;
    logic MRU [N_SETS - 1:0];
    logic next_MRU [N_SETS - 1:0];


    // Read Address
    word_t read_addr, next_read_addr; // remember read addr. at IDLE to increment by 4 later when fetching

    //ABORT 
    logic abort;

    // Counter always_ff
    always_ff @ (posedge CLK, negedge nRST) begin
        if(~nRST) begin
            set_num   <= '0;
            frame_num <= '0;
            word_num  <= '0;
        end
        else begin
            set_num   <= next_set_num;
            frame_num <= next_frame_num;
            word_num  <= next_word_num;
        end
    end // always_ff @

    // Cache Frame always_ff
    always_ff @ (posedge CLK, negedge nRST) begin
        if(~nRST)
            cache <= 0;
        else
            cache <= next_cache;
    end // always_ff @


    always_ff @(posedge CLK, negedge nRST) begin // FF for last used if ASSOC = 1
        if(~nRST)
            MRU <= 0;
        else
            MRU[i] <= next_MRU;
    end

    decoded_addr_t decoded_req_addr;
    decoded_addr_t next_decoded_req_addr;

    always_ff @ (posedge CLK, negedge nRST) begin
        if(~nRST) begin
            read_addr <= '0;
            decoded_req_addr <= '0;
        end
        else begin
            read_addr <= next_read_addr;
            decoded_req_addr <= next_decoded_req_addr;
        end
    end // always_ff @


    
     // FF for state
    always_ff @ (posedge CLK, negedge nRST)  begin
        if(~nRST) begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end // else: !if(~nRST)
    end // always_ff @


    // Comb. logic for counters
    always_comb begin
        next_set_num 	= set_num;
        next_frame_num 	= frame_num;
        next_word_num 	= word_num;

        if(clr_set_ctr) begin
            next_set_num = '0;
        end
        else if(en_set_ctr) begin
            next_set_num = set_num + 1'b1;
        end

        if(clr_frame_ctr) begin
            next_frame_num = '0;
        end
        else if(en_frame_ctr) begin
            next_frame_num = frame_num + 1'b1;
        end

        if(clr_word_ctr) begin
            next_word_num = '0;
        end
        else if(en_word_ctr) begin
            next_word_num = word_num + 1'b1;
        end
    end // always_comb

    // Comb. output logic for counter finish flags
    assign finish_set = (set_num == N_SETS) ? 1'b1 : 1'b0;
    assign finish_frame  = (frame_num == ASSOC) ? 1'b1 : 1'b0;
    assign finish_word 	= (word_num == BLOCK_SIZE) ? 1'b1 : 1'b0;

    	
    // Decode incoming addr. to cache config. bits
    decoded_addr_t decoded_addr;
    decoded_addr_t decoded_read_addr;
   



    assign decoded_addr = proc_gen_bus_if.addr;
    assign decoded_read_addr = read_addr;



    // Cache Hit
    logic hit, pass_through;
    word_t [BLOCK_SIZE - 1:0] hit_data;
    logic hit_idx;

    always_comb begin
        hit 	      = 1'b0;
        hit_idx         = '0;
        hit_data        = '0;
        pass_through  = 1'b0;

        if(proc_gen_bus_if.addr >= NONCACHE_START_ADDR) begin
            pass_through = 1'b1;
        end
        else begin
            for(int i = 0; i < ASSOC; i++) begin
                if(cache[decoded_addr.set_bits].frames[i].tag == decoded_addr.tag_bits && cache[decoded_addr.set_bits].frames[i].valid) begin
                    hit       = 1'b1;
                    hit_data  = cache[decoded_addr.set_bits].frames[i].data;
                    hit_idx   = i;
                end
            end
        end // else: !if(proc_gen_bus_if.addr >= NONCACHE_START_ADDR)
    end // always_comb

    

    ///WAS COMMENTED OUT Because combined with block below
    //always_comb begin
    //    if(ASSOC == 1) begin
    //        ridx  = 1'b0;
    //    end
    //    else if (ASSOC == 2) begin
    //        ridx  = ~MRU[decoded_addr.set_bits];
    //    e:nd
    //end
    ///


    // Comb. logic for outputs, maybe merging this comb. block with the one above
    // could be an optmization. Hopefully, synthesizer is smart to catch it.
    // for now leave it like this for readability.
    // Outputs: counter control signals, cache, signals to memory, signals to processor
    always_comb begin
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
        clear_done 	            = 1'b0;
        next_decoded_req_addr   = decoded_req_addr;

       	if(ASSOC == 1) begin
	        ridx  = 1'b0;
	    end
	    else if (ASSOC == 2) begin
	        ridx  = ~MRU[decoded_addr.set_bits];
	    end
       
        for(int i = 0; i < N_SETS; i++) begin // next = orginal Use blocking to go through array?
            for(int j = 0; j < ASSOC; j++) begin
                next_cache[i].frames[j].data   = cache[i].frames[j].data;
                next_cache[i].frames[j].tag    = cache[i].frames[j].tag;
                next_cache[i].frames[j].valid  = cache[i].frames[j].valid;
                next_cache[i].frames[j].dirty  = cache[i].frames[j].dirty;
            end // for (int j = 0; j < ASSOC; j++)
	    next_MRU[i] = MRU[i]; //keep same last used
        end

        casez(state)
            IDLE: begin
                
                next_read_addr = decoded_addr;

                if(proc_gen_bus_if.ren && hit && !flush) begin // if read enable and hit
                    proc_gen_bus_if.busy 		   = 1'b0; // Set bus to not busy
                    proc_gen_bus_if.rdata 		   = hit_data[decoded_addr.block_bits]; //
		            next_MRU[decoded_addr.set_bits]  = hit_idx;
                end
                else if(proc_gen_bus_if.wen && hit && !flush) begin // if write enable and hit
                    proc_gen_bus_if.busy 							     = 1'b0;
                    casez (proc_gen_bus_if.byte_en)
                        4'b0001:    next_cache[decoded_addr.set_bits].frames[hit_idx].data[decoded_addr.block_bits]  = (cache[decoded_addr.set_bits].frames[hit_idx].data[decoded_addr.block_bits] & 32'hFFFFFF00)|{24'd0,proc_gen_bus_if.wdata[7:0]};
                        4'b0010:    next_cache[decoded_addr.set_bits].frames[hit_idx].data[decoded_addr.block_bits]  = (cache[decoded_addr.set_bits].frames[hit_idx].data[decoded_addr.block_bits] & 32'hFFFF00FF)|{16'd0,proc_gen_bus_if.wdata[15:8], 8'd0};
                        4'b0100:    next_cache[decoded_addr.set_bits].frames[hit_idx].data[decoded_addr.block_bits]  = (cache[decoded_addr.set_bits].frames[hit_idx].data[decoded_addr.block_bits] & 32'hFF00FFFF)|{8'd0, proc_gen_bus_if.wdata[23:16], 16'd0};
                        4'b1000:    next_cache[decoded_addr.set_bits].frames[hit_idx].data[decoded_addr.block_bits]  = (cache[decoded_addr.set_bits].frames[hit_idx].data[decoded_addr.block_bits] & 32'h00FFFFFF)|{proc_gen_bus_if.wdata[31:24], 24'd0};
		                4'b0011:    next_cache[decoded_addr.set_bits].frames[hit_idx].data[decoded_addr.block_bits]  = (cache[decoded_addr.set_bits].frames[hit_idx].data[decoded_addr.block_bits] & 32'hFFFF0000)|{16'd0,proc_gen_bus_if.wdata[15:0]};
		                4'b1100:    next_cache[decoded_addr.set_bits].frames[hit_idx].data[decoded_addr.block_bits]  = (cache[decoded_addr.set_bits].frames[hit_idx].data[decoded_addr.block_bits] & 32'h0000FFFF)|{proc_gen_bus_if.wdata[31:16],16'd0};
                        default:    next_cache[decoded_addr.set_bits].frames[hit_idx].data[decoded_addr.block_bits]  = proc_gen_bus_if.wdata;
                    endcase														   				   
                    //next_cache[decoded_addr.set_bits].frames[hit_idx].data[decoded_addr.block_bits]  = proc_gen_bus_if.wdata;
		            next_cache[decoded_addr.set_bits].frames[hit_idx].dirty 	= 1'b1;
		            next_MRU[decoded_addr.set_bits] 				        = hit_idx;
                end // if (proc_gen_bus_if.wen && hit)
                else if(pass_through)begin // Passthrough data logic
                    mem_gen_bus_if.wen      = proc_gen_bus_if.wen;
                    mem_gen_bus_if.ren      = proc_gen_bus_if.ren;
                    mem_gen_bus_if.addr     = proc_gen_bus_if.addr;
                    mem_gen_bus_if.byte_en  = proc_gen_bus_if.byte_en;
                    proc_gen_bus_if.busy    = mem_gen_bus_if.busy;
                    proc_gen_bus_if.rdata   = mem_gen_bus_if.rdata;
                    if(proc_gen_bus_if.wen)begin
                        //mem_gen_bus_if.wdata    = proc_gen_bus_if.wdata; //non byte enable
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
		        else if((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && ~cache[decoded_addr.set_bits].frames[ridx].dirty && ~pass_through) begin // FETCH
                    next_decoded_req_addr = decoded_addr;
                	next_read_addr =  {decoded_addr.tag_bits, decoded_addr.set_bits, N_BLOCK_BITS'('0), 2'b00}; ////////////////////// FIX FOR WB to wrong address?

			    end
			    else if((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && cache[decoded_addr.set_bits].frames[ridx].dirty && ~pass_through) begin // WB
                    next_decoded_req_addr = decoded_addr;
			        next_read_addr  =  {cache[decoded_addr.set_bits].frames[ridx].tag, decoded_addr.set_bits, N_BLOCK_BITS'('0), 2'b00};
            	end
            end // case: IDLE
	    
            FETCH: begin
                 if(~abort)begin
                    mem_gen_bus_if.ren   = 1'b1;
                    mem_gen_bus_if.addr  = read_addr;

                    if(finish_word) begin
                        clr_word_ctr 					  = 1'b1;
                        next_cache[decoded_req_addr.set_bits].frames[ridx].valid  = 1'b1;
                        next_cache[decoded_req_addr.set_bits].frames[ridx].tag 	  = decoded_req_addr.tag_bits;
                        mem_gen_bus_if.ren 					  = 1'b0;
                    end
                    else if(~mem_gen_bus_if.busy && ~finish_word) begin
                        en_word_ctr 						   = 1'b1;
                        next_read_addr 						   = read_addr + 4;
                        next_cache[decoded_read_addr.set_bits].frames[ridx].data[word_num]  = mem_gen_bus_if.rdata;
                    end
                end
            end // case: FETCH
	    
            WB: begin
                if(~abort)begin
                    mem_gen_bus_if.wen    = 1'b1;
                    //next_read_address     =  {cache[decoded_addr.set_bits].frames[ridx].tag, decoded_addr.set_bits, 2'b00, 2'b00}; 
                    mem_gen_bus_if.addr   = read_addr; 
                    mem_gen_bus_if.wdata  = cache[decoded_read_addr.set_bits].frames[ridx].data[word_num];
                
    
                    if(finish_word) begin
                        clr_word_ctr 					  = 1'b1;
                        next_read_addr  =  {decoded_req_addr.tag_bits, decoded_req_addr.set_bits, N_BLOCK_BITS'('0), 2'b00}; //TODO: CHECK THIS, ADDED BY VERIFICATION
                        next_cache[decoded_req_addr.set_bits].frames[ridx].dirty  = 1'b0;
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
                if(finish_set) begin
                    clr_set_ctr  = 1'b1;
                    flush_done 	 = 1'b1;
                end
            end
	    
            // FLUSH_SET is not required, because we already know ASSOC is either 1 or 2
            // therefore, just checking ASSOC in FLUSH_FRAME, and deciding whether to go back to
            // FLUSH_CACHE or stay for cleaning of the another frame is sufficient
            FLUSH_SET: begin 
                if(finish_frame) begin
                    clr_frame_ctr  = 1'b1;
                    en_set_ctr 	   = 1'b1;
                end
                if(~cache[set_num].frames[frame_num].valid) begin
                    en_frame_ctr  = 1'b1;
                end
            end // case: FLUSH_SET
	    
            FLUSH_FRAME: begin
	       if (cache[set_num].frames[frame_num].dirty) begin
                mem_gen_bus_if.wen    = 1'b1;
                mem_gen_bus_if.addr   = {cache[set_num].frames[frame_num].tag, set_num[N_SET_BITS - 1:0], word_num[N_BLOCK_BITS - 1:0], 2'b00};
                mem_gen_bus_if.wdata  = cache[set_num].frames[frame_num].data[word_num];
	       end
	       //next_cache[set_num].frames[frame_num].data[word_num] = '0;
	       //next_cache[set_num].frames[frame_num].tag = '0;
	       
	       
                
                if(finish_word) begin
                    clr_word_ctr 				 = 1'b1;
                    en_frame_ctr 				 = 1'b1;
                    mem_gen_bus_if.wen 				 = 1'b0;
                    next_cache[set_num].frames[frame_num].dirty  = 1'b0;
		    next_cache[set_num].frames[frame_num].valid = 1'b0;
		    next_cache[set_num].frames[frame_num].tag = '0;
		   next_cache[set_num].frames[frame_num].data = '0;
		   
		    /*if (finish_frame) begin
		       clr_frame_ctr                             = 1'b1;
		       en_set_ctr                                = 1'b1;
		    end
		    else
		      en_frame_ctr                               = 1'b1;*/
                end		
                if(~mem_gen_bus_if.busy) begin
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
            if((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && cache[decoded_addr.set_bits].frames[ridx].dirty && ~pass_through) begin
                next_state 	= WB;
            end
            else if((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && ~cache[decoded_addr.set_bits].frames[ridx].dirty && ~pass_through) begin
                next_state 	= FETCH;
                end
            else if(flush) begin
                next_state 	= FLUSH_CACHE;
            end
	    end // case: IDLE
	    
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
	        //next_state = FLUSH_FRAME;
   
            if(finish_set) begin
                next_state 	= IDLE;
            end
	    end // case: FLUSH_CACHE
	    
	    FLUSH_SET: begin
            if(finish_frame) begin
                next_state 	= FLUSH_CACHE;
            end
            else if(cache[set_num].frames[frame_num].valid) begin
                next_state = FLUSH_FRAME;
            end
	    end // case: FLUSH_SET
	    
	    FLUSH_FRAME: begin
            if(finish_word) begin
	       /*if(finish_frame)
                next_state 	= FLUSH_CACHE;
	       else
		 next_state = FLUSH_FRAME;
	    end
	    else*/
	      next_state = FLUSH_SET;
	      end
	    end
	endcase // casez (state)
    end // always_comb

endmodule // l1_cache