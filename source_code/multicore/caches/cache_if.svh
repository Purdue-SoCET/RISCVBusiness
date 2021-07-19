/*
*   Copyright 2022 Purdue University
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
*   Filename:     cache_if.svh
*
*   Created by:   Mitch Arndt
*   Email:        arndt20@purdue.edu
*   Date Created: 04/03/2022
*   Description:  Bundles cache signals into one interface for each of passing in UVM DB
*/

`ifndef CACHE_IF_SVH
`define CACHE_IF_SVH

interface cache_if(
    input logic CLK
);
    logic nRST;
    logic clear, flush;
    logic clear_done, flush_done;

    modport driver
    (
        output nRST,
        output clear, flush,
        input CLK, clear_done, flush_done
    ); 
   
    modport cache
    (
        input clear, flush, CLK, nRST,
        output clear_done, flush_done
    ); 
endinterface

`endif
