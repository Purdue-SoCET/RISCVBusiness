// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop_core.h for the primary calling header

#include "verilated.h"
#include "verilated_dpi.h"

#include "Vtop_core__Syms.h"
#include "Vtop_core___024root.h"

VL_ATTR_COLD void Vtop_core_top_core___eval_initial__TOP__top_core(Vtop_core_top_core* vlSelf);

VL_ATTR_COLD void Vtop_core___024root___eval_initial(Vtop_core___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root___eval_initial\n"); );
    // Body
    Vtop_core_top_core___eval_initial__TOP__top_core((&vlSymsp->TOP__top_core));
    vlSelf->__Vm_traceActivity[5U] = 1U;
    vlSelf->__Vm_traceActivity[4U] = 1U;
    vlSelf->__Vm_traceActivity[3U] = 1U;
    vlSelf->__Vm_traceActivity[2U] = 1U;
    vlSelf->__Vm_traceActivity[1U] = 1U;
    vlSelf->__Vm_traceActivity[0U] = 1U;
    vlSelf->__Vtrigrprev__TOP__CLK = vlSelf->CLK;
    vlSelf->__Vtrigrprev__TOP__nRST = vlSelf->nRST;
}

VL_ATTR_COLD void Vtop_core_top_core___eval_final__TOP__top_core(Vtop_core_top_core* vlSelf);

VL_ATTR_COLD void Vtop_core___024root___eval_final(Vtop_core___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root___eval_final\n"); );
    // Body
    Vtop_core_top_core___eval_final__TOP__top_core((&vlSymsp->TOP__top_core));
    vlSelf->__Vm_traceActivity[5U] = 1U;
    vlSelf->__Vm_traceActivity[4U] = 1U;
    vlSelf->__Vm_traceActivity[3U] = 1U;
    vlSelf->__Vm_traceActivity[2U] = 1U;
    vlSelf->__Vm_traceActivity[1U] = 1U;
    vlSelf->__Vm_traceActivity[0U] = 1U;
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop_core___024root___dump_triggers__stl(Vtop_core___024root* vlSelf);
#endif  // VL_DEBUG

VL_ATTR_COLD void Vtop_core___024root___eval_triggers__stl(Vtop_core___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root___eval_triggers__stl\n"); );
    // Body
    vlSelf->__VstlTriggered.at(0U) = (0U == vlSelf->__VstlIterCount);
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vtop_core___024root___dump_triggers__stl(vlSelf);
    }
#endif
}

VL_ATTR_COLD void Vtop_core___024root___stl_sequent__TOP__0(Vtop_core___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root___stl_sequent__TOP__0\n"); );
    // Body
    vlSelf->wdata = vlSymsp->TOP__top_core__gen_bus_if.__PVT__wdata;
    vlSelf->addr = vlSymsp->TOP__top_core__gen_bus_if.__PVT__addr;
    vlSelf->byte_en = vlSymsp->TOP__top_core__gen_bus_if.__PVT__byte_en;
    vlSelf->wen = vlSymsp->TOP__top_core__gen_bus_if.__PVT__wen;
    vlSelf->ren = vlSymsp->TOP__top_core__gen_bus_if.__PVT__ren;
    vlSelf->halt = (1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                          >> 0xeU));
    vlSelf->wfi = vlSymsp->TOP__top_core.wfi;
}

VL_ATTR_COLD void Vtop_core_top_core___stl_sequent__TOP__top_core__0(Vtop_core_top_core* vlSelf);
VL_ATTR_COLD void Vtop_core_top_core___stl_sequent__TOP__top_core__1(Vtop_core_top_core* vlSelf);
VL_ATTR_COLD void Vtop_core_top_core___stl_sequent__TOP__top_core__2(Vtop_core_top_core* vlSelf);

VL_ATTR_COLD void Vtop_core___024root___eval_stl(Vtop_core___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop_core___024root___eval_stl\n"); );
    // Body
    if (vlSelf->__VstlTriggered.at(0U)) {
        Vtop_core___024root___stl_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[5U] = 1U;
        vlSelf->__Vm_traceActivity[4U] = 1U;
        vlSelf->__Vm_traceActivity[3U] = 1U;
        vlSelf->__Vm_traceActivity[2U] = 1U;
        vlSelf->__Vm_traceActivity[1U] = 1U;
        vlSelf->__Vm_traceActivity[0U] = 1U;
        Vtop_core_top_core___stl_sequent__TOP__top_core__0((&vlSymsp->TOP__top_core));
        Vtop_core_top_core___stl_sequent__TOP__top_core__1((&vlSymsp->TOP__top_core));
        Vtop_core_top_core___stl_sequent__TOP__top_core__2((&vlSymsp->TOP__top_core));
    }
}
