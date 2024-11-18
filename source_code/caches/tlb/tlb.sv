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
*   Filename:    tlb.sv
*
*   Created by:   William Milne
*   Email:        milnew@purdue.edu
*   Date Created: 10/13/2024
*   Description: Translation Lookaside Buffer (TLB)
*/

`include "generic_bus_if.vh"
`include "prv_pipeline_if.vh"

`ifdef XCELIUM
`timescale 1ns/100ps
`endif

module tlb #(
    parameter VIRTUAL_ADDR_WIDTH  = 32, // equal to SXLEN
    parameter PHYSICAL_ADDR_WIDTH = 34, // equal to MXLEN
    parameter PAGE_OFFSET_BITS    = 12, // For 4KB pages
    parameter TLB_SIZE            = 64,  // Number of entries in the TLB
    parameter ASSOC               = 1  // dont set this to 0, TLB_SIZE / ASSOC must be power of 2
)
(
    input logic CLK, nRST,
    input logic clear, flush,
    output logic clear_done, flush_done,
    generic_bus_if.cpu mem_gen_bus_if,          // to page walker
    generic_bus_if.generic_bus proc_gen_bus_if, // from pipeline
    prv_pipe_if.caches prv_pipe_if
);

    import rv32i_types_pkg::*;
    import machine_mode_types_1_13_pkg::*;

    // VA (32) = N_TAG_BITS(14) + N_SET_BITS (6) + PAGE_OFFSET_BITS (12)

    // VA -> [VPN (20)][OFFSET (12)]

    // local parameters
    localparam BLOCK_SIZE         = 1;
    localparam ASID_LENGTH        = 9; // num bits for ASID
    localparam VPN_LENGTH         = VIRTUAL_ADDR_WIDTH - PAGE_OFFSET_BITS;
    localparam PPN_LENGTH         = PHYSICAL_ADDR_WIDTH - PAGE_OFFSET_BITS;
    localparam N_SETS             = TLB_SIZE / ASSOC;
    localparam N_FRAME_BITS       = $clog2(ASSOC) + (ASSOC == 1);
    localparam N_SET_BITS         = $clog2(N_SETS) + (N_SETS == 1);
    localparam N_BLOCK_BITS       = $clog2(BLOCK_SIZE) + (BLOCK_SIZE == 1);
    localparam N_TAG_BITS         = VPN_LENGTH - N_SET_BITS;
    localparam TOTAL_TAG_SIZE     = (N_TAG_BITS + ASID_LENGTH + 1); // +1 for valid
    localparam FRAME_SIZE         = WORD_SIZE + TOTAL_TAG_SIZE; // in bits
    localparam SRAM_W             = FRAME_SIZE * ASSOC;                      // sram parameters

    // coherence params, not sure if needed
    localparam SRAM_TAG_W         = TOTAL_TAG_SIZE * ASSOC; // +1 for valid
    localparam CLEAR_LENGTH       = $clog2(BLOCK_SIZE) + 2;

    // Define the TLB entry structure
    typedef struct packed {
        logic valid;
        logic [ASID_LENGTH-1:0] asid; // Address Space Identifier
        logic [N_TAG_BITS-1:0]  vpn_tag;  // Tagged virtual Page Number
    } tlb_tag_t;

    typedef struct packed {
        logic [1:0] reserved_0;
        logic       dirty;
        logic       accessed;
        logic       global;
        logic       user;
        logic       executable;
        logic       writable;
        logic       readable;
        logic       valid;
    } tlb_perms_t;

    typedef struct packed {
        logic [PPN_LENGTH-1:0] ppn;   // Physical Page Number
        tlb_perms_t            perms; // Page permissions
    } tlb_pte_t;

    typedef struct packed {
        tlb_tag_t tag; // Valid + ASID + VPN
        tlb_pte_t pte; // Page Table Entry
    } tlb_frame_t;

    typedef struct packed {
        tlb_frame_t [ASSOC - 1:0] frames;
    } tlb_set_t;

    typedef struct packed {
        logic [N_TAG_BITS-1:0] tag_bits;
        logic [N_SET_BITS-1:0] idx_bits;
    } vpn_t;

    typedef struct packed {
        vpn_t                        vpn;
        logic [PAGE_OFFSET_BITS-1:0] page_offset_bits; // not used in addressing TLB
    } decoded_tlb_addr_t;

    typedef struct packed {
        logic                    finish;
        logic [N_SET_BITS-1:0]   set_num;
        logic [N_FRAME_BITS-1:0] frame_num; // assoc
    } flush_idx_t;             // flush counter type

    typedef enum {
       IDLE, HIT, FETCH, WB, FLUSH_TLB, SNOOP, CANCEL_REQ
    } tlb_fsm_t;            // tlb state machine

    // Signals Declarations
    // counter signals
    flush_idx_t flush_idx, next_flush_idx;
    logic clear_flush_count, enable_flush_count, enable_flush_count_nowb;

    // states
    cache_fsm_t state, next_state;

    // page translation enabled
    logic sv32;

    // lru
    logic [N_FRAME_BITS-1:0] ridx;
    logic [N_SETS-1:0] last_used;
    logic [N_SETS-1:0] next_last_used;

    // address
    word_t read_addr, next_read_addr;
    decoded_tlb_addr_t decoded_req_addr, next_decoded_req_addr;
    decoded_tlb_addr_t decoded_addr;

    // Cache Hit
    logic hit, pass_through;
    word_t [BLOCK_SIZE-1:0] hit_data;
    logic [N_FRAME_BITS-1:0] hit_idx;

    // sram signals
    tlb_set_t sramWrite, sramRead, sramMask;
    logic sramWEN; // no need for REN
    logic [N_SET_BITS-1:0] sramSEL;

    // flush reg
    logic flush_req, nflush_req;
    logic idle_done;

    // RTL
    // decoded address conversion
    assign decoded_addr = decoded_tlb_addr_t'(proc_gen_bus_if.addr);

    // sram instance
    assign sramSEL = (state == FLUSH_CACHE || state == IDLE) ? flush_idx.set_num
                   : decoded_addr.vpn.idx_bits;
    sram #(.SRAM_WR_SIZE(SRAM_W), .SRAM_HEIGHT(N_SETS)) 
        CPU_SRAM(.CLK(CLK), .nRST(nRST), .wVal(sramWrite), .rVal(sramRead), .REN(1'b1), .WEN(sramWEN), .SEL(sramSEL), .wMask(sramMask));
    
    // enable page translation
    assign sv32 = prv_pipe_if.satp.mode;

    // flip flops
    always_ff @ (posedge CLK, negedge nRST) begin
        if(~nRST) begin
            state <= IDLE;
            flush_idx <= 0;
            last_used <= 0;
            read_addr <= 0;
            decoded_req_addr <= 0;
            flush_req <= 0;
        end
        else begin
            state <= next_state;                        // cache state machine
            flush_idx <= next_flush_idx;                // index for flushing the cache entries
            last_used <= next_last_used;                // MRU index
            read_addr <= next_read_addr;                // cache address to provide to memory
            decoded_req_addr <= next_decoded_req_addr;  // cache address requested by core
            flush_req <= nflush_req;                    // flush requested by core
        end
    end

    // counters
    always_comb begin
        next_flush_idx = flush_idx;

        // flush counter logic
        if (clear_flush_count)
            next_flush_idx = 0;
        else if (enable_flush_count_nowb && BLOCK_SIZE != 1)
            next_flush_idx = flush_idx + 1;
        else if (enable_flush_count || enable_flush_count_nowb)
            next_flush_idx = flush_idx + 1;

        // correction for non-powers of 2
        if (next_flush_idx.set_num == N_SETS) begin
            next_flush_idx.finish = 1;
            next_flush_idx.set_num = 0;
            next_flush_idx.frame_num = 0;
        end
        else if (next_flush_idx.frame_num == ASSOC) begin
            next_flush_idx.set_num = flush_idx.set_num + 1;
            next_flush_idx.frame_num = 0;
        end

        // FOR ASSOC == 1 FINISH FLAG
        if (next_flush_idx.set_num == 0 && flush_idx.set_num == N_SETS - 1) begin
            next_flush_idx.finish = 1;
            next_flush_idx.set_num = 0;
            next_flush_idx.frame_num = 0;
        end
    end

    // Hit logic with pass through
    // CPU and bus sram have different always_comb blocks to prevent false
    // circular logic
    always_comb begin
        hit 	        = 0;
        hit_idx         = 0;
        hit_data        = 0;
        // pass_through    = proc_gen_bus_if.addr >= NONCACHE_START_ADDR;
        pass_through    = 0;

        if (!pass_through) begin
            for(int i = 0; i < ASSOC; i++) begin
                if(sramRead.frames[i].tag.vpn_tag == decoded_addr.vpn.tag_bits &&
                   sramRead.frames[i].tag.asid    == prv_pipe_if.satp.asid     &&
                   sramRead.frames[i].tag.valid) begin
                    //Read or write hit
                    if((state == HIT && (proc_gen_bus_if.ren || proc_gen_bus_if.wen))) begin
	                    hit       = 1'b1;
        	            hit_data  = sramRead.frames[i].data;
                	    hit_idx   = i;

                        // Add permissions checking here
                    end
                end
            end
        end
    end

    // TLB output logic
    // Outputs: counter control signals, cache, signals to page walker, signals to processor
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
        enable_flush_count_nowb = 0;
        clear_flush_count       = 0;
        flush_done 	            = 0;
        idle_done               = 0;
        clear_done 	            = 0;
        next_read_addr          = proc_gen_bus_if.addr;
        next_decoded_req_addr   = decoded_req_addr;
        next_last_used          = last_used;

        // associativity, using NRU
        if (ASSOC == 1 || (last_used[decoded_addr.vpn.idx_bits] == (ASSOC - 1)))
            ridx = 0;
        else
            ridx = last_used[decoded_addr.vpn.idx_bits] + 1;

        casez(state)
            IDLE: begin
                // clear out tlbs with flush
                sramWEN = 1;
    	        sramWrite.frames[flush_idx.frame_num] = '0;
                sramMask.frames[flush_idx.frame_num] = '0;
                enable_flush_count_nowb = 1;
                // flag the completion of flush
                if (flush_idx.finish) begin
                    clear_flush_count  = 1;
                    idle_done 	       = 1;
                    flush_done = 1; //HACK: Remove if this causes bugs, used for testbench
                end
            end
            HIT: begin
                // tlb hit on a processor read/write
                if ((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && hit && !flush) begin
                    proc_gen_bus_if.busy = 0;
                    proc_gen_bus_if.rdata = hit_data[decoded_addr.idx.block_bits];
                    next_last_used[decoded_addr.idx.idx_bits] = hit_idx;
                end
                // tlb miss on a clean block
		        else if((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && ~sramRead.frames[ridx].tag.dirty && ~pass_through) begin
                    next_decoded_req_addr = decoded_addr;
			    end
                // cache miss on a dirty block
			    else if((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && sramRead.frames[ridx].tag.dirty && ~pass_through) begin
                    next_decoded_req_addr = decoded_addr;
                    next_read_addr        =  {sramRead.frames[ridx].tag, decoded_addr.idx.idx_bits, N_BLOCK_BITS'('0), 2'b00};
                end
            end
            FETCH: begin
                // set tlb to be invalid before cache completes fetch
                mem_gen_bus_if.wen = proc_gen_bus_if.wen;
                mem_gen_bus_if.ren = proc_gen_bus_if.ren || !ccif.abort_bus;
                mem_gen_bus_if.addr = read_addr;
                sramWrite.frames[ridx].tag.valid = 0;
                sramMask.frames[ridx].tag.valid = 0;
                // fill data
                if(~mem_gen_bus_if.busy) begin
                    sramWEN                            = 1'b1;
                    sramWrite.frames[ridx].data        = mem_gen_bus_if.rdata;
                    sramWrite.frames[ridx].tag.valid   = 1'b1;
                    sramWrite.frames[ridx].tag.asid    = prv_pipe_if.satp.asid;
                    sramWrite.frames[ridx].tag.vpn_tag = decoded_req_addr.vpn.tag_bits;
                    sramMask.frames[ridx].data         = 1'b0;
                    sramMask.frames[ridx].tag.valid    = 1'b0;
                    sramMask.frames[ridx].tag.asid     = '0;
                    sramMask.frames[ridx].tag.vpn_tag  = '0;
                end
            end
            FLUSH_TLB: begin
                // flush to memory if valid & dirty
                if (sramRead.frames[flush_idx.frame_num].tag.valid && sramRead.frames[flush_idx.frame_num].pte.perms.dirty) begin
                    mem_gen_bus_if.wen    = 1'b1;
                    mem_gen_bus_if.addr   = {sramRead.frames[flush_idx.frame_num].vpn.tag_bits, flush_idx.set_num, {N_BLOCK_BITS{1'b0}}, 2'b00};
                    mem_gen_bus_if.wdata  = sramRead.frames[flush_idx.frame_num].pte;
                    // increment to next word when flush of word is done
                    if (~mem_gen_bus_if.busy) begin
                        enable_flush_count = 1;
                        // clears entry when flushed
                        sramWEN = 1;
                        sramWrite.frames[flush_idx.frame_num] = 0;
                        sramMask.frames[flush_idx.frame_num] = 0;
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
    end

    // Next State Logic
    always_comb begin
        next_state = state;
        casez(state)
            IDLE: begin
                if (idle_done) // Used for flushing cache
                    next_state = HIT;
            end
            HIT: begin
                if ((proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && ~pass_through) // not sure what to do with pass through yet.
                    next_state = FETCH;
                if (flush)
                    next_state = FLUSH_TLB;
            end
            FETCH: begin
                if (!pw_gen_bus_if.busy || pw_gen_bus_if.error)
                    next_state = HIT;
            end
            FLUSH_TLB: begin
                if (flush_done)
                    next_state = HIT;
            end
        endcase

        // do nothing if not in sv32
        if (~sv32)
            next_state = IDLE;
    end

    // flush saver
    always_comb begin
        nflush_req = flush_req;
        if (flush)
            nflush_req = 1;
        if (flush_done)
            nflush_req = 0;
    end

endmodule