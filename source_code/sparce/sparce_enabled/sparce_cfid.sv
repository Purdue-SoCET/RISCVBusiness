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
*   Filename:     sparce_cfid.sv
*
*   Created by:   Wengyan Chan
*   Email:        cwengyan@purdue.edu
*   Date Created: Oct 1st, 2019
*   Description:  The file containing the control flow instruction detector.
*/

//  modport cfid (
//    output ctrl_flow_enable,
//    input rdata
//  );

`include "sparce_internal_if.vh"

module sparce_cfid (
    sparce_internal_if.cfid cfid_if
);
    import rv32i_types_pkg::*;

    opcode_t cf_op;
    assign cf_op = opcode_t'(cfid_if.rdata[OP_W-1:0]);

    always_comb begin
        if (cf_op == BRANCH || cf_op == JAL || cf_op == JALR) cfid_if.ctrl_flow_enable = 0;
        else cfid_if.ctrl_flow_enable = 1;
    end

endmodule

