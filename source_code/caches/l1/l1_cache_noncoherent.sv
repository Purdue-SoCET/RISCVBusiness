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

module l1_cache_noncoherent #(
    parameter CPUID,
    parameter CACHE_SIZE          = 1024, // must be power of 2, in bytes, max 4k - 4 * 2^10
    parameter BLOCK_SIZE          = 2, // must be power of 2, max 8
    parameter ASSOC               = 1, // dont set this to 0
    parameter NONCACHE_START_ADDR = 32'hF000_0000 // sh/sb still have issues when uncached; not sure whats up with that still tbh
)
(
    input logic CLK, nRST,
    input logic clear, flush, reserve, exclusive,
    output logic clear_done, flush_done, abort_bus,
    generic_bus_if.generic_bus proc_gen_bus_if,
    bus_ctrl_if.tb bcif
);
    cache_coherence_if ccif();
    generic_bus_if #(.BLOCK_SIZE(BLOCK_SIZE)) mem_gen_bus_if();

    l1_cache #(
        .CACHE_SIZE(CACHE_SIZE),
        .BLOCK_SIZE(BLOCK_SIZE),
        .ASSOC(ASSOC),
        .NONCACHE_START_ADDR(NONCACHE_START_ADDR),
    ) cache (
        .CLK(CLK),
        .nRST(nRST),
        .clear(clear),
        .flush(flush),
        .reserve(reserve),
        .exclusive(exclusive),
        .clear_done(clear_done),
        .flush_done(flush_done),
        .abort_bus(abort_bus),
        .mem_gen_bus_if(mem_gen_bus_if),
        .proc_gen_bus_if(proc_gen_bus_if),
        .ccif(ccif)
    );

    always_comb begin
        ccif.state_transfer = cc_end_state'(MODIFIED);
        ccif.snoop_req = 0;
        ccif.addr = 32'hBAD1BAD1;
        bcif.ccdirty[CPUID] = ccif.dirty;
        bcif.ccsnoopdone[CPUID] = 1'b1;
        bcif.ccsnoophit[CPUID] = 1'b0;
        bcif.ccwrite[CPUID] = mem_gen_bus_if.wen;
        bcif.dstore[CPUID] = mem_gen_bus_if.wdata;
        bcif.daddr[CPUID] = mem_gen_bus_if.addr;
        bcif.dWEN[CPUID] = ccif.dWEN && mem_gen_bus_if.wen;
        bcif.dREN[CPUID] = mem_gen_bus_if.wen || mem_gen_bus_if.ren;
        bcif.dbyte_en[CPUID] = mem_gen_bus_if.byte_en;
        mem_gen_bus_if.rdata = bcif.dload[CPUID];
        mem_gen_bus_if.busy = bcif.dwait[CPUID];
    end
endmodule
