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
*   Filename:     stage5_mem_wb_if.vh
*   
*   Created by:   William Cunningham	
*   Email:        wrcunnin@purdue.edu
*   Date Created: 01/26/2026
*   Description:  Interface between the execute and memory pipeline stages
*/

`ifndef __STAGE5_MEM_WB_IF__
`define __STAGE5_MEM_WB_IF__

interface stage5_mem_wb_if();

    import rv32i_types_pkg::*;
    import stage5_types_pkg::*;

    word_t brj_addr;
    word_t pc4;
    mem_wb_t mem_wb_reg;

    modport fetch(
        input brj_addr, pc4
    );

    modport decode(
        input mem_wb_reg
    );

    modport mem(
        output brj_addr, pc4, mem_wb_reg
    );

endinterface
`endif
