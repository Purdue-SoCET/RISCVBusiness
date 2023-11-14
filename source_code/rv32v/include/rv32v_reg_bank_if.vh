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
*   Filename:     include/rv32v_reg_bank_if.vh
*
*   Created by:   Om Gupta
*   Email:        guptao@purdue.edu
*   Date Created: 11/03/2023
*   Description:  Interface for a single vector register bank 
*/

`ifndef RV32V_REG_BANK_IF_VH
`define RV32V_REG_BANK_IF_VH

interface rv32v_reg_bank_if();

  import rv32v_types_pkg::*;

  word_t        vd_data, vs1_data, vs2_data, vmask_data;
  logic   [4:0] vs1_sel, vs2_sel, vd_sel;  // 32 vector registers
  logic   [3:0] vwen;  // per-byte write enable to enable masking

  modport rf (
    // read-side inputs
    input vs1_sel, vs2_sel,
    // read-side outputs
    output vs1_data, vs2_data, vmask_data,
    // write-side inputs
    input vd_sel, vd_data, vwen
  );

endinterface

`endif //RV32V_REG_BANK_IF_VH
