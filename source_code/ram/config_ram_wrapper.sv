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
*   Filename:     config_ram_wrapper.sv
*
*   Created by:   John Skubic	
*   Email:        jskubic@purdue.edu
*   Date Created: 06/01/2016
*   Description:  Config Ram wrapper should contain the ram module provided by the
*                 simulation environment being used. If no ram modules are
*                 provided, an emulated ram module must be created.
*                 Config ram differs from ram wrapper in that it is not restricted
*                 to the word size of the core.  For that reason, no interface is
*                 used for config_ram_wrapper to preserve its flexibility.
*/

module config_ram_wrapper #(
    parameter N_BYTES   = 4,
    parameter DEPTH     = 256,
    parameter LAT       = 0,
    parameter ADDR_BITS = $clog2(DEPTH),
    parameter N_BITS    = N_BYTES * 8
) (
    input logic CLK,
    nRST,
    input logic [N_BITS-1:0] wdata,
    input logic [ADDR_BITS-1:0] addr,
    input logic [N_BYTES-1:0] byte_en,
    input logic wen,
    ren,
    output logic [N_BITS-1:0] rdata,
    output logic busy
);

    ram_sim_model #(
        .LAT(0),
        .ENDIANNESS("little"),
        .N_BYTES(N_BYTES),
        .DEPTH(DEPTH)
    ) v_lat_ram (
        .CLK(CLK),
        .nRST(nRST),
        .wdata_in(wdata),
        .addr_in(addr),
        .byte_en_in(byte_en),
        .wen_in(wen),
        .ren_in(ren),
        .rdata_out(rdata),
        .busy_out(busy)
    );

endmodule
