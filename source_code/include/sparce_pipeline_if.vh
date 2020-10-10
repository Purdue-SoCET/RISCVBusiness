/*
*   Copyright 2019 Purdue University
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
*   Filename:     sparce_pipeline_if.vh
*   
*   Created by:   Vadim V. Nikiforov 
*   Email:        vnikifor@purdue.edu
*   Date Created: 04/17/2019
*   Description:  Interface between the sparsity optimization unit and the
*                 rest of the pipeline. Does not include internal signals
*                 between blocks needed for sparsity optimizations.
*/

`ifndef SPARCE_PIPELINE_IF_VH
`define SPARCE_PIPELINE_IF_VH

interface sparce_pipeline_if;

  import rv32i_types_pkg::*;

  word_t pc, wb_data,  sasa_data, sasa_addr;
  logic wb_en, sasa_wen;
  logic [4:0] rd;
  logic if_ex_enable;
  
  word_t sparce_target, rdata;
  logic skipping;

  modport pipeline (
    input sparce_target, skipping,
    output pc, wb_data, wb_en, sasa_data, sasa_addr, sasa_wen, rd, if_ex_enable, rdata
  );

  modport pipe_fetch (
    input sparce_target, skipping,
    output pc, rdata
  );

  modport pipe_execute (
    input sparce_target, skipping,
    output wb_data, wb_en, sasa_data, sasa_addr, sasa_wen, rd
  );

  modport hazard (
    input sparce_target, skipping,
    output if_ex_enable
  );

  modport sparce (
    output sparce_target, skipping,
    input pc, wb_data, wb_en, sasa_data, sasa_addr, sasa_wen, rd, if_ex_enable, rdata
  );


endinterface
`endif //SPARCE_PIPELINE_IF
