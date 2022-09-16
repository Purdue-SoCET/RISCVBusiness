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
*   Filename:     nottaken_predictor.sv
*
*   Created by:   Jacob R. Stevens
*   Email:        steven69@purdue.edu
*   Date Created: 11/07/2016
*   Description:  A simple branch predictor that always predicts not taken
*/

`include "predictor_pipeline_if.vh"

module nottaken_predictor (
    input logic CLK,
    nRST,
    predictor_pipeline_if.predictor predict_if
);

    assign predict_if.predict_taken = 0;
    assign predict_if.target_addr   = predict_if.current_pc + 4;

endmodule
