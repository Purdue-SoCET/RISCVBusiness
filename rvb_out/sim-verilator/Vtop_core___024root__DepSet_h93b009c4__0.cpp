// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop_core.h for the primary calling header

#include "verilated.h"
#include "verilated_dpi.h"

#include "Vtop_core__Syms.h"
#include "Vtop_core___024root.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop_core___024root___dump_triggers__ico(Vtop_core___024root* vlSelf);
#endif  // VL_DEBUG

void Vtop_core___024root___eval_triggers__ico(Vtop_core___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root___eval_triggers__ico\n"); );
    // Body
    vlSelf->__VicoTriggered.at(0U) = (0U == vlSelf->__VicoIterCount);
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vtop_core___024root___dump_triggers__ico(vlSelf);
    }
#endif
}

void Vtop_core_top_core___ico_sequent__TOP__top_core__0(Vtop_core_top_core* vlSelf);

void Vtop_core___024root___eval_ico(Vtop_core___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root___eval_ico\n"); );
    // Body
    if (vlSelf->__VicoTriggered.at(0U)) {
        Vtop_core_top_core___ico_sequent__TOP__top_core__0((&vlSymsp->TOP__top_core));
        vlSelf->__Vm_traceActivity[1U] = 1U;
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop_core___024root___dump_triggers__act(Vtop_core___024root* vlSelf);
#endif  // VL_DEBUG

void Vtop_core___024root___eval_triggers__act(Vtop_core___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root___eval_triggers__act\n"); );
    // Body
    vlSelf->__VactTriggered.at(0U) = (((IData)(vlSelf->CLK) 
                                       & (~ (IData)(vlSelf->__Vtrigrprev__TOP__CLK))) 
                                      | ((~ (IData)(vlSelf->nRST)) 
                                         & (IData)(vlSelf->__Vtrigrprev__TOP__nRST)));
    vlSelf->__VactTriggered.at(1U) = ((IData)(vlSelf->CLK) 
                                      & (~ (IData)(vlSelf->__Vtrigrprev__TOP__CLK)));
    vlSelf->__VactTriggered.at(2U) = (((~ (IData)(vlSelf->CLK)) 
                                       & (IData)(vlSelf->__Vtrigrprev__TOP__CLK)) 
                                      | ((~ (IData)(vlSelf->nRST)) 
                                         & (IData)(vlSelf->__Vtrigrprev__TOP__nRST)));
    vlSelf->__Vtrigrprev__TOP__CLK = vlSelf->CLK;
    vlSelf->__Vtrigrprev__TOP__nRST = vlSelf->nRST;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vtop_core___024root___dump_triggers__act(vlSelf);
    }
#endif
}

VL_INLINE_OPT void Vtop_core___024root___nba_sequent__TOP__0(Vtop_core___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root___nba_sequent__TOP__0\n"); );
    // Body
    vlSelf->wen = vlSymsp->TOP__top_core__gen_bus_if.__PVT__wen;
    vlSelf->ren = vlSymsp->TOP__top_core__gen_bus_if.__PVT__ren;
    vlSelf->byte_en = vlSymsp->TOP__top_core__gen_bus_if.__PVT__byte_en;
    vlSelf->wdata = vlSymsp->TOP__top_core__gen_bus_if.__PVT__wdata;
    vlSelf->addr = vlSymsp->TOP__top_core__gen_bus_if.__PVT__addr;
}

VL_INLINE_OPT void Vtop_core___024root___nba_sequent__TOP__1(Vtop_core___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root___nba_sequent__TOP__1\n"); );
    // Body
    vlSelf->halt = (1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                          >> 0xeU));
}

void Vtop_core_top_core___nba_sequent__TOP__top_core__0(Vtop_core_top_core* vlSelf);
void Vtop_core_top_core___nba_sequent__TOP__top_core__1(Vtop_core_top_core* vlSelf);
void Vtop_core_top_core___nba_sequent__TOP__top_core__2(Vtop_core_top_core* vlSelf);
void Vtop_core_top_core___nba_sequent__TOP__top_core__3(Vtop_core_top_core* vlSelf);
void Vtop_core_top_core___nba_sequent__TOP__top_core__4(Vtop_core_top_core* vlSelf);
void Vtop_core_top_core___nba_comb__TOP__top_core__0(Vtop_core_top_core* vlSelf);

void Vtop_core___024root___eval_nba(Vtop_core___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root___eval_nba\n"); );
    // Body
    if (vlSelf->__VnbaTriggered.at(0U)) {
        Vtop_core_top_core___nba_sequent__TOP__top_core__0((&vlSymsp->TOP__top_core));
        vlSelf->__Vm_traceActivity[2U] = 1U;
        Vtop_core___024root___nba_sequent__TOP__0(vlSelf);
    }
    if (vlSelf->__VnbaTriggered.at(2U)) {
        Vtop_core_top_core___nba_sequent__TOP__top_core__1((&vlSymsp->TOP__top_core));
        vlSelf->__Vm_traceActivity[3U] = 1U;
    }
    if (vlSelf->__VnbaTriggered.at(1U)) {
        Vtop_core_top_core___nba_sequent__TOP__top_core__2((&vlSymsp->TOP__top_core));
    }
    if (vlSelf->__VnbaTriggered.at(0U)) {
        Vtop_core_top_core___nba_sequent__TOP__top_core__3((&vlSymsp->TOP__top_core));
        vlSelf->__Vm_traceActivity[4U] = 1U;
        Vtop_core_top_core___nba_sequent__TOP__top_core__4((&vlSymsp->TOP__top_core));
        Vtop_core___024root___nba_sequent__TOP__1(vlSelf);
    }
    if ((vlSelf->__VnbaTriggered.at(0U) | vlSelf->__VnbaTriggered.at(2U))) {
        Vtop_core_top_core___nba_comb__TOP__top_core__0((&vlSymsp->TOP__top_core));
        vlSelf->__Vm_traceActivity[5U] = 1U;
    }
}
