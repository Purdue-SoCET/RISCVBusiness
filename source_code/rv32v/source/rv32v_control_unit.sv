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
*   Filename:     rv32v_control_unit.sv
*
*   Created by:   Om Gupta
*   Email:        guptao@purdue.edu
*   Date Created: 11/13/2023
*   Description:  Vector instruction decode unit
*/

`include "rv32v_control_unit_if.vh"
import rv32v_types_pkg::*; 

module rv32v_control_unit(
    input logic CLK,
    input logic nRST,
    rv32v_control_unit_if.vcu vcu_if
);

import rv32i_types_pkg::*;
import rv32v_types_pkg::*;

//enable or disable masking by looking at bit 25
assign vcu_if.vcontrol.vmask_en = (vopi_valid && vopi_disable_mask) ? 1'b0 : ~vcu_if.instr[25]; 

// Register select extraction
logic [4:0] vd, vs1, vs2, vs3;
logic [4:0] rd, rs1, rs2;

assign rd  = vcu_if.instr[11:7];
assign vd  = vcu_if.instr[11:7];
assign vs3 = vcu_if.instr[11:7];

assign rs1 = vcu_if.instr[19:15];
assign vs1 = vcu_if.instr[19:15];

assign rs2 = vcu_if.instr[24:20];
assign vs2 = vcu_if.instr[24:20];

// Major opcode extraction
vmajoropcode_t vmajoropcode;
logic vmajoropcode_valid;

always_comb begin
    // Assume the instruction is a vector instruction
    vmajoropcode_valid = 1'b1;
    case (vcu_if.instr[6:0])
        VMOC_LOAD: vmajoropcode = VMOC_LOAD;
        VMOC_STORE: vmajoropcode = VMOC_STORE;
        // VMOC_AMO not supported in this version
        VMOC_ALU_CFG: vmajoropcode = VMOC_ALU_CFG;
        default: begin
            // If the opcode didn't match any of our major opcodes, it's not a vector instruction
            vmajoropcode_valid = 1'b0;
        end
    endcase
end

// Load/store mop extraction
mop_t mop;  // Used for determining load/store addressing mode
assign mop = mop_t'(vcu_if.instr[27:26]);

// ALU vfunct3 extraction
vfunct3_t vfunct3;  // Used for determining arithmetic instruction format
assign vfunct3 = vfunct3_t'(vcu_if.instr[14:12]);

// ALU vfunct6 extraction
logic [5:0] vfunct6;  // Used for determining operation
assign vfunct6 = vcu_if.instr[31:26];

vopi_t vopi;
vopm_t vopm;
assign vopi = vopi_t'(vfunct6);
assign vopm = vopm_t'(vfunct6);

// CFG instructions
always_comb begin
    // Set the vset* type based on the top two bits
    vcu_if.vcontrol.vtype_imm = '0; 
    vcu_if.vcontrol.vkeepvl = 0; 
    casez (vcu_if.instr[31:30])
        2'b0?: begin 
            vcu_if.vcontrol.vsetvl_type = VSETVLI;
            vcu_if.vcontrol.vtype_imm = {'0, vcu_if.instr[30:20]}; 
            if(vcu_if.rs1.regidx == 0 && vcu_if.rd.regidx == 0)
                vcu_if.vcontrol.vkeepvl = 1; 
        end 
        2'b11: begin 
            vcu_if.vcontrol.vsetvl_type = VSETIVLI;
            vcu_if.vcontrol.vtype_imm = {'0, vcu_if.instr[29:20]}; 
        end
        2'b10: begin
            vcu_if.vcontrol.vsetvl_type = VSETVL;
            if(vcu_if.rs1.regidx == 0 && vcu_if.rd.regidx == 0)
                vcu_if.vcontrol.vkeepvl = 1; 
        end
    endcase

    // If it wasn't actually a vset* instruction, set the null type
    if (!(vmajoropcode == VMOC_ALU_CFG && vfunct3 == OPCFG)) begin
        vcu_if.vcontrol.vsetvl_type = NOT_CFG;
        vcu_if.vcontrol.vtype_imm = '0; 
    end


end

// Register select
assign vcu_if.vcontrol.vd_sel = '{regclass: RC_VECTOR, regidx: vd + {2'b00, vreg_offset}};
assign vcu_if.vcontrol.vs2_sel = '{regclass: RC_VECTOR, regidx: vs2 + {2'b00, vreg_offset}};
assign vcu_if.vcontrol.vs1_sel = '{
    regclass: RC_VECTOR,
    regidx: ((vmajoropcode == VMOC_STORE) ? vs3 : vs1) + {2'b00, vreg_offset}
};

// Register write enables
logic sregwen;
assign vcu_if.vcontrol.sregwen = sregwen;

assign sregwen = (vmajoropcode == VMOC_ALU_CFG && vfunct3 == OPCFG) ||                        // vset* instructions
                 (vmajoropcode == VMOC_ALU_CFG && vfunct3 == OPMVV && vfunct6 == VWXUNARY0);  // VWXUNARY instructions

assign vcu_if.vcontrol.vregwen = (!sregwen) &&                  // Scalar write instructions
                                 (vmajoropcode != VMOC_STORE);  // Store instructions


// Execution value select
assign vcu_if.vcontrol.vxin1_use_imm = (vmajoropcode == VMOC_ALU_CFG) &&
                                       (vfunct3 == OPIVI);

assign vcu_if.vcontrol.vxin1_use_rs1 = (vmajoropcode == VMOC_LOAD) ||
                                       (vmajoropcode == VMOC_STORE) ||
                                       (vmajoropcode == VMOC_ALU_CFG && vfunct3 == OPIVX) ||
                                       (vmajoropcode == VMOC_ALU_CFG && vfunct3 == OPFVF) ||
                                       (vmajoropcode == VMOC_ALU_CFG && vfunct3 == OPMVX);

assign vcu_if.vcontrol.vxin2_use_rs2 = (vmajoropcode == VMOC_LOAD || vmajoropcode == VMOC_STORE) && 
                                       ~(mop == MOP_UINDEXED || mop == MOP_OINDEXED);

// Alignment unit signals
logic vwidening, vnarrowing;
width_t vmem_width;
vsew_t vmem_eew;
vsew_t twice_vsew;

vsew_t veew_src1, veew_src2, veew_dest;

assign vmem_width = width_t'(vcu_if.instr[14:12]);
assign vmem_eew = (vmem_width == WIDTH8 ) ? SEW8 :
                  (vmem_width == WIDTH16) ? SEW16 :
                                            SEW32;

assign vwidening = (vfunct6[5:4] == 2'b11);
assign vnarrowing = (((vopi == VNSRL) ||
                    (vopi == VNSRA) ||
                    (vopi == VNCLIPU) ||
                    (vopi == VNCLIP)) && (vopi_valid) ) ||
                    (((vopm == VNMSUB) ||
                    (vopm == VNMSAC)) && (vopm_valid) );

assign twice_vsew = vsew_t'(vcu_if.vsew + 1);

// For strided (including unit stride) store instructions, data uses instr.width
// For indexed store instructions, vs3 is data which uses vtype.vsew
assign veew_src1 = (vmeminstr && ~vindexed) ? vmem_eew : vcu_if.vsew;

// For indexed load/store instructions, addr is vs2 which uses instr.width
assign veew_src2 = vindexed   ? vmem_eew :
                   vnarrowing ? twice_vsew :
                   (vopm_valid) ? vopm_veew_src2 : vcu_if.vsew;

// For strided (including unit stride) load instructions, data uses instr.width
// For indexed load instructions, vd is data which uses vtype.vsew
assign veew_dest = vunitstride ? vmem_eew :
                   vstrided    ? vmem_eew :
                   vindexed    ? vcu_if.vsew :
                   vwidening   ? twice_vsew :
                                 vcu_if.vsew;

assign vcu_if.vcontrol.veew_src1 = veew_src1;
assign vcu_if.vcontrol.veew_src2 = veew_src2;
assign vcu_if.vcontrol.veew_dest = veew_dest;


// OPI* execution unit control signals
vexec_t vexec_opi;
logic vopi_valid_fn;
logic vopi_disable_mask; 
rv32v_opi_decode U_OPIDECODE(
    .vopi(vopi),
    .vfunct3(vfunct3),
    .vm_bit(vcu_if.instr[25]), 
    .vexec(vexec_opi),
    .valid(vopi_valid_fn),
    .disable_mask(vopi_disable_mask)
);
logic vopi_valid; 
assign vopi_valid = vopi_valid_fn && (vmajoropcode==VMOC_ALU_CFG); 

// OPM* execution unit control signals
vexec_t vexec_opm;
logic vopm_valid_fn;
logic widen_vs2; 
vsew_t vopm_veew_src2; 
rv32v_opm_decode U_OPMDECODE(
    .vopm(vopm),
    .vfunct3(vfunct3), 
    .vsew(vcu_if.vsew),
    .vs1_sel(vs1), 
    .vexec(vexec_opm),
    .valid(vopm_valid_fn),
    .veew_src2(vopm_veew_src2)
);
logic vopm_valid; 
assign vopm_valid = vopm_valid_fn && (vmajoropcode==VMOC_ALU_CFG); 

// Final execution unit control signals
logic vexecute_valid;

always_comb begin
    // Assume that execute signals are valid by default
    vexecute_valid = 1'b1;

    // Arbitrary defaults just to prevent latches
    vcu_if.vcontrol.vexec.vfu = VFU_ALU;
    vcu_if.vcontrol.vexec.valuop = VALU_ADD;
    vcu_if.vcontrol.vexec.vredop = VRED_AND;
    vcu_if.vcontrol.vexec.vmaskop = VMSK_AND;
    vcu_if.vcontrol.vexec.vpermop = VPRM_CPS;
    vcu_if.vcontrol.vexec.vopunsigned = 1'b0;
    vcu_if.vcontrol.vsignext = 1'b0; 

    unique case ({vopi_valid, vopm_valid, vmeminstr})
        3'b100: begin
            vcu_if.vcontrol.vexec = vexec_opi;
            vcu_if.vcontrol.vsignext = ~vexec_opi.vopunsigned; 
        end

        3'b010: begin
            vcu_if.vcontrol.vexec = vexec_opm;
            vcu_if.vcontrol.vsignext = ~vexec_opi.vopunsigned; 
        end

        3'b001: begin
            vcu_if.vcontrol.vexec.vfu = VFU_ALU;
            vcu_if.vcontrol.vexec.valuop = VALU_ADD;
        end
        
        default: begin
            // None of opi, opm, and memory instructions decoded correctly
            vexecute_valid = 1'b0;
        end
    endcase
end

// Memory signals
logic vmeminstr, vmemdren, vmemdwen, vunitstride, vstrided, vindexed, vmaskldst, vwholereg;;
lumop_t lumop;
logic [3:0] nf;
word_t vlby8, mask_evl, wholereg_evl, mem_evl;

assign lumop = lumop_t'(vcu_if.instr[24:20]);
assign nf = vcu_if.instr[31:29] + 1;

assign vmemdren = (vmajoropcode == VMOC_LOAD);
assign vmemdwen = (vmajoropcode == VMOC_STORE);

assign vunitstride = vmeminstr && (mop == MOP_UNIT);
assign vstrided = vmeminstr && (mop == MOP_STRIDED);
assign vindexed = vmeminstr && ((mop == MOP_OINDEXED) || (mop == MOP_UINDEXED));

assign vmeminstr = (vmemdren || vmemdwen);

assign vcu_if.vcontrol.vmemdren = vmemdren;
assign vcu_if.vcontrol.vmemdwen = vmemdwen;
assign vcu_if.vcontrol.vunitstride = vunitstride;
assign vcu_if.vcontrol.vstrided = vstrided;
assign vcu_if.vcontrol.vindexed = vindexed;

assign vmaskldst = (lumop == LUMOP_UNIT_MASK);
assign vwholereg = (lumop == LUMOP_UNIT_FULLREG);

// For mask load/store, evl = ceil(vl/8)
assign vlby8 = (vcu_if.vl >> 3);
assign mask_evl = (vcu_if.vl[2:0] ? vlby8 + 1 : vlby8);

// For whole register load/store, evl = NFIELDS*VLEN/EEW = (nf << 4) >> eew
assign wholereg_evl = ({nf, 4'b0} >> veew_dest);

// Resolve the final evl
assign mem_evl = (vmaskldst) ? (mask_evl) :
                 (vwholereg) ? (wholereg_evl) :
                               (vcu_if.vl);

// uop generation unit
logic [2:0] vreg_offset;

rv32v_uop_gen_if vug_if();

assign vug_if.gen = vcu_if.vvalid;
assign vug_if.stall = vcu_if.stall;
assign vug_if.veew = veew_dest;
assign vug_if.vl = mem_evl;

assign vcu_if.vcontrol.vuop_num = vug_if.vuop_num;
assign vcu_if.vcontrol.vbank_offset = vug_if.vbank_offset;
assign vreg_offset = vug_if.vreg_offset;
assign vcu_if.vcontrol.vlaneactive = vug_if.vlane_active;
assign vcu_if.vbusy = vug_if.busy;
assign vcu_if.vvalid = vmajoropcode_valid;

rv32v_uop_gen U_UOPGEN(
    .CLK(CLK),
    .nRST(nRST),
    .vug_if(vug_if)
);

endmodule
