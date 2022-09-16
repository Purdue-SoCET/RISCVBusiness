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
*   Filename:     sparce_wrapper.sv
*
*   Created by:   Vadim V. Nikiforov
*   Email:        vnikifor@purdue.edu
*   Date Created: 04/17/2019
*   Description:  The top level wrapper file for implementations of
*                 sparisity optimiations based on the SparCE paper
*/

`include "sparce_pipeline_if.vh"
`include "component_selection_defines.vh"

module sparce_wrapper (
    input logic CLK,
    nRST,
    sparce_pipeline_if.sparce sparce_if
);

    // Sparsity blocks used based on the SPARCE_ENABLED definition
    generate
        case (SPARCE_ENABLED)
            "disabled": sparce_disabled sparce (.*);
            "enabled":  sparce_enabled sparce (.*);
        endcase
    endgenerate

endmodule

