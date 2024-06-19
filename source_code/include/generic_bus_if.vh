/*
*		Copyright 2016 Purdue University
*		
*		Licensed under the Apache License, Version 2.0 (the "License");
*		you may not use this file except in compliance with the License.
*		You may obtain a copy of the License at
*		
*		    http://www.apache.org/licenses/LICENSE-2.0
*		
*		Unless required by applicable law or agreed to in writing, software
*		distributed under the License is distributed on an "AS IS" BASIS,
*		WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*		See the License for the specific language governing permissions and
*		limitations under the License.
*
*
*		Filename:     generic_bus_if.vh
*
*		Created by:   John Skubic
*		Email:        jskubic@purdue.edu
*		Date Created: 06/01/2016
*		Description:  Interface for connecting a requestor to ram.	
*/

`ifndef GENERIC_BUS_IF_VH
`define GENERIC_BUS_IF_VH

interface generic_bus_if ();
  import rv32i_types_pkg::*;

  logic [RAM_ADDR_SIZE-1:0] addr;
  word_t wdata;
  word_t rdata;
  word_t [DCACHE_BLOCK_SIZE-1:0] wdata_wide;
  word_t [DCACHE_BLOCK_SIZE-1:0] rdata_wide;
  logic ren,wen,wen_wide;
  logic busy;
  logic error;
  logic [3:0] byte_en;
  logic [((DCACHE_BLOCK_SIZE*WORD_SIZE)-1):0] byte_en_wide;

  modport generic_bus (
    input addr, ren, wen, wen_wide, wdata, wdata_wide, byte_en, byte_en_wide,
    output rdata, rdata_wide, busy, error
  );

  modport cpu (
    input rdata, rdata_wide, busy, error,
    output addr, ren, wen, wen_wide, wdata, wdata_wide, byte_en, byte_en_wide
  );

endinterface

`endif //GENERIC_BUS_IF_VH
