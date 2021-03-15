ude "predictor_pipeline_if.vh"

module gshare_bp (
        input logic CLK, nRST,
        predictor_pipeline_if.predictor predict_if,
        predictor_pipeline_if.pht_prediction pht_if,
        predictor_pipeline_if.btb_prediction btb_if
);

    assign predict_if.predict_taken = pht_if.taken && btb_if.branch_prediction;
    assign predict_if.target_addr = predict_taken ? btb_if.target_addr : predict_if.current_pc + 4;
        
endmodule
