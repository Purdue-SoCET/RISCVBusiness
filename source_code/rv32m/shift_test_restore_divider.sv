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
*   Filename:     shift_test_restore_divider.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 02/21/2017
*   Description:  NxN bit divider using the shift-test-restore algorithm
*/

module shift_test_restore_divider #(
    parameter int N = 32
) (
    input logic CLK,
    nRST,
    input logic [N-1:0] divisor,
    dividend,
    input logic is_signed,
    input logic start,
    output logic [N-1:0] remainder,
    quotient,
    output logic finished
);

    localparam int COUNTER_BITS = $clog2(N) + 1;
    localparam int U_Q = N - 1;
    localparam int U_R = (2 * N) - 1;

    logic [(2*N)+1:0] result;
    assign {remainder, quotient} = result[(2*N)-1:0];
    logic test_phase;
    logic [COUNTER_BITS-1:0] counter;
    logic [N-1:0] usign_divisor, usign_dividend;
    logic adjustment_possible, adjust_quotient, adjust_remainder;
    logic div_done;

    assign usign_divisor       = is_signed & divisor[N-1] ? (~divisor) + 1 : divisor;
    assign usign_dividend      = is_signed & dividend[N-1] ? (~dividend) + 1 : dividend;
    assign adjustment_possible = is_signed && (divisor[N-1] ^ dividend[N-1]);
    assign adjust_quotient     = adjustment_possible && ~quotient[N-1];
    assign adjust_remainder    = is_signed && dividend[N-1];
    assign div_done            = (counter == 0);

    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) begin
            result     <= '0;
            counter    <= N;
            test_phase <= 1'b0;
        end else if (start) begin
            result     <= {{(N - 1) {1'b0}}, usign_dividend, 1'b0};
            counter    <= N;
            test_phase <= 1'b0;
        end else if (counter > 0) begin
            if (~test_phase) begin  // shift and sub
                result[U_R+1-:N+1] <= result[U_R+1-:N+1] - usign_divisor;
            end else begin  // check result
                counter <= counter - 1;
                if (result[U_R+1])  // negative remainder, must restore
                    result <= {(result[U_R+1-:N+1] + usign_divisor), result[U_Q:0]} << 1;
                else result <= {result[U_R-1:0], 1'b1};
            end
            test_phase <= ~test_phase;
        end else if (~finished) begin
            if (adjust_quotient) result[U_Q:0] <= (~result[U_Q:0]) + 1;
            if (adjust_remainder) result[U_R-:N] <= (~result[U_R+1-:N]) + 1;
            //result[U_R-:N]  <= (~({result[U_R],result[U_R-:N-1]}))+1;
            else
                result[U_R-:N] <= result[U_R+1-:N];
        end
    end

    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) finished <= 1'b0;
        else if (start) finished <= 1'b0;
        else if (div_done) finished <= 1'b1;
    end

endmodule
