/*
*   Copyright 2016 Purdue University
*
*   Licensed under the Apache License, Version 2.0 (the "License");
*   you may not use this file except in compliance with the License.
*   You may obtain a copy of the License at
*
*       http://www.apache.org/licenses/LICENSE-2.0
*
*   Unless `quired by applicable law or agreed to in writing, software
*   distributed under the License is distributed on an "AS IS" BASIS,
*   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*   See the License for the specific language governing permissions and
*   limitations under the License.
*
*
*   Filename:     l2_cache.sv
*
*   Created by:   Aedan Frazier, Dhruv Gupta, Rufat Imanov
*   Email:        frazie35@purdue.edu, gupta479@purdue.edu
*   Date Created: 02/28/2022
*   Description:  L2 Cache. The following are configurable:
*                   - Cache Size
*                   - Non-Cacheable start address
*                   - Block Size | max 4
*	                - ASSOC | either 2 or 4
*/

`include "generic_bus_if.vh"

module l2_cache #(
    parameter CACHE_SIZE          = 4096, // in bits
    parameter BLOCK_SIZE          = 4, // in words (must be power of 2)
    parameter ASSOC               = 4, // 2 or 4 so far
    parameter NONCACHE_START_ADDR = 32'h8000_0000
)
(
    input logic CLK, nRST,
    input logic clear, flush,
    output logic clear_done, flush_done,
    generic_bus_if.cpu mem_gen_bus_if,
    generic_bus_if.generic_bus proc_gen_bus_if

);
    import rv32i_types_pkg::*;

    // local parameters
    localparam N_TOTAL_FRAMES     = CACHE_SIZE / (BLOCK_SIZE * WORD_SIZE / 8); // Default 32
    localparam N_SETS             = N_TOTAL_FRAMES / ASSOC; //Default 8
    localparam N_FRAME_BITS       = $clog2(ASSOC); 
    localparam N_SET_BITS         = $clog2(N_SETS);
    localparam N_BLOCK_BITS       = $clog2(BLOCK_SIZE);
    localparam N_TAG_BITS         = WORD_SIZE - N_SET_BITS - N_BLOCK_BITS - 2;
    localparam FRAME_SIZE         = WORD_SIZE * BLOCK_SIZE + N_TAG_BITS + 2; // in bits
    localparam L1_BLOCK_SIZE      = 2;


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
       IDLE, FETCH, WB, FLUSH_CACHE, FLUSH_SET, FLUSH_FRAME, /*for debugging*/ERROR, SEND                     //NEED TO UPDATE
    } fsm_t;
    
    // Cache address decode type
    typedef struct packed {
        logic [N_TAG_BITS - 1:0] tag_bits;
        logic [N_SET_BITS - 1:0] set_bits;
        logic [N_BLOCK_BITS - 1:0] block_bits;
        logic [1:0] byte_bits;
    } decoded_addr_t;

    typedef struct packed {
        logic [1:0] v;
        logic [1:0] nv;
        logic [1:0] [1:0] o;
    } victim_t;

    //Declarations
    

    // Set Counter
    logic [12:0] set_num, next_set_num;
    logic en_set_ctr, clr_set_ctr;

    // Frame(way) Counter - either 2 or 4 frames in a set 
    logic [2:0] frame_num, next_frame_num;
    logic en_frame_ctr, clr_frame_ctr;

    // Word Counter
    logic [3:0] word_num, next_word_num;
    logic en_word_ctr, clr_word_ctr;

    // Counter Finish flags
    logic finish_word, finish_frame, finish_set;

    //State Machines
    fsm_t state, next_state;

    // cache blocks, indexing cache chooses a set
    cache_sets cache [N_SETS - 1:0];
    cache_sets next_cache [N_SETS - 1:0];

    //Decode incoming addr
    decoded_addr_t decoded_addr;
    assign decoded_addr = proc_gen_bus_if.addr;

    // Cache Hit signals
    logic hit, pass_through;
    word_t hit_data;
    logic [(ASSOC/2)-1:0] hit_idx;


    //Replacement Signals // I think victim/nextvictim (pseudo LRU) policy is best
    victim_t lru [N_SETS-1:0];
    victim_t nextlru [N_SETS-1:0];
    logic [1:0] ridx;


    // Read Address
    word_t read_addr, next_read_addr; // remember read addr. at IDLE to increment by 4 later when fetching

    //LOGIC


    ///////////////////////////////////////////////////////////////////////////////
    //READ ADDRESS LOGIC
    ///////////////////////////////////////////////////////////////////////////////
    always_ff @ (posedge CLK, negedge nRST) begin
        if(~nRST) begin
            read_addr <= '0;
        end
        else begin
            read_addr <= next_read_addr;
        end
    end // always_ff @
    ///////////////////////////////////////////////////////////////////////////////


    ///////////////////////////////////////////////////////////////////////////////
    // Hit and Passthrough Logic
    ///////////////////////////////////////////////////////////////////////////////
    always_comb begin : Hit_Pass_comb
        hit 	      = 1'b0;
        pass_through  = 1'b0;
        hit_data  = {32'h00badbad};
        if(proc_gen_bus_if.addr >= NONCACHE_START_ADDR) begin
            pass_through = 1'b1;
        end
        else begin
            for(int i = 0; i < ASSOC; i++) begin
                if(cache[decoded_addr.set_bits].frames[i].tag == decoded_addr.tag_bits && cache[decoded_addr.set_bits].frames[i].valid) begin
                    hit       = 1'b1;
                    hit_data  = cache[decoded_addr.set_bits].frames[i].data[decoded_addr.block_bits];
                    hit_idx   = i;
                end
            end
        end // else: !if(proc_gen_bus_if.addr >= NONCACHE_START_ADDR)
    end // always_comb
    ///////////////////////////////////////////////////////////////////////////////

    ///////////////////////////////////////////////////////////////////////////////
    // Counter Logic
    ///////////////////////////////////////////////////////////////////////////////
    always_ff @ (posedge CLK, negedge nRST) begin : Counter_ff
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
    end //  counter always_ff 

    always_comb begin : Counter_comb
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
    ///////////////////////////////////////////////////////////////////////////////

    ///////////////////////////////////////////////////////////////////////////////
    // LRU Logic
    ///////////////////////////////////////////////////////////////////////////////
    always_ff @(posedge CLK, negedge nRST ) begin :  LRU_FF
        if(~nRST)begin
            for(int i = 0; i < N_SETS; i ++)begin
                    lru[i].v <= 2'b00; // Victim init
                    lru[i].nv <= 2'b01; // Next Victim init
                    lru[i].o[0] <= 2'b10; // Ordinary init [0]
                    lru[i].o[1] <= 2'b11; // Ordinary init [1]
            end
        end
        else begin
            for(int i = 0; i < N_SETS; i ++)begin
                    lru[i].v <= nextlru[i].v; // Victim 
                    lru[i].nv <= nextlru[i].nv; // Next Victim
                    lru[i].o[0] <= nextlru[i].o[0]; // Ordinary [0]
                    lru[i].o[1] <= nextlru[i].o[1]; // Ordinary [1]
            end
        end
    end

    generate //GENERATE BLOCKS BASED ON PARAMETERS
        if(ASSOC == 2)begin
            always_comb begin // output always_comb
                nextlru = lru;
                if(!(proc_gen_bus_if.addr >= NONCACHE_START_ADDR)) begin : two_way_replacement
                    if((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && hit && state == IDLE)begin //hit
                        if(hit_idx == lru[decoded_addr.set_bits].v) begin // hit set was in v
                                nextlru[decoded_addr.set_bits].v    = lru[decoded_addr.set_bits].nv;
                                nextlru[decoded_addr.set_bits].nv   = lru[decoded_addr.set_bits].v;
                        end
                        else if(hit_idx == lru[decoded_addr.set_bits].nv) begin // hit set was in nv
                                nextlru[decoded_addr.set_bits].v    = lru[decoded_addr.set_bits].v;
                                nextlru[decoded_addr.set_bits].nv   = lru[decoded_addr.set_bits].nv;
                        end
                    end // end hit
                    else if(proc_gen_bus_if.ren || proc_gen_bus_if.wen && state == IDLE)begin // if miss 
                        nextlru[decoded_addr.set_bits].v    = lru[decoded_addr.set_bits].nv; // set new victim
                        nextlru[decoded_addr.set_bits].nv   = lru[decoded_addr.set_bits].v; // set new nextvictim
                    end // end miss
                    else begin
                        nextlru[decoded_addr.set_bits].v    = lru[decoded_addr.set_bits].v; // set new victim
                        nextlru[decoded_addr.set_bits].nv   = lru[decoded_addr.set_bits].nv; // set new nextvictim
                    end
                end // end not cache start addr
            end // output always_comb end
        end // end if (ASSOC == 2)
        else if(ASSOC == 4)begin
            always_comb begin // output always_comb
                nextlru = lru;
                if(!(proc_gen_bus_if.addr >= NONCACHE_START_ADDR))  begin : four_way_replacement
                    if((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && hit && (state == IDLE))begin //hit
                        if(hit_idx == lru[decoded_addr.set_bits].v)begin // hit set was in v
                                nextlru[decoded_addr.set_bits].v    = lru[decoded_addr.set_bits].nv;
                                nextlru[decoded_addr.set_bits].nv   = lru[decoded_addr.set_bits].o[0];
                                nextlru[decoded_addr.set_bits].o[0] = lru[decoded_addr.set_bits].o[1];
                                nextlru[decoded_addr.set_bits].o[1] = lru[decoded_addr.set_bits].v;
                        end
                        else if(hit_idx == lru[decoded_addr.set_bits].nv)begin // hit set was in nv
                                nextlru[decoded_addr.set_bits].v    = lru[decoded_addr.set_bits].v;
                                nextlru[decoded_addr.set_bits].nv   = lru[decoded_addr.set_bits].o[0];
                                nextlru[decoded_addr.set_bits].o[0] = lru[decoded_addr.set_bits].o[1];
                                nextlru[decoded_addr.set_bits].o[1] = lru[decoded_addr.set_bits].nv;
                        end
                        else if(hit_idx == lru[decoded_addr.set_bits].o[0])begin //hit set was in o[0]
                                nextlru[decoded_addr.set_bits].v    = lru[decoded_addr.set_bits].v;
                                nextlru[decoded_addr.set_bits].nv   = lru[decoded_addr.set_bits].nv;
                                nextlru[decoded_addr.set_bits].o[0] = lru[decoded_addr.set_bits].o[1];
                                nextlru[decoded_addr.set_bits].o[1] = lru[decoded_addr.set_bits].o[0];
                        end
                        else if(hit_idx == lru[decoded_addr.set_bits].o[1])begin //hit set was in o[1]
                                nextlru[decoded_addr.set_bits].v    = lru[decoded_addr.set_bits].v;
                                nextlru[decoded_addr.set_bits].nv   = lru[decoded_addr.set_bits].nv;
                                nextlru[decoded_addr.set_bits].o[0] = lru[decoded_addr.set_bits].o[0];
                                nextlru[decoded_addr.set_bits].o[1] = lru[decoded_addr.set_bits].o[1];
                        end
                    end
                    else if ((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && (state == IDLE))begin // if miss 
                        nextlru[decoded_addr.set_bits].v    = lru[decoded_addr.set_bits].nv; 
                        nextlru[decoded_addr.set_bits].nv   = lru[decoded_addr.set_bits].o[0];
                        nextlru[decoded_addr.set_bits].o[0] = lru[decoded_addr.set_bits].o[1];
                        nextlru[decoded_addr.set_bits].o[1] = lru[decoded_addr.set_bits].v;
                    end
                    else begin
                        nextlru[decoded_addr.set_bits].v    = lru[decoded_addr.set_bits].v; 
                        nextlru[decoded_addr.set_bits].nv   = lru[decoded_addr.set_bits].nv;
                        nextlru[decoded_addr.set_bits].o[0] = lru[decoded_addr.set_bits].o[0];
                        nextlru[decoded_addr.set_bits].o[1] = lru[decoded_addr.set_bits].o[1];
                    end
                end
            end // output always_comb end
        end
    endgenerate // hit logic and replacement policy logic for different associativities.
    ///////////////////////////////////////////////////////////////////////////////
   

    ///////////////////////////////////////////////////////////////////////////////
    // State Machine Logic
    ///////////////////////////////////////////////////////////////////////////////
    always_ff @(posedge CLK, negedge nRST)begin : State_Logic_FF
        if(~nRST)begin
            state <= IDLE; //Cache state machine reset state
        end
        else begin
            state <= next_state; //update FSM
        end
    end// State_Logic_FF

    always_comb begin // state machine comb
        next_state = state;
        casez(state)
            IDLE: begin
                ridx = lru[decoded_addr.set_bits].v; // set replacement index
                if((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && cache[decoded_addr.set_bits].frames[ridx].dirty && ~pass_through) begin
                    next_state 	= WB;
                end
                else if((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && ~cache[decoded_addr.set_bits].frames[ridx].dirty && ~pass_through) begin
                    next_state 	= FETCH;
                end
                else if(flush) begin
                    next_state 	= FLUSH_CACHE;
                end
		        else if((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && hit && ~pass_through) begin
                    next_state 	= IDLE;
                end
            end 
            FETCH: begin
                if(finish_word) begin
                    next_state 	= IDLE;
                end
            end
            WB: begin
                if(finish_word) begin
                    next_state 	= FETCH;
                end
            end
            SEND: begin
                next_state = IDLE;
            end
            ERROR: begin
                next_state = ERROR;
            end
            default: begin
                next_state = ERROR;
            end
            
		       
        endcase //casez (state) 
    end // end state machine always_comb
    ///////////////////////////////////////////////////////////////////////////////

    ///////////////////////////////////////////////////////////////////////////////
    // Cache Update Logic
    ///////////////////////////////////////////////////////////////////////////////
    always_ff @ (posedge CLK, negedge nRST) begin : Next_Cache_FF
        if(~nRST)begin
            for(int i = 0; i < N_SETS; i++) begin
                for(int j = 0; j < ASSOC; j++) begin
                    cache[i].frames[j].data  <= '0;
                    cache[i].frames[j].tag   <= '0;
                    cache[i].frames[j].valid <= 1'b0;
                    cache[i].frames[j].dirty <= 1'b0;
                end
            end
        end
        else begin
            for(int i = 0; i < N_SETS; i++) begin
                for(int j = 0; j < ASSOC; j++) begin
                    cache[i].frames[j].data  <= next_cache[i].frames[j].data;
                    cache[i].frames[j].tag   <= next_cache[i].frames[j].tag;
                    cache[i].frames[j].valid <= next_cache[i].frames[j].valid;
                    cache[i].frames[j].dirty <= next_cache[i].frames[j].dirty;
                end
            end
            cache <= next_cache; // update cache frames
        end
    end // end next cache always_ff


    always_comb begin : output_comb
        proc_gen_bus_if.busy    = 1'b1;
        mem_gen_bus_if.ren      = 1'b0;
        mem_gen_bus_if.wen      = 1'b0;
        en_set_ctr 	            = 1'b0;
        en_word_ctr 	        = 1'b0;
        en_frame_ctr 	        = 1'b0;
        clr_set_ctr 	        = 1'b0;
        clr_word_ctr 	        = 1'b0;
        clr_frame_ctr 	        = 1'b0;
        flush_done 	            = 1'b0;
        next_cache              = cache;
        next_read_addr          = read_addr;   

        casez(state)
            IDLE: begin
	            next_read_addr = decoded_addr;       
                if(proc_gen_bus_if.ren && hit) begin // if read enable and hit
                    proc_gen_bus_if.busy 		   = 1'b0; // Set bus to not busy
                    proc_gen_bus_if.rdata 		   = hit_data[decoded_addr.block_bits - 1]; //
                end
                else if(proc_gen_bus_if.wen && hit) begin // if write enable and hit
                    proc_gen_bus_if.busy                                    = 1'b0;
		            proc_gen_bus_if.rdata = hit_data[decoded_addr.block_bits - 1];
                end // if (proc_gen_bus_if.wen && hit
		        else if(pass_through)begin // Passthrough data logic
                    if(proc_gen_bus_if.ren)begin
                        mem_gen_bus_if.ren      = 1'b1;
                        mem_gen_bus_if.addr     = proc_gen_bus_if.addr;
                        proc_gen_bus_if.busy    = mem_gen_bus_if.busy; //TODO: CHECK, ADDED BY VERIFICATION
                        proc_gen_bus_if.rdata   = mem_gen_bus_if.rdata;
                    end
                    else if(proc_gen_bus_if.wen)begin
                        //mem_gen_bus_if.wdata    = proc_gen_bus_if.wdata; //non byte enable
                        mem_gen_bus_if.wen      = 1'b1;
                        mem_gen_bus_if.addr     = proc_gen_bus_if.addr;
                        proc_gen_bus_if.busy    = mem_gen_bus_if.busy; //TODO: CHECK, ADDED BY VERIFICATION
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
                else if ((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && ~cache[decoded_addr.set_bits].frames[ridx].dirty && ~pass_through) begin // FETCH
                    next_read_addr = {decoded_addr.tag_bits, decoded_addr.set_bits, N_BLOCK_BITS'('0), 2'b00};
                end 
                else if ((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && cache[decoded_addr.set_bits].frames[ridx].dirty && ~pass_through) begin // WB
                    next_read_addr = {cache[decoded_addr.set_bits].frames[ridx].tag, decoded_addr.set_bits, N_BLOCK_BITS'('0), 2'b00};
                end		       
            end
            FETCH: begin
                mem_gen_bus_if.ren   = 1'b1;
                mem_gen_bus_if.addr  = read_addr;
                
                if(finish_word) begin
                    clr_word_ctr 					  = 1'b1;
                    next_cache[decoded_addr.set_bits].frames[ridx].valid  = 1'b1;
                    next_cache[decoded_addr.set_bits].frames[ridx].tag 	  = decoded_addr.tag_bits;
                    mem_gen_bus_if.ren 					  = 1'b0;
                end
                else if(~mem_gen_bus_if.busy && ~finish_word) begin
                    en_word_ctr 						   = 1'b1;
                    next_read_addr 						   = read_addr + 4;
                    next_cache[decoded_addr.set_bits].frames[ridx].data[word_num]  = mem_gen_bus_if.rdata;
                end 
            end// end FETCH
            WB: begin
                mem_gen_bus_if.wen    = 1'b1;
		        //next_read_addr     =  {cache[decoded_addr.set_bits].frames[ridx].tag, decoded_addr.set_bits, 2'b00, 2'b00}; 
                mem_gen_bus_if.addr   = read_addr; 
                mem_gen_bus_if.wdata  = cache[decoded_addr.set_bits].frames[ridx].data[word_num];
               
 
                if(finish_word) begin
                    clr_word_ctr 					  = 1'b1;
                    next_read_addr 					  = {decoded_addr.tag_bits, decoded_addr.set_bits, N_BLOCK_BITS'('0), 2'b00}; //TODO: CHECK THIS, ADDED BY VERIFICATION
                    next_cache[decoded_addr.set_bits].frames[ridx].dirty  = 1'b0;
                    mem_gen_bus_if.wen 					  = 1'b0;
                end
                else if(~mem_gen_bus_if.busy && ~finish_word) begin
                    en_word_ctr     = 1'b1;
                    next_read_addr  = read_addr + 4;
                end
		    end // case: WB
            SEND: begin
                    proc_gen_bus_if.busy 		   = 1'b0; // Set bus to not busy
                    proc_gen_bus_if.rdata 		   = hit_data[decoded_addr.block_bits]; //
            end // SEND       
        endcase

    end // end output combinational logic
    ///////////////////////////////////////////////////////////////////////////////

endmodule // l2_cache

