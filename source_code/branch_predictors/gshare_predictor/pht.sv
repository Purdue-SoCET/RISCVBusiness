`include "predictor_pipeline_if.vh"

module pht #(
    parameter PHT_SIZE = 32, 
    parameter GBH_SIZE = 5 
)
(
    input logic CLK, nRST, 
    predictor_pipeline_if.predictor predict_if,
    predictor_pipeline_if.pht_prediction pht_if
);
    import rv32i_types_pkg::*;

    //PHT table, 
    logic [PHT_SIZE - 1:0][1:0] pht_table;
    logic [PHT_SIZE - 1:0][1:0] nxt_pht_table;
    //global branch history,aka shift register
    logic [GBH_SIZE - 1:0] gbh_table;
    logic [GBH_SIZE - 1:0] nxt_gbh_table;
    logic [GBH_SIZE - 1:0] xored_index;

    typedef enum bit[1:0] {S_NT, W_NT, W_T, S_T} stateType;
    stateType STATE;
    stateType NXT_STATE;

    always_ff @ (negedge nRST, posedge CLK) begin: REG_LOGIC
        if (!nRST) begin
            //starts at strongly not taken
            STATE <= S_NT;
            //initialize 2 tables to be 0
            pht_table <= '0; 
            gbh_table <= '0; 
        end else begin
            STATE <= NXT_STATE;
            pht_table <= nxt_pht_table;
            gbh_table <= nxt_gbh_table;
        end
    end 

    //global history table logic
    always_comb begin: NXT_LOGIC_GBH
        nxt_gbh_table = gbh_table;
        if (pht_if.update_predictor) begin
            nxt_gbh_table = {gbh_table[GBH_SIZE - 2:0],pht_if.branch_result};
        end
    end 

    //pht logic
    assign xored_index = pht_if.current_pc[4:0] ^ gbh_table;
    always_comb begin: NXT_LOGIC_PHT
        nxt_pht_table = pht_table;
        if (pdif.update_predictor) begin
            nxt_pht_table[xored_index] = t_nt;
        end
    end 
     always_comb begin: NXT_LOGIC_2BIT
        NXT_STATE = STATE;
        case(STATE)
            S_NT: begin
                if (pht_if.branch_result) begin
                    NXT_STATE = W_NT:
                end else begin
                    NXT_STATE = S_NT;
                end
            end
            W_NT: begin
                if (pht_if.branch_result) begin
                    NXT_STATE = W_T;
                end else begin
                    NXT_STATE = S_NT;
                end
            end
            W_T: begin
                if (pht_if.branch_result) begin
                    NXT_STATE = S_T;
                end else begin
                    NXT_STATE = W_NT:
                end
            end
            S_T: begin
                if (pht_if.branch_result) begin
                    NXT_STATE = S_T;
                end else begin
                    NXT_STATE = W_T;
                end
            end
        endcase
    end

    always_comb begin: OUTPUT_LOGIC
        S_NT: begin
            t_nt = 1'b0;
        end
        W_NT: begin
            t_nt = 1'b0;
        end
        S_T: begin
            t_nt = 1'b1;
        end
        W_T: begin
            t_nt = 1'b1;
        end
        endcase
    end


endmodule
