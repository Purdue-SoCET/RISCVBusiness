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
*   Filename:     dut_params.svh
*
*   Created by:   Mitch Arndt
*   Email:        arndt20@purdue.edu
*   Date Created: 03/27/2022
*   Description:  Hard coded configuration parameters for the DUT
*/

`ifndef DUT_PARAMS_SVH
`define DUT_PARAMS_SVH

// time in ns
`define CLK_PERIOD 10
// time in ps
`define PROPAGATION_DELAY #(2000);
// time in ps
`define MONITOR_DELAY #(3000);

`define NONCACHE_START_ADDR 32'h8000_0000

//32 bit addr - word offset - byte offset
`define BYTE_INDEX_BITS 2

// L2 Params
`define L1_BLOCK_SIZE 4
`define L1_CACHE_SIZE 2048
`define L1_ASSOC 2

`define L1_WORD_INDEX_BITS ($clog2(`L1_BLOCK_SIZE))
`define L1_FRAME_INDEX_BITS ($clog2((`L1_CACHE_SIZE / (32 / 8) ) / `L1_ASSOC / `L1_BLOCK_SIZE))
`define L1_INDEX_BITS (`L1_FRAME_INDEX_BITS + `L1_WORD_INDEX_BITS + `BYTE_INDEX_BITS)
`define L1_TAG_BITS (32 - `L1_INDEX_BITS)

`define L1_ADDR_IDX_END (`BYTE_INDEX_BITS+`L1_WORD_INDEX_BITS)
`define L1_ADDR_IDX_SIZE (32 - `L1_ADDR_IDX_END)

// L2 Params

`define L2_CACHE_SIZE 4096
`define L2_BLOCK_SIZE 4
`define L2_ASSOC 4

`endif
