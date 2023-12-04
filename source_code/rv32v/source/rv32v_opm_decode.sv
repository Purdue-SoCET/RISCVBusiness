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

`include "rv32v_types_pkg.vh"

module rv32v_opm_decode(
    input vopm_t vopm,
    output vexec_t vexec,
    output logic valid
);

always_comb begin
    // Initially assume that this instruction correctly decodes for vopi
    valid = 1'b1;

    // Arbitrary defaults just to prevent latches
    vexec.vopm = VFU_ALU;
    vexec.valuop = VALU_ADD;
    vexec.vredop = VRED_AND;
    vexec.vmaskop = VMSK_AND;
    vexec.vpermop = VPRM_CPS;
    vexec.vopunsigned = 1'b0;

    case (vopm)
        VREDSUM: begin
            vexec.vopm = VFU_RED;
            vexec.vredop = VRED_SUM;
        end
        VREDAND: begin
            vexec.vopm = VFU_RED;
            vexec.vredop = VRED_AND;
        end
        VREDOR: begin
            vexec.vopm = VFU_RED;
            vexec.vredop = VRED_OR;
        end
        VREDXOR: begin
            vexec.vopm = VFU_RED;
            vexec.vredop = VRED_XOR;
        end
        VREDMINU: begin
            vexec.vopm = VFU_RED;
            vexec.vredop = VRED_MIN;
            vexec.vopunsigned = 1'b1;
        end
        VREDMIN: begin
            vexec.vopm = VFU_RED;
            vexec.vredop = VRED_MIN;
        end
        VREDMAXU: begin
            vexec.vopm = VFU_RED;
            vexec.vredop = VRED_MAX;
            vexec.vopunsigned = 1'b1;
        end
        VREDMAX: begin
            vexec.vopm = VFU_RED;
            vexec.vredop = VRED_MAX;
        end
        VAADDU: begin
            vexec.vopm = VFU_ALU;
            vexec.valuop = VALU_ADD;
            vexec.vopunsigned = 1'b1;
        end
        VAADD: begin
            vexec.vopm = VFU_ALU;
            vexec.valuop = VALU_ADD;
        end
        VASUBU: begin
            vexec.vopm = VFU_ALU;
            vexec.valuop = VALU_SUB;
            vexec.vopunsigned = 1'b1;
        end
        VASUB: begin
            vexec.vopm = VFU_ALU;
            vexec.valuop = VALU_SUB;
        end
        VSLIDE1UP: begin
            vexec.vopm = VFU_PRM;
            vexec.vpermop = VPRM_S1U;
        end
        VSLIDE1DOWN: begin
            vexec.vopm = VFU_PRM;
            vexec.vpermop = VPRM_S1D;
        end
        VWXUNARY0: begin
            /* UNIMPLEMENTED */
            valid = 1'b0;
        end
        VXUNARY0: begin
            /* UNIMPLEMENTED */
            valid = 1'b0;
        end
        VMUNARY0: begin
            /* UNIMPLEMENTED */
            valid = 1'b0;
        end
        VCOMPRESS: begin
            vexec.vopm = VFU_PRM;
            vexec.vpermop = VPRM_CPS;
        end
        VMANDN: begin
            vexec.vopm = VFU_MSK;
            vexec.vmaskop = VMSK_NDN;
        end
        VMAND: begin
            vexec.vopm = VFU_MSK;
            vexec.vmaskop = VMSK_AND;
        end
        VMOR: begin
            vexec.vopm = VFU_MSK;
            vexec.vmaskop = VMSK_OR;
        end
        VMXOR: begin
            vexec.vopm = VFU_MSK;
            vexec.vmaskop = VMSK_XOR;
        end
        VMORN: begin
            vexec.vopm = VFU_MSK;
            vexec.vmaskop = VMSK_NOR;
        end
        VMNAND: begin
            vexec.vopm = VFU_MSK;
            vexec.vmaskop = VMSK_NND;
        end
        VMNOR: begin
            vexec.vopm = VFU_MSK;
            vexec.vmaskop = VMSK_NOR;
        end
        VMXNOR: begin
            vexec.vopm = VFU_MSK;
            vexec.vmaskop = VMSK_XNR;
        end
        VDIVU: begin
            vexec.vopm = VFU_DIV;
            vexec.vopunsigned = 1'b1;
        end
        VDIV: begin
            vexec.vopm = VFU_DIV;
        end
        VREMU: begin
            vexec.vopm = VFU_DIV;
            vexec.vopunsigned = 1'b1;
        end
        VREM: begin
            vexec.vopm = VFU_DIV;
        end
        VMULHU: begin
            vexec.vopm = VFU_MUL;
            vexec.vopunsigned = 1'b1;
        end
        VMUL: begin
            vexec.vopm = VFU_MUL;
        end
        VMULHSU: begin
            vexec.vopm = VFU_MUL;
            vexec.vopunsigned = 1'b1;
        end
        VMULH: begin
            vexec.vopm = VFU_MUL;
        end
        VMADD: begin
            /* UNIMPLEMENTED */
            valid = 1'b0;
        end
        VNMSUB: begin
            /* UNIMPLEMENTED */
            valid = 1'b0;
        end
        VMACC: begin
            /* UNIMPLEMENTED */
            valid = 1'b0;
        end
        VNMSAC: begin
            /* UNIMPLEMENTED */
            valid = 1'b0;
        end
        VWADDU: begin
            vexec.vopm = VFU_ALU;
            vexec.valuop = VALU_ADD;
        end
        VWADD: begin
            vexec.vopm = VFU_ALU;
            vexec.valuop = VALU_ADD;
        end
        VWSUBU: begin
            vexec.vopm = VFU_ALU;
            vexec.valuop = VALU_SUB;
        end
        VWSUB: begin
            vexec.vopm = VFU_ALU;
            vexec.valuop = VALU_SUB;
        end
        VWADDU_W: begin
            vexec.vopm = VFU_ALU;
            vexec.valuop = VALU_ADD;
        end
        VWADD_W: begin
            vexec.vopm = VFU_ALU;
            vexec.valuop = VALU_ADD;
        end
        VWSUBU_W: begin
            vexec.vopm = VFU_ALU;
            vexec.valuop = VALU_SUB;
        end
        VWSUB_W: begin
            vexec.vopm = VFU_ALU;
            vexec.valuop = VALU_SUB;
        end
        VWMULU: begin
            vexec.vopm = VFU_MUL;
            vexec.vopunsigned = 1'b1;
        end
        VWMULSU: begin
            vexec.vopm = VFU_MUL;
            vexec.vopunsigned = 1'b1;
        end
        VWMUL: begin
            vexec.vopm = VFU_MUL;
            valuop_mul = VWMUL;
        end
        VWMACCU: begin
            /* UNIMPLEMENTED */
            valid = 1'b0;
        end
        VWMACC: begin
            /* UNIMPLEMENTED */
            valid = 1'b0;
        end
        VWMACCUS: begin
            /* UNIMPLEMENTED */
            valid = 1'b0;
        end
        VWMACCSU: begin
            /* UNIMPLEMENTED */
            valid = 1'b0;
        end

        default: begin
            // If no op matched, this must not be a supported vopm
            vopi_valid = 1'b0;
        end
    endcase
end

endmodule

