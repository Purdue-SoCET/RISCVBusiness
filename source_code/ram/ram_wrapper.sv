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
`include "component_selection_defines.vh"

module ram_wrapper #(
    parameter int N_BYTES = 4
)(
    input logic CLK,
    nRST,
    bus_if.response bus
);
    import rv32i_types_pkg::*;

    logic [RAM_ADDR_SIZE-3:0] word_addr;
    logic busy;
    logic [N_BYTES-1:0] mask;

    logic wen;
    logic ren;

    assign wen = (bus.trans == bus_pkg::NONSEQ || bus.trans == bus_pkg::SEQ) & bus.write_enable;
    assign ren = (bus.trans == bus_pkg::NONSEQ || bus.trans == bus_pkg::SEQ) & ~bus.write_enable;

    assign word_addr = bus.addr[WORD_SIZE-1:2];
    assign bus.error = (bus.addr < 32'h8000_0000);
    assign mask = { bus.size[1], bus.size[1], |bus.size[1:0], 1'b1 } << (bus.addr[1:0] >> bus.size);
    
    ram_sim_model #(
        .LAT(0),
        .ENDIANNESS(BUS_ENDIANNESS),
        .N_BYTES(N_BYTES)
    ) v_lat_ram (
        .CLK(CLK),
        .nRST(nRST),
        .wdata_in(bus.wdata),
        .addr_in(word_addr),
        .byte_en_in(mask),
        .wen_in(wen),
        .ren_in(ren),
        .rdata_out(bus.rdata),
        .busy_out(bus.busy)
    );

endmodule
