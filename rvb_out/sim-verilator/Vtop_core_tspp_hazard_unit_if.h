// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vtop_core.h for the primary calling header

#ifndef VERILATED_VTOP_CORE_TSPP_HAZARD_UNIT_IF_H_
#define VERILATED_VTOP_CORE_TSPP_HAZARD_UNIT_IF_H_  // guard

#include "verilated.h"

class Vtop_core__Syms;

class Vtop_core_tspp_hazard_unit_if final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    CData/*0:0*/ __PVT__pc_en;
    CData/*0:0*/ __PVT__npc_sel;
    CData/*0:0*/ __PVT__i_mem_busy;
    CData/*0:0*/ __PVT__d_mem_busy;
    CData/*0:0*/ __PVT__dren;
    CData/*0:0*/ __PVT__dwen;
    CData/*0:0*/ __PVT__iren;
    CData/*0:0*/ __PVT__ret;
    CData/*0:0*/ __PVT__branch_taken;
    CData/*0:0*/ __PVT__prediction;
    CData/*0:0*/ __PVT__jump;
    CData/*0:0*/ __PVT__branch;
    CData/*0:0*/ __PVT__if_ex_stall;
    CData/*0:0*/ __PVT__fence_stall;
    CData/*0:0*/ __PVT__if_ex_flush;
    CData/*0:0*/ __PVT__mispredict;
    CData/*0:0*/ __PVT__halt;
    CData/*0:0*/ __PVT__fault_insn;
    CData/*0:0*/ __PVT__mal_insn;
    CData/*0:0*/ __PVT__illegal_insn;
    CData/*0:0*/ __PVT__fault_l;
    CData/*0:0*/ __PVT__mal_l;
    CData/*0:0*/ __PVT__fault_s;
    CData/*0:0*/ __PVT__mal_s;
    CData/*0:0*/ __PVT__breakpoint;
    CData/*0:0*/ __PVT__env;
    CData/*0:0*/ __PVT__insert_priv_pc;
    CData/*0:0*/ __PVT__token_ex;
    CData/*0:0*/ __PVT__rv32c_ready;
    IData/*31:0*/ __PVT__pc;
    IData/*31:0*/ __PVT__epc_f;
    IData/*31:0*/ __PVT__epc_e;
    IData/*31:0*/ __PVT__badaddr_f;
    IData/*31:0*/ __PVT__badaddr_e;
    IData/*31:0*/ __PVT__priv_pc;

    // INTERNAL VARIABLES
    Vtop_core__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vtop_core_tspp_hazard_unit_if(Vtop_core__Syms* symsp, const char* name);
    ~Vtop_core_tspp_hazard_unit_if();
    VL_UNCOPYABLE(Vtop_core_tspp_hazard_unit_if);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard
