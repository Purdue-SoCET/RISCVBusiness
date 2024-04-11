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
    rv32v_mem_serializer_if.serial serial_if,
    output logic serializer_stall
);

    import rv32v_types_pkg::*;

    typedef enum logic [$clog2(NUM_LANES)-1:0] { VL0, VL1, VL2, VL3 } serial_state_t;

    serial_state_t serial_state, next_serial_state;
    word_t next_addr, next_next_addr, seg_addr, next_seg_addr;

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
            seg_addr <= '0; 
        end else begin
            serial_state <= next_serial_state;
            next_addr <= next_next_addr;
            seg_addr <= next_seg_addr; 
        end
    end

    logic[2:0] element_stride; 
    always_comb begin
        case(serial_if.veew)
            SEW8: element_stride = 1; 
            SEW16: element_stride = 2; 
            default: element_stride = 4; 
        endcase
    end 
    assign veew_bits = serial_if.veew; 
    always_comb begin
        next_serial_state = VL0;
        next_next_addr = next_addr;
        next_seg_addr = seg_addr; 
        serial_if.vcurr_lane = '0;
        serial_if.vaddr_lsc = '0;
        serializer_stall = 0; 
        if (serial_if.vmemdwen | serial_if.vmemdren) begin
            casez (serial_state)
                VL0: begin
                    //*** Normal Mem Operation ****// 
                    serializer_stall = 1; 
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
                    end else begin
                        next_serial_state = serial_state;
                    end

                    //***** Segmented Load/Store Operation *****// 
                    if(serial_if.vseg_op) begin
                        serializer_stall = 1'b1; 
                        next_next_addr = next_addr; 
                        next_seg_addr = seg_addr; 
                        // // next_seg_addr logic 
                        // if(serial_if.vnew_seg && (serial_if.vuop_num == 0)) begin
                        //     next_seg_addr = serial_if.base; 
                        // end
                        // else if(serial_if.vnew_seg && serial_if.strided)
                        //     next_seg_addr = seg_addr + serial_if.stride; 
                        // else if(serial_if.vnew_seg && serial_if.unit_strided)
                        //     next_seg_addr = next_addr;
                        
                        // serial_if.vaddr_lsc logic
                        if (serial_if.vindexed)
                            serial_if.vaddr_lsc = serial_if.vlane_addr[0];
                        else if(serial_if.vnew_seg && (serial_if.vuop_num == 0))
                            serial_if.vaddr_lsc = serial_if.base; 
                        else if(serial_if.vnew_seg && serial_if.strided)
                            serial_if.vaddr_lsc = seg_addr + serial_if.stride; 
                        else
                            serial_if.vaddr_lsc = next_addr;

                        // next_next_addr & next_seg logic 
                        if (serial_if.lsc_ready | (serial_if.vlane_mask == 0)) begin
                            // next_seg_addr logic 
                            if(serial_if.vnew_seg && (serial_if.vuop_num == 0)) begin
                                next_seg_addr = serial_if.base; 
                            end
                            else if(serial_if.vnew_seg && serial_if.strided)
                                next_seg_addr = seg_addr + serial_if.stride; 
                            else if(serial_if.vnew_seg && serial_if.unit_strided)
                                next_seg_addr = next_addr;

                            // next_next_addr
                            if(serial_if.vnew_seg)
                                next_next_addr = next_seg_addr + element_stride; // increment by element width in bytes 
                            else 
                                next_next_addr = next_addr + element_stride; // increment by element width in bytes 
                            
                            
                            serializer_stall = 1'b0; 
                        end 

                        // segment load/stores only happen in this state 
                        next_serial_state = VL0; 
                    end

                end
                VL1: begin
                    serializer_stall = 1; 
                    serial_if.vcurr_lane = 2'd1;
                    if (serial_if.vindexed) begin
                        serial_if.vaddr_lsc = serial_if.vlane_addr[1];
                    end else begin
                        serial_if.vaddr_lsc = next_addr;
                    end

                    if (serial_if.lsc_ready | ~serial_if.vlane_mask[1]) begin
                        next_next_addr = next_addr + serial_if.stride;
                        next_serial_state = VL2;
                    end else begin
                        next_serial_state = serial_state;
                    end
                end
                VL2: begin
                    serializer_stall = 1; 
                    serial_if.vcurr_lane = 2'd2;
                    if (serial_if.vindexed) begin
                        serial_if.vaddr_lsc = serial_if.vlane_addr[2];
                    end else begin
                        serial_if.vaddr_lsc = next_addr;
                    end

                    if (serial_if.lsc_ready | ~serial_if.vlane_mask[2]) begin
                        next_next_addr = next_addr + serial_if.stride;
                        next_serial_state = VL3;
                    end else begin
                        next_serial_state = serial_state;
                    end
                end
                VL3: begin
                    serializer_stall = 1; 
                    serial_if.vcurr_lane = 2'd3;
                    if (serial_if.vindexed) begin
                        serial_if.vaddr_lsc = serial_if.vlane_addr[3];
                    end else begin
                        serial_if.vaddr_lsc = next_addr;
                    end

                    if (serial_if.lsc_ready | ~serial_if.vlane_mask[3]) begin
                        next_next_addr = next_addr + serial_if.stride;
                        next_serial_state = VL0;
                        serializer_stall = 0; 
                    end else begin
                        next_serial_state = serial_state;
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

    always_comb begin
        serial_if.vmemdwen_lsc = serial_if.vmemdwen & serial_if.vlane_mask[serial_if.vcurr_lane];
        serial_if.vmemdren_lsc = serial_if.vmemdren & serial_if.vlane_mask[serial_if.vcurr_lane];
        serial_if.vdata_store_lsc = serial_if.vlane_store_data[serial_if.vcurr_lane];

        if(serial_if.vseg_op) begin
            serial_if.vmemdwen_lsc = serial_if.vmemdwen & (serial_if.vlane_mask != 0); 
            serial_if.vmemdren_lsc = serial_if.vmemdren & (serial_if.vlane_mask != 0);
            serial_if.vdata_store_lsc = serial_if.vlane_store_data[0]; 
        end


    end 
    
endmodule // rv32v_mem_serializer
