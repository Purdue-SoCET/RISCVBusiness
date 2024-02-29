import rv32v_types_pkg::*; 
import rv32i_types_pkg::*; 

module rv32v_vfu(
    input word_t vopA, vopB,
    input logic[3:0] mask_bits, 
    input vexec_t vop, 
    output word_t vres
);


always_comb begin
    vres = '0; 
    if(vop.vfu == VFU_ALU) begin
        case(vop.valuop)
            VALU_ADD: vres = vopA + vopB; 
            VALU_SUB: vres = $signed(vopA) - $signed(vopB);
            VALU_RSB: vres = $signed(vopB) - $signed(vopA);
            VALU_EXT: vres = vopA; // assume vopA is vs2
            
            // need case statement for sign extension
        endcase
    end
end
endmodule 
