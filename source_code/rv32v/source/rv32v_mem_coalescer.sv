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
*   Filename:     rv32v_mem_coalescer.sv
*
*   Created by:   Maxwell Michalec
*                 William Cunningham
*   Email:        michalem@purdue.edu
*                 wrcunnin@purdue.edu
*   Date Created: 01/30/2024
*   Description:  Vector memory access coalescer derived from the
*                 memory serializer created by Maxwell Michalec.
*/

`include "rv32v_mem_coalescer_if.vh"

module rv32v_mem_coalescer (
    input logic CLK,
    input logic nRST,
    input logic flush,
    rv32v_mem_coalescer_if.coalescer coalescer_if,
    output logic coalescer_stall
);

    import rv32v_types_pkg::*;

    localparam N_BLOCK_BITS = $clog2(DCACHE_BLOCK_SIZE) + (DCACHE_BLOCK_SIZE == 1);

    typedef enum logic [$clog2(NUM_LANES)-1:0] { VL0, VL1, VL2, VL3 } coalescer_state_t;

    coalescer_state_t coalescer_state, next_coalescer_state;
    word_t next_addr, next_next_addr, seg_addr, next_seg_addr, temp_tag_match_addr;
    logic  [NUM_LANES-1:0] tag_match;
    word_t [NUM_LANES-1:0] strided_addr, next_strided_addr;

    /*
    Scratch Pad:
    - Make sure to update the vcurr_lane to the hazard_if. This will need to account for when each lane could be the last element
    */

    // Initially: combine lanes that are going to the same cache block + address
    // Further optimization: skip over non-active lanes to save cycles (variable +k*stride)

    // Data alignment:
    // Generate a vload_type (see rv32i) and set byte_offset (addr[1:0])
    // Access alignment:
    // We choose to only support accesses that are naturally aligned to the element size

    always_ff @(posedge CLK or negedge nRST) begin
        if (~nRST) begin
            coalescer_state <= VL0;
            next_addr <= '0;
            seg_addr <= '0; 
            strided_addr <= '0;
        end else if (flush) begin
            coalescer_state <= VL0;
            next_addr <= '0;
            seg_addr <= '0;
            strided_addr <= '0;
        end else begin
            coalescer_state <= next_coalescer_state;
            next_addr <= next_next_addr;
            seg_addr <= next_seg_addr;
            strided_addr <= next_strided_addr;
        end
    end

    // Calculating stride addresses
    always_comb begin
        next_strided_addr = strided_addr;
        if (coalescer_if.vuop_num == '0 && coalescer_state == VL0) begin
            next_strided_addr[0] = coalescer_if.vaddr_lsc;
            next_strided_addr[1] = coalescer_if.vaddr_lsc + coalescer_if.stride;
            next_strided_addr[2] = coalescer_if.vaddr_lsc + (coalescer_if.stride << 1);
            next_strided_addr[3] = coalescer_if.vaddr_lsc + (coalescer_if.stride << 1) + coalescer_if.stride;
        end else if (coalescer_if.lsc_ready && next_coalescer_state == VL0) begin
            next_strided_addr[0] = strided_addr[3] + coalescer_if.stride;
            next_strided_addr[1] = strided_addr[3] + (coalescer_if.stride << 1);
            next_strided_addr[2] = strided_addr[3] + (coalescer_if.stride << 1) + coalescer_if.stride;
            next_strided_addr[3] = strided_addr[3] + (coalescer_if.stride << 2);
        end
    end

    // Matching tags and blocks for each lane to current lsc vaddr
    always_comb begin
        tag_match = '0;
        if (coalescer_if.vindexed) begin
            tag_match[0] = coalescer_if.vaddr_lsc[WORD_SIZE-1:(N_BLOCK_BITS + 2)] == coalescer_if.vlane_addr[0][WORD_SIZE-1:(N_BLOCK_BITS + 2)];
            tag_match[1] = coalescer_if.vaddr_lsc[WORD_SIZE-1:(N_BLOCK_BITS + 2)] == coalescer_if.vlane_addr[1][WORD_SIZE-1:(N_BLOCK_BITS + 2)];
            tag_match[2] = coalescer_if.vaddr_lsc[WORD_SIZE-1:(N_BLOCK_BITS + 2)] == coalescer_if.vlane_addr[2][WORD_SIZE-1:(N_BLOCK_BITS + 2)];
            tag_match[3] = coalescer_if.vaddr_lsc[WORD_SIZE-1:(N_BLOCK_BITS + 2)] == coalescer_if.vlane_addr[3][WORD_SIZE-1:(N_BLOCK_BITS + 2)];
        end else begin
            casez (coalescer_state)
                VL0: begin
                    tag_match[0] = 1;
                    tag_match[1] = coalescer_if.vaddr_lsc[WORD_SIZE-1:(N_BLOCK_BITS + 2)] == strided_addr[1][WORD_SIZE-1:(N_BLOCK_BITS + 2)];
                    tag_match[2] = coalescer_if.vaddr_lsc[WORD_SIZE-1:(N_BLOCK_BITS + 2)] == strided_addr[2][WORD_SIZE-1:(N_BLOCK_BITS + 2)];
                    tag_match[3] = coalescer_if.vaddr_lsc[WORD_SIZE-1:(N_BLOCK_BITS + 2)] == strided_addr[3][WORD_SIZE-1:(N_BLOCK_BITS + 2)];
                end
                VL1: begin
                    tag_match[1] = 1;
                    tag_match[2] = coalescer_if.vaddr_lsc[WORD_SIZE-1:(N_BLOCK_BITS + 2)] == strided_addr[2][WORD_SIZE-1:(N_BLOCK_BITS + 2)];
                    tag_match[3] = coalescer_if.vaddr_lsc[WORD_SIZE-1:(N_BLOCK_BITS + 2)] == strided_addr[3][WORD_SIZE-1:(N_BLOCK_BITS + 2)];
                end
                VL2: begin
                    tag_match[2] = 1;
                    tag_match[3] = coalescer_if.vaddr_lsc[WORD_SIZE-1:(N_BLOCK_BITS + 2)] == strided_addr[3][WORD_SIZE-1:(N_BLOCK_BITS + 2)];
                end
                VL3: begin
                    tag_match[3] = 1;
                end
            endcase
        end
    end

    // Sending addresses to LSC for it to do stuff if coalesced
    assign coalescer_if.vaddr_wide_lsc = coalescer_if.vindexed ? coalescer_if.vlane_addr : strided_addr;

    logic[2:0] element_stride; 
    always_comb begin
        case(coalescer_if.veew)
            SEW8: element_stride = 1; 
            SEW16: element_stride = 2; 
            default: element_stride = 4; 
        endcase
    end 
    assign veew_bits = coalescer_if.veew; 
    always_comb begin
        next_coalescer_state = VL0;
        next_next_addr = next_addr;
        next_seg_addr = seg_addr; 
        coalescer_if.vcurr_lane = '0;
        coalescer_if.ven_lanes = '0;
        coalescer_if.vaddr_lsc = '0;
        coalescer_stall = 0; 
        if (coalescer_if.vmemdwen | coalescer_if.vmemdren) begin
            coalescer_if.ven_lanes = tag_match;
            casez (coalescer_state)
                VL0: begin
                    //*** Normal Mem Operation ****// 
                    coalescer_stall = 1;
                    coalescer_if.vcurr_lane = '0;

                    if (coalescer_if.vindexed) begin
                        coalescer_if.vaddr_lsc = coalescer_if.vlane_addr[0];
                    end else if (coalescer_if.vuop_num == '0) begin
                        coalescer_if.vaddr_lsc = coalescer_if.base;
                    end else begin
                        coalescer_if.vaddr_lsc = next_addr;
                    end
                    if (coalescer_if.lsc_ready | ~coalescer_if.vlane_mask[0]) begin
                        casez (tag_match[3:1])
                            3'b??0:  next_coalescer_state = VL1;
                            3'b?01:  next_coalescer_state = VL2;
                            3'b011:  next_coalescer_state = VL3;
                            default: next_coalescer_state = VL0;
                        endcase
                        // if (coalescer_if.vuop_num == '0) begin  // new instruction, next = base + stride
                        //     next_next_addr = coalescer_if.base + coalescer_if.stride;
                        // end else begin
                        //     next_next_addr = next_addr + coalescer_if.stride;
                        // end
                        if (next_coalescer_state == VL0)
                            next_next_addr = strided_addr[3] + coalescer_if.stride;
                        else
                            next_next_addr = strided_addr[next_coalescer_state];
                        
                        if (next_coalescer_state == VL0) begin
                            coalescer_stall = 0;
                        end
                    end else begin
                        next_coalescer_state = coalescer_state;
                    end

                    //***** Segmented Load/Store Operation *****// 
                    if(coalescer_if.vseg_op) begin
                        coalescer_stall = 1'b1;
                        coalescer_if.ven_lanes = 4'b0001;
                        next_next_addr = next_addr; 
                        next_seg_addr = seg_addr; 
                        // // next_seg_addr logic 
                        // if(coalescer_if.vnew_seg && (coalescer_if.vuop_num == 0)) begin
                        //     next_seg_addr = coalescer_if.base; 
                        // end
                        // else if(coalescer_if.vnew_seg && coalescer_if.strided)
                        //     next_seg_addr = seg_addr + coalescer_if.stride; 
                        // else if(coalescer_if.vnew_seg && coalescer_if.unit_strided)
                        //     next_seg_addr = next_addr;
                        
                        // coalescer_if.vaddr_lsc logic
                        if (coalescer_if.vindexed)
                            coalescer_if.vaddr_lsc = coalescer_if.vlane_addr[0];
                        else if(coalescer_if.vnew_seg && (coalescer_if.vuop_num == 0))
                            coalescer_if.vaddr_lsc = coalescer_if.base; 
                        else if(coalescer_if.vnew_seg && coalescer_if.strided)
                            coalescer_if.vaddr_lsc = seg_addr + coalescer_if.stride; 
                        else
                            coalescer_if.vaddr_lsc = next_addr;

                        // next_next_addr & next_seg logic 
                        if (coalescer_if.lsc_ready | (coalescer_if.vlane_mask == 0)) begin
                            // next_seg_addr logic 
                            if(coalescer_if.vnew_seg && (coalescer_if.vuop_num == 0)) begin
                                next_seg_addr = coalescer_if.base; 
                            end
                            else if(coalescer_if.vnew_seg && coalescer_if.strided)
                                next_seg_addr = seg_addr + coalescer_if.stride; 
                            else if(coalescer_if.vnew_seg && coalescer_if.unit_strided)
                                next_seg_addr = next_addr;

                            // next_next_addr
                            if(coalescer_if.vnew_seg)
                                next_next_addr = next_seg_addr + element_stride; // increment by element width in bytes 
                            else 
                                next_next_addr = next_addr + element_stride; // increment by element width in bytes 
                            
                            coalescer_stall = 1'b0; 
                        end

                        // segment load/stores only happen in this state 
                        next_coalescer_state = VL0; 
                    end

                end
                VL1: begin
                    coalescer_stall = 1;
                    coalescer_if.vcurr_lane = 2'd1;
                    if (coalescer_if.vindexed) begin
                        coalescer_if.vaddr_lsc = coalescer_if.vlane_addr[1];
                    end else begin
                        coalescer_if.vaddr_lsc = next_addr;
                    end

                    if (coalescer_if.lsc_ready | ~coalescer_if.vlane_mask[1]) begin
                        // next_next_addr = next_addr + coalescer_if.stride;
                        

                        casez (tag_match[3:2])
                            2'b?0:  next_coalescer_state = VL2;
                            2'b01:  next_coalescer_state = VL3;
                            default: next_coalescer_state = VL0;
                        endcase

                        if (next_coalescer_state == VL0)
                            next_next_addr = strided_addr[3] + coalescer_if.stride;
                        else
                            next_next_addr = strided_addr[next_coalescer_state];

                        if (next_coalescer_state == VL0) begin
                            coalescer_stall = 0;
                        end
                    end else begin
                        next_coalescer_state = coalescer_state;
                    end
                end
                VL2: begin
                    coalescer_stall = 1;
                    coalescer_if.vcurr_lane = 2'd2;
                    if (coalescer_if.vindexed) begin
                        coalescer_if.vaddr_lsc = coalescer_if.vlane_addr[2];
                    end else begin
                        coalescer_if.vaddr_lsc = next_addr;
                    end

                    if (coalescer_if.lsc_ready | ~coalescer_if.vlane_mask[2]) begin
                        // next_next_addr = next_addr + coalescer_if.stride;
                        
                        casez (tag_match[3])
                            1'b0:  next_coalescer_state = VL3;
                            default: next_coalescer_state = VL0;
                        endcase

                        if (next_coalescer_state == VL0)
                            next_next_addr = strided_addr[3] + coalescer_if.stride;
                        else
                            next_next_addr = strided_addr[next_coalescer_state];

                        if (next_coalescer_state == VL0) begin
                            coalescer_stall = 0;
                        end
                    end else begin
                        next_coalescer_state = coalescer_state;
                    end
                end
                VL3: begin
                    coalescer_stall = 1;
                    coalescer_if.vcurr_lane = 2'd3;
                    if (coalescer_if.vindexed) begin
                        coalescer_if.vaddr_lsc = coalescer_if.vlane_addr[3];
                    end else begin
                        coalescer_if.vaddr_lsc = next_addr;
                    end

                    if (coalescer_if.lsc_ready | ~coalescer_if.vlane_mask[3]) begin
                        next_next_addr = next_addr + coalescer_if.stride;
                        next_coalescer_state = VL0;
                        coalescer_stall = 0; 
                    end else begin
                        next_coalescer_state = coalescer_state;
                    end
                end
            endcase
        end
    end

    always_comb begin
        coalescer_if.vload_type = LW;

        casez (coalescer_if.veew)
            SEW8:  coalescer_if.vload_type = LB;
            SEW16: coalescer_if.vload_type = LH;
            SEW32: coalescer_if.vload_type = LW;
        endcase
    end

    always_comb begin
        coalescer_if.vmemdwen_lsc = coalescer_if.vmemdwen & coalescer_if.vlane_mask[coalescer_if.vcurr_lane];
        coalescer_if.vmemdren_lsc = coalescer_if.vmemdren & coalescer_if.vlane_mask[coalescer_if.vcurr_lane];
        coalescer_if.vdata_store_lsc = coalescer_if.vlane_store_data[coalescer_if.vcurr_lane];

        if(coalescer_if.vseg_op) begin
            coalescer_if.vmemdwen_lsc = coalescer_if.vmemdwen & (coalescer_if.vlane_mask != 0); 
            coalescer_if.vmemdren_lsc = coalescer_if.vmemdren & (coalescer_if.vlane_mask != 0);
            coalescer_if.vdata_store_lsc = coalescer_if.vlane_store_data[0]; 
        end


    end 
    
endmodule // rv32v_mem_coalescer
