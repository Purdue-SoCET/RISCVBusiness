package core_configuration_pkg;

localparam NUM_HARTS = 2; // Included to use it as array declaration

// ISA extensions
localparam BASE_ISA[NUM_HARTS] = {"RV32E", "RV32I"};

typedef struct packed {
    bit RV32M;
    bit RV32A;
    bit RV32C;
    bit RV32B;
    bit RV32ZICOND;
    bit RV32ZIFENCEI;
    bit RV32ZICSR;
} isa_extension_t;

typedef enum int {  
    M,
    A,
    C,
    B,
    ZICOND,
    ZIFENCEI,
    ZICSR
} extension_idx_t;

localparam isa_extension_t CORE_CONFIG[NUM_HARTS] = '{
    '{RV32M: 0, RV32A: 1, RV32C: 1, RV32B: 0, RV32ZICOND: 0, RV32ZIFENCEI: 0, RV32ZICSR: 0},
    '{RV32M: 1, RV32A: 1, RV32C: 1, RV32B: 0, RV32ZICOND: 0, RV32ZIFENCEI: 0, RV32ZICSR: 0}
    };

// Branch configurations
localparam BR_PREDICTOR_TYPE[NUM_HARTS] = {"not_taken", "not_taken"};
localparam BTB_SIZE[NUM_HARTS] = {128, 128};
localparam USE_RAS[NUM_HARTS] = {"false", "false"};

// Cache configurations
localparam CACHE_CONFIG[NUM_HARTS] = {"separate", "separate"};
localparam DCACHE_TYPE[NUM_HARTS] = {"l1", "l1"};
localparam DCACHE_SIZE[NUM_HARTS] = {1024, 1024};
localparam DCACHE_BLOCK_SIZE[NUM_HARTS] = {2, 2};
localparam DCACHE_ASSOC[NUM_HARTS] = {1, 1};
localparam ICACHE_TYPE[NUM_HARTS] = {"l1", "l1"};
localparam ICACHE_SIZE[NUM_HARTS] = {1024, 1024};
localparam ICACHE_BLOCK_SIZE[NUM_HARTS] = {2, 2};
localparam ICACHE_ASSOC[NUM_HARTS] = {1, 1};
localparam TLB_ENTRIES[NUM_HARTS] = {16, 16};

localparam NONCACHE_START_ADDR = 32'hF000_0000;

// Multiplier settings
localparam MULTIPLIER_TYPE[NUM_HARTS] = {"shift_add_multiplier", "shift_add_multiplier"};

// Supervisor settings TODO - Not sure how this works yet
localparam SMODE_ENABLED[NUM_HARTS] = {0, 0};
localparam SUPERVISOR_ENABLED[NUM_HARTS] = {"disabled", "disabled"};
localparam ADDRESS_TRANSLATION_ENABLED[NUM_HARTS] = {"disabled", "disabled"};

endpackage