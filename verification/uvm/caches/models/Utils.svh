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
*   Filename:     utils.svh
*
*   Created by:   Mitch Arndt
*   Email:        arndt20@purdue.edu
*   Date Created: 04/1/2022
*   Description:  utility class for:
*                   - helping with byte_en masking
*/

`ifndef UTILS_SHV
`define UTILS_SHV

class Utils;
  static function word_t byte_mask(logic [3:0] byte_en);
    word_t mask;

    mask = '0;
    for (int i = 0; i < 4; i++) begin
      if (byte_en[i]) begin
        mask |= 32'hff << (8 * i);
      end
    end
    return mask;
  endfunction : byte_mask
endclass : Utils

`endif
