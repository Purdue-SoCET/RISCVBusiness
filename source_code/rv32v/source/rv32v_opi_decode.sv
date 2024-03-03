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
*   Filename:     rv32v_opi_decode.sv
*
*   Created by:   Om Gupta
*   Email:        guptao@purdue.edu
*   Date Created: 11/13/2023
*   Description:  Logic for mapping OPI* vfunct6 fields to execution unit control signals
*/


import rv32v_types_pkg::*;

module rv32v_opi_decode(
    input vopi_t vopi,
    input vfunct3_t vfunct3,
    input logic vm_bit,  
    
    output vexec_t vexec,
    output logic valid,
    output logic disable_mask
);

always_comb begin
    // Initially assume that this instruction correctly decodes for vopi
    valid = 1'b1;
    disable_mask = 1'b0; 

    // Arbitrary defaults just to prevent latches
    vexec.vfu = VFU_ALU;
    vexec.valuop = VALU_ADD;
    vexec.vredop = VRED_AND;
    vexec.vmaskop = VMSK_AND;
    vexec.vpermop = VPRM_CPS;
    vexec.vopunsigned = 1'b0;

    case (vopi)
        VADD: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_ADD;
        end
        VSUB: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_SUB;
        end
        VRSUB: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_RSB;
        end
        VMINU: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_MIN;
            vexec.vopunsigned = 1'b1;
        end
        VMIN: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_MIN;
        end
        VMAXU: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_MAX;
            vexec.vopunsigned = 1'b1;
        end
        VMAX: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_MAX;
        end
        VAND: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_AND;
        end
        VOR: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_OR;
        end
        VXOR: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_XOR;
        end
        VRGATHER: begin
            vexec.vfu = VFU_PRM;
            vexec.vpermop = VPRM_GTR;
        end
        VSLIDEUP: begin
            vexec.vfu = VFU_PRM;
            vexec.vpermop = VPRM_SLU;
        end
        VSLIDEDOWN: begin
            vexec.vfu = VFU_PRM;
            vexec.vpermop = VPRM_SLD;
        end
        VADC: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_ADC;
            disable_mask = 1'b1; 
        end
        VMADC: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = vm_bit ? VALU_VMADC : VALU_VMADC_NO_C; // Assuming VMADC uses the same operation as ADC
            disable_mask = 1'b1; 
        end
        VSBC: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_SBC;
            disable_mask = 1'b1; 
        end
        VMSBC: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = vm_bit ? VALU_VMSBC : VALU_VMSBC_NO_B; // Assuming VMSBC uses the same operation as SBC
            disable_mask = 1'b1;
        end
        VMERGE: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = vm_bit ? VALU_INT_MOVE : VALU_MERGE; 
            disable_mask = 1'b1; 
        end
        VMSEQ: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_SEQ;
        end
        VMSNE: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_SNE;
        end
        VMSLTU: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_SLT;
            vexec.vopunsigned = 1'b1;
        end
        VMSLT: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_SLT;
        end
        VMSLEU: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_SLE;
            vexec.vopunsigned = 1'b1;
        end
        VMSLE: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_SLE;
        end
        VMSGTU: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_SGT;
            vexec.vopunsigned = 1'b1;
        end
        VMSGT: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_SGT;
        end
        VSADDU: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_ADD; // Assuming VSADDU uses the same operation as ADD
            vexec.vopunsigned = 1'b1;
        end
        VSADD: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_ADD; // Assuming VSADD uses the same operation as ADD
        end
        VSSUBU: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_SUB; // Assuming VSSUBU uses the same operation as SUB
            vexec.vopunsigned = 1'b1;
        end
        VSSUB: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_SUB; // Assuming VSSUB uses the same operation as SUB
        end
        VSLL: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_SLL;
        end
        VSMUL: begin
            vexec.vfu = VFU_MUL;
        end
        VSRL: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_SRL;
            vexec.vopunsigned = 1'b1; 
        end
        VSRA: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_SRA;
        end
        VSSRL: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_SRL; // Assuming VSSRL uses the same operation as SRL
        end
        VSSRA: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_SRA; // Assuming VSSRA uses the same operation as SRA
        end
        VNSRL: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_SRL; // Assuming VNSRL uses the same operation as SRL
            vexec.vopunsigned = 1'b1; 
        end
        VNSRA: begin
            vexec.vfu = VFU_ALU;
            vexec.valuop = VALU_SRA; // Assuming VNSRA uses the same operation as SRA
        end
        VNCLIPU: begin
            /* UNIMPLEMENTED */
            valid = 1'b0;
        end
        VNCLIP: begin
            /* UNIMPLEMENTED */
            valid = 1'b0;
        end
        VWREDSUMU: begin
            vexec.vfu = VFU_RED;
            vexec.vredop = VRED_SUM;
        end
        VWREDSUM: begin
            vexec.vfu = VFU_RED;
            vexec.vredop = VRED_SUM;
        end
        default: begin
            // If no op matched, this must not be a supported vopi
            valid = 1'b0;
        end
    endcase


    case(vfunct3)
        3'd1, 3'd2, 3'd5, 3'd6: valid = 0; // prevent overlap with opm and opf encodings 
    endcase 
end

endmodule

