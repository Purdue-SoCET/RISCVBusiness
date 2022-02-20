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
*   Filename:     divide_unit.sv
*
*   Created by:   Jing Yin See
*   Email:        see4@purdue.edu
*   Date Created: 11/7/2021
*   Description:  DIVU
*/

`include "divide_unit_if.vh"

module divide_unit (
  input logic CLK, nRST,
  divide_unit_if.execute dif
);

  import rv32i_types_pkg::*;

  logic start_reg, done;
  logic [31:0] quotient, remainder;

  divider DVD (
    .CLK(CLK),
    .nRST(nRST),
    .dividend(dif.rs1_data),
    .divisor(dif.rs2_data),
    .is_signed(dif.is_signed_div),
    .start(dif.start_div),
    .finished(done),
    .quotient(quotient),
    .remainder(remainder)
  );
  logic [31:0] q;

  assign dif.busy_du      = (start_reg | dif.start_div) & !done; 
  assign dif.wdata_du     = dif.div_type ? q : remainder;
  assign dif.exception_du = 0;  // Divide by 0
  assign dif.done_du      = done;  

  assign q = (dif.rs2_data == 0) && dif.is_signed_div  ? 32'hFFFF_FFFF : 
             (dif.rs2_data == 0) && ~dif.is_signed_div ? 32'h7FFF_FFFF : quotient;

  // Fix corner case: Operate only 1 or 2 element consecutively
  always_ff @ (posedge CLK, negedge nRST) begin
    if (nRST == 0) begin
      start_reg <= '0;
    end else if (done) begin
      start_reg <= 0;
    end else if (dif.start_div) begin
      start_reg <= 1;
    end
  end

endmodule
