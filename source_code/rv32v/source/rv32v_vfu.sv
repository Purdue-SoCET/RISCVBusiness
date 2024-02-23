import rv32v_types_pkg::*; 
import rv32i_types_pkg::*; 

module rv32v_vfu(
    input word_t vopA, vopB,
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
        endcase
    end
end
endmodule 
