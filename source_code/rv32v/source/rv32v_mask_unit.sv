/*
*   Copyright 2024 Purdue University
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
*   Filename:     rv32v_mask_unit.sv
*
*   Created by:   Fahad Aloufi
*   Email:        faloufi@purdue.edu
*   Date Created: 2/3/2024
*   Description:  generates the mask bits for write back and memory accesses   
*/

import rv32i_types_pkg::*;

module rv32v_mask_unit
(
    input logic[127:0] v0, 
    input logic mask_enable, 
    input logic[4:0] uop_num,
    input logic[3:0] lane_active, 

    output logic[3:0] lane_en
);

logic[6:0] first_elem_no; 

always_comb begin
    first_elem_no = {2'b0, uop_num}; 
    first_elem_no = first_elem_no << 2; 
    if(~mask_enable)
        lane_en = lane_active; 
    else begin
        lane_en[0] = lane_active & v0[first_elem_no]; 
        lane_en[1] = lane_active & v0[first_elem_no + 1]; 
        lane_en[2] = lane_active & v0[first_elem_no + 2]; 
        lane_en[3] = lane_active & v0[first_elem_no + 3]; 
    end
end

endmodule