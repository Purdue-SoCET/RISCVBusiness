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
*   Filename:     src/dmem_extender.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 06/16/2016
*   Description:  Swaps the endianess and bit slices the data based on the
*                 load type
*/

import rv32i_types_pkg::*;
module dmem_extender (
    input  word_t       dmem_in,
    input  load_t       load_type,
    input  logic  [3:0] byte_en,
    output word_t       ext_out
);

    /*
  always_comb begin
    casez (load_type)
      LB  : begin
        casez (byte_en)
          4'b0001   : ext_out = 32'(signed'(dmem_in[7:0]));
          4'b0010   : ext_out = 32'(signed'(dmem_in[15:8]));
          4'b0100   : ext_out = 32'(signed'(dmem_in[23:16]));
          4'b1000   : ext_out = 32'(signed'(dmem_in[31:24]));
          default   : ext_out = '0;
        endcase
      end

      LBU : begin
        casez (byte_en)
          4'b0001   : ext_out = 32'({'0,dmem_in[7:0]});
          4'b0010   : ext_out = 32'({'0,dmem_in[15:8]});
          4'b0100   : ext_out = 32'({'0,dmem_in[23:16]});
          4'b1000   : ext_out = 32'({'0,dmem_in[31:24]});
          default   : ext_out = '0;
        endcase
      end

      LH  : begin
        casez (byte_en)
          4'b0011   : ext_out = 32'(signed'(dmem_in[15:0]));
          4'b1100   : ext_out = 32'(signed'(dmem_in[31:16]));
          default   : ext_out = '0;
        endcase
      end

      LHU : begin
        casez (byte_en)
          4'b0011   : ext_out = 32'({'0,dmem_in[15:0]});
          4'b1100   : ext_out = 32'({'0,dmem_in[31:16]});
          default   : ext_out = '0;
        endcase
      end

      LW            : ext_out = dmem_in;

      default       : ext_out = '0;
    endcase
  end
*/




    always_comb begin
        casez (load_type)
            LB: begin
                casez (byte_en)
                    4'b0001: ext_out = $signed(dmem_in[7:0]);
                    4'b0010: ext_out = $signed(dmem_in[15:8]);
                    4'b0100: ext_out = $signed(dmem_in[23:16]);
                    4'b1000: ext_out = $signed(dmem_in[31:24]);
                    default: ext_out = '0;
                endcase
            end

            LBU: begin
                casez (byte_en)
                    4'b0001: ext_out = dmem_in[7:0];
                    4'b0010: ext_out = dmem_in[15:8];
                    4'b0100: ext_out = dmem_in[23:16];
                    4'b1000: ext_out = dmem_in[31:24];
                    default: ext_out = '0;
                endcase
            end

            LH: begin
                casez (byte_en)
                    4'b0011: ext_out = $signed(dmem_in[15:0]);
                    4'b1100: ext_out = $signed(dmem_in[31:16]);
                    default: ext_out = '0;
                endcase
            end

            LHU: begin
                casez (byte_en)
                    4'b0011: ext_out = dmem_in[15:0];
                    4'b1100: ext_out = dmem_in[31:16];
                    default: ext_out = '0;
                endcase
            end

            LW: ext_out = dmem_in;

            default: ext_out = '0;
        endcase
    end

endmodule
