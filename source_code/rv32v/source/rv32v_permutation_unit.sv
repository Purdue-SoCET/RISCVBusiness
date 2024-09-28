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
    input logic stall, flush,
    output vperm_output_t vperm_out,
    output logic [1:0] vrgtr_elem_num,
    output logic vrgtr_vs2_read, vrgtr_busy
);

    import rv32i_types_pkg::*;
    import rv32v_types_pkg::*;

    typedef enum logic [2:0] { READ_VS1=4, READ_VS2_0=0, READ_VS2_1=1, READ_VS2_2=2, READ_VS2_3=3 } vrgtr_state_t;

    logic [$clog2(VLMAX)-1:0] slidedown_last_elems;
    vrgtr_state_t vrgtr_state, next_vrgtr_state;
    vrgather_vs2_t [3:0] vrgtr_vs2_sel;
    vrgather_vs2_t vrgtr_vs2;
    word_t vrgtr_vs2_element;
    word_t [3:0] vrgtr_index;
    logic [$clog2(VLMAX)-1:0] vcomp_count, next_vcomp_count;
    logic use_vrgtr;
    logic [1:0] vcomp_rem_lanes, next_vcomp_rem_lanes;
    logic [127:0] vcomp_mask;

    int i;

    always_ff @(posedge CLK, negedge nRST) begin
        if (~nRST) begin
            vrgtr_state <= READ_VS1;
            vcomp_count <= '0;
            vcomp_rem_lanes <= '0;
        end else if (flush) begin
            vrgtr_state <= READ_VS1;
            vcomp_count <= '0;
            vcomp_rem_lanes <= '0;
        end else begin
            vrgtr_state <= next_vrgtr_state;
            if (~stall) begin
                vcomp_count <= next_vcomp_count;
                vcomp_rem_lanes <= next_vcomp_rem_lanes;
            end
        end
    end

    assign vrgtr_busy = (vrgtr_state != READ_VS2_3) & use_vrgtr;
    assign vrgtr_vs2_read = (vrgtr_state != READ_VS1);
    assign vrgtr_elem_num = vrgtr_state[1:0];
    assign slidedown_last_elems = vperm_in.vlmax - vperm_in.offset;
    assign vcomp_mask = {vperm_in.vs1_data[3], vperm_in.vs1_data[2], vperm_in.vs1_data[1], vperm_in.vs1_data[0]};

    always_comb begin
        next_vrgtr_state = vrgtr_state;
        next_vcomp_count = vcomp_count;
        next_vcomp_rem_lanes = vcomp_rem_lanes;
        use_vrgtr = 0;
        vperm_out.vd_sel_perm = vperm_in.vd_sel;
        vperm_out.vperm_mask = vperm_in.vlaneactive;
        vperm_out.vs2_to_scratch = 0;
        vperm_out.nkeep_scratch = '1;
        vperm_out.velems_out = '{4{'0}};

        casez (vperm_in.vpermop)
            VPRM_SLU: begin
                use_vrgtr = |vperm_in.vlaneactive;
                casez (vrgtr_state)
                    READ_VS1: begin
                        if (vperm_in.offset[1:0] == 2'b00) begin
                            if (~stall) next_vrgtr_state = READ_VS2_3;
                            vrgtr_vs2_sel[3].zero_elem = 0;
                            vrgtr_vs2_sel[3].vs2_src_lane = 0;
                            casez (vperm_in.vsew)
                                SEW32: begin
                                    vrgtr_vs2_sel[3].vs2_sel = vperm_in.vs2_sel - (vperm_in.offset >> 2);
                                    vrgtr_vs2_sel[3].vbank_offset = '0;
                                end
                                SEW16: begin
                                    vrgtr_vs2_sel[3].vs2_sel = vperm_in.vs2_sel - (vperm_in.offset >> 3);
                                    vrgtr_vs2_sel[3].vbank_offset = {1'b0, vperm_in.offset[2] ^ vperm_in.vuop_num[0]};
                                end
                                SEW8: begin
                                    vrgtr_vs2_sel[3].vs2_sel = vperm_in.vs2_sel - (vperm_in.offset >> 4);
                                    vrgtr_vs2_sel[3].vbank_offset = vperm_in.offset[3:2] + vperm_in.vuop_num[1:0];
                                end
                                default: begin
                                    vrgtr_vs2_sel[3].vs2_sel = '0;
                                    vrgtr_vs2_sel[3].vbank_offset = '0;
                                end
                            endcase
                            vperm_out.velems_out = {{22'b0, vrgtr_vs2_sel[3]}, {3{32'b0}}};
                        end else begin
                            if (~stall) next_vrgtr_state = READ_VS2_0;
                            vrgtr_vs2_sel[0].zero_elem = 0;
                            vrgtr_vs2_sel[0].vs2_src_lane = 0;
                            vrgtr_vs2_sel[3].zero_elem = 0;
                            vrgtr_vs2_sel[3].vs2_src_lane = 0;
                            casez (vperm_in.vsew)
                                SEW32: begin
                                    vrgtr_vs2_sel[0].vs2_sel = vperm_in.vs2_sel - (vperm_in.offset >> 2) - 1;
                                    vrgtr_vs2_sel[0].vbank_offset = '0;
                                    vrgtr_vs2_sel[3].vs2_sel = vrgtr_vs2_sel[0].vs2_sel + 1;
                                    vrgtr_vs2_sel[3].vbank_offset = '0;
                                end
                                SEW16: begin
                                    vrgtr_vs2_sel[0].vs2_sel = vperm_in.vs2_sel - (vperm_in.offset >> 3) - 1;
                                    if (vperm_in.offset[2:0] > 3'd4)
                                        vrgtr_vs2_sel[0].vbank_offset = {1'b0, vperm_in.vuop_num[0]};
                                    else
                                        vrgtr_vs2_sel[0].vbank_offset = {1'b0, ~vperm_in.vuop_num[0]};
                                    vrgtr_vs2_sel[3].vs2_sel = vrgtr_vs2_sel[0].vs2_sel + vrgtr_vs2_sel[0].vbank_offset;
                                    vrgtr_vs2_sel[3].vbank_offset = {1'b0, ~vrgtr_vs2_sel[0].vbank_offset[0]};
                                end
                                SEW8: begin
                                    vrgtr_vs2_sel[0].vs2_sel = vperm_in.vs2_sel - ((vperm_in.offset - (vperm_in.vuop_num[1:0] << 2)) >> 4) - 1;
                                    vrgtr_vs2_sel[0].vbank_offset = vperm_in.offset[3:2] + vperm_in.vuop_num[1:0];
                                    vrgtr_vs2_sel[3].vs2_sel = vrgtr_vs2_sel[0].vs2_sel + (vrgtr_vs2_sel[0].vbank_offset == 2'd3);
                                    vrgtr_vs2_sel[3].vbank_offset = vrgtr_vs2_sel[0].vbank_offset + 1;
                                end
                                default: begin
                                    vrgtr_vs2_sel[0].vs2_sel = '0;
                                    vrgtr_vs2_sel[0].vbank_offset = '0;
                                    vrgtr_vs2_sel[3].vs2_sel = '0;
                                    vrgtr_vs2_sel[3].vbank_offset = '0;
                                end
                            endcase
                            vperm_out.velems_out = {{22'b0, vrgtr_vs2_sel[3]}, {2{32'b0}}, {22'b0, vrgtr_vs2_sel[0]}};
                        end
                    end
                    READ_VS2_0: begin
                        if (~stall) next_vrgtr_state = READ_VS2_3;
                        casez (vperm_in.offset[1:0])
                            2'b01: begin
                                vperm_out.velems_out = {{3{32'b0}}, vperm_in.vs2_data[3]};
                                vperm_out.nkeep_scratch = 4'b0001;
                            end
                            2'b10: begin
                                vperm_out.velems_out = {{2{32'b0}}, vperm_in.vs2_data[3:2]};
                                vperm_out.nkeep_scratch = 4'b0011;
                            end
                            2'b11: begin
                                vperm_out.velems_out = {32'b0, vperm_in.vs2_data[3:1]};
                                vperm_out.nkeep_scratch = 4'b0111;
                            end
                        endcase
                    end
                    READ_VS2_3: begin
                        if (~stall) next_vrgtr_state = READ_VS1;
                        casez (vperm_in.offset[1:0])
                            2'b00: vperm_out.velems_out = vperm_in.vs2_data;
                            2'b01: vperm_out.velems_out = {vperm_in.vs2_data[2:0], vperm_in.vscratchdata[0]};
                            2'b10: vperm_out.velems_out = {vperm_in.vs2_data[1:0], vperm_in.vscratchdata[1:0]};
                            2'b11: vperm_out.velems_out = {vperm_in.vs2_data[0], vperm_in.vscratchdata[2:0]};
                        endcase
                        vperm_out.nkeep_scratch = '0;
                    end
                endcase

                if (vperm_in.offset >= vperm_in.vl) begin
                    vperm_out.vperm_mask = '0;
                end else if (vperm_in.vuop_num < (vperm_in.offset >> 2)) begin
                    vperm_out.vperm_mask = '0;
                end else if (vperm_in.vuop_num == (vperm_in.offset >> 2)) begin
                    casez (vperm_in.offset[1:0])
                        2'b00: vperm_out.vperm_mask = vperm_in.vlaneactive;
                        2'b01: vperm_out.vperm_mask = {vperm_in.vlaneactive[3:1], 1'b0};
                        2'b10: vperm_out.vperm_mask = {vperm_in.vlaneactive[3:2], 2'b0};
                        2'b11: vperm_out.vperm_mask = {vperm_in.vlaneactive[3], 3'b0};
                    endcase
                end
            end
            VPRM_SLD: begin
                use_vrgtr = |vperm_in.vlaneactive;
                casez (vrgtr_state)
                    READ_VS1: begin
                        if (vperm_in.offset[1:0] == 2'b00) begin
                            if (~stall) next_vrgtr_state = READ_VS2_3;
                            vrgtr_vs2_sel[3].zero_elem = 0;
                            vrgtr_vs2_sel[3].vs2_src_lane = 0;
                            casez (vperm_in.vsew)
                                SEW32: begin
                                    vrgtr_vs2_sel[3].vs2_sel = vperm_in.vs2_sel + (vperm_in.offset >> 2);
                                    vrgtr_vs2_sel[3].vbank_offset = '0;
                                end
                                SEW16: begin
                                    vrgtr_vs2_sel[3].vs2_sel = vperm_in.vs2_sel + (vperm_in.offset >> 3);
                                    vrgtr_vs2_sel[3].vbank_offset = {1'b0, vperm_in.offset[2] ^ vperm_in.vuop_num[0]};
                                end
                                SEW8: begin
                                    vrgtr_vs2_sel[3].vs2_sel = vperm_in.vs2_sel + (vperm_in.offset >> 4);
                                    vrgtr_vs2_sel[3].vbank_offset = vperm_in.offset[3:2] + vperm_in.vuop_num[1:0];
                                end
                                default: begin
                                    vrgtr_vs2_sel[3].vs2_sel = '0;
                                    vrgtr_vs2_sel[3].vbank_offset = '0;
                                end
                            endcase
                            vperm_out.velems_out = {{22'b0, vrgtr_vs2_sel[3]}, {3{32'b0}}};
                        end else begin
                            if (~stall) next_vrgtr_state = READ_VS2_0;
                            vrgtr_vs2_sel[0].zero_elem = 0;
                            vrgtr_vs2_sel[0].vs2_src_lane = 0;
                            vrgtr_vs2_sel[3].zero_elem = 0;
                            vrgtr_vs2_sel[3].vs2_src_lane = 0;
                            casez (vperm_in.vsew)
                                SEW32: begin
                                    vrgtr_vs2_sel[0].vs2_sel = vperm_in.vs2_sel + (vperm_in.offset >> 2);
                                    vrgtr_vs2_sel[0].vbank_offset = '0;
                                    vrgtr_vs2_sel[3].vs2_sel = vrgtr_vs2_sel[0].vs2_sel + 1;
                                    vrgtr_vs2_sel[3].vbank_offset = '0;
                                end
                                SEW16: begin
                                    vrgtr_vs2_sel[0].vs2_sel = vperm_in.vs2_sel + (vperm_in.offset >> 3);
                                    if (vperm_in.offset[2:0] > 3'd4)
                                        vrgtr_vs2_sel[0].vbank_offset = {1'b0, ~vperm_in.vuop_num[0]};
                                    else
                                        vrgtr_vs2_sel[0].vbank_offset = {1'b0, vperm_in.vuop_num[0]};
                                    vrgtr_vs2_sel[3].vs2_sel = vrgtr_vs2_sel[0].vs2_sel + vrgtr_vs2_sel[0].vbank_offset;
                                    vrgtr_vs2_sel[3].vbank_offset = {1'b0, ~vrgtr_vs2_sel[0].vbank_offset[0]};
                                end
                                SEW8: begin
                                    vrgtr_vs2_sel[0].vs2_sel = vperm_in.vs2_sel + ((vperm_in.offset + (vperm_in.vuop_num[1:0] << 2)) >> 4);
                                    vrgtr_vs2_sel[0].vbank_offset = vperm_in.offset[3:2] + vperm_in.vuop_num[1:0];
                                    vrgtr_vs2_sel[3].vs2_sel = vrgtr_vs2_sel[0].vs2_sel + (vrgtr_vs2_sel[0].vbank_offset == 2'd3);
                                    vrgtr_vs2_sel[3].vbank_offset = vrgtr_vs2_sel[0].vbank_offset + 1;
                                end
                                default: begin
                                    vrgtr_vs2_sel[0].vs2_sel = '0;
                                    vrgtr_vs2_sel[0].vbank_offset = '0;
                                    vrgtr_vs2_sel[3].vs2_sel = '0;
                                    vrgtr_vs2_sel[3].vbank_offset = '0;
                                end
                            endcase
                            vperm_out.velems_out = {{22'b0, vrgtr_vs2_sel[3]}, {2{32'b0}}, {22'b0, vrgtr_vs2_sel[0]}};
                        end
                    end
                    READ_VS2_0: begin
                        if (~stall) next_vrgtr_state = READ_VS2_3;
                        casez (vperm_in.offset[1:0])
                            2'b01: begin
                                vperm_out.velems_out = {32'b0, vperm_in.vs2_data[3:1]};
                                vperm_out.nkeep_scratch = 4'b0111;
                            end
                            2'b10: begin
                                vperm_out.velems_out = {{2{32'b0}}, vperm_in.vs2_data[3:2]};
                                vperm_out.nkeep_scratch = 4'b0011;
                            end
                            2'b11: begin
                                vperm_out.velems_out = {{3{32'b0}}, vperm_in.vs2_data[3]};
                                vperm_out.nkeep_scratch = 4'b0001;
                            end
                        endcase
                    end
                    READ_VS2_3: begin
                        if (~stall) next_vrgtr_state = READ_VS1;
                        casez (vperm_in.offset[1:0])
                            2'b00: vperm_out.velems_out = vperm_in.vs2_data;
                            2'b01: vperm_out.velems_out = {vperm_in.vs2_data[0], vperm_in.vscratchdata[2:0]};
                            2'b10: vperm_out.velems_out = {vperm_in.vs2_data[1:0], vperm_in.vscratchdata[1:0]};
                            2'b11: vperm_out.velems_out = {vperm_in.vs2_data[2:0], vperm_in.vscratchdata[0]};
                        endcase
                        vperm_out.nkeep_scratch = '0;
                    end
                endcase

                if ((vperm_in.offset + (vperm_in.vuop_num << 2)) >= vperm_in.vlmax) begin
                    vperm_out.velems_out = '{4{32'b0}};
                end else if ((vperm_in.offset + (vperm_in.vuop_num << 2) + 3) >= vperm_in.vlmax) begin
                    casez (slidedown_last_elems[1:0])
                        2'b00: vperm_out.velems_out = '{4{32'b0}};
                        2'b01: vperm_out.velems_out[3:1] = {3{32'b0}};
                        2'b10: vperm_out.velems_out[3:2] = {2{32'b0}};
                        2'b11: vperm_out.velems_out[3] = 32'b0;
                    endcase
                end
            end
            VPRM_S1U: begin
                vperm_out.vs2_to_scratch = 1;
                if (vperm_in.vuop_num == '0) begin
                    vperm_out.velems_out = {vperm_in.vs2_data[2:0], vperm_in.rs1_data};
                end else begin
                    vperm_out.velems_out = {vperm_in.vs2_data[2:0], vperm_in.vscratchdata[3]};
                end
            end
            VPRM_S1D: begin
                if (vperm_in.vuop_last) begin
                    casez (vperm_in.vlaneactive)
                        4'b0001: vperm_out.velems_out = {{3{32'b0}}, vperm_in.rs1_data};
                        4'b001?: vperm_out.velems_out = {{2{32'b0}}, vperm_in.rs1_data, vperm_in.vs2_data[1]};
                        4'b01??: vperm_out.velems_out = {{1{32'b0}}, vperm_in.rs1_data, vperm_in.vs2_data[2:1]};
                        4'b1???: vperm_out.velems_out = {vperm_in.rs1_data, vperm_in.vs2_data[3:1]};
                        default: vperm_out.velems_out = '{4{32'b0}};
                    endcase
                end else begin
                    use_vrgtr = 1;
                    if (vrgtr_state == READ_VS1) begin
                        if (~stall) next_vrgtr_state = READ_VS2_3;
                        vrgtr_vs2_sel[3].zero_elem = 0;
                        vrgtr_vs2_sel[3].vs2_src_lane = 0;
                        casez (vperm_in.vsew)
                            SEW32: begin
                                vrgtr_vs2_sel[3].vs2_sel = vperm_in.vs2_sel + 1;
                                vrgtr_vs2_sel[3].vbank_offset = '0;
                            end
                            SEW16: begin
                                vrgtr_vs2_sel[3].vs2_sel = vperm_in.vs2_sel + vperm_in.vuop_num[0];
                                vrgtr_vs2_sel[3].vbank_offset = ~vperm_in.vuop_num[0];
                            end
                            SEW8: begin
                                vrgtr_vs2_sel[3].vs2_sel = vperm_in.vs2_sel + (vperm_in.vuop_num[1:0] == 2'd3);
                                vrgtr_vs2_sel[3].vbank_offset = vperm_in.vuop_num[1:0] + 1;
                            end
                            default: begin
                                vrgtr_vs2_sel[3].vs2_sel = '0;
                                vrgtr_vs2_sel[3].vbank_offset = '0;
                            end
                        endcase
                        vperm_out.velems_out = {{22'b0, vrgtr_vs2_sel[3]}, vperm_in.vs2_data[3:1]};
                    end else begin
                        if (~stall) next_vrgtr_state = READ_VS1;
                        vperm_out.velems_out = {vperm_in.vs2_data[0], vperm_in.vscratchdata[2:0]};
                        vperm_out.nkeep_scratch = '0;
                    end
                end
            end
            VPRM_GTR: begin
                use_vrgtr = 1;
                casez (vrgtr_state)
                    READ_VS1: begin
                        if (~stall) next_vrgtr_state = READ_VS2_0;
                        for (i = 0; i < NUM_LANES; i++) begin : vrgtr_generate_vs2_sel
                            vrgtr_index[i] = (vperm_in.use_rs1_data) ? vperm_in.offset : vperm_in.vs1_data[i];
                            vrgtr_vs2_sel[i].zero_elem = (vrgtr_index[i] >= vperm_in.vlmax);
                            vrgtr_vs2_sel[i].vs2_src_lane = vrgtr_index[i][1:0];
                            casez (vperm_in.vsew)
                                SEW32: begin
                                    vrgtr_vs2_sel[i].vs2_sel = vperm_in.vs2_sel + vrgtr_index[i][6:2];
                                    vrgtr_vs2_sel[i].vbank_offset = '0;
                                end
                                SEW16: begin
                                    vrgtr_vs2_sel[i].vs2_sel = vperm_in.vs2_sel + vrgtr_index[i][7:3];
                                    vrgtr_vs2_sel[i].vbank_offset = {1'b0, vrgtr_index[i][2]};
                                end
                                SEW8: begin
                                    vrgtr_vs2_sel[i].vs2_sel = vperm_in.vs2_sel + vrgtr_index[i][8:4];
                                    vrgtr_vs2_sel[i].vbank_offset = vrgtr_index[i][3:2];
                                end
                                default: begin
                                    vrgtr_vs2_sel[i].vs2_sel = '0;
                                    vrgtr_vs2_sel[i].vbank_offset = '0;
                                end
                            endcase
                            vperm_out.velems_out[i] = {22'b0, vrgtr_vs2_sel[i]};
                        end
                    end
                    READ_VS2_0: begin
                        next_vrgtr_state = READ_VS2_1;
                        vrgtr_vs2 = vrgather_vs2_t'(vperm_in.vscratchdata[0][9:0]);
                        vrgtr_vs2_element = (vrgtr_vs2.zero_elem) ? '0 : vperm_in.vs2_data[vrgtr_vs2.vs2_src_lane];
                        vperm_out.velems_out = {{3{32'b0}}, vrgtr_vs2_element};
                        vperm_out.nkeep_scratch = 4'b0001;
                    end
                    READ_VS2_1: begin
                        next_vrgtr_state = READ_VS2_2;
                        vrgtr_vs2 = vrgather_vs2_t'(vperm_in.vscratchdata[1][9:0]);
                        vrgtr_vs2_element = (vrgtr_vs2.zero_elem) ? '0 : vperm_in.vs2_data[vrgtr_vs2.vs2_src_lane];
                        vperm_out.velems_out = {{2{32'b0}}, vrgtr_vs2_element, {1{32'b0}}};
                        vperm_out.nkeep_scratch = 4'b0010;
                    end
                    READ_VS2_2: begin
                        next_vrgtr_state = READ_VS2_3;
                        vrgtr_vs2 = vrgather_vs2_t'(vperm_in.vscratchdata[2][9:0]);
                        vrgtr_vs2_element = (vrgtr_vs2.zero_elem) ? '0 : vperm_in.vs2_data[vrgtr_vs2.vs2_src_lane];
                        vperm_out.velems_out = {{1{32'b0}}, vrgtr_vs2_element, {2{32'b0}}};
                        vperm_out.nkeep_scratch = 4'b0100;
                    end
                    READ_VS2_3: begin
                        if (~stall) next_vrgtr_state = READ_VS1;
                        vrgtr_vs2 = vrgather_vs2_t'(vperm_in.vscratchdata[3][9:0]);
                        vrgtr_vs2_element = (vrgtr_vs2.zero_elem) ? '0 : vperm_in.vs2_data[vrgtr_vs2.vs2_src_lane];
                        vperm_out.velems_out = {vrgtr_vs2_element, vperm_in.vscratchdata[2:0]};
                        vperm_out.nkeep_scratch = '0;
                    end
                endcase
            end
            VPRM_CPS: begin
                use_vrgtr = 1;
                casez (vrgtr_state)
                    READ_VS1: begin
                        if (~stall) begin
                            if (vcomp_count >= vperm_in.vl) begin
                                use_vrgtr = 0;
                                vperm_out.vperm_mask = '0;
                            end
                            else next_vrgtr_state = READ_VS2_0;
                        end
                        if (vperm_in.vuop_num == '0) next_vcomp_count = '0;
                        next_vcomp_rem_lanes = 2'd3;
                        vrgtr_vs2_sel[0].zero_elem = 0;
                        vrgtr_vs2_sel[0].vs2_src_lane = 0;
                        casez (vperm_in.vsew)
                            SEW32: begin
                                vrgtr_vs2_sel[0].vs2_sel = vperm_in.vs2_sel + (vcomp_count >> 2);
                                vrgtr_vs2_sel[0].vbank_offset = '0;
                            end
                            SEW16: begin
                                vrgtr_vs2_sel[0].vs2_sel = vperm_in.vs2_sel + (vcomp_count >> 3);
                                vrgtr_vs2_sel[0].vbank_offset = {1'b0, vcomp_count[2]};
                            end
                            SEW8: begin
                                vrgtr_vs2_sel[0].vs2_sel = vperm_in.vs2_sel + (vcomp_count >> 4);
                                vrgtr_vs2_sel[0].vbank_offset = vcomp_count[3:2];
                            end
                            default: begin
                                vrgtr_vs2_sel[0].vs2_sel = '0;
                                vrgtr_vs2_sel[0].vbank_offset = '0;
                            end
                        endcase
                        vperm_out.velems_out = {{3{32'b0}}, {22'b0, vrgtr_vs2_sel[0]}};
                    end
                    READ_VS2_0: begin
                        if (vcomp_count == vperm_in.vl) begin
                            next_vrgtr_state = READ_VS2_3;
                        end else begin
                            if (vcomp_mask[vcomp_count]) begin
                                next_vcomp_rem_lanes = vcomp_rem_lanes - 1;
                                casez (vcomp_rem_lanes)
                                    2'd3: begin
                                        vperm_out.nkeep_scratch[3:1] = 3'b001;
                                        vperm_out.velems_out[1] = vperm_in.vs2_data[vcomp_count[1:0]];
                                    end
                                    2'd2: begin
                                        vperm_out.nkeep_scratch[3:1] = 3'b010;
                                        vperm_out.velems_out[2] = vperm_in.vs2_data[vcomp_count[1:0]];
                                    end
                                    2'd1: begin
                                        vperm_out.nkeep_scratch[3:1] = 3'b100;
                                        vperm_out.velems_out[3] = vperm_in.vs2_data[vcomp_count[1:0]];
                                    end
                                    2'd0: begin
                                        vperm_out.nkeep_scratch[3:1] = 3'b111;
                                        vperm_out.velems_out = {vperm_in.vscratchdata[0], vperm_in.vscratchdata[3:1]};
                                        next_vrgtr_state = READ_VS2_3;
                                    end
                                endcase
                            end else begin
                                vperm_out.nkeep_scratch[3:1] = 3'b000;
                            end

                            if ((vcomp_count[1:0] == 2'd3)) begin
                                if ((vcomp_rem_lanes == 2'd0) && (vcomp_mask[vcomp_count])) begin
                                    vperm_out.nkeep_scratch[0] = 1;
                                end else begin
                                    next_vcomp_count = vcomp_count + 1;
                                    vperm_out.nkeep_scratch[0] = 1;
                                    vrgtr_vs2_sel[0].zero_elem = 0;
                                    vrgtr_vs2_sel[0].vs2_src_lane = 0;
                                    casez (vperm_in.vsew)
                                        SEW32: begin
                                            vrgtr_vs2_sel[0].vs2_sel = vperm_in.vs2_sel + (next_vcomp_count >> 2);
                                            vrgtr_vs2_sel[0].vbank_offset = '0;
                                        end
                                        SEW16: begin
                                            vrgtr_vs2_sel[0].vs2_sel = vperm_in.vs2_sel + (next_vcomp_count >> 3);
                                            vrgtr_vs2_sel[0].vbank_offset = {1'b0, next_vcomp_count[2]};
                                        end
                                        SEW8: begin
                                            vrgtr_vs2_sel[0].vs2_sel = vperm_in.vs2_sel + (next_vcomp_count >> 4);
                                            vrgtr_vs2_sel[0].vbank_offset = next_vcomp_count[3:2];
                                        end
                                        default: begin
                                            vrgtr_vs2_sel[0].vs2_sel = '0;
                                            vrgtr_vs2_sel[0].vbank_offset = '0;
                                        end
                                    endcase
                                    vperm_out.velems_out[0] = {22'b0, vrgtr_vs2_sel[0]};
                                end
                            end else begin
                                if ((vcomp_rem_lanes == 2'd0) && (vcomp_mask[vcomp_count])) begin
                                    vperm_out.nkeep_scratch[0] = 1;
                                end else begin
                                    next_vcomp_count = vcomp_count + 1;
                                    vperm_out.nkeep_scratch[0] = 0;
                                end
                            end
                        end
                    end
                    // READ_VS2_1:
                    // READ_VS2_2:
                    READ_VS2_3: begin
                        vperm_out.nkeep_scratch = '0;
                        if (~stall) begin
                            next_vrgtr_state = READ_VS1;
                            vperm_out.velems_out = {vperm_in.vs2_data[vcomp_count], vperm_in.vscratchdata[2:0]};
                            if (vcomp_count == vperm_in.vl) begin
                                casez (vcomp_rem_lanes)
                                    2'd3: vperm_out.vperm_mask = 4'b0000;
                                    2'd2: vperm_out.vperm_mask = 4'b0001;
                                    2'd1: vperm_out.vperm_mask = 4'b0011;
                                    2'd0: vperm_out.vperm_mask = 4'b0111;
                                endcase
                            end
                            next_vcomp_count = vcomp_count + 1;
                        end
                    end
                endcase
            end
            default: begin
                vperm_out.velems_out = '{4{'0}};
            end
        endcase

        vperm_out.vscratchwdata = vperm_out.velems_out;
    end

endmodule // rv32v_permutation_unit
