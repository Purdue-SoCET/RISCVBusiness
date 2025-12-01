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
*   Filename:     separate_caches.sv
*
*   Created by:   Jacob R. Stevens
*   Email:        steven69@purdue.edu
*   Date Created: 11/08/2016
*   Description: Caches consisting of separate I$ and D$
*/

`include "generic_bus_if.vh"
`include "cache_control_if.vh"
`include "component_selection_defines.vh"
`include "bus_ctrl_if.vh"
`include "prv_pipeline_if.vh"
`include "address_translation_if.vh"

module separate_caches #(
    parameter HART_ID
) (
    input logic CLK,
    nRST,
    generic_bus_if.cpu icache_mem_gen_bus_if,
    generic_bus_if.cpu dcache_mem_gen_bus_if,
    generic_bus_if.generic_bus icache_proc_gen_bus_if,
    generic_bus_if.generic_bus dcache_proc_gen_bus_if,
    cache_control_if.caches control_if,
    prv_pipeline_if prv_pipe_if,
    front_side_bus_if.cache dcache_bus_ctrl_if,
    front_side_bus_if.cache icache_bus_ctrl_if,
    output logic abort_bus,
    output logic icache_miss,
    output logic dcache_miss
);
    import priv_isa_types_pkg::*;
    import rv32i_types_pkg::*;
    import core_configuration_pkg::*;
    
    // TLB signals L1$ needs
    logic itlb_miss, dtlb_miss;
    word_t itlb_hit_data, dtlb_hit_data;

    generic_bus_if pw_gen_bus_if ();
    generic_bus_if empty_gen_bus_if ();

    address_translation_if insn_at_if ();
    address_translation_if data_at_if ();

    // assign physical addresses to pmp
    assign prv_pipe_if.ipaddr = icache_bus_ctrl_if.daddr;
    assign prv_pipe_if.dpaddr = dcache_bus_ctrl_if.daddr;

    generate
        /* verilator lint_off width */
        case (DCACHE_TYPES[HART_ID])
            /* verilator lint_on width */
            "pass_through": begin : g_dcache_passthrough
                pass_through_cache dcache (
                    .CLK(CLK),
                    .nRST(nRST),
                    .mem_gen_bus_if(dcache_mem_gen_bus_if),
                    .proc_gen_bus_if(dcache_proc_gen_bus_if)
                );
                assign control_if.dclear_done = 1'b1;
                assign control_if.dflush_done = 1'b1;
                assign dcache_miss = 0;
            end
            "direct_mapped_tpf": begin : g_dcache_directmapped
                direct_mapped_tpf_cache dcache (
                    .CLK(CLK),
                    .nRST(nRST),
                    .mem_gen_bus_if(dcache_mem_gen_bus_if),
                    .proc_gen_bus_if(dcache_proc_gen_bus_if),
                    .flush(control_if.dcache_flush),
                    .clear(control_if.dcache_clear),
                    .flush_done(control_if.dflush_done),
                    .clear_done(control_if.dclear_done)
                );
                assign dcache_miss = 0;
            end
            "l1":
            l1_cache #(
                .CACHE_SIZE(DCACHE_SIZES[HART_ID]),
                .BLOCK_SIZE(DCACHE_BLOCK_SIZE),
                .ASSOC(DCACHE_ASSOCS[HART_ID]),
                .IS_ICACHE(0)
            )
            dcache (
                .CLK(CLK),
                .nRST(nRST),
                .proc_gen_bus_if(dcache_proc_gen_bus_if),
                .pw_gen_bus_if(pw_gen_bus_if),
                .bus_ctrl_if(dcache_bus_ctrl_if),
                .flush(control_if.dcache_flush),
                .clear(control_if.dcache_clear),
                .reserve(control_if.dcache_reserve),
                .flush_done(control_if.dflush_done),
                .abort_bus(),
                .clear_done(control_if.dclear_done),
                .cache_miss(dcache_miss),
                .prv_pipe_if(prv_pipe_if),
                .at_if(data_at_if),
                .tlb_miss(dtlb_miss),
                .ppn_tag(dtlb_hit_data[PPNLEN + 10 - 1:10])
            );
        endcase
    endgenerate

    generate
        /* verilator lint_off width */
        case (ICACHE_TYPES[HART_ID])
            /* verilator lint_on width */
            "pass_through": begin : g_icache_passthrough
                pass_through_cache icache (
                    .CLK(CLK),
                    .nRST(nRST),
                    .mem_gen_bus_if(icache_mem_gen_bus_if),
                    .proc_gen_bus_if(icache_proc_gen_bus_if)
                );
                assign control_if.iclear_done = 1'b1;
                assign control_if.iflush_done = 1'b1;
                assign icache_miss = 0;
            end
            "direct_mapped_tpf": begin : g_icache_directmapped
                direct_mapped_tpf_cache icache (
                    .CLK(CLK),
                    .nRST(nRST),
                    .mem_gen_bus_if(icache_mem_gen_bus_if),
                    .proc_gen_bus_if(icache_proc_gen_bus_if),
                    .flush(control_if.icache_flush),
                    .clear(control_if.icache_clear),
                    .flush_done(control_if.iflush_done),
                    .clear_done(control_if.iclear_done)
                );
                assign icache_miss = 0;
            end
            "l1":
            l1_cache #(
                .CACHE_SIZE(ICACHE_SIZES[NUM_HARTS]),
                .BLOCK_SIZE(ICACHE_BLOCK_SIZE),
                .ASSOC(ICACHE_ASSOCS[NUM_HARTS]),
                .IS_ICACHE(1)
            )
            icache (
                .CLK(CLK),
                .nRST(nRST),
                .proc_gen_bus_if(icache_proc_gen_bus_if),
                .pw_gen_bus_if(empty_gen_bus_if),
                .bus_ctrl_if(icache_bus_ctrl_if),
                .flush(control_if.icache_flush),
                .clear(control_if.icache_clear),
                .reserve(1'b0),
                .flush_done(control_if.iflush_done),
                .clear_done(control_if.iclear_done),
                .abort_bus(abort_bus),
                .cache_miss(icache_miss),
                .prv_pipe_if(prv_pipe_if),
                .at_if(insn_at_if),
                .tlb_miss(itlb_miss),
                .ppn_tag(itlb_hit_data[PPNLEN + 10 - 1:10])
            );
        endcase
    endgenerate

`ifdef ADDRESS_TRANSLATION
    // TLB busses
    generic_bus_if itlb_gen_bus_if ();
    generic_bus_if dtlb_gen_bus_if ();

    // TLB/PW signals
    logic itlb_fault_load_page, itlb_fault_store_page, itlb_fault_insn_page;
    logic dtlb_fault_load_page, dtlb_fault_store_page, dtlb_fault_insn_page;
    logic pw_fault_load_page, pw_fault_store_page, pw_fault_insn_page;

    // DTLB
    tlb #(.IS_ITLB(0)) dtlb (
        .CLK(CLK),
        .nRST(nRST),
        .mem_gen_bus_if(dtlb_gen_bus_if),
        .proc_gen_bus_if(dcache_proc_gen_bus_if),
        .tlb_hit_data(dtlb_hit_data),
        .fence(control_if.dtlb_fence),
        .page_fault(prv_pipe_if.fault_load_page | prv_pipe_if.fault_store_page | prv_pipe_if.fault_insn_page),
        .fence_done(control_if.dtlb_fence_done),
        .prv_pipe_if(prv_pipe_if),
        .at_if(data_at_if),
        .tlb_miss(dtlb_miss),
        .fault_load_page(dtlb_fault_load_page),
        .fault_store_page(dtlb_fault_store_page),
        .fault_insn_page(dtlb_fault_insn_page)
    );

    // ITLB
    tlb #(.IS_ITLB(1)) itlb (
        .CLK(CLK),
        .nRST(nRST),
        .mem_gen_bus_if(itlb_gen_bus_if),
        .proc_gen_bus_if(icache_proc_gen_bus_if),
        .tlb_hit_data(itlb_hit_data),
        .fence(control_if.itlb_fence),
        .page_fault(prv_pipe_if.fault_load_page | prv_pipe_if.fault_store_page | prv_pipe_if.fault_insn_page),
        .fence_done(control_if.itlb_fence_done),
        .prv_pipe_if(prv_pipe_if),
        .at_if(insn_at_if),
        .tlb_miss(itlb_miss),
        .fault_load_page(itlb_fault_load_page),
        .fault_store_page(itlb_fault_store_page),
        .fault_insn_page(itlb_fault_insn_page)
    );

    // Page Walker
    page_walker pw (
        .CLK(CLK),
        .nRST(nRST),
        .itlb_miss(itlb_miss),
        .dtlb_miss(dtlb_miss),
        .fault_load_page(pw_fault_load_page),
        .fault_store_page(pw_fault_store_page),
        .fault_insn_page(pw_fault_insn_page),
        .mem_gen_bus_if(pw_gen_bus_if),
        .itlb_gen_bus_if(itlb_gen_bus_if),
        .dtlb_gen_bus_if(dtlb_gen_bus_if),
        .prv_pipe_if(prv_pipe_if),
        .insn_at_if(insn_at_if),
        .data_at_if(data_at_if)
    );

    assign prv_pipe_if.itlb_miss = itlb_miss;
    assign prv_pipe_if.dtlb_miss = dtlb_miss;

    // arbitrate between pw, dtlb, or itlb for page faults
    always_comb begin
        prv_pipe_if.fault_load_page  = 0;
        prv_pipe_if.fault_store_page = 0;
        prv_pipe_if.fault_insn_page  = 0;

        // Order goes
        // 1. PW data access fault
        // 2. dtlb access fault
        // 3. PW insn access fault
        // 4. itlb access fault
        if (dtlb_miss && (prv_pipe_if.ex_mem_ren || prv_pipe_if.ex_mem_wen)) begin
            prv_pipe_if.fault_load_page  = pw_fault_load_page;
            prv_pipe_if.fault_store_page = pw_fault_store_page;
            prv_pipe_if.fault_insn_page  = pw_fault_insn_page;
        end
        else if (dtlb_fault_load_page  | 
                 dtlb_fault_store_page | 
                 dtlb_fault_insn_page) begin
            prv_pipe_if.fault_load_page  = dtlb_fault_load_page;
            prv_pipe_if.fault_store_page = dtlb_fault_store_page;
            prv_pipe_if.fault_insn_page  = dtlb_fault_insn_page;
        end
        else if (itlb_miss) begin
            prv_pipe_if.fault_load_page  = pw_fault_load_page;
            prv_pipe_if.fault_store_page = pw_fault_store_page;
            prv_pipe_if.fault_insn_page  = pw_fault_insn_page;
        end
        else if (itlb_fault_load_page  | 
                 itlb_fault_store_page | 
                 itlb_fault_insn_page) begin
            prv_pipe_if.fault_load_page  = itlb_fault_load_page;
            prv_pipe_if.fault_store_page = itlb_fault_store_page;
            prv_pipe_if.fault_insn_page  = itlb_fault_insn_page;
        end
    end
`else
    // TODO:
    // zero tlb misses
    assign itlb_miss = 0;
    assign dtlb_miss = 0;
    // assign prv_pipe_if.itlb_miss = 0;
    // assign prv_pipe_if.dtlb_miss = 0;

    // zero hit data
    assign itlb_hit_data = '0;
    assign dtlb_hit_data = '0;

    // zero address translation
    assign insn_at_if.addr_trans_on = '0;
    assign data_at_if.addr_trans_on = '0;

    // zero page fault signals
    // assign prv_pipe_if.fault_load_page  = 0;
    // assign prv_pipe_if.fault_store_page = 0;
    // assign prv_pipe_if.fault_insn_page  = 0;
`endif
endmodule
