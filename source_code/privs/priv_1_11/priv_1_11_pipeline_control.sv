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
*   Filename:     priv_1_11_pipeline_control.sv
*
*   Created by:   Jacob R. Stevens
*   Email:        steven69@purdue.edu
*   Date Created: 08/13/2019
*   Description:  Control signals for the pipeline from the exception/IRQ
*                 block 
*/
// Code will mainly be used as pipeline control
`include "priv_1_11_internal_if.vh"

module priv_1_11_pipeline_control
(
  input logic [1:0] prv_intr, prv_ret,
  priv_1_11_internal_if.pipe_ctrl prv_intern_if // interface for pipeline control
);
  import rv32i_types_pkg::*;
  logic interrupt_pending;
 
  assign prv_intern_if.insert_pc = prv_intern_if.mret | (prv_intern_if.pipe_clear & prv_intern_if.intr); // only need to insert the Program Counter if 
 
  always_comb begin
    if(prv_intern_if.intr)
      prv_intern_if.priv_pc = prv_intern_if.xtvec[prv_intr];

    else if (prv_intern_if.mret) // TODO: Change the logic so that we can point to the vector according to mret, sret, or uret, may need another package structure for this
      prv_intern_if.priv_pc = prv_intern_if.xtvec[prv_ret];
    else
      prv_intern_if.priv_pc = 32'b0;
  end

endmodule
