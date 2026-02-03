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
*   Filename:     branch_tracker.sv
*
*   Created by:   Jacob R. Stevens
*   Email:        steven69@purdue.edu
*   Date Created: 09/26/2016
*   Description:  Track performance stats associated with branch prediction
*/
`define STATS_FILE_NAME "stats.txt"
module branch_tracker (
    input logic CLK,
    nRST,
    input logic update_predictor,
    input logic direction,
    input logic prediction,
    input logic branch_result,
    input logic is_jalr
);
    // Branch Performance Signals
    logic [63:0]
    unconditional_count,
        prediction_count,
        misprediction_count,
        correct_pred_count,
        pred_taken_count,
        pred_not_taken_count,
        taken_incorrect_count,
        not_taken_incorrect_count,
        forward_branch_count,
        forward_pred_taken_count,
        forward_taken_correct_count,
        forward_not_taken_correct_count,
        backward_branch_count,
        backward_pred_taken_count,
        backward_taken_correct_count,
        backward_not_taken_correct_count;

    always_ff @(posedge CLK, negedge nRST) begin : tracked_registers
        if (!nRST) begin
        unconditional_count <= '0;
            prediction_count <= '0;
            misprediction_count <= '0;
            correct_pred_count <= '0;
            pred_taken_count <= '0;
            pred_not_taken_count <= '0;
            taken_incorrect_count <= '0;
            not_taken_incorrect_count <= '0;
            forward_branch_count <= '0;
            forward_pred_taken_count <= '0;
            forward_taken_correct_count <= '0;
            forward_not_taken_correct_count <= '0;
            backward_branch_count <= '0;
            backward_pred_taken_count <= '0;
            backward_taken_correct_count <= '0;
            backward_not_taken_correct_count <= '0;
        end else if (is_jalr) begin
       // if jump instruction, update unconditional counter
       unconditional_count <= unconditional_count + 1;
    end else if (update_predictor & !prediction & !branch_result) begin
            // Predicted not taken and branch result is not taken
            prediction_count <= prediction_count + 1;
            correct_pred_count <= correct_pred_count + 1;
            pred_not_taken_count <= pred_not_taken_count + 1;
            if (direction) begin
                backward_branch_count <= backward_branch_count + 1;
                backward_not_taken_correct_count <= backward_not_taken_correct_count + 1;
            end else begin
                forward_branch_count <= forward_branch_count + 1;
                forward_not_taken_correct_count <= forward_not_taken_correct_count + 1;
            end
        end else if (update_predictor & !prediction & branch_result) begin
            // Predicted not taken and branch result is taken
            prediction_count <= prediction_count + 1;
            misprediction_count <= misprediction_count + 1;
            pred_not_taken_count <= pred_not_taken_count + 1;
            not_taken_incorrect_count <= not_taken_incorrect_count + 1;
            if (direction) begin
                backward_branch_count <= backward_branch_count + 1;
            end else begin
                forward_branch_count <= forward_branch_count + 1;
            end
        end else if (update_predictor & prediction & !branch_result) begin
            // Predicted taken and branch result is not taken
            prediction_count <= prediction_count + 1;
            misprediction_count <= misprediction_count + 1;
            pred_taken_count <= pred_taken_count + 1;
            taken_incorrect_count <= taken_incorrect_count + 1;
            if (direction) begin
                backward_branch_count <= backward_branch_count + 1;
                backward_pred_taken_count <= backward_pred_taken_count + 1;
            end else begin
                forward_branch_count <= forward_branch_count + 1;
                forward_pred_taken_count <= forward_pred_taken_count + 1;
            end
        end else if (update_predictor & prediction & branch_result) begin
            // Predicted taken and branch result is taken
            prediction_count   <= prediction_count + 1;
            correct_pred_count <= correct_pred_count + 1;
            pred_taken_count   <= pred_taken_count + 1;
            if (direction) begin
                backward_branch_count <= backward_branch_count + 1;
                backward_pred_taken_count <= backward_pred_taken_count + 1;
                backward_taken_correct_count <= backward_taken_correct_count + 1;
            end else begin
                forward_branch_count <= forward_branch_count + 1;
                forward_pred_taken_count <= forward_pred_taken_count + 1;
                forward_taken_correct_count <= forward_taken_correct_count + 1;
            end
        end
    end : tracked_registers

    final begin : OUTPUT_STATS
        integer stats_fptr;
        stats_fptr = $fopen(`STATS_FILE_NAME, "a");
        $fwrite(stats_fptr, "Branch Stats:\n");
        $fwrite(stats_fptr, "Unconditional branches predicted: %2d\n", unconditional_count);
        $fwrite(stats_fptr, "Conditional branches predicted: %2d\n", prediction_count);
        $fwrite(stats_fptr, "Conditional branches predicted incorrectly: %2d\n",
                misprediction_count);
        $fwrite(stats_fptr, "Conditional branches predicted correctly: %2d\n", correct_pred_count);
        $fwrite(stats_fptr, "Branch prediction accuracy: %5f\n",
                real'(correct_pred_count) / prediction_count);
        $fwrite(stats_fptr, "Branches predicted as taken: %2d\n", pred_taken_count);
        $fwrite(stats_fptr, "Branches predicted as taken, incorrect: %2d\n", taken_incorrect_count);
        $fwrite(stats_fptr, "Branches predicted as taken, correct: %2d\n",
                pred_taken_count - taken_incorrect_count);
        $fwrite(stats_fptr, "Branches predicted as not taken: %2d\n", pred_not_taken_count);
        $fwrite(stats_fptr, "Branches predicted as not taken, incorrect: %2d\n",
                not_taken_incorrect_count);
        $fwrite(stats_fptr, "Branches predicted as not taken, correct: %2d\n",
                pred_not_taken_count - not_taken_incorrect_count);
        $fwrite(stats_fptr, "----------------------------------------------\n");
        $fwrite(stats_fptr, "Forward branches predicted: %2d\n", forward_branch_count);
        $fwrite(stats_fptr, "Forward branches predicted as taken: %2d\n", forward_pred_taken_count);
        $fwrite(stats_fptr, "Forward branches predicted as taken, incorrect: %2d\n",
            forward_pred_taken_count - forward_taken_correct_count);
        $fwrite(stats_fptr, "Forward branches predicted as taken, correct: %2d\n", forward_taken_correct_count);
        $fwrite(stats_fptr, "Forward branches predicted as not taken: %2d\n",
            forward_branch_count - forward_pred_taken_count);
        $fwrite(stats_fptr, "Forward branches predicted as not taken, incorrect: %2d\n",
            forward_branch_count - forward_pred_taken_count - forward_not_taken_correct_count);
        $fwrite(stats_fptr, "Forward branches predicted as not taken, correct: %2d\n", forward_not_taken_correct_count);
        $fwrite(stats_fptr, "----------------------------------------------\n");
        $fwrite(stats_fptr, "Backward branches predicted: %2d\n", backward_branch_count);
        $fwrite(stats_fptr, "Backward branches predicted as taken: %2d\n", backward_pred_taken_count);
        $fwrite(stats_fptr, "Backward branches predicted as taken, incorrect: %2d\n",
            backward_pred_taken_count - backward_taken_correct_count);
        $fwrite(stats_fptr, "Backward branches predicted as taken, correct: %2d\n", backward_taken_correct_count);
        $fwrite(stats_fptr, "Backward branches predicted as not taken: %2d\n",
            backward_branch_count - backward_pred_taken_count);
        $fwrite(stats_fptr, "Backward branches predicted as not taken, incorrect: %2d\n",
            backward_branch_count - backward_pred_taken_count - backward_not_taken_correct_count);
        $fwrite(stats_fptr, "Backward branches predicted as not taken, correct: %2d\n\n",
            backward_not_taken_correct_count);
        $fclose(stats_fptr);

        fb_total: assert (prediction_count == forward_branch_count + backward_branch_count);
        nt_total: assert (prediction_count == pred_taken_count + pred_not_taken_count);
    end : OUTPUT_STATS
endmodule
