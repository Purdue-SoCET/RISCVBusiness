// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vtop_core.h for the primary calling header

#ifndef VERILATED_VTOP_CORE_CONTROL_UNIT_IF_H_
#define VERILATED_VTOP_CORE_CONTROL_UNIT_IF_H_  // guard

#include "verilated.h"

class Vtop_core__Syms;

class Vtop_core_control_unit_if final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    CData/*0:0*/ __PVT__wen;
    CData/*0:0*/ __PVT__wfi;
    CData/*1:0*/ __PVT__alu_a_sel;
    CData/*1:0*/ __PVT__alu_b_sel;
    CData/*2:0*/ __PVT__w_sel;
    CData/*0:0*/ __PVT__ret_insn;
    CData/*0:0*/ __PVT__breakpoint;
    CData/*0:0*/ __PVT__ecall_insn;
    CData/*0:0*/ __PVT__csr_swap;
    CData/*0:0*/ __PVT__csr_set;
    CData/*0:0*/ __PVT__csr_clr;
    CData/*0:0*/ __PVT__csr_imm;
    SData/*11:0*/ __PVT__imm_S;
    SData/*12:0*/ __PVT__imm_SB;
    IData/*20:0*/ __PVT__imm_UJ;

    // INTERNAL VARIABLES
    Vtop_core__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vtop_core_control_unit_if(Vtop_core__Syms* symsp, const char* name);
    ~Vtop_core_control_unit_if();
    VL_UNCOPYABLE(Vtop_core_control_unit_if);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard
