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

module separate_caches (
    input logic CLK,
    nRST,
    generic_bus_if.cpu icache_mem_gen_bus_if,
    generic_bus_if.cpu dcache_mem_gen_bus_if,
    generic_bus_if.generic_bus icache_proc_gen_bus_if,
    generic_bus_if.generic_bus dcache_proc_gen_bus_if,
    cache_control_if.caches cc_if
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
                assign cc_if.dclear_done = 1'b1;
                assign cc_if.dflush_done = 1'b1;
            end
            "direct_mapped_tpf":
            direct_mapped_tpf_cache dcache (
                .CLK(CLK),
                .nRST(nRST),
                .mem_gen_bus_if(dcache_mem_gen_bus_if),
                .proc_gen_bus_if(dcache_proc_gen_bus_if),
                .flush(cc_if.dcache_flush),
                .clear(cc_if.dcache_clear),
                .flush_done(cc_if.dflush_done),
                .clear_done(cc_if.dclear_done)
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
                assign cc_if.iclear_done = 1'b1;
                assign cc_if.iflush_done = 1'b1;
            end
            "direct_mapped_tpf":
            direct_mapped_tpf_cache icache (
                .CLK(CLK),
                .nRST(nRST),
                .mem_gen_bus_if(icache_mem_gen_bus_if),
                .proc_gen_bus_if(icache_proc_gen_bus_if),
                .flush(cc_if.icache_flush),
                .clear(cc_if.icache_clear),
                .flush_done(cc_if.iflush_done),
                .clear_done(cc_if.iclear_done)
            );
        endcase
    endgenerate

endmodule
