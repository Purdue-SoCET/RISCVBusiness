//branch target buffer with 2bit saturating predictor

`include "cpu_types_pkg.vh"
`include "BTB_if.vh"

module BTB (
		      input logic CLK, nRST,
              predictor_pipeline_if.btb_prediction btb_if
);
    import cpu_types_pkg::*;
    
    typedef enum logic[1:0] {STRONG_NT, WEAK_NT, WEAK_T, STRONG_T} state;
    state pred, next_pred;

    always_ff @ (posedge CLK, negedge nRST) begin
        if(!nRST) 
            pred <= STRONG_NT;
        else
            pred <= next_pred;
    end

    always_comb begin
        if((btb_if.current_pc + 4) == btb_if.update_address) 
            btb_if.ifbranch = 1;
        else
            btb_if.ifbranch = 0;
    end

// 2bit saturating predictor
    always_comb begin
        case(pred)
            STRONG_NT: begin
                btb_if.branch_prediction = 0;
                if(btb_if.prediction)
                    next_pred = WEAK_NT;
                else 
                    next_pred = STRONG_NT;
            end
            WEAK_NT: begin
                btb_if.branch_prediction = 0;
                if(btb_if.prediction)
                    next_pred = WEAK_T;
                else 
                    next_pred = STRONG_NT;
            end
            WEAK_T: begin
                btb_if.branch_prediction = 1;
                if(btb_if.prediction)
                    next_pred = STRONG_T;
                else 
                    next_pred = WEAK_NT;
            end
            STRONG_T: begin
                btb_if.branch_prediction = 1;
                if(btb_if.prediction)
                    next_pred = STRONG_T;
                else
                    next_pred = WEAK_T;                
            end
            default:  begin
                btb_if.branch_prediction = 0;
                next_pred = pred;
            end
        endcase
    end

    always_comb begin
        btb_if.penalty_cycles = 0;
        case(btb_if.ifbranch) 
            1: begin
                if(btb_if.branch_prediction == 0 & btb_if.branch_taken == 0)
                    btb_if.penalty_cycles = 0;
                else if(btb_if.branch_taken == 1)
                    btb_if.penalty_cycles = 2'd2;
            end
            0: begin
                if(btb_if.branch_prediction == 1 & btb_if.branch_taken == 1)
                    btb_if.penalty_cycles = 0;
                else if(btb_if.branch_prediction == 1 & btb_if.branch_taken == 0)
                    btb_if.penalty_cycles = 2'd2;
            end
        endcase

    end
    


endmodule
