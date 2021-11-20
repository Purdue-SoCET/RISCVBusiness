/*
*   Copyright 2021 Purdue University
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
*   Filename:     control_unit.sv
*
*   Created by:   Owen Prince
*   Email:        oprince@purdue.edu
*   Date Created: 10/13/2021
*   Description:  Control signals for vector extension
*                  
*/

`include "vector_control_unit_if.vh"

module vector_control_unit 
(
  vector_control_unit_if.vcu  vcu_if
  //rv32i_reg_file_if.cu          rf_if
  //input logic [4:0] rmgmt_rsel_s_0, rmgmt_rsel_s_1, rmgmt_rsel_d,
  //input logic rmgmt_req_reg_r, rmgmt_req_reg_w 
);
  // import alu_types_pkg::*;
  import rv32i_types_pkg::*;
  import rv32v_types_pkg::*;
  // import machine_mode_types_1_11_pkg::*;

  rtype_t instr_r;
  itype_t instr_i;
  lumop_t lumop;
  vfunct3_t vfunct3;
  vop_decoded_t op_decoded;
  logic is_vopi, is_vopm;
  vopi_t funct6_opi;
  vopm_t funct6_opm;
  

  assign instr_r   = rtype_t'(vcu_if.instr);
  assign instr_i   = itype_t'(vcu_if.instr);

  assign vcu_if.opcode       = opcode_t'(vcu_if.instr[6:0]);
  assign vcu_if.vs1          = vcu_if.instr[19:15];
  assign vcu_if.vs2          = vcu_if.instr[24:20];
  assign vcu_if.vd           = vcu_if.instr[11:7]; 
  
  //load/store stuff
  assign vcu_if.mem_op_width = width_t'(instr_r.funct3);
  assign vcu_if.nf           = vcu_if.instr[31:29];
  assign vcu_if.mop          = mop_t'(vcu_if.instr[27:26]);
  assign vcu_if.vm           = vcu_if.instr[25];
  assign lumop               = lumop_t'(vcu_if.instr[24:20]);
  assign funct6_opi          = vopi_t'(vcu_if.instr[31:26]);
  assign funct6_opm          = vopm_t'(vcu_if.instr[31:26]);  
  assign vfunct3             = vfunct3_t'(instr_r.funct3);

  

  // Assign the immediate values
  assign vcu_if.imm_5   = vcu_if.instr[19:15];
  assign vcu_if.zimm_11 = vcu_if.instr[30:20];
  assign vcu_if.zimm_10 = vcu_if.instr[29:20];

  assign vcu_if.vd_widen   = (vcu_if.opcode == LOAD_FP) && ((op_decoded == VWREDSUMU) || (op_decoded == VWREDSUM) || 
                            (op_decoded == VWADDU) || (op_decoded == VWADD) || (op_decoded == VWSUBU) || 
                            (op_decoded == VWSUB) || (op_decoded == VWADDU_W) || (op_decoded == VWADD_W) || 
                            (op_decoded == VWSUBU_W) || (op_decoded == VWSUB_W) || (op_decoded == VWMULU) || 
                            (op_decoded == VWMULSU) || (op_decoded == VWMUL) || (op_decoded == VWMACCU) || 
                            (op_decoded == VWMACC) || (op_decoded == VWMACCUS) || (op_decoded == VWMACCSU));
  assign vcu_if.vs2_widen = (vcu_if.opcode == LOAD_FP) && ((op_decoded == VWADDU_W) || (op_decoded == VWADD_W) || 
                            (op_decoded == VWSUBU_W) || (op_decoded == VWSUB_W));

  //intermediary variables 
  assign vcu_if.is_load  = (vcu_if.opcode == STORE_FP) && ((vcu_if.mem_op_width == WIDTH8) || (vcu_if.mem_op_width == WIDTH16) || (vcu_if.mem_op_width == WIDTH32));
  assign vcu_if.is_store = (vcu_if.opcode == LOAD_FP)  && ((vcu_if.mem_op_width == WIDTH8) || (vcu_if.mem_op_width == WIDTH16) || (vcu_if.mem_op_width == WIDTH32));

  //Use OPI vs OPM enum
  assign is_vopi   = (vcu_if.opcode == VECTOR)  && (( vfunct3 == OPIVV) || (vfunct3 == OPIVX) || (vfunct3 == OPIVI));
  assign is_vopm   = (vcu_if.opcode == VECTOR)  && ( (vfunct3 == OPMVV) || (vfunct3 == OPMVX));

  //config instructions
  assign vcu_if.cfgsel = (vcu_if.opcode == VECTOR) && (vfunct3 == OPCFG) && (vcu_if.instr[31] == 0) ? VSETVLI : 
                         (vcu_if.opcode == VECTOR) && (vfunct3 == OPCFG) && (vcu_if.instr[31:30] == 2'b11) ? VSETIVLI : 
                         (vcu_if.opcode == VECTOR) && (vfunct3 == OPCFG) && (vcu_if.instr[31:30] == 2'b10) ? VSETVL  : NOT_CFG;

  
  // Assign memory read/write enables
  assign vcu_if.dwen = vcu_if.is_load;
  assign vcu_if.dren = vcu_if.is_store;


  //enable counter
  // assign vcu_if.de_en = vcu_if.is_load | vcu_if.is_store | ((vcu_if.opcode == VECTOR) &&  ~vcu_if.illegal_insn);

  // assign vcu_if.de_en = vcu_if.is_load | vcu_if.is_store | ((vcu_if.opcode == VECTOR) &&  ~vcu_if.illegal_insn);
  assign vcu_if.de_en = ((vcu_if.opcode == VECTOR) &&  ~vcu_if.illegal_insn);

  // assign vcu_if.de_en = vcu_if.arith_ena || vcu_if.mask_ena || vcu_if.perm_ena || vcu_if.reduction_ena || vcu_if.loadstore_ena || vcu_if.mul_ena || vcu_if.div_ena || vcu_if.fixed_point_ena; //unit enables



  always_comb begin
    op_decoded = BAD_OP;
    vcu_if.illegal_insn = 0;
    if (is_vopi) begin
      case (funct6_opi)
        VADD:       op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) ? OP_VADD : BAD_OP  ;
        VSUB:       op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ? OP_VSUB : BAD_OP;
        VRSUB:  	  op_decoded = (vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) ? OP_VRSUB : BAD_OP;
        VMINU:      op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ? OP_VMINU : BAD_OP;
        VMIN:       op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ? OP_VMIN : BAD_OP;
        VMAXU:      op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ? OP_VMAXU : BAD_OP;
        VMAX:       op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ? OP_VMAX : BAD_OP;
        VAND:       op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) ? OP_VAND : BAD_OP;
        VOR:        op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) ? OP_VOR : BAD_OP;
        VXOR:       op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) ? OP_VXOR : BAD_OP;
        VRGATHER:   op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) ? OP_VRGATHER : BAD_OP;
        VSLIDEUP:   op_decoded = (vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) ? OP_VSLIDEUP : (vfunct3 == OPIVV) ? OP_VRGATHEREI16 : BAD_OP;
        VSLIDEDOWN: op_decoded = (vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) ? OP_VSLIDEDOWN : BAD_OP;
        VADC:       op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) ? OP_VADC : BAD_OP;
        VMADC:      op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) ? OP_VMADC : BAD_OP;
        VSBC:       op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ? OP_VSBC : BAD_OP;
        VMSBC:      op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ? OP_VMSBC : BAD_OP;
        VMERGE:     op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) && vcu_if.vm == BAD_OP ? OP_VMERGE : (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) && (vcu_if.vm == 0 )? OP_VMV : BAD_OP;
        VMSEQ:      op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) ? OP_VMSEQ : BAD_OP;
        VMSNE:      op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) ? OP_VMSNE : BAD_OP;
        VMSLTU:     op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ? OP_VMSLTU : BAD_OP;
        VMSLT:      op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ? OP_VMSLT : BAD_OP;
        VMSLEU:     op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) ? OP_VMSLEU : BAD_OP;
        VMSLE:      op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) ? OP_VMSLE : BAD_OP;
        VMSGTU: 	  op_decoded = (vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) ? OP_VMSGTU : BAD_OP;
        VMSGT: 	    op_decoded = (vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) ? OP_VMSGT : BAD_OP;
        VSADDU:     op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) ? OP_VSADDU : BAD_OP;
        VSADD:      op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) ? OP_VSADD : BAD_OP;
        VSSUBU:     op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ? OP_VSSUBU : BAD_OP;
        VSSUB:      op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ? OP_VSSUB : BAD_OP;
        VSLL:       op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) ? OP_VSLL : BAD_OP;
        VSMUL:      op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ? OP_VSMUL : BAD_OP;
        VSRL:       op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) ? OP_VSRL : BAD_OP;
        VSRA:       op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) ? OP_VSRA : BAD_OP;
        VSSRL:      op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) ? OP_VSSRL : BAD_OP;
        VSSRA:      op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) ? OP_VSSRA : BAD_OP;
        VNSRL:      op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) ? OP_VNSRL : BAD_OP;
        VNSRA:      op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) ? OP_VNSRA : BAD_OP;
        VNCLIPU:    op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) ? OP_VNCLIPU : BAD_OP;
        VNCLIP:     op_decoded = (vfunct3 == OPIVV) ||	(vfunct3 == OPIVX) ||	(vfunct3 == OPIVI) ? OP_VNCLIP : BAD_OP;
        VWREDSUMU:  op_decoded = (vfunct3 == OPIVV) ? 	OP_VWREDSUMU : BAD_OP;
        VWREDSUM:   op_decoded = (vfunct3 == OPIVV) ? OP_VWREDSUM : BAD_OP;
      endcase
      if (op_decoded == BAD_OP) begin
        vcu_if.illegal_insn = 1;
      end
    end else if (is_vopm) begin
      case (funct6_opm)
        VREDSUM:      op_decoded = (vfunct3 == OPMVV)	 ? OP_VREDSUM   : BAD_OP;
        VREDAND:      op_decoded = (vfunct3 == OPMVV)	 ? OP_VREDAND   : BAD_OP;
        VREDOR:       op_decoded = (vfunct3 == OPMVV)	 ? OP_VREDOR    : BAD_OP;
        VREDXOR:      op_decoded = (vfunct3 == OPMVV)	 ? OP_VREDXOR   : BAD_OP;
        VREDMINU:     op_decoded = (vfunct3 == OPMVV)	 ? OP_VREDMINU    : BAD_OP;
        VREDMIN:      op_decoded = (vfunct3 == OPMVV)	 ? OP_VREDMIN   : BAD_OP;
        VREDMAXU:     op_decoded = (vfunct3 == OPMVV)	 ? OP_VREDMAXU    : BAD_OP;
        VREDMAX:      op_decoded = (vfunct3 == OPMVV)	 ? OP_VREDMAX   : BAD_OP;
        VAADDU:       op_decoded = (vfunct3 == OPMVV) ||	(vfunct3 == OPMVX) ? OP_VAADDU   : BAD_OP;
        VAADD:        op_decoded = (vfunct3 == OPMVV) ||	(vfunct3 == OPMVX) ? OP_VAADD    : BAD_OP;
        VASUBU:       op_decoded = (vfunct3 == OPMVV) ||	(vfunct3 == OPMVX) ? OP_VASUBU   : BAD_OP;
        VASUB:        op_decoded = (vfunct3 == OPMVV) ||	(vfunct3 == OPMVX) ? OP_VASUB    : BAD_OP;
        VSLIDE1UP:    op_decoded = (vfunct3 == OPMVX) ? OP_VSLIDE1UP   : BAD_OP;
        VSLIDE1DOWN:  op_decoded = (vfunct3 == OPMVX) ? OP_VSLIDE1DOWN   : BAD_OP;
        VWXUNARY0:    begin op_decoded =  (vfunct3 == OPMVV) && (vcu_if.vs1 == VMV_X_S) ? OP_VMV_X_S : 
                                          (vfunct3 == OPMVV) && (vcu_if.vs1 == VPOPC)   ? OP_VPOPC : 
                                          (vfunct3 == OPMVV) && (vcu_if.vs1 == VFIRST)  ? OP_VFIRST :
                                          (vfunct3 == OPMVX) && (vcu_if.vs2 == VMV_S_X) ? OP_VMV_S_X : BAD_OP;
                      end 
        VXUNARY0:     begin op_decoded =  (vfunct3 == OPMVV) && (vcu_if.vs1 == VZEXT_VF8) ?  OP_VZEXT_VF8 : 
                                          (vfunct3 == OPMVV) && (vcu_if.vs1 == VSEXT_VF8) ?  OP_VSEXT_VF8 : 
                                          (vfunct3 == OPMVV) && (vcu_if.vs1 == VZEXT_VF4) ?  OP_VZEXT_VF4 : 
                                          (vfunct3 == OPMVV) && (vcu_if.vs1 == VSEXT_VF4) ?  OP_VSEXT_VF4 : 
                                          (vfunct3 == OPMVV) && (vcu_if.vs1 == VZEXT_VF2) ?  OP_VZEXT_VF2 : 
                                          (vfunct3 == OPMVV) && (vcu_if.vs1 == VSEXT_VF2) ?  OP_VSEXT_VF2 : BAD_OP;
                      end 
        VMUNARY0:     begin op_decoded =  (vfunct3 == OPMVV) && (vcu_if.vs1 == VMSBF) ? OP_VMSBF : 
                                          (vfunct3 == OPMVV) && (vcu_if.vs1 == VMSOF) ? OP_VMSOF : 
                                          (vfunct3 == OPMVV) && (vcu_if.vs1 == VMSIF) ? OP_VMSIF : 
                                          (vfunct3 == OPMVV) && (vcu_if.vs1 == VIOTA) ? OP_VIOTA : 
                                          (vfunct3 == OPMVV) && (vcu_if.vs1 == VID)   ? OP_VID   : BAD_OP;
                      end 
        VCOMPRESS:    op_decoded = (vfunct3 == OPMVV)                       ? OP_VCOMPRESS : BAD_OP;
        VMANDNOT:     op_decoded = (vfunct3 == OPMVV)                       ? OP_VMANDNOT : BAD_OP;
        VMAND:        op_decoded = (vfunct3 == OPMVV)                       ? OP_VMAND : BAD_OP;
        VMOR:         op_decoded = (vfunct3 == OPMVV)                       ? OP_VMOR : BAD_OP;
        VMXOR:        op_decoded = (vfunct3 == OPMVV)                       ? OP_VMXOR : BAD_OP;
        VMORNOT:      op_decoded = (vfunct3 == OPMVV)                       ? OP_VMORNOT : BAD_OP;
        VMNAND:       op_decoded = (vfunct3 == OPMVV)                       ? OP_VMNAND : BAD_OP;
        VMNOR:        op_decoded = (vfunct3 == OPMVV)                       ? OP_VMNOR : BAD_OP;
        VMXNOR:       op_decoded = (vfunct3 == OPMVV)                       ? OP_VMXNOR : BAD_OP;
        VDIVU:        op_decoded = (vfunct3 == OPMVV)||	(vfunct3 == OPMVX)  ? OP_VDIVU : BAD_OP;
        VDIV:         op_decoded = (vfunct3 == OPMVV)||	(vfunct3 == OPMVX)  ? OP_VDIV : BAD_OP;
        VREMU:        op_decoded = (vfunct3 == OPMVV)||	(vfunct3 == OPMVX)  ? OP_VREMU : BAD_OP;
        VREM:         op_decoded = (vfunct3 == OPMVV)||	(vfunct3 == OPMVX)  ? OP_VREM : BAD_OP;
        VMULHU:       op_decoded = (vfunct3 == OPMVV)||	(vfunct3 == OPMVX)  ? OP_VMULHU : BAD_OP;
        VMUL:         op_decoded = (vfunct3 == OPMVV)||	(vfunct3 == OPMVX)  ? OP_VMUL : BAD_OP;
        VMULHSU:      op_decoded = (vfunct3 == OPMVV)||	(vfunct3 == OPMVX)  ? OP_VMULHSU : BAD_OP;
        VMULH:        op_decoded = (vfunct3 == OPMVV)||	(vfunct3 == OPMVX)  ? OP_VMULH : BAD_OP;
        VMADD:        op_decoded = (vfunct3 == OPMVV)||	(vfunct3 == OPMVX)  ? OP_VMADD : BAD_OP;
        VNMSUB:       op_decoded = (vfunct3 == OPMVV)||	(vfunct3 == OPMVX)  ? OP_VNMSUB : BAD_OP;
        VMACC:        op_decoded = (vfunct3 == OPMVV)||	(vfunct3 == OPMVX)  ? OP_VMACC : BAD_OP;
        VNMSAC:       op_decoded = (vfunct3 == OPMVV)||	(vfunct3 == OPMVX)  ? OP_VNMSAC : BAD_OP;
        VWADDU:       op_decoded = (vfunct3 == OPMVV)||	(vfunct3 == OPMVX)  ? OP_VWADDU : BAD_OP;
        VWADD:        op_decoded = (vfunct3 == OPMVV)||	(vfunct3 == OPMVX)  ? OP_VWADD : BAD_OP;
        VWSUBU:       op_decoded = (vfunct3 == OPMVV)||	(vfunct3 == OPMVX)  ? OP_VWSUBU : BAD_OP;
        VWSUB:        op_decoded = (vfunct3 == OPMVV)||	(vfunct3 == OPMVX)  ? OP_VWSUB : BAD_OP;
        VWADDU_W:     op_decoded = (vfunct3 == OPMVV)||	(vfunct3 == OPMVX)  ? OP_VWADDU_W : BAD_OP;
        VWADD_W:      op_decoded = (vfunct3 == OPMVV)||	(vfunct3 == OPMVX)  ? OP_VWADD_W : BAD_OP;
        VWSUBU_W:     op_decoded = (vfunct3 == OPMVV)||	(vfunct3 == OPMVX)  ? OP_VWSUBU_W : BAD_OP;
        VWSUB_W:      op_decoded = (vfunct3 == OPMVV)||	(vfunct3 == OPMVX)  ? OP_VWSUB_W : BAD_OP;
        VWMULU:       op_decoded = (vfunct3 == OPMVV)||	(vfunct3 == OPMVX)  ? OP_VWMULU : BAD_OP;
        VWMULSU:      op_decoded = (vfunct3 == OPMVV)||	(vfunct3 == OPMVX)  ? OP_VWMULSU : BAD_OP;
        VWMUL:        op_decoded = (vfunct3 == OPMVV)||	(vfunct3 == OPMVX)  ? OP_VWMUL : BAD_OP;
        VWMACCU:      op_decoded = (vfunct3 == OPMVV)||	(vfunct3 == OPMVX)  ? OP_VWMACCU : BAD_OP;
        VWMACC:       op_decoded = (vfunct3 == OPMVV)||	(vfunct3 == OPMVX)  ? OP_VWMACC : BAD_OP;
        VWMACCUS:     op_decoded = (vfunct3 == OPMVX)                       ? OP_VWMACCUS : BAD_OP;
        VWMACCSU:     op_decoded = (vfunct3 == OPMVV)||	(vfunct3 == OPMVX)  ? OP_VWMACCSU : BAD_OP;
      endcase
      if (op_decoded == BAD_OP) begin
        vcu_if.illegal_insn = 1;
      end
    end else begin
      vcu_if.illegal_insn = 1;
    end
  end



  //vs1 source
  // assign vcu_if.vs1_src = vcu_if.is_store; //stores use vs3 == vd for reading the data that will be stored

  
  assign vcu_if.imm_op = ((vfunct3 == OPCFG) || (vfunct3 == OPIVI)) && (vcu_if.opcode == VECTOR); 
  
  //use rs1, rs1, rd. when VMV_X_S, VMV_X_S, VFIRST write to rd
  assign vcu_if.xs1_scalar_src = vcu_if.is_store || vcu_if.is_load || (vcu_if.cfgsel == VSETVLI) || 
                                (vcu_if.cfgsel == VSETIVLI) || (vcu_if.cfgsel == VSETVL) || 
                                (vcu_if.opcode == OPIVX) || (vcu_if.opcode == OPFVF) || (vcu_if.opcode == OPMVX);
  
  assign vcu_if.xs2_scalar_src = (vcu_if.is_store || vcu_if.is_load) && (vcu_if.mop == MOP_STRIDED);
  assign vcu_if.rd_scalar_src = ((vfunct3 == OPCFG) || 
                                  ((funct6_opi == VWXUNARY0) && 
                                  ((vcu_if.vs1  == VMV_X_S) || (vcu_if.vs1  == VMV_X_S) || (vcu_if.vs1  == VFIRST)))) && 
                                  (vcu_if.opcode == VECTOR); 
  always_comb begin
    vcu_if.arith_ena = 0;
    vcu_if.reduction_ena = 0;
    vcu_if.mul_ena = 0;
    vcu_if.div_ena = 0;
    vcu_if.mask_ena = 0;
    vcu_if.perm_ena = 0;
    vcu_if.fixed_point_ena = 0;
    case (op_decoded)
      OP_VADD, OP_VSUB, OP_VRSUB, OP_VMINU, OP_VMIN, OP_VMAXU, OP_VMAX, OP_VAND, OP_VOR, OP_VXOR, OP_VADC, OP_VMADC, 
      OP_VSBC, OP_VMSBC, OP_VMERGE, OP_VMERGE, OP_VMSEQ, OP_VMSNE, OP_VMSLTU, OP_VMSLT, OP_VMSLEU, OP_VMSLE, OP_VMSGTU, 
      OP_VMSGT, OP_VSRL, OP_VSRA, OP_VNSRL, OP_VNSRA, OP_VZEXT_VF8, OP_VSEXT_VF8, OP_VZEXT_VF4, OP_VSEXT_VF4, 
      OP_VZEXT_VF2, OP_VSEXT_VF2, OP_VMADD, OP_VNMSUB, OP_VMACC, OP_VNMSAC, OP_VWADDU, OP_VWADD, OP_VWSUBU, OP_VWSUB, OP_VWADDU_W, 
      OP_VWADD_W, OP_VWSUBU_W, OP_VWSUB_W, OP_VWMACCU, OP_VWMACC, OP_VWMACCUS, OP_VWMACCSU: vcu_if.arith_ena = 1;
      OP_VWREDSUMU, OP_VWREDSUM, OP_VREDSUM, OP_VREDAND, OP_VREDOR, OP_VREDXOR, OP_VREDMINU, OP_VREDMIN, OP_VREDMAXU, VREDMAX: vcu_if.reduction_ena = 1;
      OP_VREM, OP_VMULHU, OP_VMUL, OP_VMULHSU, OP_VMULH, OP_VWMULU, OP_VWMULSU, VWMUL: vcu_if.mul_ena = 1;
      OP_VDIVU, OP_VDIV, OP_VREMU, VREM: vcu_if.div_ena = 1;
      OP_VPOPC, OP_VFIRST, OP_VMSBF, OP_VMSOF, OP_VMSIF, OP_VIOTA, OP_VID, OP_VMANDNOT, OP_VMAND, OP_VMOR, OP_VMXOR, OP_VMORNOT, OP_VMNAND, OP_VMNOR, VMXNOR: vcu_if.mask_ena = 1;
      OP_VRGATHER, OP_VSLIDEUP, OP_VRGATHEREI16, OP_VSLIDEDOWN, OP_VSLIDE1UP, OP_VSLIDE1DOWN, OP_VMV_X_S, OP_VMV_S_X, VCOMPRESS: vcu_if.perm_ena = 1;
      OP_VSADDU, OP_VSADD, OP_VSSUBU, OP_VSSUB, OP_VSMUL, OP_VSSRL, OP_VSSRA, OP_VNCLIPU, OP_VNCLIP, OP_VAADDU, OP_VAADD, OP_VASUBU, VASUB: vcu_if.fixed_point_ena = 1;
    endcase
  end
  assign vcu_if.loadstore_ena = vcu_if.is_load | vcu_if.is_store; 
    

  //select mask unit
  assign vcu_if.fu_type = vcu_if.arith_ena ? ARITH :
                              vcu_if.mask_ena  ? MASK :
                              vcu_if.perm_ena  ? PEM :
                              vcu_if.is_load ? LOAD_UNIT : 
                              vcu_if.is_store ? STORE_UNIT : ARITH; 



  assign vcu_if.rs1_type = vcu_if.is_load || vcu_if.is_store || (vcu_if.opcode == VECTOR) &&  ((vfunct3 == OPIVX) || (vfunct3 == OPMVX)) ||
                            (vcu_if.opcode == VECTOR) && ((vcu_if.cfgsel == VSETVLI) || (vcu_if.cfgsel == VSETVL)) ? X : 
                            vcu_if.imm_op ? I : V;

  
  assign vcu_if.stride_type =  (vcu_if.is_load || vcu_if.is_store) && (vcu_if.mop == MOP_STRIDED);

  assign vcu_if.rs2_type = vcu_if.stride_type == 1 ? X : V;


  //write to 1 bit instead of 1 element
  assign vcu_if.single_bit_op  = (funct6_opi == VMSEQ) || (funct6_opi == VMSNE) || (funct6_opi == VMSLTU) || (funct6_opi == VMSLT) || (funct6_opi == VMSLEU) || 
                                  (funct6_opi == VMSLE) || (funct6_opi == VMSGTU) || (funct6_opi == VMSGT);


  // Assign register write enable

  always_comb begin
    case(vcu_if.opcode)
      LOAD_FP: vcu_if.wen   = 1'b1;
      VECTOR:  vcu_if.wen = is_vopi || is_vopm;
      STORE_FP: vcu_if.wen   = 1'b0;
      default:  vcu_if.wen   = 1'b0;
    endcase
  end

  //stall
  assign vcu_if.stall = ((vfunct3 == OPIVV) && (funct6_opi == VSLIDEUP)) || ((funct6_opi == VRGATHER) && is_vopi);


  // OFFSET SOURCE MUX CONTROL LINES
  //choose vs1 offset, any of the reduction ops cause it to be 0
  assign vcu_if.vs1_offset_src = (vfunct3 == OPMVV) && ((op_decoded == OP_VREDSUM) || 
                                  (op_decoded == OP_VREDAND) || (op_decoded == OP_VREDOR) || 
                                  (op_decoded == OP_VREDXOR) || (op_decoded == OP_VREDMINU) || 
                                  (op_decoded == OP_VREDMIN) || (op_decoded == OP_VREDMAXU) || 
                                  (op_decoded == OP_VREDMAX)) ? VS1_SRC_ZERO : VS1_SRC_NORMAL ; //some reduction ops
  
  always_comb begin
    vcu_if.vs2_offset_src = VS2_SRC_NORMAL;
    case(funct6_opi)
      VSLIDEDOWN: begin 
        if  (vfunct3 == OPIVX) vcu_if.vs2_offset_src = VS2_SRC_IDX_PLUS_RS1; // i + rs1; 
        else if (vfunct3 == OPIVI) vcu_if.vs2_offset_src = VS2_SRC_IDX_PLUS_UIMM; //i +uimm 
        else if (vfunct3 == OPMVX) vcu_if.vs2_offset_src = VS2_SRC_IDX_PLUS_1; //i +1 --> this turns into slide1down 
      end
      VRGATHER: begin
        if (vfunct3 == OPIVV) vcu_if.vs2_offset_src = VS2_SRC_VS1; // vs1[i]
        else if (vfunct3 == OPIVX) vcu_if.vs2_offset_src = VS2_SRC_RS1; // x[rs1]
        else if (vfunct3 == OPIVI) vcu_if.vs2_offset_src = VS2_SRC_UIMM; // uimm
      end
      VSLIDEUP: if (vfunct3 == OPIVV) vcu_if.vs2_offset_src = VS2_SRC_VS1; // vs1[i], this actually turns into a gather instr
      default:  vcu_if.vs2_offset_src = 0;
    endcase

    if ((funct6_opm == VWXUNARY0) && (vwxunary0_t'(vcu_if.vs1) == VMV_X_S)) begin
      vcu_if.vs2_offset_src = VS2_SRC_ZERO; //vs2[0]
    end


  end


  // vcu_if.vd_offset_src  = if reduction, scalar move s.x, choose 0; if slideup vx choose i + rs1; if slideup vi choose i + uimm; if slide1up choose i + 1; if compress then use permutation vd; if else i; 
  always_comb begin
    vcu_if.vd_offset_src = VD_SRC_NORMAL; //i
    if (vcu_if.reduction_ena) begin 
      vcu_if.vd_offset_src = VD_SRC_ZERO; //0
    end else if (is_vopi) begin
      case  (funct6_opi)
        VSLIDEUP:  begin
            if (vfunct3 == OPIVX) vcu_if.vd_offset_src = VD_SRC_IDX_PLUS_RS1; // i + rs1
            else if (vfunct3 == OPIVI) vcu_if.vd_offset_src = VD_SRC_IDX_PLUS_UIMM; // i + uimm
            else if (vfunct3 == OPMVX) vcu_if.vd_offset_src = VD_SRC_IDX_PLUS_1; // i + 1
          end
        VCOMPRESS: vcu_if.vd_offset_src = VD_SRC_COMPRESS; //use special counter
      endcase
    end
  end


  //sign_extend uimm           
  assign vcu_if.sign_extend  = ~((funct6_opi == VSLL) || (funct6_opi == VSRL)|| (funct6_opi == VSRA)|| (funct6_opi == VNSRL)|| (funct6_opi == VNSRA)|| 
                              (funct6_opi == VSSRL)|| (funct6_opi == VSSRA)|| (funct6_opi == VNCLIPU)|| (funct6_opi == VNCLIP)|| (funct6_opi == VSLIDEUP)||
                                 (funct6_opi == VSLIDEDOWN)|| (funct6_opi == VRGATHER) || (vcu_if.cfgsel == VSETIVLI)); //vmv1r includes vmv2, vmv4, vmv8

  //op in the execution stage is signed
  always_comb begin
    case(op_decoded)
      VADD, VSUB, VRSUB, VMIN, VMAX, VMSEQ, VMSNE, VMSLT, VMSLE, VMSGT, VSADD, VSSUB, VSMUL, VSSRL, VNCLIP, 
      VWREDSUM, VREDSUM, VREDMIN, VREDMAX, VAADD, VASUB, VSEXT_VF8, VSEXT_VF4, VSEXT_VF2, VDIV, VREM, VMUL, 
      VMULHSU, VMULH, VMADD, VNMSUB, VMACC, VNMSAC, VWADD, VWSUB, VWADD_W, VWSUB_W, VWMULSU, VWMUL, VWMACC, 
      VWMACCUS, VWMACCSU:  vcu_if.is_signed = 1;
      default: vcu_if.is_signed = 0;
    endcase
  end
 
  always_comb begin
    case(op_decoded)
      OP_VADD, OP_VSUB, OP_VRSUB, OP_VMINU, OP_VMIN, OP_VMAXU, OP_VMAX, OP_VAND, OP_VOR, OP_VXOR, OP_VRGATHER, 
      OP_VSLIDEUP, OP_VRGATHEREI16, OP_VSLIDEDOWN, OP_VADC, OP_VSBC, OP_VMERGE, OP_VMV, OP_VMSEQ, OP_VMSNE, 
      OP_VMSLTU, OP_VMSLT, OP_VMSLEU, OP_VMSLE, OP_VMSGTU, OP_VMSGT, OP_VSADDU, OP_VSADD, OP_VSSUBU, OP_VSSUB, OP_VSLL, 
      OP_VSRL, OP_VSRA, OP_VSSRL, OP_VSSRA, OP_VNSRL, OP_VNSRA, OP_VNCLIPU, OP_VNCLIP, OP_VWREDSUMU, OP_VWREDSUM, 
      OP_VREDSUM, OP_VREDAND, OP_VREDOR, OP_VREDXOR, OP_VREDMINU, OP_VREDMIN, OP_VREDMAXU, OP_VREDMAX, OP_VAADDU, OP_VAADD, 
      OP_VASUBU, OP_VASUB, OP_VSLIDE1UP, OP_VSLIDE1DOWN, OP_VMV_X_S, OP_VPOPC, OP_VFIRST, OP_VMV_S_X, OP_VZEXT_VF8, 
      OP_VSEXT_VF8, OP_VZEXT_VF4, OP_VSEXT_VF4, OP_VZEXT_VF2, OP_VSEXT_VF2, OP_VMSBF, OP_VMSOF, OP_VMSIF, OP_VIOTA, OP_VID, 
      OP_VCOMPRESS, OP_VMANDNOT, OP_VMAND, OP_VMOR, OP_VMXOR, OP_VMORNOT, OP_VMNAND, OP_VMNOR, OP_VMXNOR, OP_VWADDU, OP_VWADD, OP_VWSUBU, 
      OP_VWSUB, OP_VWADDU_W, OP_VWADD_W, OP_VWSUBU_W, OP_VWSUB_W:  vcu_if.result_type =    NORMAL; 
      OP_VMADC, OP_VMSBC: vcu_if.result_type = A_S; 
      OP_VSMUL, OP_VMULHU, OP_VMUL, OP_VMULHSU, OP_VMULH, OP_VWMULU, OP_VWMULSU, OP_VWMUL: vcu_if.result_type = MULTI;
      OP_VDIVU, OP_VDIV: vcu_if.result_type = DIVI;
      OP_VREMU, OP_VREM: vcu_if.result_type = REM;
      default: vcu_if.result_type = A_S;
    endcase
  end

  always_comb begin
    case(op_decoded)
      OP_VSLL: vcu_if.aluop = VALU_SLL;
      OP_VSRL, OP_VSSRL, OP_VNSRL: vcu_if.aluop = VALU_SRL;
      OP_VSRA, OP_VSSRA, OP_VNSRA: vcu_if.aluop = VALU_SRA;
      OP_VADD, OP_VADC, OP_VMADC, OP_VSADDU, OP_VSADD, OP_VWREDSUMU, OP_VWREDSUM, 
      OP_VREDSUM, OP_VAADDU, OP_VAADD, OP_VWADDU, OP_VWADD, OP_VWADDU_W, OP_VWADD_W: vcu_if.aluop = VALU_ADD;
      OP_VSUB, OP_VRSUB, OP_VSBC, OP_VMSBC, OP_VSSUBU, OP_VSSUB, 
      OP_VASUBU, OP_VASUB, OP_VWSUBU, OP_VWSUB, OP_VWSUBU_W, OP_VWSUB_W: vcu_if.aluop = VALU_SUB;       
      OP_VAND, OP_VREDAND, OP_VMANDNOT, OP_VMAND, OP_VMNAND: vcu_if.aluop = VALU_AND;
      OP_VOR, OP_VREDOR, OP_VMOR, OP_VMORNOT, OP_VMNOR:     vcu_if.aluop = VALU_OR;
      OP_VXOR, OP_VREDXOR, OP_VMXOR, OP_VMXNOR: vcu_if.aluop = VALU_XOR;
      OP_VMSEQ, OP_VMSNE, OP_VMSLTU, OP_VMSLT, OP_VMSLEU, OP_VMSLE, OP_VMSGTU, OP_VMSGT: vcu_if.aluop = VALU_COMP;    
      OP_VMERGE: vcu_if.aluop = VALU_MERGE;
      OP_VMV, OP_VMV_X_S, OP_VMV_S_X: vcu_if.aluop = VALU_MOVE;
      OP_VMINU, OP_VMIN, OP_VMAXU, OP_VMAX, OP_VREDMINU, 
      OP_VREDMIN, OP_VREDMAXU, OP_VREDMAX: vcu_if.aluop = VALU_MM;
      OP_VZEXT_VF8, OP_VSEXT_VF8, OP_VZEXT_VF4, OP_VSEXT_VF4, OP_VZEXT_VF2, 
      OP_VSEXT_VF2, OP_VMSBF, OP_VMSOF, OP_VMSIF, OP_VIOTA, OP_VID:   vcu_if.aluop = VALU_EXT;
      default: vcu_if.aluop = VALU_SLL;
    endcase
  end

  always_comb begin
    case(op_decoded)
      OP_VMSEQ:	 vcu_if.comp_type = VSEQ;
      OP_VMSNE:  vcu_if.comp_type = VSNE;
      OP_VMSLTU: vcu_if.comp_type = VSLTU;
      OP_VMSLT:  vcu_if.comp_type = VSLT;
      OP_VMSLEU: vcu_if.comp_type = VSLEU;
      OP_VMSLE:  vcu_if.comp_type = VSLE;
      OP_VMSLE:  vcu_if.comp_type = VSGTU;
      OP_VMSLE:  vcu_if.comp_type = VSGT;
      default:   vcu_if.comp_type = VSEQ;
    endcase
  end

  always_comb begin
    case(op_decoded)
      OP_VMIN, OP_VREDMIN:    vcu_if.minmax_type = MIN;
      OP_VMINU, OP_VREDMINU:  vcu_if.minmax_type = MINU;
      OP_VMAX, OP_VREDMAXU:   vcu_if.minmax_type = MAX;
      OP_VMAXU, OP_VREDMAX:   vcu_if.minmax_type = MAXU;
    default:                  vcu_if.minmax_type = MIN;
    endcase
  end

  always_comb begin
    case (op_decoded)
      OP_VZEXT_VF8: vcu_if.ext_type = F8Z;
      OP_VSEXT_VF8: vcu_if.ext_type = F8S;
      OP_VZEXT_VF4: vcu_if.ext_type = F4Z;
      OP_VSEXT_VF4: vcu_if.ext_type = F4S;
      OP_VZEXT_VF2: vcu_if.ext_type = F2Z;
      OP_VSEXT_VF2: vcu_if.ext_type = F2S;
    default:        vcu_if.ext_type = F2Z;
    endcase
  end

  //div_type;
  always_comb begin
    case (op_decoded)
      VDIVU: vcu_if.div_type = 1;
      default: vcu_if.div_type = 0;
    endcase
  end

  //is_signed_div;
  always_comb begin
    case (op_decoded)
      VDIV, VREM: vcu_if.is_signed_div = 1;
      default: vcu_if.is_signed_div = 0;
    endcase
  end

  //high_low;
  always_comb begin
    case (op_decoded)
      VMULHU, VMULHSU, VMULH: vcu_if.high_low = 1;
      default: vcu_if.high_low = 0;
    endcase
  end

  //is_signed_mul;
  always_comb begin
    case (op_decoded)
      VMULHU, VMUL, VMADD, VNMSUB, VMACC, VNMSAC, VWMUL, VWMACC: vcu_if.is_signed_mul = 2'b11;
      VMULH, VWMULSU, VWMACCSU: vcu_if.is_signed_mul = 2'b10;
      VWMACCUS: vcu_if.is_signed_mul = 2'b01;
      default: vcu_if.is_signed_mul = 0;
    endcase
  end
  
  //mul_widen_ena;
  always_comb begin
    case (op_decoded)
      VWMULU, VWMULSU, VWMUL, VWMACCU, VWMACC, VWMACCUS, VWMACCSU: vcu_if.mul_widen_ena = 1;
      default: vcu_if.mul_widen_ena = 0;
    endcase
  end
  
  //multiply_pos_neg;
  always_comb begin
    case (op_decoded)
      VMADD, VMACC, VWMACCU, VWMACC: vcu_if.multiply_pos_neg = 1 ;
      default: vcu_if.multiply_pos_neg = 0;
    endcase
  end

  //multiply_type;
  always_comb begin
    case (op_decoded)
      VMADD, VNMSUB, VMACC, VNMSAC, VWMACCU, VWMACC, VWMACCUS, VWMACCSU: vcu_if.multiply_type = 1 ;
      default: vcu_if.multiply_type = 0;
    endcase
  end

  assign vcu_if.adc_sbc = (op_decoded == VADC) || (op_decoded == VMADC);
  assign vcu_if.carry_borrow_ena = (op_decoded == VMADC) || (op_decoded == VMSBC);
  assign vcu_if.rev = (op_decoded == VRSUB);


  always_comb begin : CARRYIN_ENA
    case(op_decoded)
    VADC, VSBC:   vcu_if.carryin_ena = 1;
    //VMADC, VMSBC: ONLY USES mask as a carry-in if mask bit is 1
    VMADC, VMSBC: vcu_if.carryin_ena = (vcu_if.instr[25] == 1) ?  1 : 0;
    default: vcu_if.carryin_ena = 0;
    endcase
  end

  assign vcu_if.win       = (op_decoded == VWADDU_W) || (op_decoded == VWADD_W) || (op_decoded == VWSUBU_W) || (op_decoded == VWSUB_W);
  assign vcu_if.woutu     = (op_decoded == VWADDU) || (op_decoded == VWSUBU) || (op_decoded == VWADDU_W) || (op_decoded == VWSUBU_W) || (op_decoded == VWMULU) || (op_decoded == VWMULSU);
  assign vcu_if.zext_w    = (op_decoded == VWADDU_W) || (op_decoded == VWSUBU_W);

endmodule