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
*   Filename:     stage5_forwarding_unit.sv
*
*   Created by:   William Cunningham
*   Email:        wrcunnin@purdue.edu
*   Date Created: 01/26/2026
*   Description:  Forwarding unit for the Five Stage Pipeline
*/

module stage5_forwarding_unit (
    stage5_forwarding_unit_if.fw_unit fw_if
);

    logic rs1_match_mem2ex, rs2_match_mem2ex;
    logic rs1_match_wb2ex, rs2_match_wb2ex;
    logic rs1_match_wb2mem;

    // ****************************************
    // to execute stage
    assign rs1_match_mem2ex = (fw_if.rd_m != 0) && (fw_if.rs1_e == fw_if.rd_m);
    assign rs2_match_mem2ex = (fw_if.rd_m != 0) && (fw_if.rs2_e == fw_if.rd_m);
    assign rs1_match_wb2ex = (fw_if.rd_wb != 0) && (fw_if.rs1_e == fw_if.rd_wb);
    assign rs2_match_wb2ex = (fw_if.rd_wb != 0) && (fw_if.rs2_e == fw_if.rd_wb);

    // TODO(wrcunnin): prevent load-use here? perhaps.
    //                 going to stall d/ex if load use occurs.
    assign fw_if.fwd_rs1_2ex[0] = rs1_match_mem2ex && fw_if.reg_write_m;
    assign fw_if.fwd_rs2_2ex[0] = rs2_match_mem2ex && fw_if.reg_write_m;
    assign fw_if.fwd_rs1_2ex[1] = rs1_match_wb2ex && fw_if.reg_write_wb;
    assign fw_if.fwd_rs2_2ex[1] = rs2_match_wb2ex && fw_if.reg_write_wb;

    // ****************************************
    // to memory stage
    assign rs1_match_wb2mem = (fw_if.rd_wb != 0) && (fw_if.rs1_m == fw_if.rd_wb);

    // only going to forward from wb if mem is going to use the register & is a store
    assign fw_if.fwd_rs1_wb2mem = rs1_match_wb2mem && fw_if.reg_write_wb && fw_if.store_m;


endmodule
