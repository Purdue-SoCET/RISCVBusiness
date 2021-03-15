module BTB 
#(
parameter NUM_BTB_BITS = 32
)
(
input CLK, nRST,
predictor_pipline_if.predictor predictor,
predictor_pipline_if.update update,
predictor_pipline_if.access access
);



















endmodule 
