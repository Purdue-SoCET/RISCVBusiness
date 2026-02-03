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
    parameter int NFRAMES = 32, // Note: Requires power-of-two
    parameter int N_TAG_BITS = 8
)
(
    input logic CLK, nRST,
    predictor_pipeline_if.predictor predict_if
);
    import rv32i_types_pkg::*;

    localparam int N_SETS        = NFRAMES;
    localparam int N_SET_BITS    = $clog2(N_SETS) + (N_SETS == 1);
    localparam int N_IGNORE_BITS = WORD_SIZE - N_TAG_BITS - N_SET_BITS - 1;
    localparam int LOWER_BITS    = PRED_BITS > 1 ? PRED_BITS - 1 : 1;

    typedef struct packed {
        logic [N_TAG_BITS-1:0] tag;
        word_t target;
        logic [PRED_BITS-1:0] taken;
    } btb_frame_t;      // BTB frame

    typedef struct packed {
        logic [N_IGNORE_BITS-1:0] ignore_bits;
        logic [N_TAG_BITS-1:0] tag_bits;
        logic [N_SET_BITS-1:0] idx_bits;
        logic byte_bits; // PC is 2B-aligned
    } btb_addr_t;       // decoded curr PC type

    btb_frame_t [N_SETS-1:0] buffer;
    btb_addr_t curr_pc, update_pc;
    btb_frame_t selected_set, next_set, update_set;
    btb_frame_t selected_frame;

    assign curr_pc = predict_if.current_pc; // fetch stage PC, convert PC to decoded type
    assign update_pc = predict_if.pc_to_update; // memory stage PC
    assign selected_set = buffer[curr_pc.idx_bits];
    assign selected_frame = selected_set;
    assign update_set = buffer[update_pc.idx_bits];

    always_ff @(posedge CLK, negedge nRST) begin
        if(!nRST) begin
            buffer <= 0;
        end else begin
            buffer[update_pc.idx_bits] <= next_set;
        end
    end

    //BTB update logic WITH state machine implemented
    always_comb begin: update_logic
        next_set = buffer[update_pc.idx_bits];
        if(predict_if.update_predictor) begin
            next_set.tag = update_pc.tag_bits;
            next_set.target = predict_if.update_addr;

            // if more than one bits and have a tag match, update the set accordingly
            if (update_set.tag == update_pc.tag_bits) begin
                //  Saturating counter with better hysteresis
                case(update_set.taken[LOWER_BITS-1:0])
                    // Either in weakest taken or strongest not taken.
                    // For better hysteresis, we swap to strongest not taken if
                    // we mispredict and are in weakest taken.
                    '0 : next_set.taken = predict_if.branch_result ? update_set.taken + 1 : '0;

                    // Either in strongest taken or weakest not taken.
                    // For better hysteresis, we swap to strongest taken if
                    // we mispredict and are in weakest not taken
                    '1 : next_set.taken = predict_if.branch_result ? '1 : update_set.taken - 1;

                    // default saturating counter update
                    default: next_set.taken = predict_if.branch_result ? update_set.taken + 1 : update_set.taken - 1;
                endcase
            end else begin
                next_set.taken = predict_if.branch_result ? '1 : '0;
            end
        end
    end

    // get prediction
    always_comb begin : predict_logic
        predict_if.predict_taken = 0;

        // If we have a tag match,
        if (selected_set.tag == curr_pc.tag_bits) begin
            if (predict_if.is_branch)
                predict_if.predict_taken = selected_frame.taken[PRED_BITS-1];
            else if (predict_if.is_jump)
                predict_if.predict_taken = 1;
        end

        predict_if.target_addr = selected_frame.target;
    end
endmodule
