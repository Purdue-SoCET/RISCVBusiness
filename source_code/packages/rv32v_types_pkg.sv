/*
*   Copyright 2016 Purdue University
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
*   Filename:     rv32v_types_pkg.sv
*   
*   Created by:   Owen Prince	
*   Email:        oprince@purdue.edu
*   Date Created: 10/10/2021
*   Description:  Package containing types used for a RV32V implementation
*/

`ifndef RV32V_TYPES_PKG_SV
`define RV32V_TYPES_PKG_SV
// `include "rv32i_types_pkg.sv";

package rv32v_types_pkg;
  parameter VLEN_WIDTH = 7; // 128 bit registers
  parameter VL_WIDTH = VLEN_WIDTH; //width of largest vector = VLENB * 8 
  parameter VLEN = 1 << 7; 
  parameter VLENB = VLEN / 8; //VLEN in bytes- TODO change to use csr val
  parameter NUM_LANES = 2;
  // import rv32i_types_pkg::opcode_t;


  typedef enum logic [2:0]  {
    SEW8    = 3'd0, 
    SEW16   = 3'd1,  
    SEW32   = 3'd2,
    SEW64   = 3'd3,
    SEW128  = 3'd4,
    SEW256  = 3'd5,
    SEW512  = 3'd6,
    SEW1024 = 3'd7
  } sew_t;

  typedef enum logic [2:0] {
    LMUL1       = 3'd0,
    LMUL2       = 3'd1,
    LMUL4       = 3'd2,
    LMUL8       = 3'd3,
    LMULHALF    = 3'd5,
    LMULFOURTH  = 3'd6,
    LMULEIGHTH  = 3'd7
  } vlmul_t;

  typedef enum logic [2:0] { 
    WIDTH8  = 3'd0, 
    WIDTH16 = 3'b101, 
    WIDTH32 = 3'b110
    // RES = 3'd1, 3'd2, 3'd3, 3'd4, 3'd7 
  } width_t;

  typedef enum logic [4:0] { 
    LUMOP_UNIT = 5'd0, 
    LUMOP_UNIT_FULLREG = 5'b01000, 
    LUMOP_UNIT_MASK = 5'b01011, //EEW 8
    LUMOP_UNIT_FAULT_ONLY = 5'b10000 //EEW 8
  } lumop_t;

  typedef enum logic [1:0] { 
    MOP_UNIT = 0,
    MOP_UINDEXED = 1,
    MOP_STRIDED = 2,
    MOP_OINDEXED = 3 
  } mop_t;

  // typedef enum logic [2:0] { 
  //   ARITH,
  //   MASK,
  //   PERM,
  //   LOADSTORE,
  //   NOOP
  // } funit_type;

  typedef enum logic [2:0] { 
    OPIVV = 3'b0,
    OPFVV = 3'd1,
    OPMVV = 3'd2,
    OPIVI = 3'd3,
    OPIVX = 3'd4,
    OPFVF = 3'd5,
    OPMVX = 3'd6,
    OPCFG = 3'd7
  } vfunct3_t;

  typedef enum logic [1:0] { 
    NOT_CFG, 
    VSETVLI,
    VSETIVLI,
    VSETVL 
  } cfgsel_t;

  typedef enum logic [5:0] {
    VADD = 6'b000000,
    VSUB = 6'b000010,
    VRSUB = 6'b000011,
    VMINU = 6'b000100,
    VMIN = 6'b000101,
    VMAXU = 6'b000110,
    VMAX = 6'b000111,
    VAND = 6'b001001,
    VOR = 6'b001010,
    VXOR = 6'b001011,
    VRGATHER = 6'b001100,
    VSLIDEUP = 6'b001110, //VRGATHEREI16 when OPIVV, something is very weird about this instruction
    VSLIDEDOWN = 6'b001111,
    VADC = 6'b010000,
    VMADC = 6'b010001,
    VSBC = 6'b010010,
    VMSBC = 6'b010011,
    VMERGE = 6'b010111,         //also VMV
    VMSEQ = 6'b011000,
    VMSNE = 6'b011001,
    VMSLTU = 6'b011010,
    VMSLT = 6'b011011,
    VMSLEU = 6'b011100,
    VMSLE = 6'b011101,
    VMSGTU = 6'b011110,
    VMSGT = 6'b011111,
    VSADDU = 6'b100000,
    VSADD = 6'b100001,
    VSSUBU = 6'b100010,
    VSSUB = 6'b100011,
    VSLL = 6'b100101,
    VSMUL = 6'b100111, //also VMV<nf>R
    VSRL = 6'b101000,
    VSRA = 6'b101001,
    VSSRL = 6'b101010,
    VSSRA = 6'b101011,
    VNSRL = 6'b101100,
    VNSRA = 6'b101101,
    VNCLIPU = 6'b101110,
    VNCLIP = 6'b101111,
    VWREDSUMU =6'b110000,
    VWREDSUM =6'b110001
  } vopi_t;

  typedef enum logic [5:0]{
    VREDSUM = 6'b000000,
    VREDAND = 6'b000001,
    VREDOR = 6'b000010,
    VREDXOR = 6'b000011,
    VREDMINU = 6'b000100,
    VREDMIN = 6'b000101,
    VREDMAXU = 6'b000110,
    VREDMAX = 6'b000111,
    VAADDU = 6'b001000,
    VAADD = 6'b001001,
    VASUBU = 6'b001010,
    VASUB = 6'b001011,
    VSLIDE1UP = 6'b001110,
    VSLIDE1DOWN = 6'b001111,
    VWXUNARY0 = 6'b010000, //V is w, X is VRXUNARY0
    VXUNARY0 = 6'b010010,
    VMUNARY0 = 6'b010100,
    VCOMPRESS = 6'b010111,
    VMANDN = 6'b011000,
    VMAND = 6'b011001,
    VMOR = 6'b011010,
    VMXOR = 6'b011011,
    VMORN = 6'b011100,
    VMNAND = 6'b011101,
    VMNOR = 6'b011110,
    VMXNOR = 6'b011111,
    VDIVU = 6'b100000,
    VDIV = 6'b100001,
    VREMU = 6'b100010,
    VREM = 6'b100011,
    VMULHU = 6'b100100,
    VMUL = 6'b100101,
    VMULHSU = 6'b100110,
    VMULH = 6'b100111,
    VMADD = 6'b101001,
    VNMSUB = 6'b101011,
    VMACC = 6'b101101,
    VNMSAC = 6'b101111,
    VWADDU = 6'b110000,
    VWADD = 6'b110001,
    VWSUBU = 6'b110010,
    VWSUB = 6'b110011,
    VWADDU_W = 6'b110100,
    VWADD_W = 6'b110101,
    VWSUBU_W = 6'b110110,
    VWSUB_W = 6'b110111,
    VWMULU = 6'b111000,
    VWMULSU = 6'b111010,
    VWMUL = 6'b111011,
    VWMACCU = 6'b111100,
    VWMACC = 6'b111101,
    VWMACCUS = 6'b111110,
    VWMACCSU = 6'b111111
  } vopm_t;


  typedef enum logic [6:0] { 
    BAD_OP = 0,
    OP_VADD,
    OP_VSUB,
    OP_VRSUB,
    OP_VMINU,
    OP_VMIN,
    OP_VMAXU,
    OP_VMAX,
    OP_VAND,
    OP_VOR,
    OP_VXOR,
    OP_VRGATHER,
    OP_VSLIDEUP,
    OP_VRGATHEREI16,
    OP_VSLIDEDOWN,
    OP_VADC,
    OP_VMADC,
    OP_VSBC,
    OP_VMSBC,
    OP_VMERGE,
    OP_VMV,
    OP_VMSEQ,
    OP_VMSNE,
    OP_VMSLTU,
    OP_VMSLT,
    OP_VMSLEU,
    OP_VMSLE,
    OP_VMSGTU,
    OP_VMSGT,
    OP_VSADDU,
    OP_VSADD,
    OP_VSSUBU,
    OP_VSSUB,
    OP_VSLL,
    OP_VSMUL,
    OP_VMV1R,
    OP_VMV2R,
    OP_VMV4R,
    OP_VMV8R,
    OP_VSRL,
    OP_VSRA,
    OP_VSSRL,
    OP_VSSRA,
    OP_VNSRL,
    OP_VNSRA,
    OP_VNCLIPU,
    OP_VNCLIP,
    OP_VWREDSUMU,
    OP_VWREDSUM,
    OP_VREDSUM,
    OP_VREDAND,
    OP_VREDOR,
    OP_VREDXOR,
    OP_VREDMINU,
    OP_VREDMIN,
    OP_VREDMAXU,
    OP_VREDMAX,
    OP_VAADDU,
    OP_VAADD,
    OP_VASUBU,
    OP_VASUB,
    OP_VSLIDE1UP,
    OP_VSLIDE1DOWN,
    OP_VMV_X_S,
    OP_VPOPC,
    OP_VFIRST,
    OP_VMV_S_X,
    OP_VZEXT_VF8,
    OP_VSEXT_VF8,
    OP_VZEXT_VF4,
    OP_VSEXT_VF4,
    OP_VZEXT_VF2,
    OP_VSEXT_VF2,
    OP_VMSBF,
    OP_VMSOF,
    OP_VMSIF,
    OP_VIOTA,
    OP_VID,
    OP_VCOMPRESS,
    OP_VMANDN,
    OP_VMAND,
    OP_VMOR,
    OP_VMXOR,
    OP_VMORN,
    OP_VMNAND,
    OP_VMNOR,
    OP_VMXNOR,
    OP_VDIVU,
    OP_VDIV,
    OP_VREMU,
    OP_VREM,
    OP_VMULHU,
    OP_VMUL,
    OP_VMULHSU,
    OP_VMULH,
    OP_VMADD,
    OP_VNMSUB,
    OP_VMACC,
    OP_VNMSAC,
    OP_VWADDU,
    OP_VWADD,
    OP_VWSUBU,
    OP_VWSUB,
    OP_VWADDU_W,
    OP_VWADD_W,
    OP_VWSUBU_W,
    OP_VWSUB_W,
    OP_VWMULU,
    OP_VWMULSU,
    OP_VWMUL,
    OP_VWMACCU,
    OP_VWMACC,
    OP_VWMACCUS,
    OP_VWMACCSU
  } vop_decoded_t;

  typedef enum logic[4:0] { //vs1
    VMV_X_S = 5'b00000,
    VPOPC = 5'b10000,
    VFIRST = 5'b10001
  } vwxunary0_t;

  typedef enum logic[4:0] { 
    VMV_S_X = 5'b00000 
  } vrxunary0_t;

  typedef enum logic[4:0] { 
    VZEXT_VF8 = 5'b00010,
    VSEXT_VF8 = 5'b00011,
    VZEXT_VF4 = 5'b00100,
    VSEXT_VF4 = 5'b00101,
    VZEXT_VF2 = 5'b00110,
    VSEXT_VF2 = 5'b00111
  } vxunary0_t;

  typedef enum logic[4:0] { 
    VMSBF = 5'b00001,
    VMSOF = 5'b00010,
    VMSIF = 5'b00011,
    VIOTA = 5'b10000,
    VID = 5'b10001
  } vmunary0_t;

  typedef logic [VLEN_WIDTH: 0] offset_t; //bits needed to hold offset
  typedef logic [7:0] byte_t;
  typedef byte_t [VLENB-1:0]  vreg_t;

  typedef enum logic [3:0] {
    ARITH,
    RED,  //WRONG
    MUL,
    DIV,
    MASK,
    PEM,
    LOAD_UNIT,
    STORE_UNIT,
    MOVE,
    MADD, //WRONG
  } fu_t;

  typedef enum logic [3:0] {
    VALU_SLL   = 4'b0000,
    VALU_SRL   = 4'b0001,
    VALU_SRA   = 4'b0010,
    VALU_ADD   = 4'b0011,
    VALU_SUB   = 4'b0100,
    VALU_AND   = 4'b0101,
    VALU_OR    = 4'b0110,
    VALU_XOR   = 4'b0111,
    VALU_COMP  = 4'b1000,
    VALU_MERGE = 4'b1001,
    // VALU_MOVE  = 4'b1010,
    VALU_MM    = 4'b1011,
    VALU_EXT   = 4'b1100,
  } valuop_t;

  typedef enum logic [2:0] {
    VSEQ   = 3'b000,
    VSNE   = 3'b001,
    VSLTU  = 3'b010,
    VSLT   = 3'b011,
    VSLEU  = 3'b100,
    VSLE   = 3'b101,
    VSGTU  = 3'b110,
    VSGT   = 3'b111
  } comp_t;

  typedef enum logic [2:0] {
    MIN   = 3'b00,
    MINU  = 3'b01,
    MAX   = 3'b10,
    MAXU  = 3'b11
  } mm_t;

  typedef enum logic [3:0] {
    NORMAL  = 4'b0000,
    A_S     = 4'b0001,
    MULTI   = 4'b0010,
    DIVI    = 4'b0011,
    REM     = 4'b0100
  } athresult_t;

  typedef enum logic [3:0] {
    VMASK_AND,
    VMASK_NAND,
    VMASK_ANDN,
    VMASK_OR,
    VMASK_NOR,
    VMASK_ORN,
    VMASK_XOR,
    VMASK_XNOR,
    VMASK_POPC,
    VMASK_FIRST,
    VMASK_SBF,
    VMASK_SIF,
    VMASK_SOF,
    VMASK_IOTA,
    VMASK_ID    
  } ma_t;

  typedef enum logic [2:0] {
    F2Z = 3'b000,
    F2S = 3'b001,
    F4Z = 3'b010,
    F4S = 3'b011,
    F8Z = 3'b100,
    F8S = 3'b101
  } ext_t;

  typedef enum logic [1:0] {
    V = 2'b00,
    I = 2'b01,
    X = 2'b10
  } rs_t;
  
  typedef enum logic { 
    VS1_SRC_NORMAL = 0, 
    VS1_SRC_ZERO = 1 
  } vs1_offset_src_t;

  typedef enum logic [3:0] { 
    VS2_SRC_NORMAL = 0,
    VS2_SRC_IDX_PLUS_RS1,
    VS2_SRC_IDX_PLUS_UIMM,
    VS2_SRC_IDX_PLUS_1,
    VS2_SRC_IDX_MINUS_1,
    VS2_SRC_VS1,
    VS2_SRC_RS1,
    VS2_SRC_UIMM,
    VS2_SRC_ZERO
  } vs2_offset_src_t;

  typedef enum logic [2:0] { 
    VD_SRC_NORMAL = 0,
    VD_SRC_ZERO,
    VD_SRC_IDX_PLUS_RS1,
    VD_SRC_IDX_PLUS_UIMM,
    VD_SRC_IDX_PLUS_1,
    VD_SRC_COMPRESS
  } vd_offset_src_t;

  typedef struct packed {
    logic [3:0] reserved;
    logic vma;
    logic vta;
    sew_t sew;
    vlmul_t lmul;
    logic [4:0] rs1;
    vfunct3_t funct3;
    logic [4:0] rd;
    // rv32i_types_pkg::opcode_t op;
  } vop_cfg;

  typedef enum logic [2:0] {
    ONE = 0,
    TWO = 1,
    FOUR = 2, 
    EIGHT = 3,
    X_S,
    S_X,
    NOT_VMV = 7
  } vmv_type_t;

  typedef enum logic [1:0] {
    SIGNED = 2'b11,
    SIGNED_UNSIGNED = 2'b10,
    UNSIGNED_SIGNED = 2'b01,
    UNSIGNED = 0
  } sign_type_t;


endpackage
`endif
