module PHT(
    input logic CLK, nRST,
    input xored_result,
    input GBH_result,
    input update_predictor,
    output t_nt
);

    typedef enum bit[1:0] {IDLE, S_NT, W_NT, W_T, S_T} stateType;
    stateType STATE;
    stateType NXT_STATE;

    always_ff @ (negedge nRST, posedge CLK)
    begin: REG_LOGIC
        if (!nRST) begin
            STATE <= IDLE;
        end else begin
            STATE <= NXT_STATE;
        end
    end

    always_comb begin: NXT_LOGIC
        NXT_STATE = STATE;
        case(STATE)
            IDLE: begin
                if ((xored_result == 1) & (GBH_result == 1)) begin
                    NXT_STATE = S_T;
                end else if ((xored_result == 1) & (GBH_reuslt == 0)) begin
                    NXT_STATE = W_T;
                end else if ((xored_result == 0) & (GBH_result == 0)) begin
                    NXT_STATE  = S_NT;
                end else begin
                    NXT_STATE = W_NT;
                end
            end
            S_T: begin
                if (update_predictor == 1) begin
                    NXT_STATE = S_T;
                end else begin
                    NXT_STATE = W_T;
                end
            end
            W_T: begin
                if (update_predictor == 1) begin
                    NXT_STATE = S_T;
                end else begin
                    NXT_STATE = W_NT:
                end
            end
            W_NT: begin
                if (update_predictor == 1) begin
                    NXT_STATE = W_T;
                end else begin
                    NXT_STATE = S_NT;
                end
            end
            W_NT: begin
                if (update_predictor == 1) begin
                    NXT_STATE = W_NT:
                end else begin
                    NXT_STATE = S_NT;
                end
            end
        endcase
    end

    always_comb begin: OUTPUT_LOGIC
        t_nt = 0;
        case(STATE)
        S_NT: begin
            t_nt = 0;
        end
        W_NT: begin
            t_nt = 0;
        end
        S_T: begin
            t_nt = 1;
        end
        W_T: begin
            t_nt = 1;
        end
        IDLE: begin
            t_nt = 0;
        end
        endcase
    end
endmodule


