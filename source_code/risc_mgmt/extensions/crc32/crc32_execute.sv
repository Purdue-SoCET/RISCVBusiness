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
*   Filename:     crc32_execute.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 02/07/2017
*   Description:  Execute stage for the crc32 ISA extension.
*/

`include "risc_mgmt_execute_if.vh"

module crc32_execute (
    input logic CLK,
    nRST,
    //risc mgmt connection
    risc_mgmt_execute_if.ext eif,
    //stage to stage connection
    input crc32_pkg::decode_execute_t idex,
    output crc32_pkg::execute_memory_t exmem
);

    import rv32i_types_pkg::*;

    logic [7:0] in_byte;
    logic reset, new_byte, done;
    word_t result;

    //prevent this extension from accessing the core
    assign eif.exception   = 1'b0;
    assign eif.branch_jump = 1'b0;

    // Instantiation of CRC calculation block
    crc32 CRC32 (.*);

    assign new_byte = eif.start & idex.new_byte;
    assign reset    = idex.reset;
    assign in_byte  = eif.rdata_s_0[7:0];
    assign eif.busy = ~done;
    assign eif.reg_w = idex.new_byte & done;
    assign eif.reg_wdata = result;

endmodule
