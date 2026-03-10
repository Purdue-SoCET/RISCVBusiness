
module amo_alu(
    input logic [31:0] portA, portB,
    input logic [3:0] alu_op,
    output logic negative, zero, overflow,
    output logic [31:0] output_port
); 

always_comb begin //bit flags
    negative = output_port[31];
    zero = output_port == '0 ? 1'b1 : 1'b0;
end

logic [31:0] temp_signal;

always_comb begin
    overflow = 1'b0;
    temp_signal = '0;

    casez(alu_op)
       
        ALU_ADD: begin //signed
            output_port = portA + portB; //ADD    rd, rs1, rs2      R[rd] <= R[rs1] + R[rs2]

            if((portA[31] == portB[31]) && (output_port[31] != portA[31])) begin
                overflow = 1'b1;
            end

        end
        
        ALU_SWAP: begin 
            temp_signal = portA;
            portA = portB;
            output_port = temp_signal;
        end

        ALU_AND: output_port = portA & portB; //AND    rd, rs1, rs2      R[rd] <= R[rs1] AND R[rs2]

        ALU_OR: output_port = portA | portB; //OR     rd, rs1, rs2      R[rd] <= R[rs1] OR R[rs2]

        ALU_XOR: output_port = portA ^ portB; //XOR    rd, rs1, rs2      R[rd] <= R[rs1] XOR R[rs2]

        ALU_MAX:    output_port = ($signed(portA) < $signed(portB)) ? portB : portA;
        ALU_MAXU:   output_port = (portA < portB) ? portB : portA;
        ALU_MIN:    output_port = ($signed(portA) < $signed(portB)) ? portA : portB;
        ALU_MINU:   output_port = (portA < portB) ? portA : portB;

        default: output_port = '0;

    endcase

end

endmodule


