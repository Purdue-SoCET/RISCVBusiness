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

module separate_caches (
    input logic CLK,
    nRST,
    generic_bus_if.cpu icache_mem_gen_bus_if,
    generic_bus_if.cpu dcache_mem_gen_bus_if,
    generic_bus_if.cpu pw_mem_gen_bus_if,
    generic_bus_if.generic_bus icache_proc_gen_bus_if,
    generic_bus_if.generic_bus dcache_proc_gen_bus_if,
    cache_control_if.caches control_if,
    cache_coherence_if.cache i_cache_coherency_if,
    cache_coherence_if.cache d_cache_coherency_if,
    prv_pipeline_if.cache prv_pipe_if,
    output logic icache_miss,
    output logic dcache_miss
);
    import machine_mode_types_1_13_pkg::*;

    // TLB signals
    logic itlb_miss, dtlb_miss;
    

    generic_bus_if itlb_gen_bus_if ();
    generic_bus_if dtlb_gen_bus_if ();

    address_translation_if at_if ();

    generate
        /* verilator lint_off width */
        case (DCACHE_TYPE)
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
                .CACHE_SIZE(DCACHE_SIZE),
                .BLOCK_SIZE(DCACHE_BLOCK_SIZE),
                .ASSOC(DCACHE_ASSOC),
                .NONCACHE_START_ADDR(NONCACHE_START_ADDR)
            )
            dcache (
                .CLK(CLK),
                .nRST(nRST),
                .mem_gen_bus_if(dcache_mem_gen_bus_if),
                .proc_gen_bus_if(dcache_proc_gen_bus_if),
                .flush(control_if.dcache_flush),
                .clear(control_if.dcache_clear),
                .reserve(control_if.dcache_reserve),
                .exclusive(control_if.dcache_exclusive),
                .flush_done(control_if.dflush_done),
                .clear_done(control_if.dclear_done),
                .ccif(d_cache_coherency_if),
                .cache_miss(dcache_miss),
                .prv_pipe_if(prv_pipe_if),
                .at_if(at_if),
                .tlb_miss(1'b0),
                .ppn_tag('0)
            );
            "l1_tlb": begin
                l1_cache #(
                    .CACHE_SIZE(DCACHE_SIZE),
                    .BLOCK_SIZE(DCACHE_BLOCK_SIZE),
                    .ASSOC(DCACHE_ASSOC),
                    .NONCACHE_START_ADDR(NONCACHE_START_ADDR)
                )
                dcache (
                    .CLK(CLK),
                    .nRST(nRST),
                    .mem_gen_bus_if(dcache_mem_gen_bus_if),
                    .proc_gen_bus_if(dcache_proc_gen_bus_if),
                    .flush(control_if.dcache_flush),
                    .clear(control_if.dcache_clear),
                    .reserve(control_if.dcache_reserve),
                    .exclusive(control_if.dcache_exclusive),
                    .flush_done(control_if.dflush_done),
                    .clear_done(control_if.dclear_done),
                    .ccif(d_cache_coherency_if),
                    .prv_pipe_if(prv_pipe_if),
                    .at_if(at_if),
                    .tlb_miss(dtlb_miss),
                    .ppn_tag(dtlb_gen_bus_if.rdata[PPNLEN:10])
                );
                tlb dtlb (
                    .CLK(CLK),
                    .nRST(nRST),
                    .mem_gen_bus_if(dtlb_gen_bus_if),
                    .proc_gen_bus_if(dcache_proc_gen_bus_if),
                    .fence(control_if.dtlb_fence),
                    .clear(1'b0),
                    .fence_done(control_if.dtlb_fence_done),
                    .prv_pipe_if(prv_pipe_if),
                    .at_if(at_if),
                    .tlb_miss(dtlb_miss)
                );
            end
        endcase
    endgenerate

    generate
        /* verilator lint_off width */
        case (ICACHE_TYPE)
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
                .CACHE_SIZE(ICACHE_SIZE),
                .BLOCK_SIZE(ICACHE_BLOCK_SIZE),
                .ASSOC(ICACHE_ASSOC),
                .NONCACHE_START_ADDR(NONCACHE_START_ADDR)
            )
            icache (
                .CLK(CLK),
                .nRST(nRST),
                .mem_gen_bus_if(icache_mem_gen_bus_if),
                .proc_gen_bus_if(icache_proc_gen_bus_if),
                .flush(control_if.icache_flush),
                .clear(control_if.icache_clear),
                .reserve(1'b0),
                .exclusive(1'b0),
                .flush_done(control_if.iflush_done),
                .clear_done(control_if.iclear_done),
                .ccif(i_cache_coherency_if),
                .cache_miss(icache_miss),
                .prv_pipe_if(prv_pipe_if),
                .at_if(at_if),
                .tlb_miss(1'b0),
                .ppn_tag('0)
            );
            "l1_tlb": begin
                l1_cache #(
                    .CACHE_SIZE(ICACHE_SIZE),
                    .BLOCK_SIZE(ICACHE_BLOCK_SIZE),
                    .ASSOC(ICACHE_ASSOC),
                    .NONCACHE_START_ADDR(NONCACHE_START_ADDR)
                )
                icache (
                    .CLK(CLK),
                    .nRST(nRST),
                    .mem_gen_bus_if(icache_mem_gen_bus_if),
                    .proc_gen_bus_if(icache_proc_gen_bus_if),
                    .flush(control_if.icache_flush),
                    .clear(control_if.icache_clear),
                    .reserve(1'b0),
                    .exclusive(1'b0),
                    .flush_done(control_if.iflush_done),
                    .clear_done(control_if.iclear_done),
                    .ccif(i_cache_coherency_if),
                    .prv_pipe_if(prv_pipe_if),
                    .at_if(at_if),
                    .tlb_miss(itlb_miss),
                    .ppn_tag(itlb_gen_bus_if.rdata[PPNLEN:10])
                );
                tlb itlb (
                    .CLK(CLK),
                    .nRST(nRST),
                    .mem_gen_bus_if(itlb_gen_bus_if),
                    .proc_gen_bus_if(icache_proc_gen_bus_if),
                    .fence(control_if.itlb_fence),
                    .clear(1'b0),
                    .fence_done(control_if.itlb_fence_done),
                    .prv_pipe_if(prv_pipe_if),
                    .at_if(at_if),
                    .tlb_miss(itlb_miss)
                );
            end
        endcase
    endgenerate

    generate
        if (ICACHE_TYPE == "l1_tlb" && DCACHE_TYPE == "l1_tlb") begin
            page_walker pw (
                .CLK(CLK),
                .nRST(nRST),
                .itlb_miss(itlb_miss),
                .dtlb_miss(dtlb_miss),
                .mem_gen_bus_if(pw_mem_gen_bus_if),
                .itlb_gen_bus_if(itlb_gen_bus_if),
                .dtlb_gen_bus_if(dtlb_gen_bus_if),
                .prv_pipe_if(prv_pipe_if),
                .at_if(at_if)
            );
        end else begin
            assign at_if.addr_trans_on = '0;
        end
    endgenerate

endmodule
