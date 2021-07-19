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
*   Filename:     caches_wrapper.sv
*
*   Created by:   Jacob R. Stevens
*   Email:        steven69@purdue.edu
*   Date Created: 11/08/2016
*   Description:  Wrapper file that instantiates the desired cache structure
*/

`include "generic_bus_if.vh"
`include "cache_control_if.vh"
`include "component_selection_defines.vh"

module caches_wrapper (
    input logic CLK,
    nRST,
    generic_bus_if.cpu icache_mem_gen_bus_if,
    generic_bus_if.cpu dcache_mem_gen_bus_if,
    generic_bus_if.generic_bus icache_proc_gen_bus_if,
    generic_bus_if.generic_bus dcache_proc_gen_bus_if,
    cache_control_if cc_if
);
    generate
        case (CACHE_CONFIG)
            "separate": separate_caches sep_caches (.*);
        endcase
    endgenerate

endmodule

