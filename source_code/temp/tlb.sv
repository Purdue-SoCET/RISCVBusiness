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
*   Date Created: 
*   Description: Translation Lookaside Buffer (TLB) for sv32
*/

module tlb_sv32 #(
    parameter VIRTUAL_ADDR_WIDTH = 32,
    parameter PHYSICAL_ADDR_WIDTH = 32,
    parameter PAGE_OFFSET_BITS = 12, // For 4KB pages
    parameter TLB_SIZE = 64 // Number of entries in the TLB
) (
    input logic clk,
    input logic reset,
    // Virtual address input from the CPU core
    input logic [VIRTUAL_ADDR_WIDTH-1:0] virtual_address,
    input logic request_valid,
    // Translated physical address output to the CPU core
    output logic [PHYSICAL_ADDR_WIDTH-1:0] physical_address,
    output logic response_valid,
    output logic translation_fault,
    // Interface to the page table walker
    // ...
);

    // Define the TLB entry structure
    typedef struct packed {
        logic valid;
        logic [VIRTUAL_ADDR_WIDTH-PAGE_OFFSET_BITS-1:0] vpn; // Virtual Page Number
        logic [PHYSICAL_ADDR_WIDTH-PAGE_OFFSET_BITS-1:0] ppn; // Physical Page Number
        // Additional fields for access rights, dirty bit, etc.
    } tlb_entry_t;

    // TLB array
    tlb_entry_t tlb_array[TLB_SIZE];
    // VIPT cache indexing logic
    logic [VIRTUAL_ADDR_WIDTH-PAGE_OFFSET_BITS-1:0] index;
    logic [VIRTUAL_ADDR_WIDTH-PAGE_OFFSET_BITS-1:0] tag;

    // Extract index and tag from the virtual address
    always_comb begin
        index = virtual_address[VIRTUAL_ADDR_WIDTH-1:PAGE_OFFSET_BITS];
        tag = virtual_address[VIRTUAL_ADDR_WIDTH-1:PAGE_OFFSET_BITS];
    end

    // TLB lookup logic
    always_ff @(posedge clk) begin
        if (request_valid) begin
            // Search the TLB for a matching entry
            for (int i = 0; i < TLB_SIZE; i++) begin
                if (tlb_array[i].valid && tlb_array[i].vpn == tag) begin
                    // TLB hit
                    physical_address <= {tlb_array[i].ppn, virtual_address[PAGE_OFFSET_BITS-1:0]};
                    response_valid <= 1;
                    translation_fault <= 0;
                    break;  //may not be synthesizablle, seems to be possible with bounded for loop, but maybe redesign
                end
            end
            // If no match is found, a TLB miss occurs, and the page table walker must be invoked
            // ...
        end else begin
            response_valid <= 0;
            translation_fault <= 0;
        end
    end

    // Initialization and reset logic
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            // Invalidate all TLB entries
            for (int i = 0; i < TLB_SIZE; i++) begin
                tlb_array[i].valid <= 0;
            end
        end

        // Additional logic for updating TLB entries upon page table walker responses
        // ...
    end

endmodule