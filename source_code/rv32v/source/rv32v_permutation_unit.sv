/*
*   Copyright 2024 Purdue University
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
*   Filename:     rv32v_permutation_unit.sv
*
*   Created by:   Maxwell Michalec
*   Email:        michalem@purdue.edu
*   Date Created: 03/19/2024
*   Description:  rv32v permutation unit
*/

module rv32v_permutation_unit (
    input logic CLK,
    input logic nRST,
    input vperm_input_t vperm_in,
    output vperm_output_t vperm_out
);

    import rv32i_types_pkg::*;
    import rv32v_types_pkg::*;

    logic [3:0] pre_vl_mask;
    logic [$clog2(VLMAX)-1:0] elements_to_slide;

    assign elements_to_slide = vperm_in.vl - vperm_in.offset;

    always_comb begin
        casez (vperm_in.vpermop)
            VPRM_SLU: begin
                if (vperm_in.vuop_num == '0) begin
                    casez (vperm_in.offset[1:0])
                        2'b00: begin
                            vperm_out.velems_out = vperm_in.vs2_data;
                            pre_vl_mask = 4'b1111;
                        end
                        2'b01: begin
                            vperm_out.velems_out = {vperm_in.vs2_data[2:0], '0};
                            pre_vl_mask = 4'b1110;
                        end
                        2'b10: begin
                            vperm_out.velems_out = {vperm_in.vs2_data[1:0], {2{'0}}};
                            pre_vl_mask = 4'b1100;
                        end
                        2'b11: begin
                            vperm_out.velems_out = {vperm_in.vs2_data[0], {3{'0}}};
                            pre_vl_mask = 4'b1000;
                        end
                    endcase
                end else begin
                    casez (vperm_in.offset[1:0])
                        2'b00: vperm_out.velems_out = vperm_in.vs2_data;
                        2'b01: vperm_out.velems_out = {vperm_in.vs2_data[2:0], vperm_in.vscratchdata[3]};
                        2'b10: vperm_out.velems_out = {vperm_in.vs2_data[1:0], vperm_in.vscratchdata[3:2]};
                        2'b11: vperm_out.velems_out = {vperm_in.vs2_data[0], vperm_in.vscratchdata[3:1]};
                    endcase
                    pre_vl_mask = '1;
                end

                casez (vperm_in.vsew)
                    SEW32: begin
                        vperm_out.vbank_offset = '0;
                        vperm_out.vd_sel_perm = vperm_in.vd_sel + (vperm_in.offset >> 2) + vperm_in.vuop_num;
                    end
                    SEW16: begin
                        vperm_out.vbank_offset = {vperm_in.offset[2] ^ vperm_in.vuop_num[0], 1'b0};
                        vperm_out.vd_sel_perm = vperm_in.vd_sel + (vperm_in.offset >> 3) + vperm_in.vuop_num;
                    end
                    SEW8: begin
                        vperm_out.vbank_offset = vperm_in.offset[3:2] + vperm_in.vuop_num[1:0];
                        vperm_out.vd_sel_perm = vperm_in.vd_sel + (vperm_in.offset >> 4) + vperm_in.vuop_num;
                    end
                    default: begin
                        vperm_out.vbank_offset = '0;
                        vperm_out.vd_sel_perm = vperm_in.vd_sel;
                    end
                endcase

                if (vperm_in.offset >= vperm_in.vl) begin
                    vperm_out.vperm_mask = '0;
                end else if (vperm_in.vuop_num == (elements_to_slide >> 2)) begin
                    casez (elements_to_slide[1:0])
                        2'b00: vperm_out.vperm_mask = 4'b0;
                        2'b01: vperm_out.vperm_mask = {3'b0, pre_vl_mask[0]};
                        2'b10: vperm_out.vperm_mask = {2'b0, pre_vl_mask[1:0]};
                        2'b11: vperm_out.vperm_mask = {1'b0, pre_vl_mask[2:0]};
                    endcase
                end else begin
                    vperm_out.vperm_mask = pre_vl_mask;
                end
            end
            VPRM_SLD: begin
                if (vperm_in.vuop_num == '0) begin
                    casez (vperm_in.offset[1:0])
                        2'b00: begin
                            vperm_out.velems_out = vperm_in.vs2_data;
                            pre_vl_mask = 4'b1111;
                        end
                        2'b01: begin
                            vperm_out.velems_out = {'0, vperm_in.vs2_data[3:1]};
                            pre_vl_mask = 4'b0111;
                        end
                        2'b10: begin
                            vperm_out.velems_out = {{2{'0}}, vperm_in.vs2_data[3:2]};
                            pre_vl_mask = 4'b0011;
                        end
                        2'b11: begin
                            vperm_out.velems_out = {{3{'0}}, vperm_in.vs2_data[3]};
                            pre_vl_mask = 4'b0001;
                        end
                    endcase
                end else begin
                    casez (vperm_in.offset[1:0])
                        2'b00: vperm_out.velems_out = vperm_in.vs2_data;
                        2'b01: vperm_out.velems_out = {vperm_in.vs2_data[2:0], vperm_in.vscratchdata[3]};
                        2'b10: vperm_out.velems_out = {vperm_in.vs2_data[1:0], vperm_in.vscratchdata[3:2]};
                        2'b11: vperm_out.velems_out = {vperm_in.vs2_data[0], vperm_in.vscratchdata[3:1]};
                    endcase
                    pre_vl_mask = '1;
                end

                casez (vperm_in.vsew)
                    SEW32: begin
                        vperm_out.vbank_offset = '0;
                        vperm_out.vd_sel_perm = vperm_in.vd_sel + (vperm_in.offset >> 2) + vperm_in.vuop_num;
                    end
                    SEW16: begin
                        vperm_out.vbank_offset = {vperm_in.offset[2] ^ vperm_in.vuop_num[0], 1'b0};
                        vperm_out.vd_sel_perm = vperm_in.vd_sel + (vperm_in.offset >> 3) + vperm_in.vuop_num;
                    end
                    SEW8: begin
                        vperm_out.vbank_offset = vperm_in.offset[3:2] + vperm_in.vuop_num[1:0];
                        vperm_out.vd_sel_perm = vperm_in.vd_sel + (vperm_in.offset >> 4) + vperm_in.vuop_num;
                    end
                    default: begin
                        vperm_out.vbank_offset = '0;
                        vperm_out.vd_sel_perm = vperm_in.vd_sel;
                    end
                endcase

                if ((vperm_in.vuop_num << 2) < vperm_in.offset) begin
                    vperm_out.vperm_mask = '0;
                end else if (vperm_in.vuop_num == (vperm_in.offset >> 2)) begin
                    casez (vperm_in.offset[1:0])
                        2'b00: vperm_out.vperm_mask = 4'b1111;
                        2'b01: vperm_out.vperm_mask = {3'b0, pre_vl_mask[0]};
                        2'b10: vperm_out.vperm_mask = {2'b0, pre_vl_mask[1:0]};
                        2'b11: vperm_out.vperm_mask = {1'b0, pre_vl_mask[2:0]};
                    endcase
                end else begin
                    vperm_out.vperm_mask = pre_vl_mask;
                end
            end
            VPRM_S1U: begin
                if (vperm_in.vuop_num == '0) begin
                    vperm_out.velems_out = {vperm_in.vs2_data[2:0], vperm_in.rs1_data};
                end else begin
                    vperm_out.velems_out = {vperm_in.vs2_data[2:0], vperm_in.vscratchdata[3]};
                end
                vperm_out.vperm_mask = vperm_in.vlaneactive;
            end
            VPRM_S1D: begin
                if (vperm_in.vuop_last) begin
                    if (vperm_in.vuop_num == '0) begin
                        casez (vperm_in.vlaneactive)
                            4'b0001: vperm_out.velems_out = {{3{'0}}, vperm_in.rs1_data};
                            4'b001?: vperm_out.velems_out = {{2{'0}}, vperm_in.rs1_data, vperm_in.vs2_data[1]};
                            4'b01??: vperm_out.velems_out = {'0, vperm_in.rs1_data, vperm_in.vs2_data[2:1]};
                            4'b1???: vperm_out.velems_out = {vperm_in.rs1_data, vperm_in.vs2_data[3:1]};
                            default: vperm_out.velems_out = '{4{'0}};
                        endcase
                    end else begin
                        casez (vperm_in.vlaneactive)
                            4'b0001: vperm_out.velems_out = {{3{'0}}, vperm_in.rs1_data};
                            4'b001?: vperm_out.velems_out = {{2{'0}}, vperm_in.rs1_data, vperm_in.vscratchdata[1]};
                            4'b01??: vperm_out.velems_out = {'0, vperm_in.rs1_data, vperm_in.vscratchdata[2:1]};
                            4'b1???: vperm_out.velems_out = {vperm_in.rs1_data, vperm_in.vscratchdata[3:1]};
                            default: vperm_out.velems_out = '{4{'0}};
                        endcase
                    end
                end else if (vperm_in.vuop_num == '0) begin
                    vperm_out.velems_out = {'0, vperm_in.vs2_data[3:1]};
                end else begin
                    vperm_out.velems_out = {vperm_in.vs2_data[0], vperm_in.vscratchdata[3:1]};
                end
                vperm_out.vperm_mask = vperm_in.vlaneactive;
            end
            default: begin
                vperm_out.vd_sel_perm = '0;
                vperm_out.vbank_offset = '0;
                vperm_out.velems_out = '{4{'0}};
                vperm_out.vperm_mask = '0;
            end
        endcase
    end

endmodule // rv32v_permutation_unit
