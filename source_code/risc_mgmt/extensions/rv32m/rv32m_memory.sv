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
*   Filename:     rv32n_memory.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 02/07/2017
*   Description:  Memory stage for standard RV32M extension
*                 This stage will do nothing.
*/

`include "risc_mgmt_memory_if.vh"

module rv32m_memory (
    input logic CLK,
    nRST,
    //risc mgmt connection
    risc_mgmt_memory_if.ext mif,
    //stage to stage connection
    input rv32m_pkg::execute_memory_t exmem
);

    //prevent this extension from accessing the core
    assign mif.exception = 1'b0;
    assign mif.busy = 1'b0;
    assign mif.reg_w = 1'b0;
    assign mif.mem_ren = 1'b0;
    assign mif.mem_wen = 1'b0;

endmodule
