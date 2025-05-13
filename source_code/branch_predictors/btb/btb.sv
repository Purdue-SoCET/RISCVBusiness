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
 *   Filename:     btb.sv
 *
 *   Created by:   Yueting Zhao
 *   Email:        zhao979@purdue.edu
 *   Date Created: 07/07/2023
 *   Description:  Branch target buffer that caches target address and predicted branch direction. 
 */

`include "predictor_pipeline_if.vh"

module btb #(
    parameter int PRED_BITS = 1,
    parameter int NFRAMES = 32
)
(
    input logic CLK, nRST,
    predictor_pipeline_if.predictor predict_if
);
    import rv32i_types_pkg::*;

    localparam ASSOC        = 2;
    localparam N_SETS       = NFRAMES / ASSOC;
    localparam N_TAG_BITS   = 8 - PRED_BITS;
    localparam N_SET_BITS   = $clog2(N_SETS) + (N_SETS == 1);
    localparam N_IGNORE_BITS = WORD_SIZE - N_TAG_BITS - N_SET_BITS - 2;

    typedef struct packed {
        logic [N_TAG_BITS-1:0] tag;
        word_t target;
        logic [PRED_BITS-1:0]taken;
    } btb_frame_t;      // BTB frame

    typedef struct packed {
        logic [N_IGNORE_BITS-1:0] ignore_bits;
        logic [N_TAG_BITS-1:0] tag_bits;
        logic [N_SET_BITS-1:0] idx_bits;
        logic [1:0] byte_bits;
    } btb_addr_t;       // decoded curr PC type

    btb_frame_t [N_SETS-1:0] buffer;
    btb_addr_t curr_pc, update_pc;
    btb_frame_t selected_set, next_set, update_set;
    btb_frame_t selected_frame; 

    assign curr_pc = predict_if.current_pc; // convert PC to decoded type
    assign update_pc = predict_if.pc_to_update;
    assign selected_set = buffer[curr_pc.idx_bits];
    assign selected_frame = selected_set;
    assign update_set = buffer[update_pc.idx_bits];
    
    always_ff @(posedge CLK, negedge nRST) begin
        if(!nRST) begin
            buffer <= '0;
        end else begin
            buffer[update_pc.idx_bits] <= next_set; 
        end
    end

    // Struct defining 4 states for updates logic
    typedef enum logic [1:0] {
        SNT = 2'b00,//Strongly Not Taken
        WNT = 2'b01, //Weakly Not Taken
        ST = 2'b11, //Stronly Taken
        WT = 2'b10 //Weakly Taken
    } state_t;

    //BTB update logic WITH state machine implemented
    always_comb begin: update_logic
        next_set = buffer[update_pc.idx_bits];
        if(predict_if.update_predictor) begin
            next_set.tag = update_pc.tag_bits;
            next_set.target = predict_if.update_addr;
            case(update_set.taken) 
                SNT: next_set.taken = predict_if.branch_result ? WNT : SNT; 
                WNT: next_set.taken = predict_if.branch_result ? ST : SNT; 
                ST: next_set.taken = predict_if.branch_result ? ST : WT; 
                WT: next_set.taken = predict_if.branch_result ? ST : SNT; 
                default: next_set.taken = SNT;
            endcase
        end
    end

    // get prediction
    always_comb begin : predict_logic
        if(selected_set.tag != curr_pc.tag_bits) begin
            // current PC not in buffer: predict not taken, 
            predict_if.predict_taken = 0;
            predict_if.target_addr = predict_if.is_rv32c ? predict_if.current_pc + 2 : predict_if.current_pc + 4;
            end
        else begin
            // if using 2 bit predictor:
            // 00 - strongly NT, 01 - NT, 11 - strongly T, 10 - T
            predict_if.predict_taken = (predict_if.is_branch)? selected_frame.taken[PRED_BITS-1] : 0;
            predict_if.target_addr = predict_if.predict_taken ? selected_frame.target
                                    : predict_if.is_rv32c ? predict_if.current_pc + 2
                                    : predict_if.current_pc + 4;
        end 
    end
endmodule
