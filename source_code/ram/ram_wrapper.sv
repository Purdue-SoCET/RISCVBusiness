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
*   Filename:     ram_wrapper.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 06/01/2016
*   Description:  Ram wrapper should contain the ram module provided by the
*                 simulation environment being used. If no ram modules are
*                 provided, an emulated ram module must be created.
*/

`include "generic_bus_if.vh"
`include "component_selection_defines.vh"

module ram_wrapper (
    input logic CLK,
    nRST,
    generic_bus_if.generic_bus gen_bus_if
);
    import rv32i_types_pkg::*;

    logic [RAM_ADDR_SIZE-3:0] word_addr;
    assign word_addr = gen_bus_if.addr[WORD_SIZE-1:2];

    ram_sim_model #(
        .LAT(0),
        .ENDIANNESS(BUS_ENDIANNESS),
        .N_BYTES(4)
    ) v_lat_ram (
        .CLK(CLK),
        .nRST(nRST),
        .wdata_in(gen_bus_if.wdata),
        .addr_in(word_addr),
        .byte_en_in(gen_bus_if.byte_en),
        .wen_in(gen_bus_if.wen),
        .ren_in(gen_bus_if.ren),
        .rdata_out(gen_bus_if.rdata),
        .busy_out(gen_bus_if.busy)
    );

endmodule
