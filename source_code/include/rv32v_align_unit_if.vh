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
*   Filename:     include/rv32v_align_unit_if.vh
*
*   Created by:   Om Gupta
*   Email:        guptao@purdue.edu
*   Date Created: 11/03/2023
*   Description:  Interface for the data alignment unit
*/

`ifndef RV32V_ALIGN_UNIT_IF_VH
`define RV32V_ALIGN_UNIT_IF_VH

interface rv32v_align_unit_if();

  import rv32v_types_pkg::*;

  word_t vin_data, vout_data;

  sew_t vsew_src;
  logic [1:0] velemoffset;
  logic vsignext;  // 0 -> zero extend; 1 -> sign extend

  modport vau(
    input vin_data, vsew_src, velemoffset, vsignext,
    output vout_data
  );

endinterface

`endif //RV32V_ALIGN_UNIT_IF_VH
