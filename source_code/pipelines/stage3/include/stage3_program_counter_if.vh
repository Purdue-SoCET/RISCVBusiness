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
*   Filename:     stage3_program_counter_if.vh
*   
*   Created by:   Rohan Gangraju	
*   Email:        rgangar@purdue.edu
*   Date Created: 11/20/2023
*   Description:  Program counter interface signals
*/

`ifndef STAGE3_PROGRAM_COUNTER_IF
`define STAGE3_PROGRAM_COUNTER_IF

interface stage3_program_counter_if #(
  parameter NUM_HARTS = 1
);
  import rv32i_types_pkg::*;
  import stage3_types_pkg::*;
 
  word_t [NUM_HARTS-1:0] pc;
  word_t npc;

  modport pc_unit(
    input npc,
    output pc
  );

  modport fetch(
    input pc,
    output npc
  );
endinterface
`endif
