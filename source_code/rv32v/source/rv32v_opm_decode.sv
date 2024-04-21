/*
*   Copyright 2023 Purdue University
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
*   Filename:     rv32v_opm_decode.sv
*
*   Created by:   Om Gupta
*   Email:        guptao@purdue.edu
*   Date Created: 11/13/2023
*   Description:  Logic for mapping OPM* vfunct6 fields to execution unit control signals
*/


import rv32v_types_pkg::*;

module rv32v_opm_decode(
    input vopm_t vopm,
    input vfunct3_t vfunct3,
    input logic[4:0] vs1_sel, 
    input vsew_t vsew, 

    output vexec_t vexec,
    output logic valid, 
    output vsew_t veew_src2,
    output logic disable_mask
);

logic[2:0] vsew_bits; 

assign vsew_bits = vsew; 

always_comb begin
    // Initially assume that this instruction correctly decodes for vopi
    valid = 1'b1;
    veew_src2 = vsew; 

    // Arbitrary defaults just to prevent latches
    vexec.vfu = VFU_ALU;
    vexec.valuop = VALU_ADD;
    vexec.vmulop = UNFUSED;
    vexec.vmulwiden = 1'b0;
    vexec.vmulrethigh = 1'b0;
    vexec.vdivremainder = 1'b0;
    vexec.vmaskop = VMSK_AND;
    vexec.vpermop = VPRM_CPS;
    vexec.vsigntype = SIGNED;
    vexec.vopunsigned = 1'b0;
    disable_mask = 1'b0; 

    case (vopm)
        VREDSUM: begin
            vexec.vfu = VFU_RED;
            vexec.valuop = VALU_ADD;
        end
        VREDAND: begin
            vexec.vfu = VFU_RED;
            vexec.valuop = VALU_AND;
        end
        VREDOR: begin
            vexec.vfu = VFU_RED;
            vexec.valuop = VALU_OR;
        end
        VREDXOR: begin
            vexec.vfu = VFU_RED;
            vexec.valuop = VALU_XOR;
        end
        VREDMINU: begin
            vexec.vfu = VFU_RED;
            vexec.valuop = VALU_MIN;
            vexec.vopunsigned = 1'b1;
        end
        VREDMIN: begin
            vexec.vfu = VFU_RED;
            vexec.valuop = VALU_MIN;
        end
        VREDMAXU: begin
            vexec.vfu = VFU_RED;
            vexec.valuop = VALU_MAX;
            vexec.vopunsigned = 1'b1;
        end
        VREDMAX: begin
            vexec.vfu = VFU_RED;
            vexec.valuop = VALU_MAX;
        end
        VAADDU: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_ADD;
            vexec.vopunsigned = 1'b1;
        end
        VAADD: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_ADD;
        end
        VASUBU: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_SUB;
            vexec.vopunsigned = 1'b1;
        end
        VASUB: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_SUB;
        end
        VSLIDE1UP: begin
            vexec.vfu = VFU_PRM;
            vexec.vpermop = VPRM_S1U;
        end
        VSLIDE1DOWN: begin
            vexec.vfu = VFU_PRM;
            vexec.vpermop = VPRM_S1D;
        end
        VWXUNARY0: begin
            case(vs1_sel)
                5'b00000: begin // VMV.X.S INSTR
                    vexec.vfu = VFU_PASS_VS2;
                end
                5'b10000: begin // VCPOP INSTR
                    vexec.vfu = VFU_MSK; 
                    vexec.vmaskop = VMSK_CNT;
                end 
                5'b10001: begin // VFIRST INSTR
                    vexec.vfu = VFU_MSK; 
                    vexec.vmaskop = VMSK_FST; 
                end
            endcase 
        end
        VXUNARY0: begin
            vexec.vfu = VFU_ALU; 
            valid = 1'b0;             
            case(vs1_sel)
                5'd2: begin // vzext.vf8 instr 
                    veew_src2 = vsew_t'(vsew_bits - 3); 
                    vexec.vopunsigned = 1'b1; 
                    vexec.valuop = VALU_EXT; 
                    valid = 1'b1; 
                end
                5'd3: begin // vsext.vf8 instr 
                    veew_src2 = vsew_t'(vsew_bits - 3); 
                    vexec.valuop = VALU_EXT; 
                    valid = 1'b1; 
                end
                5'd4: begin // vzext.vf4 instr 
                    vexec.valuop = VALU_EXT; 
                    veew_src2 = vsew_t'(vsew_bits - 2); 
                    vexec.vopunsigned = 1'b1; 
                    valid = 1'b1; 
                end
                5'd5: begin // vsext.vf4
                    vexec.valuop = VALU_EXT; 
                    veew_src2 = vsew_t'(vsew_bits - 2); 
                    valid = 1'b1; 
                end
                5'd6: begin //vzext.vf2
                    vexec.valuop = VALU_EXT; 
                    veew_src2 = vsew_t'(vsew_bits - 1); 
                    valid = 1'b1; 
                    vexec.vopunsigned = 1'b1; 
                end
                5'd7: begin // vsext.vf2
                    vexec.valuop = VALU_EXT; 
                    veew_src2 = vsew_t'(vsew_bits - 1); 
                    valid = 1'b1; 
                end
            endcase 
        end
        VMUNARY0: begin
            vexec.vfu = VFU_MSK; 
            case(vs1_sel)
                5'b00001: begin
                     vexec.vmaskop = VMSK_SBF; 
                end 
                5'b00010: begin
                     vexec.vmaskop = VMSK_SOF;
                end 
                5'b00011: begin
                     vexec.vmaskop = VMSK_SIF; 
                end 
                5'b10000: vexec.vmaskop = VMSK_ITA;
                5'b10001: vexec.vmaskop = VMSK_IDX;  
            endcase 
        end
        VCOMPRESS: begin
            vexec.vfu = VFU_PRM;
            vexec.vpermop = VPRM_CPS;
        end
        VMANDN: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_ANDN;
        end
        VMAND: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_AND;
            disable_mask = 1; 
        end
        VMOR: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_OR;
            disable_mask = 1; 
        end
        VMXOR: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_XOR;
            disable_mask = 1; 
        end
        VMORN: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_NOR;
            disable_mask = 1; 
        end
        VMNAND: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_NAND;
            disable_mask = 1; 
        end
        VMNOR: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_NOR;
            disable_mask = 1; 
        end
        VMXNOR: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_XNOR;
            disable_mask = 1; 
        end
        VDIVU: begin
            vexec.vfu = VFU_DIV;
            vexec.vopunsigned = 1'b1;
        end
        VDIV: begin
            vexec.vfu = VFU_DIV;
        end
        VREMU: begin
            vexec.vfu = VFU_DIV;
            vexec.vdivremainder = 1'b1;
            vexec.vopunsigned = 1'b1;
        end
        VREM: begin
            vexec.vfu = VFU_DIV;
            vexec.vdivremainder = 1'b1;
        end
        VMULHU: begin
            vexec.vfu = VFU_MUL;
            vexec.vmulrethigh = 1'b1;
            vexec.vsigntype = UNSIGNED;
            vexec.vopunsigned = 1'b1;
        end
        VMUL: begin
            vexec.vfu = VFU_MUL;
        end
        VMULHSU: begin
            vexec.vfu = VFU_MUL;
            vexec.vmulrethigh = 1'b1;
            vexec.vsigntype = SIGNED_UNSIGNED;
            vexec.vopunsigned = 1'b1;
        end
        VMULH: begin
            vexec.vfu = VFU_MUL;
            vexec.vmulrethigh = 1'b1;
        end
        VMADD: begin
            vexec.vfu = VFU_MUL;
            vexec.vmulop = VMUL_MADD;
        end
        VNMSUB: begin
            vexec.vfu = VFU_MUL;
            vexec.vmulop = VMUL_NMSUB;
        end
        VMACC: begin
            vexec.vfu = VFU_MUL;
            vexec.vmulop = VMUL_MACC;
        end
        VNMSAC: begin
            vexec.vfu = VFU_MUL;
            vexec.vmulop = VMUL_NMSAC;
        end
        VWADDU: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_ADD;
            vexec.vopunsigned = 1'b1;
        end
        VWADD: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_ADD;
        end
        VWSUBU: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_SUB;
            vexec.vopunsigned = 1'b1;
        end
        VWSUB: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_SUB;
        end
        VWADDU_W: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_ADD;
            veew_src2 = vsew_t'(vsew_bits + 1); 
            vexec.vopunsigned = 1'b1;
        end
        VWADD_W: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_ADD;
            veew_src2 = vsew_t'(vsew_bits + 1); 
        end
        VWSUBU_W: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_SUB;
            veew_src2 = vsew_t'(vsew_bits + 1); 
            vexec.vopunsigned = 1'b1;
        end
        VWSUB_W: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_SUB;
            veew_src2 = vsew_t'(vsew_bits + 1); 
        end
        VWMULU: begin
            vexec.vfu = VFU_MUL;
            vexec.vmulwiden = 1'b1;
            vexec.vsigntype = UNSIGNED;
            vexec.vopunsigned = 1'b1;
        end
        VWMULSU: begin
            vexec.vfu = VFU_MUL;
            vexec.vmulwiden = 1'b1;
            vexec.vsigntype = SIGNED_UNSIGNED;
            vexec.vopunsigned = 1'b1;
        end
        VWMUL: begin
            vexec.vfu = VFU_MUL;
            vexec.vmulwiden = 1'b1;
        end
        VWMACCU: begin
            vexec.vfu = VFU_MUL;
            vexec.vmulop = VMUL_MACC;
            vexec.vmulwiden = 1'b1;
            vexec.vsigntype = UNSIGNED;
            vexec.vopunsigned = 1'b1;
        end
        VWMACC: begin
            vexec.vfu = VFU_MUL;
            vexec.vmulop = VMUL_MACC;
            vexec.vmulwiden = 1'b1;
        end
        VWMACCUS: begin
            vexec.vfu = VFU_MUL;
            vexec.vmulop = VMUL_MACC;
            vexec.vmulwiden = 1'b1;
            vexec.vsigntype = UNSIGNED_SIGNED;
            vexec.vopunsigned = 1'b1;
        end
        VWMACCSU: begin
            vexec.vfu = VFU_MUL;
            vexec.vmulop = VMUL_MACC;
            vexec.vmulwiden = 1'b1;
            vexec.vsigntype = SIGNED_UNSIGNED;
            vexec.vopunsigned = 1'b1;
        end

        default: begin
            // If no op matched, this must not be a supported vopm
            valid = 1'b0;
        end
    endcase

    case(vfunct3)
        3'd0, 3'd1, 3'd3, 3'd4, 3'd5: valid = 0; // prevent overlap with opm and opf encodings 
    endcase 
end

endmodule

