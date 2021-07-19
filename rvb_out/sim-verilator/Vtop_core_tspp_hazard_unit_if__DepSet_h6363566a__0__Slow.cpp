// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop_core.h for the primary calling header

#include "verilated.h"
#include "verilated_dpi.h"

#include "Vtop_core_tspp_hazard_unit_if.h"

VL_ATTR_COLD void Vtop_core_tspp_hazard_unit_if___ctor_var_reset(Vtop_core_tspp_hazard_unit_if* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+          Vtop_core_tspp_hazard_unit_if___ctor_var_reset\n"); );
    // Body
    vlSelf->__PVT__pc_en = VL_RAND_RESET_I(1);
    vlSelf->__PVT__npc_sel = VL_RAND_RESET_I(1);
    vlSelf->__PVT__i_mem_busy = VL_RAND_RESET_I(1);
    vlSelf->__PVT__d_mem_busy = VL_RAND_RESET_I(1);
    vlSelf->__PVT__dren = VL_RAND_RESET_I(1);
    vlSelf->__PVT__dwen = VL_RAND_RESET_I(1);
    vlSelf->__PVT__iren = VL_RAND_RESET_I(1);
    vlSelf->__PVT__ret = VL_RAND_RESET_I(1);
    vlSelf->__PVT__branch_taken = VL_RAND_RESET_I(1);
    vlSelf->__PVT__prediction = VL_RAND_RESET_I(1);
    vlSelf->__PVT__jump = VL_RAND_RESET_I(1);
    vlSelf->__PVT__branch = VL_RAND_RESET_I(1);
    vlSelf->__PVT__if_ex_stall = VL_RAND_RESET_I(1);
    vlSelf->__PVT__fence_stall = VL_RAND_RESET_I(1);
    vlSelf->__PVT__if_ex_flush = VL_RAND_RESET_I(1);
    vlSelf->__PVT__mispredict = VL_RAND_RESET_I(1);
    vlSelf->__PVT__halt = VL_RAND_RESET_I(1);
    vlSelf->__PVT__pc = VL_RAND_RESET_I(32);
    vlSelf->__PVT__fault_insn = VL_RAND_RESET_I(1);
    vlSelf->__PVT__mal_insn = VL_RAND_RESET_I(1);
    vlSelf->__PVT__illegal_insn = VL_RAND_RESET_I(1);
    vlSelf->__PVT__fault_l = VL_RAND_RESET_I(1);
    vlSelf->__PVT__mal_l = VL_RAND_RESET_I(1);
    vlSelf->__PVT__fault_s = VL_RAND_RESET_I(1);
    vlSelf->__PVT__mal_s = VL_RAND_RESET_I(1);
    vlSelf->__PVT__breakpoint = VL_RAND_RESET_I(1);
    vlSelf->__PVT__env = VL_RAND_RESET_I(1);
    vlSelf->__PVT__epc_f = VL_RAND_RESET_I(32);
    vlSelf->__PVT__epc_e = VL_RAND_RESET_I(32);
    vlSelf->__PVT__badaddr_f = VL_RAND_RESET_I(32);
    vlSelf->__PVT__badaddr_e = VL_RAND_RESET_I(32);
    vlSelf->__PVT__priv_pc = VL_RAND_RESET_I(32);
    vlSelf->__PVT__insert_priv_pc = VL_RAND_RESET_I(1);
    vlSelf->__PVT__token_ex = VL_RAND_RESET_I(1);
    vlSelf->__PVT__rv32c_ready = VL_RAND_RESET_I(1);
}
