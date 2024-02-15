/*
*   Copyright 2023 Purdue University
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
*   Filename:     rv32v_mem_serializer.sv
*
*   Created by:   Maxwell Michalec
*   Email:        michalem@purdue.edu
*   Date Created: 01/30/2024
*   Description:  Vector memory access serializer
*/

`include "rv32v_mem_serializer_if.vh"

module rv32v_mem_serializer (
    input logic CLK,
    input logic nRST,
    rv32v_mem_serializer_if.serial serial_if
);

    import rv32v_types_pkg::*;

    typedef enum logic [$clog2(NUM_LANES)-1:0] { VL0, VL1, VL2, VL3 } serial_state_t;

    serial_state_t serial_state, next_serial_state;
    word_t next_addr, next_next_addr;

    // Initially: cycle through each lane (prev/base +stride each time)
    // Further optimization: skip over non-active lanes to save cycles (variable +k*stride)

    // Data alignment:
    // Generate a vload_type (see rv32i) and set byte_offset (addr[1:0])
    // Access alignment:
    // We choose to only support accesses that are naturally aligned to the element size

    always_ff @(posedge CLK or negedge nRST) begin
        if (~nRST) begin
            serial_state <= VL0;
            next_addr <= '0;
        end else begin
            serial_state <= next_serial_state;
            next_addr <= next_next_addr;
        end
    end

    always_comb begin
        next_serial_state = VL0;
        next_next_addr = next_addr;
        serial_if.vcurr_lane = '0;
        serial_if.vaddr_lsc = '0;

        if (serial_if.vmemdwen | serial_if.vmemdren) begin
            casez (serial_state)
                VL0: begin
                    serial_if.vcurr_lane = 2'd0;
                    if (serial_if.vindexed) begin
                        serial_if.vaddr_lsc = serial_if.vlane_addr[0];
                    end else if (serial_if.vuop_num == '0) begin
                        serial_if.vaddr_lsc = serial_if.base;
                    end else begin
                        serial_if.vaddr_lsc = next_addr;
                    end

                    if (serial_if.lsc_ready | ~serial_if.vlane_mask[0]) begin
                        if (serial_if.vuop_num == '0) begin  // new instruction, next = base + stride
                            next_next_addr = serial_if.base + serial_if.stride;
                        end else begin
                            next_next_addr = next_addr + serial_if.stride;
                        end
                        next_serial_state = VL1;
                    end
                end
                VL1: begin
                    serial_if.vcurr_lane = 2'd1;
                    if (serial_if.vindexed) begin
                        serial_if.vaddr_lsc = serial_if.vlane_addr[1];
                    end else begin
                        serial_if.vaddr_lsc = next_addr;
                    end

                    if (serial_if.lsc_ready | ~serial_if.vlane_mask[1]) begin
                        next_next_addr = next_addr + serial_if.stride;
                        next_serial_state = VL2;
                    end
                end
                VL2: begin
                    serial_if.vcurr_lane = 2'd2;
                    if (serial_if.vindexed) begin
                        serial_if.vaddr_lsc = serial_if.vlane_addr[2];
                    end else begin
                        serial_if.vaddr_lsc = next_addr;
                    end

                    if (serial_if.lsc_ready | ~serial_if.vlane_mask[2]) begin
                        next_next_addr = next_addr + serial_if.stride;
                        next_serial_state = VL3;
                    end
                end
                VL3: begin
                    serial_if.vcurr_lane = 2'd3;
                    if (serial_if.vindexed) begin
                        serial_if.vaddr_lsc = serial_if.vlane_addr[3];
                    end else begin
                        serial_if.vaddr_lsc = next_addr;
                    end

                    if (serial_if.lsc_ready | ~serial_if.vlane_mask[3]) begin
                        next_next_addr = next_addr + serial_if.stride;
                        next_serial_state = VL0;
                    end
                end
            endcase
        end
    end

    always_comb begin
        serial_if.vload_type = LW;

        casez (serial_if.veew)
            SEW8:  serial_if.vload_type = LB;
            SEW16: serial_if.vload_type = LH;
            SEW32: serial_if.vload_type = LW;
        endcase
    end

    assign serial_if.vmemdwen_lsc = serial_if.vmemdwen & serial_if.vlane_mask[serial_if.vcurr_lane];
    assign serial_if.vmemdren_lsc = serial_if.vmemdren & serial_if.vlane_mask[serial_if.vcurr_lane];
    assign serial_if.vdata_store_lsc = serial_if.vlane_store_data[serial_if.vcurr_lane];

endmodule // rv32v_mem_serializer
