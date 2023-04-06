// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop_core.h for the primary calling header

#include "verilated.h"
#include "verilated_dpi.h"

#include "Vtop_core___024root.h"

void Vtop_core___024root___eval_act(Vtop_core___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root___eval_act\n"); );
}

void Vtop_core___024root___eval_triggers__ico(Vtop_core___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop_core___024root___dump_triggers__ico(Vtop_core___024root* vlSelf);
#endif  // VL_DEBUG
void Vtop_core___024root___eval_ico(Vtop_core___024root* vlSelf);
void Vtop_core___024root___eval_triggers__act(Vtop_core___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop_core___024root___dump_triggers__act(Vtop_core___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop_core___024root___dump_triggers__nba(Vtop_core___024root* vlSelf);
#endif  // VL_DEBUG
void Vtop_core___024root___eval_nba(Vtop_core___024root* vlSelf);

void Vtop_core___024root___eval(Vtop_core___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root___eval\n"); );
    // Init
    CData/*0:0*/ __VicoContinue;
    VlTriggerVec<3> __VpreTriggered;
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    vlSelf->__VicoIterCount = 0U;
    __VicoContinue = 1U;
    while (__VicoContinue) {
        __VicoContinue = 0U;
        Vtop_core___024root___eval_triggers__ico(vlSelf);
        if (vlSelf->__VicoTriggered.any()) {
            __VicoContinue = 1U;
            if ((0x64U < vlSelf->__VicoIterCount)) {
#ifdef VL_DEBUG
                Vtop_core___024root___dump_triggers__ico(vlSelf);
#endif
                VL_FATAL_MT("src/socet_riscv_riscv_standard_0.1.0/top_core.sv", 5, "", "Input combinational region did not converge.");
            }
            vlSelf->__VicoIterCount = ((IData)(1U) 
                                       + vlSelf->__VicoIterCount);
            Vtop_core___024root___eval_ico(vlSelf);
        }
    }
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        __VnbaContinue = 0U;
        vlSelf->__VnbaTriggered.clear();
        vlSelf->__VactIterCount = 0U;
        vlSelf->__VactContinue = 1U;
        while (vlSelf->__VactContinue) {
            vlSelf->__VactContinue = 0U;
            Vtop_core___024root___eval_triggers__act(vlSelf);
            if (vlSelf->__VactTriggered.any()) {
                vlSelf->__VactContinue = 1U;
                if ((0x64U < vlSelf->__VactIterCount)) {
#ifdef VL_DEBUG
                    Vtop_core___024root___dump_triggers__act(vlSelf);
#endif
                    VL_FATAL_MT("src/socet_riscv_riscv_standard_0.1.0/top_core.sv", 5, "", "Active region did not converge.");
                }
                vlSelf->__VactIterCount = ((IData)(1U) 
                                           + vlSelf->__VactIterCount);
                __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
                vlSelf->__VnbaTriggered.set(vlSelf->__VactTriggered);
                Vtop_core___024root___eval_act(vlSelf);
            }
        }
        if (vlSelf->__VnbaTriggered.any()) {
            __VnbaContinue = 1U;
            if ((0x64U < __VnbaIterCount)) {
#ifdef VL_DEBUG
                Vtop_core___024root___dump_triggers__nba(vlSelf);
#endif
                VL_FATAL_MT("src/socet_riscv_riscv_standard_0.1.0/top_core.sv", 5, "", "NBA region did not converge.");
            }
            __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
            Vtop_core___024root___eval_nba(vlSelf);
        }
    }
}

#ifdef VL_DEBUG
void Vtop_core___024root___eval_debug_assertions(Vtop_core___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->CLK & 0xfeU))) {
        Verilated::overWidthError("CLK");}
    if (VL_UNLIKELY((vlSelf->nRST & 0xfeU))) {
        Verilated::overWidthError("nRST");}
    if (VL_UNLIKELY((vlSelf->busy & 0xfeU))) {
        Verilated::overWidthError("busy");}
    if (VL_UNLIKELY((vlSelf->ext_int & 0xfeU))) {
        Verilated::overWidthError("ext_int");}
    if (VL_UNLIKELY((vlSelf->ext_int_clear & 0xfeU))) {
        Verilated::overWidthError("ext_int_clear");}
    if (VL_UNLIKELY((vlSelf->soft_int & 0xfeU))) {
        Verilated::overWidthError("soft_int");}
    if (VL_UNLIKELY((vlSelf->soft_int_clear & 0xfeU))) {
        Verilated::overWidthError("soft_int_clear");}
    if (VL_UNLIKELY((vlSelf->timer_int & 0xfeU))) {
        Verilated::overWidthError("timer_int");}
    if (VL_UNLIKELY((vlSelf->timer_int_clear & 0xfeU))) {
        Verilated::overWidthError("timer_int_clear");}
}
#endif  // VL_DEBUG
