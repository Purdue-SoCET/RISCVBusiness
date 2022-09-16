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
*   Filename:     sparce_enabled.sv
*
*   Created by:   Vadim V. Nikiforov
*   Email:        vnikifor@purdue.edu
*   Date Created: 04/29/2019
*   Description:  The top level file for sparsity enabled for the CPU
*/

`include "sparce_pipeline_if.vh"
`include "sparce_internal_if.vh"

module sparce_enabled (
    input logic CLK,
    nRST,
    sparce_pipeline_if.sparce sparce_if
);

    sparce_internal_if internal_if ();

    // assign inputs to the internal modules
    assign internal_if.pc = sparce_if.pc;
    assign internal_if.wb_data = sparce_if.wb_data;
    assign internal_if.wb_en = sparce_if.wb_en;
    assign internal_if.sasa_data = sparce_if.sasa_data;
    assign internal_if.sasa_addr = sparce_if.sasa_addr;
    assign internal_if.sasa_wen = sparce_if.sasa_wen;
    assign internal_if.rd = sparce_if.rd;
    assign internal_if.sasa_enable = sparce_if.if_ex_enable;
    assign internal_if.rdata = sparce_if.rdata;

    // assign to sparce module outputs
    assign sparce_if.skipping = internal_if.skipping;
    assign sparce_if.sparce_target = internal_if.sparce_target;

    // instantiate internal modules
    sparce_svc sparce_svc_i (internal_if.svc);
    sparce_sprf sparce_sprf_i (
        CLK,
        nRST,
        internal_if.sprf
    );
    sparce_sasa_table #(
        .SASA_SETS(4)
    ) sparce_sasa_table_i (
        CLK,
        nRST,
        internal_if.sasa_table
    );
    sparce_psru sparce_psru_i (internal_if.psru);
    sparce_cfid sparce_cfid_i (internal_if.cfid);


endmodule
