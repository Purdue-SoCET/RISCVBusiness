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
`include "cpu_tracker_if.vh"
//`include "rv32i_types_pkg.sv"

module l1_cache #(
    parameter CACHE_SIZE          = 1024, // must be power of 2, in bytes, max 4k - 4 * 2^10
    parameter BLOCK_SIZE          = 2, // must be power of 2, max 8
    parameter ASSOC               = 1, // dont set this to 0
    parameter NONCACHE_START_ADDR = 32'hF000_0000, // sh/sb still have issues when uncached; not sure whats up with that still tbh
    parameter NUM_HARTS = 1
)
(
    input logic CLK, nRST,
    input logic clear, flush,
    output logic clear_done, flush_done,
    generic_bus_if.cpu mem_gen_bus_if,
    generic_bus_if.generic_bus proc_gen_bus_if,
    global_events_if.caches global_events_if,
    output integer conflicts, misses
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
       IDLE, HIT, FETCH, WB, UWB, FLUSH_CACHE
    //    , UPDATE
    } cache_fsm_t;            // cache state machine

    typedef enum {
       UIDLE, UPDATE
    } update_fsm_t;           // update state machine
    
    // counter signals
    flush_idx_t flush_idx, next_flush_idx;
    logic   [N_BLOCK_BITS:0] word_num, next_word_num;
    logic   enable_word_count, clear_word_count, 
            clear_flush_count, enable_flush_count, enable_flush_count_nowb;
    logic   word_count_done;
    // States
    cache_fsm_t state, next_state;
    update_fsm_t ustate, next_ustate;
    // lru
    logic [N_FRAME_BITS-1:0] aq_ridx, ridx;
    logic [N_SETS-1:0] last_used;
    logic [N_SETS-1:0] next_last_used;
    // address
    word_t read_addr, next_read_addr;
    decoded_cache_addr_t decoded_req_addr, next_decoded_req_addr;
    decoded_cache_addr_t decoded_addr, aq_decoded;
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
    integer next_conflicts, next_misses;

    // error handling
    assign proc_gen_bus_if.error = mem_gen_bus_if.error;

    // Queue Signals

    // Egress Queue Signals
    // TODO INCLUDE THREAD COUNT PARAMETER
    typedef struct packed {
        logic [31 : 0] addr;
        logic [31 : 0] data;
    } addr_pair_t;
    typedef struct packed {
        addr_pair_t [1 : 0] pair;
        logic wen;
    } item;
    item [NUM_HARTS: 0] egress_queue;

    //logic [ 1 : 0] [ 2  : 0] [WORD_SIZE - 1 : 0] egress_queue;
    // logic [$clog2(BLOCK_SIZE * 2 + 1) - 1 : 0] [WORD_SIZE - 1 : 0]  eq_dataout;
    item eq_datain;
    //queue_t e_qstate, ne_qstate; // egress queue state
    logic [$clog2(NUM_HARTS) : 0] eq_wptr;//, ne_wptr;
    logic [$clog2(NUM_HARTS) : 0] eq_rptr;// ne_rptr;
    // logic [3:0] e_qsize;
    logic enqueue;
    // logic [$clog2(BLOCK_SIZE) - 1:0] [WORD_SIZE - 1 : 0] qdata_addr; // addresses inputted into queue
    // logic e_qwrite; // write enable for item
    // logic [$clog2(BLOCK_SIZE) - 1 : 0] [WORD_SIZE - 1 : 0] qwrite_data; // data to write if writing
    logic eq_empty;
    logic [$clog2(BLOCK_SIZE) : 0] eq_wordcnt, n_eq_wordcnt;
    logic eq_wordcntdone;

    // Ingress queue signals
    logic iq_empty, iq_full;
    typedef struct packed {
        logic [BLOCK_SIZE - 1 : 0] [31 : 0] data;
    } response_t;
    response_t [NUM_HARTS - 1 : 0] ingress_queue;
    logic iq_wen, iq_ren;
    response_t iq_datain, iq_dataout, n_iq_datain;

    // TODO: $clog2(THREAD_CNT) instead of 3
    logic [$clog2(NUM_HARTS) : 0] iq_wptr, iq_rptr;
    //logic [$clog2(3) - 1 : 0] [$clog2(BLOCK_SIZE * 2 + 1) - 1 : 0] [WORD_SIZE - 1 : 0] ingress_queue;

    logic [$clog2(BLOCK_SIZE) : 0] iq_wordcnt,  n_iq_wordcnt;
    logic iq_wordcntdone;

    // Address Queue Signals
    // TODO: replace 3 with address size
    typedef struct packed {
        logic [1:0] [31:0] addr;
    } addr_pairs;
    addr_pairs [1:0] addr_queue;
    // TODO: parameterize
    logic [0 : 0] aq_wptr, aq_rptr;
    addr_pairs aq_dataout, aq_datain;




    // sram instance
    assign sramSEL = (state == FLUSH_CACHE || state == IDLE) ? flush_idx.set_num : ((state == UPDATE) ? aq_decoded.idx_bits : decoded_addr.idx_bits);
    sram #(.SRAM_WR_SIZE(SRAM_W), .SRAM_HEIGHT(N_SETS)) 
        SRAM(CLK, nRST, sramWrite, sramRead, 1'b1, sramWEN, sramSEL, sramMask);

    // flip flops
    always_ff @ (posedge CLK, negedge nRST) begin
        if(~nRST) begin
            state <= IDLE;
            ustate <= UIDLE;
            flush_idx <= 0;
            word_num <= 0;
            last_used <= 0;
            read_addr <= 0;
            decoded_req_addr <= 0;
            flush_req <= 0;
        end
        else begin
            state <= next_state;                        // cache state machine
            ustate <= next_ustate;
            flush_idx <= next_flush_idx;                // index for flushing the cache entries
            word_num <= next_word_num;                  // word counter for fetching/writing back
            last_used <= next_last_used;                // MRU index
            read_addr <= next_read_addr;                // cache address to provide to memory
            decoded_req_addr <= next_decoded_req_addr;  // cache address requested by core
            flush_req <= nflush_req;                    // flush requested by core
        end
    end

    // cache tracker
    always_ff @ (posedge CLK, negedge nRST) begin
        if(~nRST) begin
            conflicts <= 0;
            misses <= 0;
        end
        else begin
            conflicts <= next_conflicts;
            misses <= next_misses;
        end
    end
    
    // counters
    always_comb begin
        //next_word_num = word_num;
        next_flush_idx = flush_idx;
        //word_count_done = ~mem_gen_bus_if.busy && (BLOCK_SIZE - 1) == word_num;
        // word counter logic
        // if (clear_word_count)
        //     next_word_num = 0;
        // else if (enable_word_count)
        //     next_word_num = word_num + 1;

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
    assign decoded_addr = decoded_cache_addr_t'(proc_gen_bus_if.addr);
    assign aq_decoded = decoded_cache_addr_t'(aq_dataout.addr[0]);

    // hit logic with pass through
    always_comb begin
        hit 	        = 0;
        hit_idx         = 0;
        hit_data        = 0;
        pass_through    = proc_gen_bus_if.addr >= NONCACHE_START_ADDR;

        if (!pass_through) begin
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
    genvar gen_word_num;
    generate
    always_comb begin
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
        next_conflicts          = conflicts;
        next_misses             = misses;
        // e_qwrite = '0;
        enqueue = 1'b0;
        eq_datain.wen = '0;
        for (integer i = 0; i < BLOCK_SIZE; i++) begin
            eq_datain.pair[i].data = '0;
            eq_datain.pair[i].addr = '0;

        end

        mem_gen_bus_if.addr = ~eq_empty ? egress_queue[eq_rptr].pair[eq_wordcnt].addr : '0;
        mem_gen_bus_if.wdata = ~eq_empty ? egress_queue[eq_rptr].pair[eq_wordcnt].data : '0;
        mem_gen_bus_if.wen = ~eq_empty ? egress_queue[eq_rptr].wen : 0;
        mem_gen_bus_if.ren = ~eq_empty ? ~egress_queue[eq_rptr].wen : 0;
        
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
                global_events_if.cache_miss = 0;
                next_read_addr = decoded_addr;
                clear_word_count = 1;
                // cache hit on a processor read
                if(proc_gen_bus_if.ren && hit && !flush) begin
                    proc_gen_bus_if.busy = 0; 
                    proc_gen_bus_if.rdata = hit_data[decoded_addr.block_bits];
		            next_last_used[decoded_addr.idx_bits] = hit_idx;
                end
                // cache hit on a processor write
                else if(proc_gen_bus_if.wen && hit && !flush) begin
                    proc_gen_bus_if.busy = 0;
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
                    sramMask.frames[hit_idx].dirty = 0;														   				   
                    sramWrite.frames[hit_idx].data[decoded_addr.block_bits] = proc_gen_bus_if.wdata;
		            sramWrite.frames[hit_idx].dirty = 1;
		            next_last_used[decoded_addr.idx_bits] = hit_idx;
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
                // cache miss on a clean block
		        else if((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && ~sramRead.frames[ridx].dirty && ~pass_through) begin
                    next_decoded_req_addr = decoded_addr;
                	next_read_addr =  {decoded_addr.tag_bits, decoded_addr.idx_bits, N_BLOCK_BITS'('0), 2'b00};
                    if(sramRead.frames[ridx].valid) next_conflicts = conflicts + 1;
                        next_misses = misses + 1;
                    enqueue = 1'b1;
                    for (int queue_word = 0; queue_word < BLOCK_SIZE; queue_word = queue_word + 1) begin
                        // mem_gen_bus_if.ren = 1;
                        //eq_datain[queue_word] = read_addr + queue_word*4;
                        eq_datain.pair[queue_word].addr = next_read_addr + queue_word*4;
                        aq_datain.addr[queue_word] = next_read_addr + queue_word*4;
                    end
                  global_events_if.cache_miss = 1;
			    end
                // cache miss on a dirty block
			    else if((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && sramRead.frames[ridx].dirty && ~pass_through) begin
                    next_decoded_req_addr = decoded_addr;
			        next_read_addr  =  {sramRead.frames[ridx].tag, decoded_addr.idx_bits, N_BLOCK_BITS'('0), 2'b00};
                    next_conflicts = conflicts + 1;
                    next_misses = misses + 1;
                    eq_datain.wen = 1'b1;
                    enqueue = 1'b1;
                    for (integer word_sel = 0; word_sel < BLOCK_SIZE; word_sel = word_sel + 1) begin
                        //qdata_addr[word_sel] = read_addr + word_sel*4;
                        //eq_datain[word_sel] = read_addr + word_sel*4;
                        eq_datain.pair[word_sel].addr = next_read_addr + word_sel*4;
                        eq_datain.pair[word_sel].data = sramRead.frames[ridx].data[word_sel];
                    end
              global_events_if.cache_miss = 1;
            	end
            end 
            FETCH: begin
                // set cache to be invalid before cache completes fetch
                sramMask.frames[ridx].valid = 0;
                sramWrite.frames[ridx].valid = 0;
                //global_events_if.cache_miss = 0;
                // enqueue = 1'b1;
                // for (int queue_word = 0; queue_word < BLOCK_SIZE; queue_word = queue_word + 1) begin
                //     // mem_gen_bus_if.ren = 1;
                //     //eq_datain[queue_word] = read_addr + queue_word*4;
                //     eq_datain.pair[queue_word].addr = read_addr + queue_word*4;
                // end
                proc_gen_bus_if.busy = 0; 
                // fill data
                //if(~mem_gen_bus_if.busy) begin
                    //sramWEN                                = 1'b1;
                    //enable_word_count                      = 1'b1;
                    //next_read_addr 						   = read_addr + 4;
                    // sramWrite.frames[ridx].data[word_num]  = mem_gen_bus_if.rdata;
                    // sramMask.frames[ridx].data[word_num]   = 1'b0;
                //end
                // complete fetch transaction from memory
                // if(word_count_done) begin
                //     sramWEN = 1;
                //     clear_word_count 					    = 1'b1;
                //     sramWrite.frames[ridx].valid            = 1'b1;
                //     sramWrite.frames[ridx].tag 	            = decoded_req_addr.tag_bits;
                //     sramMask.frames[ridx].valid             = 1'b0;
                //     sramMask.frames[ridx].tag               = 1'b0;
                // end
            end
            WB: begin
                // set stim for eviction
                // global_events_if.cache_miss = 0;
                // e_qwrite = 1'b1;
                //eq_datain[BLOCK_SIZE*2] = 1'b1;
                // eq_datain.wen = 1'b1;
                // enqueue = 1'b1;
                // for (integer word_sel = 0; word_sel < BLOCK_SIZE; word_sel = word_sel + 1) begin
                //     //qdata_addr[word_sel] = read_addr + word_sel*4;
                //     //eq_datain[word_sel] = read_addr + word_sel*4;
                //     eq_datain.pair[word_sel].addr = read_addr + word_sel*4;
                //     eq_datain.pair[word_sel].data = sramRead.frames[ridx].data[word_sel];
                // end
                // mem_gen_bus_if.addr = read_addr; 
                // for (integer write_data_sel = BLOCK_SIZE; write_data_sel < BLOCK_SIZE * 2; write_data_sel++) begin
                //     qwrite_data[write_data_sel] = sramRead.frames[ridx].data[write_data_sel - BLOCK_SIZE];
                //     // eq_datain[write_data_sel] = sramRead.frames[ridx].data[write_data_sel - BLOCK_SIZE];
                // end
                //mem_gen_bus_if.wdata = sramRead.frames[ridx].data[word_num];
                // increment eviction word counter
                //if(~mem_gen_bus_if.busy) begin
                    //enable_word_count = 1;
                    // next_read_addr    = read_addr + 4;
                //end
                // invalidate when eviction is complete
                //if(word_count_done) begin
                    sramWEN = 1;
                    //clear_word_count = 1;
                    sramWrite.frames[ridx].dirty = 0;
                    sramMask.frames[ridx].dirty = 0;
                    sramWrite.frames[ridx].valid = 0;
                    sramMask.frames[ridx].valid = 0;
                    next_read_addr = {decoded_addr.tag_bits, decoded_addr.idx_bits, N_BLOCK_BITS'('0), 2'b00};

                    if (!(mem_gen_bus_if.error || decoded_addr != decoded_req_addr || !(proc_gen_bus_if.ren || proc_gen_bus_if.wen))) begin
                        enqueue = 1'b1;
                        for (int queue_word = 0; queue_word < BLOCK_SIZE; queue_word = queue_word + 1) begin
                            // mem_gen_bus_if.ren = 1;
                            //eq_datain[queue_word] = read_addr + queue_word*4;
                            eq_datain.pair[queue_word].addr = next_read_addr + queue_word*4;
                            aq_datain.addr[queue_word] = next_read_addr + queue_word*4;
                        end 
                    end
                    // next_read_addr = {decoded_addr.tag_bits, decoded_addr.idx_bits, N_BLOCK_BITS'('0), 2'b00};
                //end
            end
            UWB: begin
                // e_qwrite = 1'b1;
                //eq_datain[BLOCK_SIZE*2] = 1'b1;
                eq_datain.wen = 1'b1;
                enqueue = 1'b1;
                for (integer word_sel = 0; word_sel < BLOCK_SIZE; word_sel = word_sel + 1) begin
                    // qdata_addr[word_sel] = {sramRead.frames[ridx].tag, ridx, word_sel, 2'b00};//read_addr + word_sel*4;
                    //eq_datain[word_sel] = read_addr + word_sel*4; //{sramRead.frames[ridx].tag, ridx, word_sel, 2'b00};
                    eq_datain.pair[word_sel].addr = {sramRead.frames[ridx].tag, ridx, word_sel, 2'b00}; //read_addr + word_sel*4; 
                    eq_datain.pair[word_sel].data = sramRead.frames[ridx].data[word_sel];
                end
                // mem_gen_bus_if.addr = read_addr; 
                // for (integer write_data_sel = BLOCK_SIZE; write_data_sel < BLOCK_SIZE * 2; write_data_sel++) begin
                //     qwrite_data[write_data_sel] = sramRead.frames[ridx].data[write_data_sel - BLOCK_SIZE];
                //     // eq_datain[write_data_sel] = sramRead.frames[ridx].data[write_data_sel - BLOCK_SIZE];
                // end
                //mem_gen_bus_if.wdata = sramRead.frames[ridx].data[word_num];
                // increment eviction word counter
                //if(~mem_gen_bus_if.busy) begin
                    //enable_word_count = 1;
                    // next_read_addr    = read_addr + 4;
                //end
                // invalidate when eviction is complete
                //if(word_count_done) begin
                    sramWEN = 1;
                    //clear_word_count = 1;
                    sramWrite.frames[ridx].dirty = 0;
                    sramMask.frames[ridx].dirty = 0;
                    sramWrite.frames[ridx].valid = 0;
                    sramMask.frames[ridx].valid = 0;
                    next_read_addr = {decoded_addr.tag_bits, decoded_addr.idx_bits, N_BLOCK_BITS'('0), 2'b00};
            end
            FLUSH_CACHE: begin
                // flush to memory if valid & dirty
                if (sramRead.frames[flush_idx.frame_num].valid && sramRead.frames[flush_idx.frame_num].dirty) begin
                    mem_gen_bus_if.wen    = 1'b1;
                    mem_gen_bus_if.addr   = {sramRead.frames[flush_idx.frame_num].tag, flush_idx.set_num, flush_idx.word_num, 2'b00};
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
            // UPDATE: begin
            //         sramWEN = 1;
            //         //clear_word_count 					    = 1'b1;
            //         sramWrite.frames[ridx].valid            = 1'b1;
            //         //sramWrite.frames[ridx].tag 	            = QUEUE ADDR GOES HERE;
            //         sramWrite.frames[ridx].tag = aq_decoded.tag_bits;
            //         // read next data from queue
            //         iq_ren =  1'b1;
            //         sramMask.frames[ridx].valid             = 1'b0;
            //         sramMask.frames[ridx].tag               = 1'b0;
            //         //sramWrite.frames[ridx].data[word_num]  = mem_gen_bus_if.rdata;
            //         sramMask.frames[ridx].data[word_num]   = 1'b0;
            //         for (integer update_write_data_sel = BLOCK_SIZE; update_write_data_sel < BLOCK_SIZE * 2; update_write_data_sel = update_write_data_sel + 1) begin
            //             sramWrite.frames[ridx].data[update_write_data_sel - BLOCK_SIZE] = iq_dataout[update_write_data_sel];
            //         end
            // end
        endcase
        
        next_ustate = ustate;
        iq_ren = 1'b0;
        casez(ustate)
            UIDLE: begin
                iq_ren = 1'b0;
                if (!iq_empty && !((state == HIT) && (proc_gen_bus_if.wen && hit && !flush))) begin
                    next_ustate = UPDATE;
                    iq_ren = 1'b1;
                end
            end
            UPDATE: begin
                next_ustate = UIDLE;
            end
        endcase

        casez(ustate)
            UIDLE: begin
                aq_ridx = '0;
                global_events_if.cache_updated = 1'b0;
            end
            UPDATE: begin
                global_events_if.cache_updated = 1'b1;
                aq_ridx = last_used[aq_decoded.idx_bits] + 1;
                sramWEN = 1;
                //clear_word_count 					    = 1'b1;
                sramWrite.frames[aq_ridx].valid            = 1'b1;
                //sramWrite.frames[ridx].tag 	            = QUEUE ADDR GOES HERE;
                sramWrite.frames[aq_ridx].tag = aq_decoded.tag_bits;
                // read next data from queue
                iq_ren =  1'b0;
                sramMask.frames[aq_ridx].valid             = 1'b0;
                sramMask.frames[aq_ridx].tag               = 1'b0;
                //sramWrite.frames[ridx].data[word_num]  = mem_gen_bus_if.rdata;
                sramMask.frames[aq_ridx].data[word_num]   = 1'b0;
                for (integer update_write_data_sel = 0; update_write_data_sel < BLOCK_SIZE; update_write_data_sel = update_write_data_sel + 1) begin
                    sramWrite.frames[aq_ridx].data[update_write_data_sel] = iq_dataout.data[update_write_data_sel];
                    sramMask.frames[aq_ridx].data[update_write_data_sel]   = 1'b0;
                end
            end
        endcase
    end
    endgenerate

    // next state logic
    always_comb begin
	    next_state = state;
	    casez(state)
            IDLE: begin        
                if (idle_done)
                    next_state = HIT;
	        end
	        HIT: begin
                // if (!iq_empty)
                //     next_state = UPDATE;                    
                // else 
                if ((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && sramRead.frames[ridx].dirty && ~pass_through)
                    next_state = WB;
                else if (!iq_empty && (ridx == aq_decoded.idx_bits) && sramRead.frames[aq_decoded.idx_bits].dirty)
                    next_state = UWB;
                else if ((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && ~sramRead.frames[ridx].dirty && ~pass_through)
                    next_state = FETCH;
                if (flush || flush_req)  
                    next_state = FLUSH_CACHE;
	        end
	        FETCH: begin
                if (mem_gen_bus_if.error || decoded_addr != decoded_req_addr || !(proc_gen_bus_if.ren || proc_gen_bus_if.wen))
                    next_state = HIT; 
                else
                    next_state = HIT;
	        end
	        WB: begin
                if (mem_gen_bus_if.error || decoded_addr != decoded_req_addr || !(proc_gen_bus_if.ren || proc_gen_bus_if.wen))
                    next_state = HIT; 
                else
                    next_state = FETCH;
	        end
            UWB: begin
                next_state = HIT;
            end
	        FLUSH_CACHE: begin        
                if (flush_done)
                    next_state = HIT;
	        end
            // UPDATE: begin
            //     next_state = HIT;
            // end
	    endcase
    end

    //next update logic
    always_comb begin

    end

    // flush saver
    always_comb begin
        nflush_req = flush_req;
        if (flush)
            nflush_req = 1;
        if (state == FLUSH_CACHE)
            nflush_req = 0;
    end


    // Queue design
    // queue has these dimensions:
    // #thread items, each entry having block size words of 32 bits
    // TODO: parametrize queue instantiation

    // egress queue

    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) begin
            eq_wordcnt <= '0;
        end
        else begin
            eq_wordcnt <= n_eq_wordcnt;
        end
    end

    always_comb begin
        n_eq_wordcnt = eq_wordcnt;
        eq_wordcntdone = eq_wordcnt == BLOCK_SIZE - 1 && ~mem_gen_bus_if.busy;
        if (eq_wordcntdone) begin
            n_eq_wordcnt = 0;
        end
        else if (~mem_gen_bus_if.busy) begin
            n_eq_wordcnt = eq_wordcnt + 1;
        end
    end

    assign eq_empty = eq_wptr == eq_rptr;
    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) begin
            egress_queue <= '0;
            eq_wptr <= '0;
            eq_rptr <= '0;
            // eq_dataout <= '0;
        end
        else begin
            if (enqueue) begin
                egress_queue[eq_wptr] <= eq_datain;
                //eq_wptr <= eq_wptr + 1;
                if (eq_wptr == NUM_HARTS) begin
                    eq_wptr <= 0;
                end
                else begin
                    eq_wptr <= eq_wptr + 1;
                end
            end
            if (~eq_empty) begin
                if (eq_wordcntdone) begin
                    if ((eq_rptr) == NUM_HARTS) begin
                        eq_rptr <= '0;
                    end
                    else begin
                        eq_rptr <= eq_rptr + 1;
                    end
                end
            end
        end
    end



    // ingress queue

    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) begin
            iq_wordcnt <= '0;
            iq_datain <= '0;
        end
        else begin
            iq_wordcnt <= n_iq_wordcnt;
            iq_datain <= n_iq_datain;
        end
    end

    always_comb begin
        n_iq_wordcnt = iq_wordcnt;
        n_iq_datain = iq_datain;
        iq_wordcntdone = /*~mem_gen_bus_if.busy &&*/ (BLOCK_SIZE) == iq_wordcnt;
        if (iq_wordcntdone) begin
            n_iq_wordcnt = '0;
            //n_iq_datain[iq_wordcnt] = '0; // TODO: Get addresses into queue
            //n_iq_datain[iq_wordcnt] = mem_gen_bus_if.rdata;
        end
        else if (~mem_gen_bus_if.busy && mem_gen_bus_if.ren) begin
            n_iq_wordcnt = iq_wordcnt + 1;
            //n_iq_datain[iq_wordcnt] = '0;
            n_iq_datain.data[iq_wordcnt] = mem_gen_bus_if.rdata;
        end
    end

    assign iq_wen = iq_wordcntdone; // TODO: Possibly enqueues data too early?

    always_ff @(posedge CLK, negedge nRST) begin
        if (!nRST) begin
            iq_wptr <= '0;
            iq_rptr <= '0;
            ingress_queue <= '0;
            iq_dataout <= '0;
        end
        else begin
            if (iq_wen) begin
                // TODO: THREAD_CNT instead of 3
                ingress_queue[iq_wptr] <= iq_datain;
                if (iq_wordcntdone) begin
                    iq_wptr <= iq_wptr + 1;
                end
            end
            if (iq_ren) begin
                // TODO: THREAD_CNT instead of 3
                iq_dataout <= ingress_queue[iq_rptr];
                iq_rptr <= iq_rptr + 1;
            end
        end
    end

    assign iq_empty = iq_wptr == iq_rptr;
    // TODO: possible full condition?

    // BIG TODO: implement an address queue so that the same addresses can come back


    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) begin
            addr_queue <= '0;
            aq_dataout <= '0;
            aq_wptr <= '0;
            aq_rptr <= '0;
        end
        else begin
            if (enqueue && ~eq_datain.wen) begin
                addr_queue[aq_wptr] <= aq_datain;
                aq_wptr <= aq_wptr + 1;
            end
            if (iq_ren) begin
                aq_dataout <= addr_queue[aq_rptr];
                aq_rptr <= aq_rptr + 1;
            end
        end
    end

endmodule
