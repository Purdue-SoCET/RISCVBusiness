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

/**********************************************************/
/* FIELD EXTRACTION
/**********************************************************/

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

assign vcu_if.vcontrol.vimm = vcu_if.instr[19:15]; 
assign vug_if.nf_seg = vcu_if.instr[31:29]; 

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
            vmajoropcode = VMOC_INVALID;
            vmajoropcode_valid = 1'b0;
        end
    endcase
end

// Load/store mop extraction
mop_t mop;  // Used for determining load/store addressing mode
assign mop = mop_t'(vcu_if.instr[27:26]);

assign vug_if.is_seg_op = vmeminstr && (vug_if.nf_seg != 0) && ~vmaskldst && ~vwholereg ; 
assign vcu_if.vcontrol.vseg_op = vug_if.is_seg_op; 
assign vcu_if.vcontrol.vnew_seg = vug_if.new_seg; 
assign vcu_if.vcontrol.nf_counter = vug_if.nf_counter; 

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

// Mask enable extraction
logic vencmasken;
assign vencmasken = (vfunct3 != OPCFG) && !vcu_if.instr[25];

/**********************************************************/
/* CFG (VSET*) INSTRUCTIONS
/**********************************************************/
always_comb begin
    // Set the vset* type based on the top two bits
    vcu_if.vcontrol.vtype_imm = '0; 
    vcu_if.vcontrol.vkeepvl = 0; 
    vcu_if.vcontrol.vuop_last = 0;  // to prevent setting vstart if vset*
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
        vcu_if.vcontrol.vuop_last = vug_if.vuop_last;
    end
end

/**********************************************************/
/* REGISTER FILE CONTROL SIGNALS
/**********************************************************/

// Register select
regsel_t vd_sel, vs1_sel, vs2_sel;
regsel_t vd_sel_red, vs1_sel_red, vs2_sel_red;

logic vmskst_instr; 
assign vmskset_instr = vopi_valid && (
                        vexec_opi.valuop == VALU_SEQ || // MOVE THIS TO DECODE
                        vexec_opi.valuop == VALU_SNE ||
                        vexec_opi.valuop == VALU_SLT ||
                        vexec_opi.valuop == VALU_SLE ||
                        vexec_opi.valuop == VALU_SGT ||
                        vexec_opi.valuop == VALU_VMADC_NO_C ||
                        vexec_opi.valuop == VALU_VMADC ||
                        vexec_opi.valuop == VALU_VMSBC_NO_B ||
                        vexec_opi.valuop == VALU_VMSBC
                       );
always_comb begin
    // Default values based on register select fields
    vd_sel = '{regclass: RC_VECTOR, regidx: vd + {2'b00, vug_if.vreg_offset_dest}};
    vs1_sel = '{regclass: RC_VECTOR, regidx: vs1 + {2'b00, vug_if.vreg_offset_src1}};
    vs2_sel = '{regclass: RC_VECTOR, regidx: vs2 + {2'b00, vug_if.vreg_offset_src2}};

    // Override vs1 to vs3 in case of a store
    if (vmemdwen) begin
        vs1_sel = '{regclass: RC_VECTOR, regidx: vs3 + {2'b00, vug_if.vreg_offset_dest}};
    end

    // Override selects completely in case of a reduction
    if (vredinstr) begin
        vd_sel = vd_sel_red;
        vs1_sel = vs1_sel_red;
        vs2_sel = vs2_sel_red;
    end

    // Override in case of mask setting instructions (vd value never changes even of vs1 and vs2 do due to LMUL settings)
    if(vmskset_instr) begin
        vd_sel = '{regclass: RC_VECTOR, regidx: vd};
    end 

    if(vmask_calc_instr && vmask_calc_instr_uop) begin
        vs2_sel = '{regclass: RC_VECTOR, regidx: vs2};
    end

    // Override in case of permutation instructions (currently only slide(1)up/slide(1)down)
    if (vperminstr) begin
        vd_sel = vd_sel_perm;
    end
end

assign vcu_if.vcontrol.vd_sel = vd_sel;
assign vcu_if.vcontrol.vs1_sel = vs1_sel;
assign vcu_if.vcontrol.vs2_sel = vs2_sel;

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

// Vector-scalar move
assign vcu_if.vcontrol.vmv_s_x = (vopm == VWXUNARY0 && vfunct3 == OPMVX && vopm_valid && vs2_sel.regidx == 0);

