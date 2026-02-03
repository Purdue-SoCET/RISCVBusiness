// Global History Register (GHR) - A shift register that stores the outcome of
// last n branches.

`include "predictor_pipeline_if.vh"

module ghr_pht #(
    parameter SIZE = 4,
    parameter PRED_BITS = 2
) (
    input logic CLK, nRST,
    predictor_pipeline_if.predictor predict_if,
    output logic GHR_taken
);
    logic previous_branch;
    assign previous_branch = predict_if.branch_result;

    // GHR LOGIC
    logic [(SIZE - 1):0] GHR, nxt_GHR;
    always_ff @(posedge CLK, negedge nRST) begin : GHR_REG_LOGIC
        if (!nRST) begin
            GHR <= '0;
        end

        else begin
            GHR <= nxt_GHR;
        end
    end

    always_comb begin : GHR_NXT_LOGIC
    nxt_GHR = GHR;
    if (predict_if.update_predictor) begin
            nxt_GHR = {GHR[(SIZE - 2):0],previous_branch};
    end
    end

    // PHT LOGIC
    logic [(PRED_BITS - 1):0] PHT [(2**SIZE - 1):0];
    logic [(PRED_BITS - 1):0] nxt_PHT;
    always_ff @(posedge CLK, negedge nRST) begin : PHT_REG_LOGIC
        if (!nRST) begin
            //PHT[(2**SIZE - 1):0] <= '0;
        PHT <= '{default:2'b00};
        end

        else begin
            PHT[GHR] <= nxt_PHT;
        end
    end

    always_comb begin : PHT_NXT_LOGIC
        nxt_PHT = PHT[GHR];

        if (predict_if.update_predictor) begin
            nxt_PHT = {PHT[GHR],previous_branch};
        end
    end

    assign GHR_taken = PHT[GHR][(PRED_BITS - 1)];
endmodule
