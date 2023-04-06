// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop_core.h for the primary calling header

#include "verilated.h"
#include "verilated_dpi.h"

#include "Vtop_core_risc_mgmt_if.h"

VL_ATTR_COLD void Vtop_core_risc_mgmt_if___ctor_var_reset(Vtop_core_risc_mgmt_if* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+          Vtop_core_risc_mgmt_if___ctor_var_reset\n"); );
    // Body
    vlSelf->__PVT__insn = VL_RAND_RESET_I(32);
    vlSelf->__PVT__req_reg_r = VL_RAND_RESET_I(1);
    vlSelf->__PVT__req_reg_w = VL_RAND_RESET_I(1);
    vlSelf->__PVT__rsel_s_0 = VL_RAND_RESET_I(5);
    vlSelf->__PVT__rsel_s_1 = VL_RAND_RESET_I(5);
    vlSelf->__PVT__rsel_d = VL_RAND_RESET_I(5);
    vlSelf->__PVT__rdata_s_0 = VL_RAND_RESET_I(32);
    vlSelf->__PVT__rdata_s_1 = VL_RAND_RESET_I(32);
    vlSelf->__PVT__reg_w = VL_RAND_RESET_I(1);
    vlSelf->__PVT__reg_wdata = VL_RAND_RESET_I(32);
    vlSelf->__PVT__req_br_j = VL_RAND_RESET_I(1);
    vlSelf->__PVT__branch_jump = VL_RAND_RESET_I(1);
    vlSelf->__PVT__br_j_addr = VL_RAND_RESET_I(32);
    vlSelf->__PVT__pc = VL_RAND_RESET_I(32);
    vlSelf->__PVT__req_mem = VL_RAND_RESET_I(1);
    vlSelf->__PVT__mem_addr = VL_RAND_RESET_I(32);
    vlSelf->__PVT__mem_store = VL_RAND_RESET_I(32);
    vlSelf->__PVT__mem_load = VL_RAND_RESET_I(32);
    vlSelf->__PVT__mem_ren = VL_RAND_RESET_I(1);
    vlSelf->__PVT__mem_wen = VL_RAND_RESET_I(1);
    vlSelf->__PVT__mem_busy = VL_RAND_RESET_I(1);
    vlSelf->__PVT__mem_byte_en = VL_RAND_RESET_I(4);
    vlSelf->__PVT__execute_stall = VL_RAND_RESET_I(1);
    vlSelf->__PVT__memory_stall = VL_RAND_RESET_I(1);
    vlSelf->__PVT__active_insn = VL_RAND_RESET_I(1);
    vlSelf->__PVT__ex_token = VL_RAND_RESET_I(1);
    vlSelf->__PVT__if_ex_enable = VL_RAND_RESET_I(1);
    vlSelf->__PVT__exception = VL_RAND_RESET_I(1);
    vlSelf->__PVT__ex_cause = VL_RAND_RESET_I(1);
    vlSelf->__PVT__risc_mgmt_start = VL_RAND_RESET_I(1);
}
