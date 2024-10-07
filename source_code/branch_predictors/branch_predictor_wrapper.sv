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
*   Filename:     branch_predictor_wrapper.sv
*
*   Created by:   John Skubic
*   Email:        jskubic@purdue.edu
*   Date Created: 06/19/2016
*   Description:  Branch Predictor, BTB, RAS, GHR_PHT
*                 Replace declaration of not taken predictor as desired
*/

`include "predictor_pipeline_if.vh"
`include "component_selection_defines.vh"
`include "fetch_buffer_if.vh"

module branch_predictor_wrapper (
    input logic CLK,
    nRST,
    predictor_pipeline_if.predictor predict_if,
    tspp_fetch_execute_if.fetch fetch_ex_if
    //fetch_buffer_if.fb fb_if
    //predictor_pipeline_if.access access_if
);
    // Predictor used based on the BR_PREDICTOR_TYPE definition

    predictor_pipeline_if predict_temp1();
    predictor_pipeline_if predict_temp2();    
   
    always_comb begin
        $display(BR_PREDICTOR_TYPE);

        predict_temp1.current_pc = predict_if.current_pc;
        predict_temp1.update_predictor = predict_if.update_predictor;
        predict_temp1.prediction = predict_if.prediction;
        predict_temp1.branch_result = predict_if.branch_result;
        predict_temp1.update_addr = predict_if.update_addr;
        predict_temp1.is_rv32c = predict_if.is_rv32c;
        predict_temp1.imm_sb = predict_if.imm_sb;
        predict_temp1.pc_to_update = predict_if.pc_to_update;
        predict_temp1.is_branch = predict_if.is_branch;
        predict_temp1.is_jump = predict_if.is_jump;
        predict_temp1.direction = predict_if.direction;
        predict_temp1.instr = predict_if.instr;
        predict_temp1.is_jalr = predict_if.is_jalr;

        predict_temp2.current_pc = predict_if.current_pc;
        predict_temp2.update_predictor = predict_if.update_predictor;
        predict_temp2.prediction = predict_if.prediction;
        predict_temp2.branch_result = predict_if.branch_result;
        predict_temp2.update_addr = predict_if.update_addr;
        predict_temp2.is_rv32c = predict_if.is_rv32c;
        predict_temp2.imm_sb = predict_if.imm_sb;
        predict_temp2.pc_to_update = predict_if.pc_to_update;
        predict_temp2.is_branch = predict_if.is_branch;
        predict_temp2.is_jump = predict_if.is_jump;
        predict_temp2.direction = predict_if.direction;
        predict_temp2.instr = predict_if.instr;
        predict_temp2.is_jalr = predict_if.is_jalr;
        
        if(predict_if.is_jalr) begin //might have to be is_jalr or is_jump
            predict_if.predict_taken = predict_temp2.predict_taken;
            predict_if.target_addr = predict_temp2.target_addr;
        end
        else begin
            predict_if.predict_taken = predict_temp1.predict_taken;
            predict_if.target_addr = predict_temp1.target_addr;
        end
    end
    generate
        //case (BR_PREDICTOR_TYPE)
        //    "not_taken": nottaken_predictor predictor (.*);	// static not taken predictor
		//	"btfnt"	   : btfnt_predictor predictor (.*);	// static backward taken/forward not taken predictor
		//	"btb_1"	   : btb predictor (.*);				// branch target buffer with 1 bit predictor
		//	"btb_2"	   : btb #(.PRED_BITS(2)) predictor (.*); // BTB with 2-bit predictor
		//	"return"   : return_predictor #(.entries(10)) predictor (.*); //return address predictor
        //endcase
            case (BR_PREDICTOR_TYPE)
                "not_taken": nottaken_predictor predictor (CLK, nRST, predict_temp1);	// static not taken predictor
		        "btfnt"	   : btfnt_predictor predictor (CLK, nRST, predict_temp1);	// static backward taken/forward not taken predictor
		        "btb_1"	   : btb predictor (CLK, nRST, predict_temp1);				// branch target buffer with 1 bit predictor
		        "btb_2"	   : btb #(.PRED_BITS(2)) predictor (CLK, nRST, predict_temp1); // BTB with 2-bit predictor
            endcase
    endgenerate
    return_predictor #(.entries(4)) predictor (CLK, nRST, predict_temp2);

endmodule
