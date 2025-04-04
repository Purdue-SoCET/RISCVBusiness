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
*   Created by:   William Cunningham
*   Email:        wrcunnin@purdue.edu
*   Date Created: 10/13/2024
*   Description: Translation Lookaside Buffer (TLB)
*/

`include "generic_bus_if.vh"
`include "prv_pipeline_if.vh"
`include "address_translation_if.vh"

`ifdef XCELIUM
`timescale 1ns/10ps
`endif

import rv32i_types_pkg::*;
import machine_mode_types_1_13_pkg::*;

module tlb #(
    parameter PAGE_OFFSET_BITS    = 12, // For 4KB pages
    parameter TLB_SIZE            = TLB_ENTRIES, // Number of entries in the TLB
    parameter TLB_ASSOC           = 1,  // dont set this to 0, TLB_SIZE / TLB_ASSOC must be power of 2
    parameter IS_ITLB             = 1,   // denotes special behavior for permission checking
    parameter BLOCK_SIZE          = 1
)
(
    input logic CLK, nRST,
    input logic clear, fence, page_fault,
    output logic clear_done, fence_done, tlb_miss,
    output logic fault_load_page, fault_store_page, fault_insn_page,
    output word_t tlb_hit_data,
    generic_bus_if.cpu mem_gen_bus_if,          // to page walker
    generic_bus_if.generic_bus proc_gen_bus_if, // from pipeline
    prv_pipeline_if.cache prv_pipe_if,
    address_translation_if.cache at_if
);
    // VA (32) = N_TAG_BITS(14) + N_SET_BITS (6) + PAGE_OFFSET_BITS (12)

    // VA -> [VPN (20)][OFFSET (12)]

    // local parameters
    localparam ASID_LENGTH        = 9; // num bits for ASID
    localparam VPN_LENGTH         = SXLEN - PAGE_OFFSET_BITS;
    localparam PPN_LENGTH         = PPNLEN;
    localparam N_SETS             = TLB_SIZE / TLB_ASSOC;
    localparam N_FRAME_BITS       = $clog2(TLB_ASSOC) + (TLB_ASSOC == 1);
    localparam N_SET_BITS         = $clog2(N_SETS) + (N_SETS == 1);
    localparam N_BLOCK_BITS       = $clog2(BLOCK_SIZE) + (BLOCK_SIZE == 1);
    localparam N_TAG_BITS         = VPN_LENGTH - N_SET_BITS;
    localparam TOTAL_TAG_SIZE     = (N_TAG_BITS + ASID_LENGTH + 1); // +1 for valid
    localparam FRAME_SIZE         = WORD_SIZE + TOTAL_TAG_SIZE; // in bits
    localparam SRAM_W             = FRAME_SIZE * TLB_ASSOC;                      // sram parameters

    // coherence params, not sure if needed
    localparam SRAM_TAG_W         = TOTAL_TAG_SIZE * TLB_ASSOC; // +1 for valid
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
        logic       global_page;
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
        tlb_frame_t [TLB_ASSOC - 1:0] frames;
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
        logic [N_FRAME_BITS-1:0] frame_num; // TLB_ASSOC
    } fence_idx_t;             // fence counter type

    typedef enum {
       IDLE, HIT, FETCH, FENCE_TLB
    } tlb_fsm_t;            // tlb state machine

    // Signals Declarations
    // counter signals
    fence_idx_t fence_idx, next_fence_idx;
    logic clear_fence_count, enable_fence_count, enable_fence_count_nowb;

    // states
    tlb_fsm_t state, next_state;

    // lru
    logic [N_FRAME_BITS-1:0] ridx;
    logic [N_SETS-1:0] last_used;
    logic [N_SETS-1:0] next_last_used;

    // address
    word_t read_addr, next_read_addr;
    decoded_tlb_addr_t decoded_req_addr, next_decoded_req_addr;
    decoded_tlb_addr_t decoded_addr;

    // Cache Hit
    logic hit, pass_through, activate_hit;
    word_t [BLOCK_SIZE-1:0] hit_data;
    logic [N_FRAME_BITS-1:0] hit_idx;

    // sram signals
    tlb_set_t sramWrite, sramRead, sramMask;
    logic sramWEN; // no need for REN
    logic [N_SET_BITS-1:0] sramSEL;

    // fence reg
    logic fence_req, nfence_req;
    logic idle_done;

    // fence va and asid
    decoded_tlb_addr_t decoded_fence_va;
    logic [ASID_LENGTH-1:0] fence_asid;

    // permissions
    access_t access;
    pte_sv32_t pte_sv32;

    // RTL
    // decoded address conversion
    assign decoded_addr = decoded_tlb_addr_t'(proc_gen_bus_if.addr);

    // fence assigns
    assign decoded_fence_va = decoded_tlb_addr_t'(prv_pipe_if.fence_va);
    assign fence_asid = prv_pipe_if.fence_asid;

    // turning on or off hit logic
    assign activate_hit = ~pass_through && at_if.addr_trans_on;

    // sram instance
    assign sramSEL = (state == FENCE_TLB || state == IDLE) ? fence_idx.set_num : decoded_addr.vpn.idx_bits;
    sram #(.SRAM_WR_SIZE(SRAM_W), .SRAM_HEIGHT(N_SETS)) 
        CPU_SRAM(.CLK(CLK), .nRST(nRST), .wVal(sramWrite), .rVal(sramRead), .REN(1'b1), .WEN(sramWEN), .SEL(sramSEL), .wMask(sramMask));

    // setting permissions signals
    assign pte_sv32 = pte_sv32_t'(hit_data);
    
    generate
        if (IS_ITLB) begin
            assign access = ACCESS_INSN;
        end else begin
            assign access = prv_pipe_if.ex_mem_wen ? ACCESS_STORE : prv_pipe_if.ex_mem_ren ? ACCESS_LOAD : ACCESS_NONE;
        end
    endgenerate

    // permission checking for TLB accesses
    page_perm_check TLB_PERM_CHECK (
        .check(hit),
        .level(0),
        .access(access),
        .pte_sv32(pte_sv32),
        .fault_load_page(fault_load_page),
        .fault_store_page(fault_store_page),
        .fault_insn_page(fault_insn_page),
        .prv_pipe_if(prv_pipe_if),
        .at_if(at_if)
    );

    // flip flops
    always_ff @ (posedge CLK, negedge nRST) begin
        if(~nRST) begin
            state <= IDLE;
            fence_idx <= 0;
            last_used <= 0;
            read_addr <= 0;
            decoded_req_addr <= 0;
            fence_req <= 0;
        end
        else begin
            state <= next_state;                        // cache state machine
            fence_idx <= next_fence_idx;                // index for fenceing the cache entries
            last_used <= next_last_used;                // MRU index
            read_addr <= next_read_addr;                // cache address to provide to memory
            decoded_req_addr <= next_decoded_req_addr;  // cache address requested by core
            fence_req <= nfence_req;                    // fence requested by core
        end
    end

    // counters
    always_comb begin
        next_fence_idx = fence_idx;

        // fence counter logic
        if (clear_fence_count)
            next_fence_idx = 0;
        else if (enable_fence_count_nowb && BLOCK_SIZE != 1)
            next_fence_idx = fence_idx + 1;
        else if (enable_fence_count || enable_fence_count_nowb)
            next_fence_idx = fence_idx + 1;

        // correction for non-powers of 2
        if (next_fence_idx.set_num == N_SETS) begin
            next_fence_idx.finish = 1;
            next_fence_idx.set_num = 0;
            next_fence_idx.frame_num = 0;
        end
        else if (next_fence_idx.frame_num == TLB_ASSOC) begin
            next_fence_idx.set_num = fence_idx.set_num + 1;
            next_fence_idx.frame_num = 0;
        end

        // FOR TLB_ASSOC == 1 FINISH FLAG
        if (next_fence_idx.set_num == 0 && fence_idx.set_num == N_SETS - 1) begin
            next_fence_idx.finish = 1;
            next_fence_idx.set_num = 0;
            next_fence_idx.frame_num = 0;
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

        if (activate_hit) begin
            for(int i = 0; i < TLB_ASSOC; i++) begin
                if(sramRead.frames[i].tag.vpn_tag == decoded_addr.vpn.tag_bits &&
                   sramRead.frames[i].tag.asid    == prv_pipe_if.satp.asid     &&
                   sramRead.frames[i].tag.valid) begin
                    //Read or write hit
                    // if((state == HIT && (proc_gen_bus_if.ren || proc_gen_bus_if.wen))) begin
                    if(state == HIT) begin
	                    hit       = 1'b1;
        	            hit_data  = sramRead.frames[i].pte;
                	    hit_idx   = i;
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
        tlb_hit_data            = '0;
        enable_fence_count      = 0;
        enable_fence_count_nowb = 0;
        clear_fence_count       = 0;
        fence_done 	            = 0;
        tlb_miss                = 0;
        idle_done               = 0;
        clear_done 	            = 0;
        next_read_addr          = proc_gen_bus_if.addr;
        next_decoded_req_addr   = decoded_req_addr;
        next_last_used          = last_used;

        // TLB_ASSOCiativity, using NRU
        if (TLB_ASSOC == 1 || (last_used[decoded_addr.vpn.idx_bits] == (TLB_ASSOC - 1)))
            ridx = 0;
        else
            ridx = last_used[decoded_addr.vpn.idx_bits] + 1;

        casez(state)
            IDLE: begin
                // clear out tlbs with fence
                sramWEN = 1;
    	        sramWrite.frames[fence_idx.frame_num] = '0;
                sramMask.frames[fence_idx.frame_num] = '0;
                enable_fence_count_nowb = 1;
                // flag the completion of fence
                if (fence_idx.finish) begin
                    clear_fence_count  = 1;
                    idle_done 	       = 1;
                    fence_done = 1; //HACK: Remove if this causes bugs, used for testbench
                end
            end
            HIT: begin
                // tlb hit on a processor read/write
                // if (at_if.addr_trans_on && (proc_gen_bus_if.ren || proc_gen_bus_if.wen) && hit && !fence) begin
                if (at_if.addr_trans_on && hit && !fence) begin
                    proc_gen_bus_if.busy = 0;
                    tlb_hit_data = hit_data;
                    next_last_used[decoded_addr.vpn.idx_bits] = hit_idx;
                end
                // tlb miss on a clean block
		        else if(at_if.addr_trans_on && ~hit && activate_hit) begin
		        // else if(at_if.addr_trans_on && (proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && activate_hit) begin
                    mem_gen_bus_if.wen = proc_gen_bus_if.wen;
                    mem_gen_bus_if.ren = proc_gen_bus_if.ren;
                    mem_gen_bus_if.addr = proc_gen_bus_if.addr;
                    tlb_miss = 1;
                    next_decoded_req_addr = decoded_addr;
			    end
            end
            FETCH: begin
                // set tlb to be invalid before cache completes fetch
                tlb_miss = 1;
                mem_gen_bus_if.wen = proc_gen_bus_if.wen;
                mem_gen_bus_if.ren = proc_gen_bus_if.ren;
                mem_gen_bus_if.addr = read_addr;
                sramWrite.frames[ridx].tag.valid = 0;
                sramMask.frames[ridx].tag.valid = 0;
                // fill data
                if(~mem_gen_bus_if.busy) begin
                    sramWEN                            = 1'b1;
                    sramWrite.frames[ridx].pte         = mem_gen_bus_if.rdata;
                    sramWrite.frames[ridx].tag.valid   = 1'b1;
                    sramWrite.frames[ridx].tag.asid    = prv_pipe_if.satp.asid;
                    sramWrite.frames[ridx].tag.vpn_tag = decoded_req_addr.vpn.tag_bits;
                    sramMask.frames[ridx].pte          = 1'b0;
                    sramMask.frames[ridx].tag.valid    = 1'b0;
                    sramMask.frames[ridx].tag.asid     = '0;
                    sramMask.frames[ridx].tag.vpn_tag  = '0;
                    tlb_hit_data = mem_gen_bus_if.rdata;
                end
            end
            FENCE_TLB: begin
                enable_fence_count_nowb = 1;
                // fence if valid and
                // rs1 == 0 or sram.vpn == fence_va.vpn and
                // rs2 == 0 or (sram.asid == fence_asid and is not a global page)
                // if (!fence_idx.finish && sramRead.frames[fence_idx.frame_num].tag.valid &&
                if (!fence_idx.finish && sramRead.frames[fence_idx.frame_num].tag.valid &&
                    (~|decoded_fence_va | ({sramRead.frames[fence_idx.frame_num].tag.vpn_tag, sramSEL} == decoded_fence_va.vpn)) && 
                    (~|fence_asid | (sramRead.frames[fence_idx.frame_num].tag.asid == fence_asid && ~sramRead.frames[fence_idx.frame_num].pte.perms.global_page))) begin
                    // clears entry when fenceed
                    sramWEN = 1;
                    sramWrite.frames[fence_idx.frame_num] = 0;
                    sramMask.frames[fence_idx.frame_num] = 0;
                end

                // flag the completion of fence
                if (fence_idx.finish) begin
                    clear_fence_count  = 1;
                    fence_done 	       = 1;
                end
            end
        endcase
    end

    // Next State Logic
    always_comb begin
        next_state = state;
        casez(state)
            IDLE: begin
                if (idle_done) // Used for fencing cache
                    next_state = HIT;
            end
            HIT: begin
                if (at_if.addr_trans_on && (proc_gen_bus_if.ren || proc_gen_bus_if.wen) && ~hit && ~pass_through) // not sure what to do with pass through yet.
                    next_state = FETCH;
                if (fence)
                    next_state = FENCE_TLB;
            end
            FETCH: begin
                if (!mem_gen_bus_if.busy || mem_gen_bus_if.error || page_fault)
                    next_state = HIT;
            end
            FENCE_TLB: begin
                if (fence_done)
                    next_state = HIT;
                    // next_state = at_if.addr_trans_on ? HIT : IDLE;
            end
        endcase

        // do nothing if not in address translation is not on (and if we're not actively fencing the tlb)
        // if (~at_if.addr_trans_on && state != FENCE_TLB)
        //     next_state = IDLE;
    end

    // fence saver
    always_comb begin
        nfence_req = fence_req;
        if (fence)
            nfence_req = 1;
        if (fence_done)
            nfence_req = 0;
    end

endmodule