package core_configuration_pkg;

localparam NUM_HARTS = 2;
    
// Packed struct is MSB - LSB
typedef struct packed {
    bit RV32ZICSR;
    bit RV32ZIFENCEI;
    bit RV32ZICOND;
    bit RV32B;
    bit RV32C;
    bit RV32A;
    bit RV32M;
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

// ISA extensions
localparam string BASE_ISA[NUM_HARTS] = {"RV32I", "RV32I"};

localparam isa_extension_t CORE_CONFIG[NUM_HARTS] = '{
    '{RV32M: 1, RV32A: 1, RV32C: 1, RV32B: 1, RV32ZICOND: 0, RV32ZIFENCEI: 1, RV32ZICSR: 1},
    '{RV32M: 1, RV32A: 1, RV32C: 1, RV32B: 1, RV32ZICOND: 0, RV32ZIFENCEI: 1, RV32ZICSR: 1} 
    };

// Branch configurations
localparam string BR_PREDICTOR_TYPE[NUM_HARTS] = {"not_taken", "not_taken"};
localparam int BTB_SIZE[NUM_HARTS] = {128, 128};
localparam string USE_RAS[NUM_HARTS] = {"false", "false"};

// Cache configurations
localparam string CACHE_CONFIG[NUM_HARTS] = {"separate", "separate"};
localparam string DCACHE_TYPES[NUM_HARTS] = {"l1", "l1"};
localparam int DCACHE_SIZES[NUM_HARTS] = {1024, 1024};
localparam int DCACHE_ASSOCS[NUM_HARTS] = {1, 1};
localparam string ICACHE_TYPES[NUM_HARTS] = {"l1", "l1"};
localparam int ICACHE_SIZES[NUM_HARTS] = {1024, 1024};
localparam int ICACHE_ASSOCS[NUM_HARTS] = {1, 1};

// Multiplier settings
localparam string MULTIPLIER_TYPE[NUM_HARTS] = {"shift_add_multiplier", "shift_add_multiplier"};

// Supervisor settings
localparam int SMODE_ENABLED[NUM_HARTS] = {0, 0};
localparam string SUPERVISOR_ENABLED[NUM_HARTS] = {"disabled","disabled"};
localparam string ADDRESS_TRANSLATION_ENABLED[NUM_HARTS] = {"disabled","disabled"};

endpackage
