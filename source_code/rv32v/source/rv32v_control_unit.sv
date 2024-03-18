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

always_comb begin
    // Default values based on register select fields
    vd_sel = '{regclass: RC_VECTOR, regidx: vd + {2'b00, vreg_offset}};
    vs1_sel = '{regclass: RC_VECTOR, regidx: vs1 + {2'b00, vreg_offset}};
    vs2_sel = '{regclass: RC_VECTOR, regidx: vs2 + {2'b00, vreg_offset}};

    // Override vs1 to vs3 in case of a store
    if (vmemdwen) begin
        vs1_sel = '{regclass: RC_VECTOR, regidx: vs3 + {2'b00, vreg_offset}};
    end

    // Override selects completely in case of a reduction
    if (vredinstr) begin
        vd_sel = vd_sel_red;
        vs1_sel = vs1_sel_red;
        vs2_sel = vs2_sel_red;
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
    end
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
rv32v_opm_decode U_OPMDECODE(
    .vopm(vopm),
    .vfunct3(vfunct3), 
    .vsew(vcu_if.vsew),
    .vs1_sel(vs1), 
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

    if (vredinstr && !vmask_red) begin
        vcu_if.vcontrol.vmask_en = 0;
    end
end


/**********************************************************/
/* MEMORY CONTROL SIGNALS
/**********************************************************/
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

/**********************************************************/
/* UOP GENERATION UNIT
/**********************************************************/
logic [2:0] vreg_offset;
logic vgen_uops;

rv32v_uop_gen_if vug_if();

assign vgen_uops = vmajoropcode_valid && !(vmajoropcode == VMOC_ALU_CFG && vfunct3 == OPCFG);

assign vug_if.gen = vgen_uops;
assign vug_if.stall = vcu_if.stall;
assign vug_if.veew = veew_dest;
assign vug_if.vl = (vredinstr) ? vl_red : mem_evl;

assign vcu_if.vcontrol.vuop_num = vug_if.vuop_num;
assign vcu_if.vcontrol.vbank_offset = vug_if.vbank_offset;
assign vreg_offset = vug_if.vreg_offset;
assign vcu_if.vcontrol.vlaneactive = vug_if.vlane_active;
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
word_t vl_red;

assign vopi_red = (vopi_valid && vexec_opi.vfu == VFU_RED);
assign vopm_red = (vopm_valid && vexec_opm.vfu == VFU_RED);
assign vredinstr = (vopi_red || vopm_red);

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
    vd_sel_red = '{regclass: RC_VECTOR, regidx: vd + {2'b00, vreg_offset}};
    vs1_sel_red = '{regclass: RC_VECTOR, regidx: vs1 + {2'b00, vreg_offset}};
    vs2_sel_red = '{regclass: RC_VECTOR, regidx: vs2 + {2'b00, vreg_offset}};
    vl_red = vcu_if.vl;
    busy_red = 0;
    vmask_red = 1;

    case (redstate)
        REDC_IDLE: begin
            if (vredinstr) begin
                // If we get a new reduction, copy vs2 to the scratch register
                vexec_red.vfu = VFU_PASS_VS2;
                vd_sel_red = '{regclass: RC_SCRATCH, regidx: '0};
                vs2_sel_red = '{regclass: RC_VECTOR, regidx: vs2};
                busy_red = 1;

                if (vcu_if.vl > 4) begin
                    // If we have more than 4 elements, we'll need to reduce to 4
                    next_redstate = REDC_UNTIL_4;
                end else if (vcu_if.vl > 1) begin
                    // If we have 3 or 4 elements, go straight to the reduce 4 step
                    next_redstate = REDC_LAST_4;
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
            vs1_sel_red = '{regclass: RC_SCRATCH, regidx: '0};
            vs2_sel_red = '{regclass: RC_SCRATCH, regidx: '0};
            busy_red = 1;
            vmask_red = 0;

            next_redstate = REDC_FINAL;
        end

        REDC_FINAL: begin
            // Op the bottom element of the scratch register with the bottom element of vs1
            // and put the result into the destination register
            vexec_red.vfu = VFU_ALU;
            vs2_sel_red = '{regclass: RC_SCRATCH, regidx: '0};
            vl_red = 1;
            busy_red = 0;
            vmask_red = 0;

            next_redstate = REDC_IDLE;
        end
    endcase
end


endmodule
