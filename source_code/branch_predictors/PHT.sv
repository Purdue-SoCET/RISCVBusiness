`include "predictor_pipeline_if.vh"

module PHT
#(
    parameter PHT_SIZE = 32,
    parameter GBH_SIZE = 5
)
(
    input logic CLK, nRST, predictor_pipeline_if.pht_prediction ppif,
    predictor_pipeline_if.predictor pdif
);
    import rv32i_types_pkg::*;
     

    //PHT table
    logic [PHT_SIZE - 1:0][1:0] pht_table;
    logic [PHT_SIZE - 1:0][1:0] nxt_pht_table;
    //global branch history,aka shift register
    logic [GBH_SIZE - 1:0] gbh_table;
    logic [GBH_SIZE - 1:0] nxt_gbh_table;
    
    typedef enum bit[1:0] {IDLE, S_NT, W_NT, W_T, S_T} stateType;
    stateType STATE;
    stateType NXT_STATE;
    logic t_nt;

    always_ff @ (negedge nRST, posedge CLK)
    begin: REG_LOGIC
        if (!nRST) begin
            STATE <= IDLE;
            pht_table <= '0;
            gbh_table <= '0;
        end else begin
            STATE <= NXT_STATE;
            pht_table <= nxt_pht_table;
            gbh_table <= nxt_gbh_table;
        end
    end

    always_comb begin: NXT_LOGIC_GBH
        nxt_gbh_table = gbh_table;
        if (pdif.update_predictor) begin
            nxt_gbh_table = {gbh_table[GBH_SIZE - 2:0],branch_result};
        end
    end
    //to be moved elsewhere
    assign ppif.pht_index = pdif.current_pc ^ gbh_table; 

    always_comb begin: NXT_LOGIC_PHT
        nxt_pht_table = table;
        if (pdif.update_predictor) begin//when to update the content in the pht
            nxt_pht_table[ppif.pht_index] = t_nt;
        end
    end
    assign ppif.pht_tnt = pht_table[pht_index]; //assign the output tnt

    always_comb begin: NXT_LOGIC_2BIT
        NXT_STATE = STATE;
        case(STATE)
            IDLE: begin
                if  (gbh_result)  begin
                    NXT_STATE = S_T;
                end else if (!(gbh_result)) begin
                    NXT_STATE = S_NT;
                end
            end
            S_T: begin
                if (gbh_result) begin
                    NXT_STATE = S_T;
                end else begin
                    NXT_STATE = W_T;
                end
            end
            W_T: begin
                if (gbh_result) begin
                    NXT_STATE = S_T;
                end else begin
                    NXT_STATE = W_NT:
                end
            end
            W_NT: begin
                if (gbh_result) begin
                    NXT_STATE = W_T;
                end else begin
                    NXT_STATE = S_NT;
                end
            end
            S_NT: begin
                if (gbh_result) begin
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


