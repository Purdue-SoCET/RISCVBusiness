module rv32b_alu(
    input [31:0] a,
    input [31:0] b,
    input rv32b_pkg::rv32b_op_t aluop,
    output logic [31:0] y
);
   
    import rv32b_pkg::*;
    logic [5:0] acc;

    function [7:0] xperm8_lookup;
        input [7:0] idx;
        input [31:0] lut;
        begin
            logic [31:0] lut_shift;
            lut_shift = lut >> {idx,3'b000};
            xperm8_lookup = lut_shift[7:0];
        end  
    endfunction

    function [3:0] xperm4_lookup;
        input [3:0] idx;
        input [31:0] lut;
        begin
            logic [31:0] lut_shift;
            lut_shift = lut >> {idx,2'b00};
            xperm4_lookup = lut_shift[3:0];
        end  
    endfunction

    always_comb begin
        acc = 0;
        casez(aluop)
            SH1ADD: y = (a << 1) + b;
            SH2ADD: y = (a << 2) + b;
            SH3ADD: y = (a << 3) + b;
            MAX:    y = ($signed(a) < $signed(b)) ? b : a;
            MAXU:   y = (a < b) ? b : a;
            MIN:    y = ($signed(a) < $signed(b)) ? a : b;
            MINU:   y = (a < b) ? a : b;
            SEXTB:  y = {{24{a[7]}}, a[7:0]};
            SEXTH:  y = {{16{a[15]}}, a[15:0]};
            ZEXTH:  y = {{16{1'b0}}, a[15:0]};
            ORC:    y = {{8{|a[31:24]}}, {8{|a[23:16]}}, {8{|a[15:8]}}, {8{|a[7:0]}}};
            BCLR:   y = a & ~(32'b1 << b[4:0]);
            BEXT:   y = {{31{1'b0}}, a[b[4:0]]};
            BINV:   y = a ^ (32'b1 << b[4:0]);
            BSET:   y = a | (32'b1 << b[4:0]);
            ROR, RORI:    y = (a >> b[4:0]) | (a << ($bits(a) - b[4:0])); // RORI unsure
            ROL:    y = (a << b[4:0]) | (a >> ($bits(a) - b[4:0]));
            ANDN:   y = a & ~b;
            ORN:    y = a | ~b;
            XNOR:   y = ~(a ^ b);
            PACK:   y = {b[15:0], a[15:0]};
            PACKH:  y = {16'b0, b[7:0], a[7:0]};
            BREV8:  y = {a[24], a[25], a[26], a[27], a[28], a[29], a[30], a[31], a[16], a[17], a[18], a[19], a[20], a[21], a[22], a[23], a[8], a[9], a[10], a[11], a[12], a[13], a[14], a[15], a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7]};
            REV8:   y = {a[7:0], a[15:8], a[23:16], a[31:24]};
            ZIP:    y = {a[31], a[15], a[30], a[14], a[29], a[13], a[28], a[12], a[27], a[11], a[26], a[10], a[25], a[9], a[24], a[8], a[23], a[7], a[22], a[6], a[21], a[5], a[20], a[4], a[19], a[3], a[18], a[2], a[17], a[1], a[16], a[0]};
            UNZIP:  y = {a[31], a[29], a[27], a[25], a[23], a[21], a[19], a[17], a[15], a[13], a[11], a[9], a[7], a[5], a[3], a[1], a[30], a[28], a[26], a[24], a[22], a[20], a[18], a[16], a[14], a[12], a[10], a[8], a[6], a[4], a[2], a[0]};
            CLZ: begin
                acc = 0;
                for(int i = 31; i >= 0; i--) begin
                    if(a[i] == 1) begin
                        break;
                    end else begin
                        acc += 1;
                    end
                end
                y = acc;
            end
            CTZ: begin
                acc = 0;
                for(int i = 0; i < 32; i++) begin
                    if(a[i] == 1) begin
                        break;
                    end else begin
                        acc += 1;
                    end
                end
                y = acc;
            end
            CPOP: begin
                acc = 0;
                for(int i = 0; i < 32; i++) begin
                    if(a[i]) begin
                        acc += 1;
                    end
                end
                y = acc;
            end
            CLMUL: begin
                for (int i = 0; i < 32; i++) begin
                    if ((b >> i) & 32'b1)
                        y = y ^ (a << i);
                end
            end   
            CLMULH: begin
                for (int i = 0; i < 32; i++) begin
                    if ((b >> i) & 32'b1)
                        y = y ^ (a >> (6'b32 - i));
                end
            end
            XPERM8: begin
                for (int i = 0; i < 32; i = i + 8) begin
                        y[i + 7:i] = xperm8_lookup(b[i + 7:i], a);
                end
            end   
            XPERM4: begin
                for (int i = 0; i < 32; i = i + 4) begin
                        y[i + 3:i] = xperm4_lookup(b[i + 3:i], a);
                end
            end
            default: y = 0;
        endcase
    end

endmodule