/**********************************************************/
/* WIDTH CONTROL LOGIC
/**********************************************************/
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
logic vmask_calc_instr; 
logic vmask_calc_instr_uop;
assign vmask_calc_instr = (vopm_valid) &&  (
                            vexec_opm.vmaskop == VMSK_CNT ||
                            vexec_opm.vmaskop == VMSK_FST || 
                            vexec_opm.vmaskop == VMSK_SBF || 
                            vexec_opm.vmaskop == VMSK_SIF || 
                            vexec_opm.vmaskop == VMSK_SOF || 
                            vexec_opm.vmaskop == VMSK_ITA || 
                            vexec_opm.vmaskop == VMSK_IDX ); 
assign vmask_calc_instr_uop = (vexec_opm.vmaskop == VMSK_ITA || 
                              vexec_opm.vmaskop == VMSK_IDX ); 
// assign vmask_calc_instr_uop = 0; 
//assign vmask_calc_instr = 0; 

logic vmask_logical_instr;
assign vmask_logical_instr = (vopm_valid) &&  (
                            vopm == VMANDN ||
                            vopm == VMAND  || 
                            vopm == VMNAND || 
                            vopm == VMOR   || 
                            vopm == VMORN  || 
                            vopm == VMNOR  || 
                            vopm == VMXOR  || 
                            vopm == VMXNOR ); 

