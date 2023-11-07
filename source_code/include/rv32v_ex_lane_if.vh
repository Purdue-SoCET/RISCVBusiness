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
*   Filename:     include/rv32v_ex_lane_if.vh
*
*   Created by:   Om Gupta
*   Email:        guptao@purdue.edu
*   Date Created: 11/03/2023
*   Description:  Interface for a single vector execution lane
*/

`ifndef RV32V_EX_LANE_IF_VH
`define RV32V_EX_LANE_IF_VH

interface rv32v_ex_lane_if();

  import rv32v_types_pkg::*;

  // Input and output data lines
  word_t vin1_data, vin2_data, vout_data;

  // Functional unit to use
  vfu_t vfu;

  // Ops for each functional unit (MUL and DIV ops implicit as they are single-purpose)
  valuop_t valuop;
  vredop_t vredop;
  vmaskop_t vmaskop;
  vpermop_t vpermop;

  logic vxbusy;

  modport vxl(
    input vin1_data, vin2_data,
    input vfu, valuop, vredop, vmaskop, vpermop,
    output vout_data, vxbusy
  )

endinterface

`endif //RV32V_EX_LANE_IF_VH
