/*
*   Copyright 2019 Purdue University
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
*   Filename:     sparce_disabled.sv
*
*   Created by:   Vadim V. Nikiforov
*   Email:        vnikifor@purdue.edu
*   Date Created: 04/29/2019
*   Description:  The top level file for a CPU without sparsity optimizations
*                 enabled
*/

`include "sparce_pipeline_if.vh"

module sparce_disabled (
    input logic CLK,
    nRST,
    sparce_pipeline_if.sparce sparce_if
);

    // when disabled, sparce should never force the pipeline to skip

    // all inputs are to be ignored
    assign sparce_if.skipping = 1'b0;
    assign sparce_if.sparce_target = '0;


endmodule
