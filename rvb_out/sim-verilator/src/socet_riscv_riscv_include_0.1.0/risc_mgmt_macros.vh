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
*   Filename:     risc_mgmt_macros.vh
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 02/07/2017
*   Description:  Macros used to automate the instantiation of RISC-MGMT
*                 extensions. 
*/

`ifndef RISC_MGMT_MACROS_VH
`define RISC_MGMT_MACROS_VH
 
/*****************************************************************************
 *  ADD_EXTENSION
 *
 *  This macro will instantiate all the interfaces and modules needed for an 
 *  extension.
 *
 *  This version of ADD_EXTENSION will connect the extension to a two stage
 *  inorder pipeline.  To have ADD_EXTENSION connect the extension to a deeper
 *  pipeline, pipeline registers should be inserted between stages using the
 *  structs in the pkg for the module.  Enable and flush signals should be
 *  connected to each pipeline register  
 *
 *  After instantiation, the interface will be connected to the RISC-MGMT
 *  logic based off of EXT_ID.  EXT_ID must be unique to the extension and
 *  must be less than NUM_EXTENSIONS.
 *
 ****************************************************************************/

`define ADD_EXTENSION(EXT_NAME,EXT_ID)                                                                                \
  // instantiate stage to stage interfaces  \
  ``EXT_NAME``_pkg::decode_execute_t ``EXT_NAME``_idex;                                                               \
  ``EXT_NAME``_pkg::execute_memory_t ``EXT_NAME``_exmem;                                                              \
  // instantiate RISC-MGMT interfaces \
  risc_mgmt_decode_if   ``EXT_NAME``_idif();                                                                          \
  risc_mgmt_execute_if  ``EXT_NAME``_exif();                                                                          \
  risc_mgmt_memory_if   ``EXT_NAME``_memif();                                                                         \
  // instantiate extension stages   \
  ``EXT_NAME``_decode   ``EXT_NAME``_decode_t (CLK, nRST, ``EXT_NAME``_idif, ``EXT_NAME``_idex);                      \
  ``EXT_NAME``_execute  ``EXT_NAME``_execute_t(CLK, nRST, ``EXT_NAME``_exif, ``EXT_NAME``_idex, ``EXT_NAME``_exmem);  \
  ``EXT_NAME``_memory   ``EXT_NAME``_memory_t(CLK, nRST, ``EXT_NAME``_memif, ``EXT_NAME``_exmem);                     \
  // decode stage connections to RISC-MGMT \
  assign ``EXT_NAME``_idif.insn       = d_insn[EXT_ID];                                                               \
  assign d_insn_claim[EXT_ID]         = ``EXT_NAME``_idif.insn_claim;                                                 \
  assign d_mem_to_reg[EXT_ID]         = ``EXT_NAME``_idif.mem_to_reg;                                                 \
  assign d_rsel_s_0[EXT_ID]           = ``EXT_NAME``_idif.rsel_s_0;                                                   \
  assign d_rsel_s_1[EXT_ID]           = ``EXT_NAME``_idif.rsel_s_1;                                                   \
  assign d_rsel_d[EXT_ID]             = ``EXT_NAME``_idif.rsel_d;                                                     \
  // execute stage connections to RISC-MGMT \
  assign e_exception[EXT_ID]          = ``EXT_NAME``_exif.exception;                                                  \
  assign e_busy[EXT_ID]               = ``EXT_NAME``_exif.busy;                                                       \
  assign e_branch_jump[EXT_ID]        = ``EXT_NAME``_exif.branch_jump;                                                \
  assign e_br_j_addr[EXT_ID]          = ``EXT_NAME``_exif.br_j_addr;                                                  \
  assign ``EXT_NAME``_exif.pc         = e_pc[EXT_ID];                                                                 \
  assign e_reg_wdata[EXT_ID]          = ``EXT_NAME``_exif.reg_wdata;                                                  \
  assign e_reg_w[EXT_ID]              = ``EXT_NAME``_exif.reg_w;                                                      \
  assign ``EXT_NAME``_exif.rdata_s_0  = e_rdata_s_0[EXT_ID];                                                          \
  assign ``EXT_NAME``_exif.rdata_s_1  = e_rdata_s_1[EXT_ID];                                                          \
  assign ``EXT_NAME``_exif.start      = e_start[EXT_ID];                                                              \
  // memory stage connections to RISC-MGMT  \
  assign m_exception[EXT_ID]          = ``EXT_NAME``_memif.exception;                                                 \
  assign m_busy[EXT_ID]               = ``EXT_NAME``_memif.busy;                                                      \
  assign m_mem_addr[EXT_ID]           = ``EXT_NAME``_memif.mem_addr;                                                  \
  assign m_mem_ren[EXT_ID]            = ``EXT_NAME``_memif.mem_ren;                                                   \
  assign m_mem_wen[EXT_ID]            = ``EXT_NAME``_memif.mem_wen;                                                   \
  assign m_mem_byte_en[EXT_ID]        = ``EXT_NAME``_memif.mem_byte_en;                                               \
  assign m_reg_wdata[EXT_ID]          = ``EXT_NAME``_memif.reg_wdata;                                                 \
  assign m_reg_w[EXT_ID]              = ``EXT_NAME``_memif.reg_w;                                                     \
  assign m_mem_store[EXT_ID]          = ``EXT_NAME``_memif.mem_store;                                                 \
  assign ``EXT_NAME``_memif.mem_busy  = m_mem_busy[EXT_ID];                                                           \
  assign ``EXT_NAME``_memif.mem_load  = m_mem_load[EXT_ID];
 
/*****************************************************************************
 *  ADD_EXTENSION_WITH_OPCODE
 *
 *  This macro will instantiate all the interfaces and modules needed for an 
 *  extension.
 *
 *  This version of ADD_EXTENSION will connect the extension to a two stage
 *  inorder pipeline.  To have ADD_EXTENSION connect the extension to a deeper
 *  pipeline, pipeline registers should be inserted between stages using the
 *  structs in the pkg for the module.  Enable and flush signals should be
 *  connected to each pipeline register  
 *
 *  After instantiation, the interface will be connected to the RISC-MGMT
 *  logic based off of EXT_ID.  EXT_ID must be unique to the extension and
 *  must be less than NUM_EXTENSIONS.
 *
 *  This macro will also override the opcode parameter for portibility of 
 *  nonstandard extensions.
 *
 ****************************************************************************/

`define ADD_EXTENSION_WITH_OPCODE(EXT_NAME,EXT_ID,EXT_OPCODE)                                                         \
  // instantiate stage to stage interfaces  \
  ``EXT_NAME``_pkg::decode_execute_t ``EXT_NAME``_idex;                                                               \
  ``EXT_NAME``_pkg::execute_memory_t ``EXT_NAME``_exmem;                                                              \
  // instantiate RISC-MGMT interfaces \
  risc_mgmt_decode_if   ``EXT_NAME``_idif();                                                                          \
  risc_mgmt_execute_if  ``EXT_NAME``_exif();                                                                          \
  risc_mgmt_memory_if   ``EXT_NAME``_memif();                                                                         \
  // instantiate extension stages   \
  ``EXT_NAME``_decode #(.OPCODE(EXT_OPCODE))  ``EXT_NAME``_decode_t (CLK, nRST, ``EXT_NAME``_idif, ``EXT_NAME``_idex);\
  ``EXT_NAME``_execute  ``EXT_NAME``_execute_t(CLK, nRST, ``EXT_NAME``_exif, ``EXT_NAME``_idex, ``EXT_NAME``_exmem);  \
  ``EXT_NAME``_memory   ``EXT_NAME``_memory_t(CLK, nRST, ``EXT_NAME``_memif, ``EXT_NAME``_exmem);                     \
  // decode stage connections to RISC-MGMT \
  assign ``EXT_NAME``_idif.insn       = d_insn[EXT_ID];                                                               \
  assign d_insn_claim[EXT_ID]         = ``EXT_NAME``_idif.insn_claim;                                                 \
  assign d_mem_to_reg[EXT_ID]         = ``EXT_NAME``_idif.mem_to_reg;                                                 \
  assign d_rsel_s_0[EXT_ID]           = ``EXT_NAME``_idif.rsel_s_0;                                                   \
  assign d_rsel_s_1[EXT_ID]           = ``EXT_NAME``_idif.rsel_s_1;                                                   \
  assign d_rsel_d[EXT_ID]             = ``EXT_NAME``_idif.rsel_d;                                                     \
  // execute stage connections to RISC-MGMT \
  assign e_exception[EXT_ID]          = ``EXT_NAME``_exif.exception;                                                  \
  assign e_busy[EXT_ID]               = ``EXT_NAME``_exif.busy;                                                       \
  assign e_branch_jump[EXT_ID]        = ``EXT_NAME``_exif.branch_jump;                                                \
  assign e_br_j_addr[EXT_ID]          = ``EXT_NAME``_exif.br_j_addr;                                                  \
  assign ``EXT_NAME``_exif.pc         = e_pc[EXT_ID];                                                                 \
  assign e_reg_wdata[EXT_ID]          = ``EXT_NAME``_exif.reg_wdata;                                                  \
  assign e_reg_w[EXT_ID]              = ``EXT_NAME``_exif.reg_w;                                                      \
  assign ``EXT_NAME``_exif.rdata_s_0  = e_rdata_s_0[EXT_ID];                                                          \
  assign ``EXT_NAME``_exif.rdata_s_1  = e_rdata_s_1[EXT_ID];                                                          \
  assign ``EXT_NAME``_exif.start      = e_start[EXT_ID];                                                              \
  // memory stage connections to RISC-MGMT  \
  assign m_exception[EXT_ID]          = ``EXT_NAME``_memif.exception;                                                 \
  assign m_busy[EXT_ID]               = ``EXT_NAME``_memif.busy;                                                      \
  assign m_mem_addr[EXT_ID]           = ``EXT_NAME``_memif.mem_addr;                                                  \
  assign m_mem_ren[EXT_ID]            = ``EXT_NAME``_memif.mem_ren;                                                   \
  assign m_mem_wen[EXT_ID]            = ``EXT_NAME``_memif.mem_wen;                                                   \
  assign m_mem_byte_en[EXT_ID]        = ``EXT_NAME``_memif.mem_byte_en;                                               \
  assign m_reg_wdata[EXT_ID]          = ``EXT_NAME``_memif.reg_wdata;                                                 \
  assign m_reg_w[EXT_ID]              = ``EXT_NAME``_memif.reg_w;                                                     \
  assign m_mem_store[EXT_ID]          = ``EXT_NAME``_memif.mem_store;                                                 \
  assign ``EXT_NAME``_memif.mem_busy  = m_mem_busy[EXT_ID];                                                           \
  assign ``EXT_NAME``_memif.mem_load  = m_mem_load[EXT_ID];


`endif //RISC_MGMT_MACROS_VH
