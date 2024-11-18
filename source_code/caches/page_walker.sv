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
*   Filename:    page_walker.sv
*
*   Created by:   William Milne
*   Email:        milnew@purdue.edu
*   Date Created: 10/13/2024
*   Description: Automatically load virtual-to-physical translations into 
*                the Translation Lookaside Buffer (TLB) when queued
*/

module page_walker #(
    parameter int ADDR_WIDTH = 32,
    parameter int PTE_WIDTH = 32,
    parameter int PGSIZE_BITS = 12 // Assuming a 4 KiB page size
)
(
    input logic CLK, nRST,
    input logic itlb_miss, dtlb_miss,
    generic_bus_if.cpu mem_gen_bus_if,
    generic_bus_if.generic_bus itlb_gen_bus_if,
    generic_bus_if.generic_bus dtlb_gen_bus_if,
    prv_pipe_if.caches prv_pipe_if
);

    import rv32i_types_pkg::*;
    import machine_mode_types_1_13_pkg::*;

    typedef enum {
        IDLE, WALK, RETURN_PA, FAULT
    }

endmodule