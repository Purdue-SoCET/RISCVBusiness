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
*   Filename:     pass_through_cache.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 06/01/2016
*   Description:  Pass Through Cache
*/

`include "generic_bus_if.vh"

module pass_through_cache (
    input logic CLK,
    nRST,
    generic_bus_if.cpu mem_gen_bus_if,
    generic_bus_if.generic_bus proc_gen_bus_if
);

    //passthrough layer
    assign mem_gen_bus_if.addr    = proc_gen_bus_if.addr;
    assign mem_gen_bus_if.ren     = proc_gen_bus_if.ren;
    assign mem_gen_bus_if.wen     = proc_gen_bus_if.wen;
    assign mem_gen_bus_if.wdata   = proc_gen_bus_if.wdata;
    assign mem_gen_bus_if.byte_en = proc_gen_bus_if.byte_en;

    assign proc_gen_bus_if.rdata  = mem_gen_bus_if.rdata;
    assign proc_gen_bus_if.busy   = mem_gen_bus_if.busy;

endmodule
