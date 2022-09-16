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
*   Filename:     direct_mapped_tpf_cache.sv
*
*   Created by:   John Skubic
*   Email:        jjs.skubic@gmail.com
*   Date Created: 05/28/2017
*   Description:  Direct Mapped Cache with tagged prefetch.  The following are configurable:
*                   - Cache Size
*                   - Non-Cacheable start address
*                   - Block Size
*                     - Prefetch Length
*/

`include "generic_bus_if.vh"

module direct_mapped_tpf_cache (
    input logic CLK,
    nRST,
    input logic clear,
    flush,
    output logic clear_done,
    flush_done,
    generic_bus_if.cpu mem_gen_bus_if,
    generic_bus_if.generic_bus proc_gen_bus_if
);

    import rv32i_types_pkg::*;

    /* --- Parameters --- */

    // configurable parameters
    parameter CACHE_SIZE = 1024;  // In bytes, must be power of 2
    parameter BLOCK_SIZE = 2;  // must be power of 2
    parameter PREFETCH_LENGTH = 1;  // must be power of 2
    parameter NONCACHE_START_ADDR = 32'h8000_0000;

    // local parameters
    localparam N_INDICES = CACHE_SIZE / (BLOCK_SIZE * WORD_SIZE / 8);
    localparam BLK_OFF_BITS = $clog2(BLOCK_SIZE);
    localparam IDX_BITS = $clog2(N_INDICES);
    localparam TAG_BITS = RAM_ADDR_SIZE - 2 - BLK_OFF_BITS - IDX_BITS;
    localparam N_BITS_IN_FRAME = (BLOCK_SIZE * WORD_SIZE) + TAG_BITS + 3;
    localparam N_BYTES_IN_FRAME = N_BITS_IN_FRAME%8 ? N_BITS_IN_FRAME/8 + 1 : N_BITS_IN_FRAME/8;
    localparam META_BYTE_L = (BLOCK_SIZE * WORD_SIZE) / 8;
    localparam META_BYTE_H = N_BYTES_IN_FRAME - 1;
    localparam PFETCH_CNT_BITS = $clog2(PREFETCH_LENGTH);

    /* --- Custom Data Types --- */

    typedef struct packed {
        logic [TAG_BITS-1:0] tag;
        logic [IDX_BITS-1:0] idx;
        logic [BLK_OFF_BITS-1:0] blk_off;
        logic [1:0] byte_off;
    } cache_addr_t;

    typedef struct packed {
        logic d;
        logic v;
        logic p;
        logic [TAG_BITS-1:0] tag;
        word_t [BLOCK_SIZE-1:0] data;
    } cache_frame_t;

    typedef enum logic [3:0] {
        IDLE,
        // flush and clear handling
        CLEAR_PREP,
        CLEAR_WB,
        CLEAR_UPDATE,
        // normal operation
        EVAL,
        FETCH,
        PREFETCH,
        PREFETCH_PREP,
        PREFETCH_WB,
        WB
    } sm_t;

    /* --- Signal Instantiations --- */

    cache_frame_t frame_buffer, frame_buffer_next;
    cache_addr_t req_addr;

    logic init_flag;
    logic init_complete;
    logic flush_flag;
    logic flush_reg;
    logic flush_clear;
    logic clear_flag, clear_clear, clear_reg;
    logic request;
    logic direct_mem_req;
    logic hit, tag_match;

    logic [ 3:0] req_byte_en;
    logic [31:0] req_byte_en_expand;

    cache_addr_t curr_addr, curr_addr_next;

    // signals for accessing the sram of cache
    cache_frame_t cache_wdata;
    logic [RAM_ADDR_SIZE-1:0] cache_addr;
    logic [N_BYTES_IN_FRAME-1:0] cache_byte_en;
    logic cache_wen, cache_ren;
    logic [N_BITS_IN_FRAME-1:0] cache_rdata;
    logic cache_busy, cache_busy_raw;

    // state machine
    sm_t curr_state, next_state;
    cache_addr_t sm_addr;
    generic_bus_if sm_bus_if ();

    logic [IDX_BITS:0] flush_cnt, flush_cnt_next;
    logic [BLK_OFF_BITS:0] access_cnt, access_cnt_next;
    logic [PFETCH_CNT_BITS:0] prefetch_cnt, prefetch_cnt_next;

    /* --- Module Instantiations --- */

    // sram for cache
    config_ram_wrapper #(
        .N_BYTES(N_BYTES_IN_FRAME),
        .DEPTH  (N_INDICES)
    ) cache_mem (
        .CLK(CLK),
        .nRST(nRST),
        .wdata(cache_wdata),
        .addr(cache_addr),
        .byte_en(cache_byte_en),
        .wen(cache_wen),
        .ren(cache_ren),
        .rdata(cache_rdata),
        .busy(cache_busy_raw)
    );

    assign cache_busy = cache_busy_raw | ~(cache_wen | cache_ren);

    /* --- Glue Logic and Output Logic --- */

    assign req_addr = proc_gen_bus_if.addr;
    assign req_byte_en = proc_gen_bus_if.byte_en;
    assign req_byte_en_expand = {
        {8{req_byte_en[3]}}, {8{req_byte_en[2]}}, {8{req_byte_en[1]}}, {8{req_byte_en[0]}}
    };
    assign direct_mem_req = (proc_gen_bus_if.addr >= NONCACHE_START_ADDR);
    assign flush_flag = flush | init_flag | flush_reg;
    assign clear_flag = clear | clear_reg;
    assign request = (proc_gen_bus_if.wen | proc_gen_bus_if.ren) && ~direct_mem_req;

    // clear and flush response
    assign clear_done = clear_clear;
    assign flush_done = flush_clear;

    //hits given out in EVAL and FETCH
    assign tag_match = (req_addr.tag == frame_buffer.tag) && frame_buffer.v;
    always_comb begin
        hit = 1'b0;
        if (curr_state == EVAL) begin
            if (tag_match && (~proc_gen_bus_if.wen || ~cache_busy)) hit = 1'b1;
        end else if ((curr_state == FETCH) && (access_cnt == BLOCK_SIZE) && ~cache_busy) begin
            hit = 1'b1;
        end
    end

    // Memory Arbitration between state machine and direct memory access
    assign mem_gen_bus_if.addr = direct_mem_req ? proc_gen_bus_if.addr : sm_bus_if.addr;
    assign mem_gen_bus_if.wdata = direct_mem_req ? proc_gen_bus_if.wdata : sm_bus_if.wdata;
    assign mem_gen_bus_if.ren = direct_mem_req ? proc_gen_bus_if.ren : sm_bus_if.ren;
    assign mem_gen_bus_if.wen = direct_mem_req ? proc_gen_bus_if.wen : sm_bus_if.wen;
    assign mem_gen_bus_if.byte_en = direct_mem_req ? proc_gen_bus_if.byte_en : sm_bus_if.byte_en;
    assign proc_gen_bus_if.rdata = direct_mem_req ? mem_gen_bus_if.rdata :frame_buffer.data[req_addr.blk_off] ;
    assign sm_bus_if.rdata = mem_gen_bus_if.rdata;
    assign proc_gen_bus_if.busy = direct_mem_req ? mem_gen_bus_if.busy : ~hit;
    assign sm_bus_if.busy = direct_mem_req ? 1'b1 : mem_gen_bus_if.busy;

    assign sm_bus_if.addr = sm_addr;


    // Flip-Flops with no reset
    always_ff @(posedge CLK) begin
        frame_buffer <= frame_buffer_next;
        curr_addr <= curr_addr_next;
    end

    // Flip-Flops with reset
    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) begin
            flush_cnt <= '0;
            access_cnt <= '0;
            prefetch_cnt <= '0;
        end else begin
            flush_cnt <= flush_cnt_next;
            access_cnt <= access_cnt_next;
            prefetch_cnt <= prefetch_cnt_next;
        end
    end

    // Init on reset
    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) init_flag <= 1'b1;
        else if (init_complete) init_flag <= 1'b0;
    end

    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) flush_reg <= 1'b0;
        else if (flush_clear) flush_reg <= 1'b0;
        else if (flush) flush_reg <= 1'b1;
    end

    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) clear_reg <= 1'b0;
        else if (clear_clear) clear_reg <= 1'b0;
        else if (clear) clear_reg <= 1'b1;
    end

    // SM ouptut Logic

    always_comb begin
        flush_cnt_next = flush_cnt;
        cache_addr = '0;
        cache_ren = 0;
        cache_wen = 0;
        cache_byte_en = '1;
        cache_wdata = '0;
        curr_addr_next = curr_addr;
        frame_buffer_next = frame_buffer;
        access_cnt_next = access_cnt;
        prefetch_cnt_next = prefetch_cnt;
        sm_addr = '0;
        sm_bus_if.wen = 0;
        sm_bus_if.ren = 0;
        sm_bus_if.wdata = '0;
        sm_bus_if.byte_en = '1;
        init_complete = 1'b0;
        flush_clear = 1'b0;
        clear_clear = 1'b0;

        casez (curr_state)
            IDLE: begin
                if (clear_flag) begin
                    curr_addr_next = req_addr;
                    flush_cnt_next = N_INDICES - 1;
                end else if (flush_flag) begin
                    curr_addr_next = 0;
                    flush_cnt_next = 0;
                end else if (request) begin
                    cache_addr = req_addr.idx;
                    cache_ren  = 1'b1;
                    if (~cache_busy) begin
                        curr_addr_next = req_addr;
                        frame_buffer_next = cache_rdata;
                    end
                end
            end
            // Normal Operation
            EVAL: begin
                if (~tag_match) access_cnt_next = 0;
                else begin  // hit
                    if (hit && frame_buffer.p) begin
                        {curr_addr_next.tag, curr_addr_next.idx} =
                {curr_addr.tag, curr_addr.idx} + 1;
                        prefetch_cnt_next = 0;
                    end
                    if (proc_gen_bus_if.wen) begin  // cache write hit
                        cache_addr = req_addr.idx;
                        frame_buffer_next.data[req_addr.blk_off] =
              (frame_buffer.data[req_addr.blk_off] & ~req_byte_en_expand) |
              (req_byte_en_expand & proc_gen_bus_if.wdata);
                        frame_buffer_next.d = 1'b1;
                        cache_wdata = frame_buffer_next;
                        cache_wdata.p = 1'b0;
                        cache_wen = 1'b1;
                    end
                end
            end
            FETCH: begin
                sm_addr = curr_addr;
                sm_addr.byte_off = 2'b0;
                sm_addr.blk_off = access_cnt[BLK_OFF_BITS-1:0];

                cache_wdata = frame_buffer;
                cache_addr = curr_addr.idx;
                if (access_cnt == BLOCK_SIZE) begin
                    sm_bus_if.ren = 1'b0;
                    cache_wen = 1'b1;
                    if (~cache_busy) begin
                        {curr_addr_next.tag, curr_addr_next.idx}
              = {curr_addr.tag, curr_addr.idx} + 1;
                        prefetch_cnt_next = 0;
                    end
                end else begin
                    sm_bus_if.ren = 1'b1;
                    cache_wen = 1'b0;
                end

                frame_buffer_next.tag = req_addr.tag;
                frame_buffer_next.p   = 0;
                frame_buffer_next.v   = 1;
                frame_buffer_next.d   = proc_gen_bus_if.wen;

                if (~sm_bus_if.busy) begin
                    if (proc_gen_bus_if.wen && (sm_addr.blk_off == req_addr.blk_off)) begin
                        frame_buffer_next.data[sm_addr.blk_off] =
              (sm_bus_if.rdata & ~req_byte_en_expand) |
              (req_byte_en_expand & proc_gen_bus_if.wdata);
                    end else begin
                        frame_buffer_next.data[sm_addr.blk_off] = sm_bus_if.rdata;
                    end
                    access_cnt_next = access_cnt + 1;
                end
            end
            WB: begin
                sm_addr.idx = curr_addr.idx;
                sm_addr.byte_off = 2'b0;
                sm_addr.blk_off = access_cnt[BLK_OFF_BITS-1:0];
                sm_addr.tag = frame_buffer.tag;
                sm_bus_if.wdata = frame_buffer.data[access_cnt];
                sm_bus_if.wen = 1'b1;
                if (~sm_bus_if.busy) access_cnt_next = access_cnt + 1;

                if (~sm_bus_if.busy && (access_cnt == BLOCK_SIZE - 1)) access_cnt_next = '0;
            end
            PREFETCH_PREP: begin
                cache_addr = curr_addr.idx;
                cache_ren  = 1'b1;
                if (~cache_busy) begin
                    access_cnt_next   = 0;
                    frame_buffer_next = cache_rdata;
                end
            end
            PREFETCH_WB: begin
                sm_addr.idx = curr_addr.idx;
                sm_addr.tag = frame_buffer.tag;
                sm_addr.byte_off = 2'b0;
                sm_addr.blk_off = access_cnt[BLK_OFF_BITS-1:0];
                sm_bus_if.wdata = frame_buffer.data[access_cnt];
                sm_bus_if.wen = 1'b1;
                sm_bus_if.byte_en = 4'hf;
                if (~sm_bus_if.busy) begin
                    if (access_cnt == BLOCK_SIZE - 1) access_cnt_next = 0;
                    else access_cnt_next = access_cnt + 1;
                end
            end
            PREFETCH: begin
                sm_addr = curr_addr;
                sm_addr.byte_off = 2'b0;
                sm_addr.blk_off = access_cnt[BLK_OFF_BITS-1:0];
                cache_addr = curr_addr.idx;
                cache_wdata = frame_buffer;

                if (access_cnt == BLOCK_SIZE) begin
                    sm_bus_if.ren = 1'b0;
                    cache_wen = 1'b1;
                end else begin
                    sm_bus_if.ren = 1'b1;
                    cache_wen = 1'b0;
                end

                if (~sm_bus_if.busy) begin
                    access_cnt_next = access_cnt + 1;
                    frame_buffer_next.data[access_cnt] = sm_bus_if.rdata;
                    frame_buffer_next.p = 1'b1;
                    frame_buffer_next.v = 1'b1;
                    frame_buffer_next.d = 1'b0;
                    frame_buffer_next.tag = curr_addr.tag;
                end

                if (~cache_busy) begin
                    prefetch_cnt_next = prefetch_cnt + 1;
                    {curr_addr_next.tag, curr_addr_next.idx} = {curr_addr.tag, curr_addr.idx} + 1;
                end
            end
            // Flush and Clear
            CLEAR_PREP: begin
                cache_addr = curr_addr.idx;
                cache_ren  = 1'b1;
                if (~cache_busy) begin
                    frame_buffer_next = cache_rdata;
                    if (frame_buffer_next.d && frame_buffer_next.v) access_cnt_next = 0;
                end
            end
            CLEAR_WB: begin  //writeback all words in the current frame
                sm_addr.idx = curr_addr.idx;
                sm_addr.byte_off = 2'b0;
                sm_addr.blk_off = access_cnt[BLK_OFF_BITS-1:0];
                sm_addr.tag = frame_buffer.tag;
                sm_bus_if.wdata = frame_buffer.data[access_cnt];
                sm_bus_if.wen = 1'b1;
                if (~sm_bus_if.busy) access_cnt_next = access_cnt + 1;
            end
            CLEAR_UPDATE: begin  // clear out the cache memory, increment flush count
                cache_addr = curr_addr.idx;
                cache_wen = 1'b1;
                cache_wdata = '0;
                cache_byte_en = '1;
                if (~cache_busy) begin
                    flush_cnt_next = flush_cnt + 1;
                    curr_addr_next.idx = curr_addr.idx + 1;
                    if (flush_cnt == N_INDICES - 1) begin
                        init_complete = 1'b1;
                        if (flush_reg) flush_clear = 1'b1;
                        else if (clear_reg) clear_clear = 1'b1;
                    end
                end
            end
        endcase
    end

    /* --- State Machine Logic --- */

    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) curr_state <= IDLE;
        else curr_state <= next_state;
    end

    // Next State Logic

    always_comb begin
        next_state = curr_state;
        casez (curr_state)
            IDLE: begin
                if (clear_flag || flush_flag) next_state = CLEAR_PREP;
                else if (~cache_busy && request) begin
                    next_state = EVAL;
                end
            end
            // Normal Operation
            EVAL: begin
                if (proc_gen_bus_if.ren && tag_match) begin
                    if (frame_buffer.p) next_state = PREFETCH_PREP;
                    else next_state = IDLE;
                end else if (proc_gen_bus_if.wen && tag_match) begin
                    if (~cache_busy) begin
                        if (frame_buffer.p) next_state = PREFETCH_PREP;
                        else next_state = IDLE;
                    end
                end else if (frame_buffer.v && frame_buffer.d) next_state = WB;
                else next_state = FETCH;
            end
            FETCH: begin
                if ((access_cnt == BLOCK_SIZE) && ~cache_busy) next_state = PREFETCH_PREP;
            end
            PREFETCH_PREP: begin
                if (~cache_busy) begin
                    if (frame_buffer_next.d && frame_buffer_next.v) next_state = PREFETCH_WB;
                    else next_state = PREFETCH;
                end
            end
            PREFETCH_WB: begin
                if (~sm_bus_if.busy && (access_cnt == BLOCK_SIZE - 1)) next_state = PREFETCH;
            end
            PREFETCH: begin
                if ((access_cnt == BLOCK_SIZE) && ~cache_busy) begin
                    if (prefetch_cnt == PREFETCH_LENGTH - 1) next_state = IDLE;
                    else next_state = PREFETCH_PREP;
                end
            end
            WB: begin
                if (~sm_bus_if.busy && (access_cnt == BLOCK_SIZE - 1)) next_state = FETCH;
            end
            // Flush and Clear
            CLEAR_PREP: begin
                if (~cache_busy) begin
                    if (~init_flag && frame_buffer_next.d && frame_buffer_next.v)
                        next_state = CLEAR_WB;
                    else next_state = CLEAR_UPDATE;
                end
            end
            CLEAR_WB: begin
                if (~sm_bus_if.busy && (access_cnt == (BLOCK_SIZE - 1))) next_state = CLEAR_UPDATE;
            end
            CLEAR_UPDATE: begin
                if (~cache_busy) begin
                    if (flush_cnt != N_INDICES - 1) next_state = CLEAR_PREP;
                    else next_state = IDLE;
                end
            end

            default: next_state = curr_state;
        endcase
    end
endmodule
