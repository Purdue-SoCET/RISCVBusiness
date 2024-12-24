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

module separate_caches#(
    parameter HART_ID
) (
    input logic CLK,
    nRST,
    generic_bus_if.cpu icache_mem_gen_bus_if,
    generic_bus_if.cpu dcache_mem_gen_bus_if,
    generic_bus_if.generic_bus icache_proc_gen_bus_if,
    generic_bus_if.generic_bus dcache_proc_gen_bus_if,
    cache_control_if.caches control_if,
    bus_ctrl_if.cache bus_ctrl_if,
    output logic icache_miss,
    output logic dcache_miss
);
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
                .HART_ID(HART_ID*2+1)
            )
            dcache (
                .CLK(CLK),
                .nRST(nRST),
                .proc_gen_bus_if(dcache_proc_gen_bus_if),
                .bus_ctrl_if(bus_ctrl_if),
                .flush(control_if.dcache_flush),
                .clear(control_if.dcache_clear),
                .reserve(control_if.dcache_reserve),
                .flush_done(control_if.dflush_done),
                .abort_bus(),
                .cache_miss(dcache_miss)
            );
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
                .HART_ID(HART_ID*2)
            )
            icache (
                .CLK(CLK),
                .nRST(nRST),
                .proc_gen_bus_if(icache_proc_gen_bus_if),
                .bus_ctrl_if(bus_ctrl_if),
                .flush(control_if.icache_flush),
                .clear(control_if.icache_clear),
                .reserve(1'b0),
                .flush_done(control_if.iflush_done),
                .abort_bus(),
                .cache_miss(icache_miss)
            );
        endcase
    endgenerate

endmodule
