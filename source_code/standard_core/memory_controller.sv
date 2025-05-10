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
*   Filename:     memory_controller.sv
*
*   Created by:   John Skubic
*   Modified by:  Chuan Yean Tan
*   Email:        jskubic@purdue.edu , tan56@purdue.edu
*   Date Created: 09/12/2016
*   Description:  Memory controller and arbitration between instruction
*                 and data accesses
*/

`include "component_selection_defines.vh"
`include "generic_bus_if.vh"
`include "bus_ctrl_if.vh"

module memory_controller #(
    parameter NUM_HARTS
) (
    input logic CLK,
    nRST,
    bus_ctrl_if.cc bcif,
    generic_bus_if.cpu out_gen_bus_if
);
    bus_ctrl #(.BLOCK_SIZE(2), .CPUS(NUM_HARTS * 2)) BUS_CTRL(
        .CLK(CLK),
        .nRST(nRST),
        .ccif(bcif)
    );

    always_comb begin
        out_gen_bus_if.addr = bus_ctrl_if.l2addr;
        out_gen_bus_if.byte_en = bus_ctrl_if.l2_byte_en;
        out_gen_bus_if.ren = bus_ctrl_if.l2REN;
        out_gen_bus_if.wen = bus_ctrl_if.l2WEN;
        out_gen_bus_if.wdata = bus_ctrl_if.l2store;

        bus_ctrl_if.l2load = out_gen_bus_if.rdata;
        bus_ctrl_if.l2state = out_gen_bus_if.busy ? L2_BUSY : L2_ACCESS;
        bus_ctrl_if.l2error = out_gen_bus_if.error;
    end
endmodule
