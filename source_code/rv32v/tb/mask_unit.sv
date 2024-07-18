module mask_unit
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