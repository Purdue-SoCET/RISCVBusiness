interface l1_snoop_if(); //check about clk, nRST
    logic               [CPUS-1:0] cctrans;     // indicates that the requester is undergoing a miss
    logic               [CPUS-1:0] ccwrite;     // indicates that the requester is attempting to go to M
    logic               [CPUS-1:0] ccsnoophit;  // indicates that the responder has the data
    logic               [CPUS-1:0] ccsnoopdone;  // indicates that the responder has the data
    logic               [CPUS-1:0] ccIsPresent; // indicates that nonrequesters have the data valid
    logic               [CPUS-1:0] ccdirty;     // indicates that we have [I -> S, M -> S]
    // L1 coherence OUTPUTS
    logic               [CPUS-1:0] ccwait;      // indicates a potential snoophit wait request
    logic               [CPUS-1:0] ccinv;       // indicates an invalidation request
    logic               [CPUS-1:0] ccexclusive; // indicates an exclusivity update
    word_t              [CPUS-1:0] ccsnoopaddr;

    modport l1(
        input ccwait, ccinv, ccexclusive, ccsnoopaddr,
        output cctrans, ccwrite, ccsnoophit, ccsnoopdone, ccIsPresent, ccdirty
    );
    modport bus(
        input cctrans, ccwrite, ccsnoophit, ccsnoopdone, ccIsPresent, ccdirty,
        output ccwait, ccinv, ccexclusive, ccsnoopaddr
    );
endinterface
