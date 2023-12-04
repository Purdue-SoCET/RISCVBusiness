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

`include "rv32v_types_pkg.vh"

module rv32v_control_unit(
    input logic CLK,
    input logic nRST,
    rv32v_control_unit_if.vcu vcu_if
);

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

// Register select
assign vcu_if.vcontrol.vd_sel.regidx = '{regclass: RC_VECTOR, regidx: vd};
assign vcu_if.vcontrol.vs2_sel.regidx = '{regclass: RC_VECTOR, regidx: vs2};
assign vcu_if.vcontrol.vs1_sel.regidx = '{regclass: RC_VECTOR, regidx: (vmajoropcode == VMOC_STORE) ? vs3 : vs1};

assign vcu_if.vcontrol.sregwen = (vmajoropcode == VMOC_ALU_CFG && vfunct3 == OPCFG) ||                        // vset* instructions
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

assign vcu_if.vcontrol.vxin2_use_rs2 = (vmajoropcode == VMOC_LOAD || vmajoropcode_t == VMOC_STORE) && 
                                       (mop == MOP_UINDEXED || mop == MOP_OINDEXED);

// Alignment unit signals
logic vwidening, vnarrowing;
vsew_t twice_vsew;

assign vwidening = (vfunct6[5:4] == 2'b11);
assign vnarrowing = (vopi == VNSRL) ||
                    (vopi == VNSRA) ||
                    (vopi == VNCLIPU) ||
                    (vopi == VNCLIP) ||
                    (vopm == VNMSUB) ||
                    (vopm == VNMSAC);

assign twice_vsew = (vcu_if.vsew << 1);

assign vcu_if.vcontrol.veew_src1 = vcu_if.vsew;
assign vcu_if.vcontrol.veew_src2 = vnarrowing ? twice_vsew : vcu_if.vsew;
assign vcu_if.vcontrol.veew_dest = vwidening ? twice_vsew : vcu_if.vsew;

// OPI* execution unit control signals
vexec_t vexec_opi;
logic vopi_valid;
rv32v_opi_decode U_OPIDECODE(
    .vopi(vopi),
    .vexec(vexec_opi),
    .valid(vopi_valid)
);

// OPM* execution unit control signals
vexec_t vexec_opm;
logic vopm_valid;
rv32v_opm_decode U_OPMDECODE(
    .vopm(vopm),
    .vexec(vexec_opm),
    .valid(vopm_valid)
);

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

    unique case ({vopi_valid, vopm_valid, vcu_if.vcontrol.vmemtoreg})
        3'b100: begin
            vcu_if.vcontrol.vexec = vexec_opi;
        end

        3'b010: begin
            vcu_if.vcontrol.vexec = vexec_opm;
        end

        3'b001: begin
            vcu_if.vcontrol.vexec.vfu = VFU_ALU;
            vcu_if.vcontrol.vexec.valuop = ALU_ADD;
            vcu_if.vcontrol.vexec.vopunsigned = 1'b1;
        end
        
        default: begin
            // None of opi, opm, and memory instructions decoded correctly
            vexecute_valid = 1'b0;
        end
    endcase
end

// Memory signals
assign vcu_if.vcontrol.vmemrden = (vmajoropcode == VMOC_LOAD);
assign vcu_if.vcontrol.vmemwren = (vmajoropcode == VMOC_STORE);

assign vcu_if.vcontrol.vmemtoreg = vcu_if.vcontrol.vmemrden || vcu_if.vcontrol.vmemwren;







endmodule
