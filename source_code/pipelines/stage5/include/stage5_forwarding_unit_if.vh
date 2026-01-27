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
*   Filename:     stage5_forwarding_unit_if.vh
*   
*   Created by:   William Cunningham	
*   Email:        wrcunnin@purdue.edu
*   Date Created: 01/26/2026
*   Description:  Interface for the forwarding unit to to execute stage from mem/wb
*/

`ifndef __STAGE5_FORWARD_UNIT_VH__
`define __STAGE5_FORWARD_UNIT_VH__

interface stage5_forwarding_unit_if();
    import rv32i_types_pkg::*;

    // execute signals
    logic [4:0] rs1_e, rs2_e;

    // memory signals
    logic reg_write_m, store_m;
    logic [4:0] rs1_m, rs2_m, rd_m;
    word_t rd_m_data;

    // wb signals
    logic reg_write_wb;
    logic [4:0] rd_wb;
    word_t rd_wb_data;

    // forward unit signals
    logic [1:0] fwd_rs1_2ex;
    logic [1:0] fwd_rs2_2ex;
    logic       fwd_rs1_wb2mem;
    logic       fwd_rs2_wb2mem;

    modport execute(
        input fwd_rs1_2ex, fwd_rs2_2ex,
        rd_wb_data, rd_m_data,
        output rs1_e, rs2_e
    );

    modport mem(
        input fwd_rs1_wb2mem, fwd_rs2_wb2mem,
        output rs1_m, rs2_m, rd_m, reg_write_m, rd_m_data, store_m,
        rd_wb, reg_write_wb, rd_wb_data
    );

    modport fw_unit(
        // from execute
        input rs1_e, rs2_e,

        // from memory
        rs1_m, rs2_m, rd_m, reg_write_m, store_m,

        // from write back
        rd_wb, reg_write_wb,

        // from wb or mem to execute
        output fwd_rs1_2ex, fwd_rs2_2ex,

        // from wb to memory
        fwd_rs1_wb2mem, fwd_rs2_wb2mem
    );

endinterface
`endif