logic[2:0] vlmul_bits;
logic[2:0] vsew_bits; 
assign vlmul_bits = vcu_if.vlmul; 
assign vsew_bits = vcu_if.vsew; 
always_comb begin
    // Use VSEW for everything by default
    veew_src1 = vcu_if.vsew;
    veew_src2 = vcu_if.vsew;
    veew_dest = vcu_if.vsew;

    // For a narrowing instruction, src2 uses 2*SEW
    if (vnarrowing) begin
        veew_src2 = twice_vsew;
    end

    // For a widening instruction, dest uses 2*SEW
    if (vwidening) begin
        veew_dest = twice_vsew;
    end

    // Non-indexed store instructions use instr.width for data src and dest
    if (vmeminstr && !vindexed) begin
        veew_src1 = vmem_eew;
        veew_dest = vmem_eew;
    end

    // Indexed load/store instructions use instr.width for the addr
    if (vmeminstr && vindexed) begin
        veew_src2 = vmem_eew;
    end

    // Override special src2 widths for OPM instructions
    if (vopm_valid) begin
        veew_src2 = vopm_veew_src2;

        // Override with mask logical instructions (operate on all 128 bits in a register regardless of LMUL, SEW, and VL values)
        if(vfunct6[5:3] == 3'b011) begin
            veew_src1 = SEW32; 
            veew_src2 = SEW32;
            veew_dest = SEW32; 
        end
    end

    if(vmask_calc_instr) begin
        veew_src2 = SEW32; 
        veew_dest = SEW32;

        if(vmask_calc_instr_uop)
            veew_dest = vcu_if.vsew;  
    end

    // Override vs1 width for reduction finalization
    if (vredinstr && redstate == REDC_FINAL) begin
        veew_src1 = veew_dest;
    end


    // emul logic for segment load/store instructions 
    vug_if.emul_dest = vlmul_t'((vlmul_bits + veew_dest) - vsew_bits); 
    if(vug_if.emul_dest > 3'd3)
        vug_if.emul_dest = LMUL1; 
    
    vug_if.emul_src1 = vlmul_t'((vlmul_bits + veew_src1) - vsew_bits); 
    if(vug_if.emul_src1 > 3'd3)
        vug_if.emul_src1 = LMUL1; 
end

assign vcu_if.vcontrol.veew_src1 = veew_src1;
assign vcu_if.vcontrol.veew_src2 = veew_src2;
assign vcu_if.vcontrol.veew_dest = veew_dest;

/**********************************************************/
/* EXECUTION UNIT DECODE LOGIC
/**********************************************************/

// OPI* execution unit control signals
vexec_t vexec_opi;
logic vopi_decode_valid;
logic vopi_disable_mask; 
vsew_t vopi_veew_dest; 
rv32v_opi_decode U_OPIDECODE(
    .vopi(vopi),
    .vfunct3(vfunct3),
    .vm_bit(vcu_if.instr[25]), 
    .vsew(vcu_if.vsew), 
    
    .vexec(vexec_opi),
    .valid(vopi_decode_valid),
    .disable_mask(vopi_disable_mask)
);

// OPM* execution unit control signals
vexec_t vexec_opm;
logic vopm_decode_valid;
logic widen_vs2; 
vsew_t vopm_veew_src2; 
logic vopm_disable_mask; 
rv32v_opm_decode U_OPMDECODE(
    .vopm(vopm),
    .vfunct3(vfunct3), 
    .vsew(vcu_if.vsew),
    .vs1_sel(vs1), 
    .disable_mask(vopm_disable_mask), 
    .vexec(vexec_opm),
    .valid(vopm_decode_valid),
    .veew_src2(vopm_veew_src2)
);

// Final execution unit control signals
logic vopi_valid;
logic vopm_valid;
logic vexecute_valid;

assign vopi_valid = (vmajoropcode == VMOC_ALU_CFG &&
                     vopi_decode_valid &&
                     (vfunct3 == OPIVV ||
                      vfunct3 == OPIVI ||
                      vfunct3 == OPIVX));
assign vopm_valid = (vmajoropcode == VMOC_ALU_CFG &&
                     vopm_decode_valid &&
                     (vfunct3 == OPMVV ||
                      vfunct3 == OPMVX));

always_comb begin
    // Arbitrary defaults just to prevent latches
    vcu_if.vcontrol.vexec.vfu = VFU_PASS_VS1;
    vcu_if.vcontrol.vexec.valuop = VALU_ADD;
    vcu_if.vcontrol.vexec.vmaskop = VMSK_AND;
    vcu_if.vcontrol.vexec.vpermop = VPRM_CPS;
    vcu_if.vcontrol.vexec.vopunsigned = 1'b0;
    vcu_if.vcontrol.vsignext = 1'b0; 
    vexecute_valid = 1'b0;

    unique case ({vopi_valid, vopm_valid, vmeminstr, vredinstr})
        4'b1000: begin
            vcu_if.vcontrol.vexec = vexec_opi;
            vcu_if.vcontrol.vsignext = ~vexec_opi.vopunsigned;
            vexecute_valid = 1'b1;
        end

        4'b0100: begin
            vcu_if.vcontrol.vexec = vexec_opm;
            vcu_if.vcontrol.vsignext = ~vexec_opm.vopunsigned; 
            vexecute_valid = 1'b1;
        end

        4'b0010: begin
            vcu_if.vcontrol.vexec.vfu = VFU_ALU;
            vcu_if.vcontrol.vexec.valuop = VALU_ADD;
            vexecute_valid = (vmajoropcode == VMOC_LOAD || vmajoropcode == VMOC_STORE);
        end

        4'b1001, 4'b0101: begin
            vcu_if.vcontrol.vexec = vexec_red;
            vcu_if.vcontrol.vsignext = ~vexec_red.vopunsigned;
            vexecute_valid = 1'b1;
        end

        default: begin
            vexecute_valid = 1'b0;
        end
    endcase
end

// Mask enable logic
always_comb begin
    vcu_if.vcontrol.vmask_en = vencmasken;

    if (vopi_valid && vopi_disable_mask) begin
        vcu_if.vcontrol.vmask_en = 0;
    end
    
    if(vopm_valid && vopm_disable_mask) begin
        vcu_if.vcontrol.vmask_en = 0; 
    end

    if (vredinstr && !vmask_red) begin
        vcu_if.vcontrol.vmask_en = 0;
    end
end

// Whole register move logic
logic [3:0] nreg;
logic wholereg_mv;
word_t wholereg_mv_evl;

assign nreg = vcu_if.instr[17:15] + 1;

assign wholereg_mv = (vopi_valid) && vopi == VSMUL && vfunct3 == OPIVI;

// For whole register move, evl = NREG*VLEN/EEW = (simm[2:0] << 4) >> eew
assign wholereg_mv_evl = ({nreg, 4'b0} >> veew_dest);

/**********************************************************/
/* MEMORY CONTROL SIGNALS
/**********************************************************/
logic vmeminstr, vmemdren, vmemdwen, vunitstride, vstrided, vindexed, vmaskldst, vwholereg;;
lumop_t lumop;
logic [3:0] nf;
word_t vlby8, mask_evl, wholereg_ldst_evl, mem_evl;

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

assign vmaskldst = (lumop == LUMOP_UNIT_MASK) && (mop == MOP_UNIT);
assign vwholereg = (lumop == LUMOP_UNIT_FULLREG) && (mop == MOP_UNIT);

// For mask load/store, evl = ceil(vl/8)
assign vlby8 = (vcu_if.vl >> 3);
assign mask_evl = (vcu_if.vl[2:0] ? vlby8 + 1 : vlby8);

// For whole register load/store, evl = NFIELDS*VLEN/EEW = (nf << 4) >> eew
assign wholereg_ldst_evl = ({nf, 4'b0} >> veew_dest);

// Resolve the final evl
assign mem_evl = (vmaskldst) ? (mask_evl) :
                 (vwholereg) ? (wholereg_ldst_evl) :
                               (vcu_if.vl);

/**********************************************************/
/* UOP GENERATION UNIT
/**********************************************************/
logic [2:0] vreg_offset;
logic vgen_uops;

rv32v_uop_gen_if vug_if();

always_comb begin
    vgen_uops = vmajoropcode_valid;

    // Suppress uop generation for vset* instructions
    if (vmajoropcode == VMOC_ALU_CFG && vfunct3 == OPCFG) begin
        vgen_uops = 0;
    end

    // Suppress uop generation for mask calc instructions
    if (vopm_valid && (vmask_logical_instr || (vmask_calc_instr && ~vmask_calc_instr_uop))) begin
        vgen_uops = 0;
    end

    // Suppress uop generation for vector-scalar move instructions
    if (vopm_valid && vfunct6 == VWXUNARY0 && (vfunct3 == OPMVV || vfunct3 == OPMVX)) begin
        vgen_uops = 0;
    end
end

assign vug_if.gen = vgen_uops;
assign vug_if.stall = vcu_if.stall;
//assign vug_if.veew = veew_dest;
assign vug_if.veew_dest = veew_dest; 
assign vug_if.veew_src1 = veew_src1; 
assign vug_if.veew_src2 = veew_src2; 


assign vug_if.vl = (vredinstr)        ? vl_red : 
                   (vperm_var_offset) ? vl_perm : 
                   (wholereg_mv)      ? wholereg_mv_evl :
                                        mem_evl;

assign vcu_if.vcontrol.vuop_num = vug_if.vuop_num;
assign vcu_if.vcontrol.vbank_offset = vug_if.vbank_offset;
assign vreg_offset = vug_if.vreg_offset_dest;

// vlane active logic
always_comb begin
    assign vcu_if.vcontrol.vlaneactive = vug_if.vlane_active; 

    if(vmask_logical_instr)
        vcu_if.vcontrol.vlaneactive = '1; 
    else if(vmask_calc_instr && ~vmask_calc_instr_uop)
        vcu_if.vcontrol.vlaneactive = '1; 

end 
//assign vcu_if.vcontrol.vlaneactive = vug_if.vlane_active;
assign vcu_if.vbusy = (vredinstr) ? busy_red : vug_if.busy;
assign vcu_if.vcontrol.vvalid = vmajoropcode_valid;
assign vcu_if.vvalid = vmajoropcode_valid;

rv32v_uop_gen U_UOPGEN(
    .CLK(CLK),
    .nRST(nRST),
    .vug_if(vug_if)
);

/**********************************************************/
/* REDUCTION CONTROL LOGIC
/**********************************************************/
logic vopi_red, vopm_red, vredinstr;
vexec_t vexec_red;
logic busy_red;
logic vmask_red;
logic vpad_red;
word_t vl_red;

assign vopi_red = (vopi_valid && vexec_opi.vfu == VFU_RED);
assign vopm_red = (vopm_valid && vexec_opm.vfu == VFU_RED);
assign vredinstr = (vopi_red || vopm_red);

assign vcu_if.vcontrol.vpadscratch = vpad_red;

typedef enum logic [3:0] {
    REDC_IDLE,
    REDC_UNTIL_4,
    REDC_LAST_4,
    REDC_FINAL
} red_state_t;

red_state_t redstate, next_redstate;

always_ff @(posedge CLK, negedge nRST) begin
    if (!nRST) begin
        redstate <= REDC_IDLE;
    end else if (!vcu_if.stall) begin
        redstate <= next_redstate;
    end
end

always_comb begin
    vexec_red = (vopi_red) ? vexec_opi : vexec_opm;
    vd_sel_red = '{regclass: RC_VECTOR, regidx: vd + {2'b00, vug_if.vreg_offset_dest}};
    vs1_sel_red = '{regclass: RC_VECTOR, regidx: vs1 + {2'b00, vug_if.vreg_offset_src1}};
    vs2_sel_red = '{regclass: RC_VECTOR, regidx: vs2 + {2'b00, vug_if.vreg_offset_src2}};
    vl_red = vcu_if.vl;
    vpad_red = 0;
    busy_red = 0;
    vmask_red = 1;

    case (redstate)
        REDC_IDLE: begin
            if (vredinstr) begin
                // If we get a new reduction, copy vs2 to the scratch register
                busy_red = 1;

                if (vcu_if.vl > 4) begin
                    // If we have more than 4 elements, copy vs2 to the scratch
                    // register to set up for reducing down to 4 elements
                    vexec_red.vfu = VFU_PASS_VS2;
                    vd_sel_red = '{regclass: RC_SCRATCH, regidx: '0};
                    vs2_sel_red = '{regclass: RC_VECTOR, regidx: vs2};
                    vpad_red = 1;
                    next_redstate = REDC_UNTIL_4;
                end else if (vcu_if.vl > 1) begin
                    // If we have 2, 3, or 4 elements, we don't need to do the
                    // copy and can instead directly reduce into the scratch register
                    vexec_red.vfu = VFU_RED;
                    vd_sel_red = '{regclass: RC_SCRATCH, regidx: '0};
                    vs2_sel_red = '{regclass: RC_VECTOR, regidx: vs2};
                    next_redstate = REDC_FINAL;
                end else begin
                    // If we have just 1 element, the operation is a simple op
                    // between the lowest two elements of vs1 and vs2
                    vexec_red.vfu = VFU_ALU;
                    vd_sel_red = '{regclass: RC_VECTOR, regidx: vd};
                    vs1_sel_red = '{regclass: RC_VECTOR, regidx: vs1};
                    vs2_sel_red = '{regclass: RC_VECTOR, regidx: vs2};
                    busy_red = 0;

                    next_redstate = REDC_IDLE;  // and we're done
                end
            end else begin
                next_redstate = REDC_IDLE;
            end
        end

        REDC_UNTIL_4: begin
            // If we fix the src1 and dest register to the scratch register
            // then the uop generator will correctly generate uops that will
            // reduce the vector down to 4 elements since the scratch register
            // always stores elements at native (extended) width
            vexec_red.vfu = VFU_ALU;
            vd_sel_red = '{regclass: RC_SCRATCH, regidx: '0};
            vs1_sel_red = '{regclass: RC_SCRATCH, regidx: '0};
            busy_red = 1;

            if (!vug_if.busy) begin
                // This is the last uop for reducing down to 4
                next_redstate = REDC_LAST_4;
            end else begin
                next_redstate = REDC_UNTIL_4;
            end
        end

        REDC_LAST_4: begin
            // Use the reduction functional unit to reduce the final 4 elements into
            // the lane 0 of the scratch register (disable masking here)
            vexec_red.vfu = VFU_RED;
            vd_sel_red = '{regclass: RC_SCRATCH, regidx: '0};
            vs2_sel_red = '{regclass: RC_SCRATCH, regidx: '0};
            vl_red = 4;
            busy_red = 1;
            vmask_red = 0;

            next_redstate = REDC_FINAL;
        end

        REDC_FINAL: begin
            // Op the bottom element of the scratch register with the bottom element of vs1
            // and put the result into the destination register
            vexec_red.vfu = VFU_ALU;
            vd_sel_red = '{regclass: RC_VECTOR, regidx: vd};
            vs1_sel_red = '{regclass: RC_VECTOR, regidx: vs1};
            vs2_sel_red = '{regclass: RC_SCRATCH, regidx: '0};
            vl_red = 1;
            busy_red = 0;
            vmask_red = 0;

            next_redstate = REDC_IDLE;
        end
    endcase
end

/**********************************************************/
/* PERMUTATION CONTROL LOGIC
/**********************************************************/
logic vopi_perm, vopm_perm, vperminstr, vperm_var_offset;
regsel_t vd_sel_perm;
word_t vl_perm;

assign vopi_perm = (vopi_valid && vexec_opi.vfu == VFU_PRM);
assign vopm_perm = (vopm_valid && vexec_opm.vfu == VFU_PRM);
assign vperminstr = (vopi_perm || vopm_perm);
assign vperm_var_offset = (vopi_perm && ((vexec_opi.vpermop == VPRM_SLU) || (vexec_opi.vpermop == VPRM_SLD)));

assign vd_sel_perm = '{regclass: RC_SCRATCH, regidx: vd};
assign vl_perm = vcu_if.vl + 4;  // need extra uOP for offset%4 != 0

endmodule