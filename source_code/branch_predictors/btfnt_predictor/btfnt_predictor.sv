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
*   Filename:     btfnt_predictor.sv
*
*   Created by:   Yueting Mary Zhao
*   Email:        zhao979@purdue.edu
*   Date Created: 06/30/2023
*   Description:  A static branch predictor that predicts taken if the branch
*				  is backward, and not taken if it is forward.
*/

`include "predictor_pipeline_if.vh"

module btfnt_predictor (
    input logic CLK,
    nRST,
    predictor_pipeline_if.predictor predict_if
);
	
	import rv32i_types_pkg::*;

	word_t offset;

	assign offset = $signed(predict_if.imm_sb);
    assign predict_if.predict_taken = (predict_if.is_branch && offset[WORD_SIZE-1]) ? 1 : 0;		// offset < 0 taken; otherwise not taken
    assign predict_if.target_addr   = predict_if.predict_taken ? predict_if.current_pc + offset
									  : (predict_if.is_rv32c	   ? predict_if.current_pc + 2
									  : predict_if.current_pc + 4);

endmodule
