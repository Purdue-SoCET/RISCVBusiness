// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VTOP_CORE__SYMS_H_
#define VERILATED_VTOP_CORE__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vtop_core.h"

// INCLUDE MODULE CLASSES
#include "Vtop_core___024root.h"
#include "Vtop_core_top_core.h"
#include "Vtop_core___024unit.h"
#include "Vtop_core_risc_mgmt_if.h"
#include "Vtop_core_tspp_fetch_execute_if.h"
#include "Vtop_core_tspp_hazard_unit_if.h"
#include "Vtop_core_prv_pipeline_if.h"
#include "Vtop_core_generic_bus_if.h"
#include "Vtop_core_cache_control_if.h"
#include "Vtop_core_sparce_pipeline_if.h"
#include "Vtop_core_rv32c_if.h"
#include "Vtop_core_stage3_fetch_execute_if.h"
#include "Vtop_core_stage3_hazard_unit_if.h"
#include "Vtop_core_stage3_forwarding_unit_if.h"
#include "Vtop_core_stage3_mem_pipe_if.h"
#include "Vtop_core_priv_1_12_internal_if.h"
#include "Vtop_core_priv_ext_if.h"
#include "Vtop_core_alu_if.h"
#include "Vtop_core_branch_res_if.h"
#include "Vtop_core_control_unit_if.h"

// DPI TYPES for DPI Export callbacks (Internal use)

// SYMS CLASS (contains all model state)
class Vtop_core__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vtop_core* const __Vm_modelp;
    bool __Vm_activity = false;  ///< Used by trace routines to determine change occurred
    uint32_t __Vm_baseCode = 0;  ///< Used by trace routines when tracing multiple models
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vtop_core___024root            TOP;
    Vtop_core_top_core             TOP__top_core;
    Vtop_core_cache_control_if     TOP__top_core__CORE__DOT__cc_if;
    Vtop_core_generic_bus_if       TOP__top_core__CORE__DOT__dcache_mc_if;
    Vtop_core_tspp_fetch_execute_if TOP__top_core__CORE__DOT__fetch_ex_if;
    Vtop_core_tspp_hazard_unit_if  TOP__top_core__CORE__DOT__hazard_if;
    Vtop_core_generic_bus_if       TOP__top_core__CORE__DOT__icache_mc_if;
    Vtop_core_alu_if               TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu_if;
    Vtop_core_branch_res_if        TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_if;
    Vtop_core_control_unit_if      TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if;
    Vtop_core_stage3_fetch_execute_if TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if;
    Vtop_core_stage3_forwarding_unit_if TOP__top_core__CORE__DOT__pipeline__DOT__fw_if;
    Vtop_core_stage3_hazard_unit_if TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if;
    Vtop_core_stage3_mem_pipe_if   TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if;
    Vtop_core_generic_bus_if       TOP__top_core__CORE__DOT__pipeline_trans_if;
    Vtop_core_priv_ext_if          TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pma_if;
    Vtop_core_priv_ext_if          TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pmp_if;
    Vtop_core_priv_1_12_internal_if TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if;
    Vtop_core_prv_pipeline_if      TOP__top_core__CORE__DOT__prv_pipe_if;
    Vtop_core_risc_mgmt_if         TOP__top_core__CORE__DOT__rm_if;
    Vtop_core_rv32c_if             TOP__top_core__CORE__DOT__rv32cif;
    Vtop_core_sparce_pipeline_if   TOP__top_core__CORE__DOT__sparce_if;
    Vtop_core_generic_bus_if       TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if;
    Vtop_core_generic_bus_if       TOP__top_core__CORE__DOT__tspp_icache_gen_bus_if;
    Vtop_core_generic_bus_if       TOP__top_core__gen_bus_if;

    // CONSTRUCTORS
    Vtop_core__Syms(VerilatedContext* contextp, const char* namep, Vtop_core* modelp);
    ~Vtop_core__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

#endif  // guard
