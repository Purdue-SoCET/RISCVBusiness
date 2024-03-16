import rv32v_types_pkg::*; 
import rv32i_types_pkg::*; 

module rv32v_mask_set_layer(
    input logic[3:0] vfu_results,
    input logic[127:0] vd,
    input logic[3:0] vd_fwd_bits,
    input logic[3:0] msku_lane_masks, // lane masks from mask unit
    input logic[4:0] vuopnum, 

    output logic[7:0] vmskset_res,  
    output logic[3:0] vmskset_lane_mask
);


logic[6:0] vd_start_idx; 
logic[6:0] vd_upper_idx;
logic[6:0] vd_lower_idx; 
logic[3:0] vfu_results_masked; 

assign vd_start_idx = {2'b0, vuopnum} << 2;
assign vd_upper_idx = vd_start_idx + 7; 
assign vd_lower_idx = vd_start_idx + 4; 


assign vfu_results_masked[0] = msku_lane_masks[0] ? vfu_results[0] : vd[vd_start_idx]; 
assign vfu_results_masked[1] = msku_lane_masks[1] ? vfu_results[1] : vd[vd_start_idx+1]; 
assign vfu_results_masked[2] = msku_lane_masks[2] ? vfu_results[2] : vd[vd_start_idx+2]; 
assign vfu_results_masked[3] = msku_lane_masks[3] ? vfu_results[3] : vd[vd_start_idx+3];


assign vmskset_res[3:0] = vuopnum[0] ? vd_fwd_bits : vfu_results_masked; 
assign vmskset_res[7:4] = vuopnum[0] ? vfu_results_masked : {vd[vd_start_idx+7], vd[vd_start_idx+6], vd[vd_start_idx+5], vd[vd_start_idx+4]}; 


always_comb begin: VMSKSET_LANE_EN_LOGIC
    case(vuopnum[2:1])
        2'b00: vmskset_lane_mask   = {3'b0, 1'b1}; 
        2'b01: vmskset_lane_mask   = {2'b0, 1'b1, 1'b0}; 
        2'b10: vmskset_lane_mask   = {1'b0, 1'b1, 2'b0}; 
        default: vmskset_lane_mask = {1'b1, 3'b0};
    endcase 
end


endmodule 