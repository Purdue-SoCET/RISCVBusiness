`timescale 1ns/10ps

module tb_mask_unit();

logic[127:0] v0; 
logic mask_enable; 
logic[4:0] uop_num; 
logic[3:0] lane_active; 
logic[3:0] lane_en; 


mask_unit DUT(.*); 

initial begin
    v0 = '0; 
    mask_enable = '0; 
    uop_num = '0; 
    lane_active = '0; 

    #(50);

    $stop;  

end



endmodule 