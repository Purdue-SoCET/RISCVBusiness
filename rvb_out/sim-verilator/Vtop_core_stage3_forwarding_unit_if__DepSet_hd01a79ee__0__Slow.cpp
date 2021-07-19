// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop_core.h for the primary calling header

#include "verilated.h"
#include "verilated_dpi.h"

#include "Vtop_core_stage3_forwarding_unit_if.h"

VL_ATTR_COLD void Vtop_core_stage3_forwarding_unit_if___ctor_var_reset(Vtop_core_stage3_forwarding_unit_if* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+              Vtop_core_stage3_forwarding_unit_if___ctor_var_reset\n"); );
    // Body
    vlSelf->__PVT__load = VL_RAND_RESET_I(1);
    vlSelf->__PVT__rd_mem_data = VL_RAND_RESET_I(32);
}
