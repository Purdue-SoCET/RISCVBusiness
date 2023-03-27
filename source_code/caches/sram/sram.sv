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
*   Filename:     sram.sv
*
*   Created by:   Jimmy Mingze Jin
*   Email:        jin357@purdue.edu
*   Date Created: 01/29/2023
*   Description:  SRAM dummy module
*                   - w/r size in bits
*/

module sram #(
    parameter SRAM_WR_SIZE = 128,
    parameter SRAM_HEIGHT = 128
)
(
    input logic                     CLK, nRST,
    input logic [SRAM_WR_SIZE-1:0]  wVal,
    output logic [SRAM_WR_SIZE-1:0] rVal,
    input logic                     REN, WEN,
    input logic [$clog2(SRAM_HEIGHT)-1:0] SEL,
    input logic [SRAM_WR_SIZE-1:0] wMask
);
    typedef logic [SRAM_WR_SIZE-1:0] sram_entry_size_t;
    sram_entry_size_t [SRAM_HEIGHT-1:0] sramMemory; 
    sram_entry_size_t [SRAM_HEIGHT-1:0] n_sramMemory;

    always_ff @(negedge CLK, negedge nRST) begin
        if (!nRST)
            sramMemory <= 0;
        else
            sramMemory <= n_sramMemory;
    end

    always_comb begin
        n_sramMemory = sramMemory;
        rVal = 32'hBAD0BAD0;
        if (WEN)
            n_sramMemory[SEL] = (wVal & ~wMask) | (wMask & sramMemory[SEL]);
        if (REN)
            rVal = sramMemory[SEL];
    end
endmodule