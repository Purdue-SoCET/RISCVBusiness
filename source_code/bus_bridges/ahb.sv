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
*   Filename:    ahb_master.sv
*
*   Created by:   Chuan Yean Tan
*   Email:        tan56@purdue.edu
*   Date Created: 08/31/2016
*   Description: Processes read & write request into AHB-Lite protocol
*   TODO: 1. HRESP -> has to be added to the state transitions
*/

`include "generic_bus_if.vh"

module ahb (
    input CLK,
    nRST,
    ahb_if.ahb_m ahb_m,
    generic_bus_if.generic_bus out_gen_bus_if
);

    typedef enum logic {
        IDLE,
        DATA
    } state_t;

    state_t state, n_state;

    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) state <= IDLE;
        else state <= n_state;
    end

    always_comb begin
        if ((state == DATA) & !(ahb_m.HREADY)) n_state = state;
        else n_state = out_gen_bus_if.ren | out_gen_bus_if.wen ? DATA : IDLE;
    end

    always_comb begin
        if (out_gen_bus_if.byte_en == 4'b1111) ahb_m.HSIZE = 3'b010;  // word
        else if (out_gen_bus_if.byte_en == 4'b1100 || out_gen_bus_if.byte_en == 4'b0011)
            ahb_m.HSIZE = 3'b001;  // half word
        else ahb_m.HSIZE = 3'b000;  // byte
    end

    always_comb begin
        if (out_gen_bus_if.ren) begin
            ahb_m.HTRANS = 2'b10;
            ahb_m.HWRITE = 1'b0;
            ahb_m.HADDR = out_gen_bus_if.addr;
            ahb_m.HWDATA = out_gen_bus_if.wdata;
            ahb_m.HBURST = 0;
            ahb_m.HPROT = 0;
            ahb_m.HMASTLOCK = 0;
        end else if (out_gen_bus_if.wen) begin
            ahb_m.HTRANS = 2'b10;
            ahb_m.HWRITE = 1'b1;
            ahb_m.HADDR = out_gen_bus_if.addr;
            ahb_m.HWDATA = out_gen_bus_if.wdata;
            ahb_m.HBURST = 0;
            ahb_m.HPROT = 0;
            ahb_m.HMASTLOCK = 0;
        end else begin
            ahb_m.HTRANS = 2'b0;
            ahb_m.HWRITE = 1'b0;
            ahb_m.HADDR = 0;
            ahb_m.HWDATA = out_gen_bus_if.wdata;
            ahb_m.HBURST = 0;
            ahb_m.HPROT = 0;
            ahb_m.HMASTLOCK = 0;
        end

        if (state == DATA) begin
            ahb_m.HWDATA = out_gen_bus_if.wdata;
        end
    end


    assign out_gen_bus_if.busy  = state == IDLE || ~((ahb_m.HREADY && (state == DATA)));
    assign out_gen_bus_if.rdata = ahb_m.HRDATA;

endmodule
