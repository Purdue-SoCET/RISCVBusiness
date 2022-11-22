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
*   Filename:     priv_wrapper.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 05/18/2017
*   Description:  Top level wrapper for the priv ISA implementation.
*/

`include "prv_pipeline_if.vh"
`include "core_interrupt_if.vh"

module priv_wrapper (
    input logic CLK, nRST,
    input logic [63:0] mtime,
    prv_pipeline_if.priv_block prv_pipe_if,
    core_interrupt_if.core interrupt_if
);

    priv_1_12_block priv_block_i(.*);

endmodule
