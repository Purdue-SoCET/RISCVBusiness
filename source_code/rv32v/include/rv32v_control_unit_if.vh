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
*   Filename:     include/rv32v_control_unit_if.vh
*
*   Created by:   Om Gupta
*   Email:        guptao@purdue.edu
*   Date Created: 11/13/2023
*   Description:  Interface for the instruction decode for vector instructions
*/

`ifndef RV32V_CONTROL_UNIT_IF_VH
`define RV32V_CONTROL_UNIT_IF_VH

interface rv32v_control_unit_if();

  import rv32i_types_pkg::*;
  import rv32v_types_pkg::*;

  // Incoming instruction
  word_t instr;

  // Vector CSR values
  vsew_t vsew;
  vlmul_t vlmul;
  logic vta, vma;

  // Control signals
  vcontrol_t vcontrol;

  // Valid output flag
  logic vvalid;

  modport vcu(
    input instr,
    output vcontrol, vvalid
  );

endinterface

`endif //RV32V_CONTROL_UNIT_IF_VH
