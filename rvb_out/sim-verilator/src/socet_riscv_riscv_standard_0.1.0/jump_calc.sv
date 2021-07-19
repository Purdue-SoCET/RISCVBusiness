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
*   Filename:     jump_calc.sv
*
*   Created by:   Jacob R. Stevens
*   Email:        steven69@purdue.edu
*   Date Created: 06/15/2016
*   Description:  A simple adder for calculating branch targets
*/

`include "jump_calc_if.vh"

module jump_calc (
    jump_calc_if.jump_calc jump_if
);

    import rv32i_types_pkg::*;

    word_t jump_addr;
    assign jump_addr = jump_if.base + jump_if.offset;

    assign jump_if.jal_addr = jump_addr;
    assign jump_if.jalr_addr = {jump_addr[31:1], 1'b0};

endmodule
