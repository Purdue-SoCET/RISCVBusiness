// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vtop_core.h for the primary calling header

#ifndef VERILATED_VTOP_CORE_PRIV_1_12_INTERNAL_IF_H_
#define VERILATED_VTOP_CORE_PRIV_1_12_INTERNAL_IF_H_  // guard

#include "verilated.h"

class Vtop_core__Syms;

class Vtop_core_priv_1_12_internal_if final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    CData/*0:0*/ __PVT__env_u;
    CData/*0:0*/ __PVT__env_m;
    CData/*0:0*/ __PVT__insert_pc;
    CData/*0:0*/ __PVT__mret;
    CData/*0:0*/ __PVT__intr;
    CData/*0:0*/ __PVT__pma_s_fault;
    CData/*0:0*/ __PVT__pma_l_fault;
    CData/*0:0*/ __PVT__pma_i_fault;
    CData/*0:0*/ __PVT__pmp_s_fault;
    CData/*0:0*/ __PVT__pmp_l_fault;
    CData/*0:0*/ __PVT__pmp_i_fault;
    IData/*31:0*/ __PVT__old_csr_val;
    IData/*31:0*/ __PVT__next_mip;
    IData/*31:0*/ __PVT__next_mie;
    IData/*31:0*/ __PVT__next_mcause;
    IData/*31:0*/ __PVT__next_mstatus;
    IData/*31:0*/ __PVT__priv_pc;

    // INTERNAL VARIABLES
    Vtop_core__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vtop_core_priv_1_12_internal_if(Vtop_core__Syms* symsp, const char* name);
    ~Vtop_core_priv_1_12_internal_if();
    VL_UNCOPYABLE(Vtop_core_priv_1_12_internal_if);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard
