// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table implementation internals

#include "Vtop_core__Syms.h"
#include "Vtop_core.h"
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

// FUNCTIONS
Vtop_core__Syms::~Vtop_core__Syms()
{
}

Vtop_core__Syms::Vtop_core__Syms(VerilatedContext* contextp, const char* namep, Vtop_core* modelp)
    : VerilatedSyms{contextp}
    // Setup internal state of the Syms class
    , __Vm_modelp{modelp}
    // Setup module instances
    , TOP{this, namep}
    , TOP__top_core{this, Verilated::catName(namep, "top_core")}
    , TOP__top_core__CORE__DOT__cc_if{this, Verilated::catName(namep, "top_core.CORE.cc_if")}
    , TOP__top_core__CORE__DOT__dcache_mc_if{this, Verilated::catName(namep, "top_core.CORE.dcache_mc_if")}
    , TOP__top_core__CORE__DOT__fetch_ex_if{this, Verilated::catName(namep, "top_core.CORE.fetch_ex_if")}
    , TOP__top_core__CORE__DOT__hazard_if{this, Verilated::catName(namep, "top_core.CORE.hazard_if")}
    , TOP__top_core__CORE__DOT__icache_mc_if{this, Verilated::catName(namep, "top_core.CORE.icache_mc_if")}
    , TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu_if{this, Verilated::catName(namep, "top_core.CORE.pipeline.execute_stage_i.alu_if")}
    , TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_if{this, Verilated::catName(namep, "top_core.CORE.pipeline.execute_stage_i.branch_if")}
    , TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if{this, Verilated::catName(namep, "top_core.CORE.pipeline.execute_stage_i.cu_if")}
    , TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if{this, Verilated::catName(namep, "top_core.CORE.pipeline.fetch_ex_if")}
    , TOP__top_core__CORE__DOT__pipeline__DOT__fw_if{this, Verilated::catName(namep, "top_core.CORE.pipeline.fw_if")}
    , TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if{this, Verilated::catName(namep, "top_core.CORE.pipeline.hazard_if")}
    , TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if{this, Verilated::catName(namep, "top_core.CORE.pipeline.mem_pipe_if")}
    , TOP__top_core__CORE__DOT__pipeline_trans_if{this, Verilated::catName(namep, "top_core.CORE.pipeline_trans_if")}
    , TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pma_if{this, Verilated::catName(namep, "top_core.CORE.priv_wrapper_i.priv_block_i.priv_ext_pma_if")}
    , TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pmp_if{this, Verilated::catName(namep, "top_core.CORE.priv_wrapper_i.priv_block_i.priv_ext_pmp_if")}
    , TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if{this, Verilated::catName(namep, "top_core.CORE.priv_wrapper_i.priv_block_i.prv_intern_if")}
    , TOP__top_core__CORE__DOT__prv_pipe_if{this, Verilated::catName(namep, "top_core.CORE.prv_pipe_if")}
    , TOP__top_core__CORE__DOT__rm_if{this, Verilated::catName(namep, "top_core.CORE.rm_if")}
    , TOP__top_core__CORE__DOT__rv32cif{this, Verilated::catName(namep, "top_core.CORE.rv32cif")}
    , TOP__top_core__CORE__DOT__sparce_if{this, Verilated::catName(namep, "top_core.CORE.sparce_if")}
    , TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if{this, Verilated::catName(namep, "top_core.CORE.tspp_dcache_gen_bus_if")}
    , TOP__top_core__CORE__DOT__tspp_icache_gen_bus_if{this, Verilated::catName(namep, "top_core.CORE.tspp_icache_gen_bus_if")}
    , TOP__top_core__gen_bus_if{this, Verilated::catName(namep, "top_core.gen_bus_if")}
{
    // Configure time unit / time precision
    _vm_contextp__->timeunit(-12);
    _vm_contextp__->timeprecision(-12);
    // Setup each module's pointers to their submodules
    TOP.top_core = &TOP__top_core;
    TOP__top_core.__PVT__CORE__DOT__cc_if = &TOP__top_core__CORE__DOT__cc_if;
    TOP__top_core.__PVT__CORE__DOT__dcache_mc_if = &TOP__top_core__CORE__DOT__dcache_mc_if;
    TOP__top_core.__PVT__CORE__DOT__fetch_ex_if = &TOP__top_core__CORE__DOT__fetch_ex_if;
    TOP__top_core.__PVT__CORE__DOT__hazard_if = &TOP__top_core__CORE__DOT__hazard_if;
    TOP__top_core.__PVT__CORE__DOT__icache_mc_if = &TOP__top_core__CORE__DOT__icache_mc_if;
    TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu_if = &TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu_if;
    TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_if = &TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_if;
    TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if = &TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if;
    TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__fetch_ex_if = &TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if;
    TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__fw_if = &TOP__top_core__CORE__DOT__pipeline__DOT__fw_if;
    TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__hazard_if = &TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if;
    TOP__top_core.__PVT__CORE__DOT__pipeline__DOT__mem_pipe_if = &TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if;
    TOP__top_core.__PVT__CORE__DOT__pipeline_trans_if = &TOP__top_core__CORE__DOT__pipeline_trans_if;
    TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pma_if = &TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pma_if;
    TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pmp_if = &TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pmp_if;
    TOP__top_core.__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if = &TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if;
    TOP__top_core.__PVT__CORE__DOT__prv_pipe_if = &TOP__top_core__CORE__DOT__prv_pipe_if;
    TOP__top_core.__PVT__CORE__DOT__rm_if = &TOP__top_core__CORE__DOT__rm_if;
    TOP__top_core.__PVT__CORE__DOT__rv32cif = &TOP__top_core__CORE__DOT__rv32cif;
    TOP__top_core.__PVT__CORE__DOT__sparce_if = &TOP__top_core__CORE__DOT__sparce_if;
    TOP__top_core.__PVT__CORE__DOT__tspp_dcache_gen_bus_if = &TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if;
    TOP__top_core.__PVT__CORE__DOT__tspp_icache_gen_bus_if = &TOP__top_core__CORE__DOT__tspp_icache_gen_bus_if;
    TOP__top_core.__PVT__gen_bus_if = &TOP__top_core__gen_bus_if;
    // Setup each module's pointer back to symbol table (for public functions)
    TOP.__Vconfigure(true);
    TOP__top_core.__Vconfigure(true);
    TOP__top_core__CORE__DOT__cc_if.__Vconfigure(true);
    TOP__top_core__CORE__DOT__dcache_mc_if.__Vconfigure(true);
    TOP__top_core__CORE__DOT__fetch_ex_if.__Vconfigure(true);
    TOP__top_core__CORE__DOT__hazard_if.__Vconfigure(true);
    TOP__top_core__CORE__DOT__icache_mc_if.__Vconfigure(false);
    TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__alu_if.__Vconfigure(true);
    TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__branch_if.__Vconfigure(true);
    TOP__top_core__CORE__DOT__pipeline__DOT__execute_stage_i__DOT__cu_if.__Vconfigure(true);
    TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__Vconfigure(true);
    TOP__top_core__CORE__DOT__pipeline__DOT__fw_if.__Vconfigure(true);
    TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__Vconfigure(true);
    TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__Vconfigure(true);
    TOP__top_core__CORE__DOT__pipeline_trans_if.__Vconfigure(false);
    TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pma_if.__Vconfigure(true);
    TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pmp_if.__Vconfigure(false);
    TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__Vconfigure(true);
    TOP__top_core__CORE__DOT__prv_pipe_if.__Vconfigure(true);
    TOP__top_core__CORE__DOT__rm_if.__Vconfigure(true);
    TOP__top_core__CORE__DOT__rv32cif.__Vconfigure(true);
    TOP__top_core__CORE__DOT__sparce_if.__Vconfigure(true);
    TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__Vconfigure(false);
    TOP__top_core__CORE__DOT__tspp_icache_gen_bus_if.__Vconfigure(false);
    TOP__top_core__gen_bus_if.__Vconfigure(false);
    // Setup export functions
    for (int __Vfinal=0; __Vfinal<2; __Vfinal++) {
    }
}
