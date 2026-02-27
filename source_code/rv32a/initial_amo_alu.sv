`include "amo_alu_if.vh"
import cpu_types_pkg::*;
 
 
module amo_alu( 
    alu_if.alu ar_logic_if
);
 
 
always_comb begin //bit flags
    ar_logic_if.negative = ar_logic_if.output_port[31];
    ar_logic_if.zero = ar_logic_if.output_port == '0 ? 1'b1 : 1'b0;
end
 
logic [31:0] temp_signal;
 
always_comb begin
    ar_logic_if.overflow = 1'b0;
 
    casez(ar_logic_if.alu_op) //asm -i in terminal for instructions
       // ALU_SLL: ar_logic_if.output_port = ar_logic_if.port_a << ar_logic_if.port_b[4:0]; //SLL    rd, rs1, rs2  R[rd] <= R[rs1] << [4:0] R[rs2]
 
        //ALU_SRL: ar_logic_if.output_port = ar_logic_if.port_a >> ar_logic_if.port_b[4:0]; //SRL    rd, rs1, rs2   R[rd] <= R[rs1] >> [4:0] R[rs2]
 
   //     ALU_SRA: ar_logic_if.output_port = $signed(ar_logic_if.port_a) >>> ar_logic_if.port_b[4:0]; //SRA rd, rs1, rs2 R[rd] <= R[rs1] >>> [4:0] R[rs2] (sign extend msb of R[rs1])
 
        ALU_ADD: begin //signed
            ar_logic_if.output_port = ar_logic_if.port_a + ar_logic_if.port_b; //ADD    rd, rs1, rs2      R[rd] <= R[rs1] + R[rs2]
 
            if((ar_logic_if.port_a[31] == ar_logic_if.port_b[31]) && (ar_logic_if.output_port[31] != ar_logic_if.port_a[31])) begin
                ar_logic_if.overflow = 1'b1;
            end
 
        end
      /*  ALU_SUB: begin //signed
            ar_logic_if.output_port = ar_logic_if.port_a - ar_logic_if.port_b; //SUB    rd, rs1, rs2      R[rd] <= R[rs1] - R[rs2]
 
            if((ar_logic_if.port_a[31] != ar_logic_if.port_b[31]) && (ar_logic_if.output_port[31] != ar_logic_if.port_a[31])) begin
                ar_logic_if.overflow = 1'b1;
            end
 
        end */
 
        ALU_SWAP: begin 
            temp_signal = ar_logic_if.port_a;
            ar_logic_if.port_a = ar_logic_if.port_b;
            ar_logic_if.output_port = temp_signal;
        end
 
        ALU_AND: ar_logic_if.output_port = ar_logic_if.port_a & ar_logic_if.port_b; //AND    rd, rs1, rs2      R[rd] <= R[rs1] AND R[rs2]
 
        ALU_OR: ar_logic_if.output_port = ar_logic_if.port_a | ar_logic_if.port_b; //OR     rd, rs1, rs2      R[rd] <= R[rs1] OR R[rs2]
 
        ALU_XOR: ar_logic_if.output_port = ar_logic_if.port_a ^ ar_logic_if.port_b; //XOR    rd, rs1, rs2      R[rd] <= R[rs1] XOR R[rs2]
 
     //   ALU_SLT: ar_logic_if.output_port = $signed(ar_logic_if.port_a) < $signed(ar_logic_if.port_b) ? 32'd1 : 32'd0; //SLT    rd, rs1, rs2  R[rd] <= (R[rs1] < R[rs2]) ? 1 : 0
 
       // ALU_SLTU: ar_logic_if.output_port = ar_logic_if.port_a < ar_logic_if.port_b ? 32'd1 : 32'd0; //SLTU   rd, rs1, rs2  R[rd] <= (R[rs1] < R[rs2]) ? 1 : 0 (treat values as unsigned)
 
            ALU_MAX:    ar_logic_if.output_port = ($signed(ar_logic_if.port_a) < $signed(ar_logic_if.port_b)) ? ar_logic_if.port_b : ar_logic_if.port_a;
            ALU_MAXU:   ar_logic_if.output_port = (ar_logic_if.port_a < ar_logic_if.port_b) ? ar_logic_if.port_b : ar_logic_if.port_a;
            ALU_MIN:    ar_logic_if.output_port = ($signed(ar_logic_if.port_a) < $signed(ar_logic_if.port_b)) ? ar_logic_if.port_a : ar_logic_if.port_b;
            ALU_MINU:   ar_logic_if.output_port = (ar_logic_if.port_a < ar_logic_if.port_b) ? ar_logic_if.port_a : ar_logic_if.port_b;
 
        default: ar_logic_if.output_port = '0;
 
    endcase
 
end
 
 
endmodule
