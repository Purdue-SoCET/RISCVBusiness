// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop_core.h for the primary calling header

#include "verilated.h"
#include "verilated_dpi.h"

#include "Vtop_core__Syms.h"
#include "Vtop_core_top_core.h"

extern const VlWide<12>/*383:0*/ Vtop_core__ConstPool__CONST_h29f43d96_0;

VL_ATTR_COLD void Vtop_core_top_core___stl_sequent__TOP__top_core__2(Vtop_core_top_core* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+      Vtop_core_top_core___stl_sequent__TOP__top_core__2\n"); );
    // Init
    IData/*31:0*/ __Vilp;
    // Body
    vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__wen = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[0U] = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[1U] = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[2U] = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[3U] = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[4U] = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[5U] = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[6U] = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[7U] = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[8U] = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[9U] = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[0xaU] = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[0xbU] = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[0U] = 0xffffffffU;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[1U] = 0xffffffffU;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[2U] = 0xffffffffU;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[3U] = 0xffffffffU;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[4U] = 0xffffffffU;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[5U] = 0xffffffffU;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[6U] = 0xffffffffU;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[7U] = 0xffffffffU;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[8U] = 0xffffffffU;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[9U] = 0xffffffffU;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[0xaU] = 0xffffffffU;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[0xbU] = 0xfffffU;
    vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__wdata = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_read_addr 
        = vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__read_addr;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_decoded_req_addr 
        = vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__decoded_req_addr;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx 
        = (3U & ((IData)(1U) + (1U & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__last_used) 
                                      >> (1U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                >> 4U))))));
    if ((0U == vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__state)) {
        vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_read_addr 
            = ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xbU] 
                << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                             >> 1U));
        if ((1U & (~ (((IData)(vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__ren) 
                       & (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit)) 
                      & (~ (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__ifence_pulse)))))) {
            if ((1U & (~ (((IData)(vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__wen) 
                           & (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit)) 
                          & (~ (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__ifence_pulse)))))) {
                if (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__pass_through) {
                    vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__wen 
                        = vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__wen;
                }
            }
            if ((((IData)(vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__wen) 
                  & (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit)) 
                 & (~ (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__ifence_pulse)))) {
                vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h75d3f992__0 
                    = vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__wdata;
                if ((8U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))) {
                    if ((4U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))) {
                        if ((2U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))) {
                            vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h214df0a5__6 = 0U;
                            if ((0x173U >= (0x1ffU 
                                            & (((IData)(0x5dU) 
                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                               + (0x20U 
                                                  & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                     << 2U)))))) {
                                VL_ASSIGNSEL_WI(372,32,
                                                (0x1ffU 
                                                 & (((IData)(0x5dU) 
                                                     * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                                    + 
                                                    (0x20U 
                                                     & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                        << 2U)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask, vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h214df0a5__6);
                            }
                        } else if ((1U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))) {
                            vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h214df0a5__6 = 0U;
                            if ((0x173U >= (0x1ffU 
                                            & (((IData)(0x5dU) 
                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                               + (0x20U 
                                                  & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                     << 2U)))))) {
                                VL_ASSIGNSEL_WI(372,32,
                                                (0x1ffU 
                                                 & (((IData)(0x5dU) 
                                                     * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                                    + 
                                                    (0x20U 
                                                     & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                        << 2U)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask, vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h214df0a5__6);
                            }
                        } else {
                            vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h214df0a5__5 = 0xffffU;
                            if ((0x173U >= (0x1ffU 
                                            & (((IData)(0x5dU) 
                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                               + (0x20U 
                                                  & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                     << 2U)))))) {
                                VL_ASSIGNSEL_WI(372,32,
                                                (0x1ffU 
                                                 & (((IData)(0x5dU) 
                                                     * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                                    + 
                                                    (0x20U 
                                                     & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                        << 2U)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask, vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h214df0a5__5);
                            }
                        }
                    } else if ((2U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))) {
                        vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h214df0a5__6 = 0U;
                        if ((0x173U >= (0x1ffU & (((IData)(0x5dU) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                                  + 
                                                  (0x20U 
                                                   & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                      << 2U)))))) {
                            VL_ASSIGNSEL_WI(372,32,
                                            (0x1ffU 
                                             & (((IData)(0x5dU) 
                                                 * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                                + (0x20U 
                                                   & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                      << 2U)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask, vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h214df0a5__6);
                        }
                    } else if ((1U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))) {
                        vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h214df0a5__6 = 0U;
                        if ((0x173U >= (0x1ffU & (((IData)(0x5dU) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                                  + 
                                                  (0x20U 
                                                   & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                      << 2U)))))) {
                            VL_ASSIGNSEL_WI(372,32,
                                            (0x1ffU 
                                             & (((IData)(0x5dU) 
                                                 * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                                + (0x20U 
                                                   & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                      << 2U)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask, vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h214df0a5__6);
                        }
                    } else {
                        vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h214df0a5__3 = 0xffffffU;
                        if ((0x173U >= (0x1ffU & (((IData)(0x5dU) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                                  + 
                                                  (0x20U 
                                                   & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                      << 2U)))))) {
                            VL_ASSIGNSEL_WI(372,32,
                                            (0x1ffU 
                                             & (((IData)(0x5dU) 
                                                 * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                                + (0x20U 
                                                   & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                      << 2U)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask, vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h214df0a5__3);
                        }
                    }
                } else if ((4U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))) {
                    if ((2U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))) {
                        vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h214df0a5__6 = 0U;
                        if ((0x173U >= (0x1ffU & (((IData)(0x5dU) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                                  + 
                                                  (0x20U 
                                                   & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                      << 2U)))))) {
                            VL_ASSIGNSEL_WI(372,32,
                                            (0x1ffU 
                                             & (((IData)(0x5dU) 
                                                 * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                                + (0x20U 
                                                   & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                      << 2U)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask, vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h214df0a5__6);
                        }
                    } else if ((1U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))) {
                        vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h214df0a5__6 = 0U;
                        if ((0x173U >= (0x1ffU & (((IData)(0x5dU) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                                  + 
                                                  (0x20U 
                                                   & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                      << 2U)))))) {
                            VL_ASSIGNSEL_WI(372,32,
                                            (0x1ffU 
                                             & (((IData)(0x5dU) 
                                                 * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                                + (0x20U 
                                                   & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                      << 2U)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask, vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h214df0a5__6);
                        }
                    } else {
                        vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h214df0a5__2 = 0xff00ffffU;
                        if ((0x173U >= (0x1ffU & (((IData)(0x5dU) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                                  + 
                                                  (0x20U 
                                                   & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                      << 2U)))))) {
                            VL_ASSIGNSEL_WI(372,32,
                                            (0x1ffU 
                                             & (((IData)(0x5dU) 
                                                 * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                                + (0x20U 
                                                   & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                      << 2U)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask, vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h214df0a5__2);
                        }
                    }
                } else if ((2U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))) {
                    if ((1U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))) {
                        vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h214df0a5__4 = 0xffff0000U;
                        if ((0x173U >= (0x1ffU & (((IData)(0x5dU) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                                  + 
                                                  (0x20U 
                                                   & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                      << 2U)))))) {
                            VL_ASSIGNSEL_WI(372,32,
                                            (0x1ffU 
                                             & (((IData)(0x5dU) 
                                                 * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                                + (0x20U 
                                                   & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                      << 2U)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask, vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h214df0a5__4);
                        }
                    } else {
                        vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h214df0a5__1 = 0xffff00ffU;
                        if ((0x173U >= (0x1ffU & (((IData)(0x5dU) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                                  + 
                                                  (0x20U 
                                                   & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                      << 2U)))))) {
                            VL_ASSIGNSEL_WI(372,32,
                                            (0x1ffU 
                                             & (((IData)(0x5dU) 
                                                 * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                                + (0x20U 
                                                   & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                      << 2U)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask, vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h214df0a5__1);
                        }
                    }
                } else if ((1U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))) {
                    vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h214df0a5__0 = 0xffffff00U;
                    if ((0x173U >= (0x1ffU & (((IData)(0x5dU) 
                                               * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                              + (0x20U 
                                                 & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                    << 2U)))))) {
                        VL_ASSIGNSEL_WI(372,32,(0x1ffU 
                                                & (((IData)(0x5dU) 
                                                    * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                                   + 
                                                   (0x20U 
                                                    & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                       << 2U)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask, vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h214df0a5__0);
                    }
                } else {
                    vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h214df0a5__6 = 0U;
                    if ((0x173U >= (0x1ffU & (((IData)(0x5dU) 
                                               * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                              + (0x20U 
                                                 & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                    << 2U)))))) {
                        VL_ASSIGNSEL_WI(372,32,(0x1ffU 
                                                & (((IData)(0x5dU) 
                                                    * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                                   + 
                                                   (0x20U 
                                                    & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                       << 2U)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask, vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h214df0a5__6);
                    }
                }
                if ((0x173U >= (0x1ffU & (((IData)(0x5dU) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                          + (0x20U 
                                             & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                << 2U)))))) {
                    VL_ASSIGNSEL_WI(372,32,(0x1ffU 
                                            & (((IData)(0x5dU) 
                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)) 
                                               + (0x20U 
                                                  & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                     << 2U)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite, vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h75d3f992__0);
                }
                vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_hc69e7196__0 = 0U;
                vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h033cbfa6__0 = 1U;
                if ((0x173U >= (0x1ffU & ((IData)(0x5bU) 
                                          + ((IData)(0x5dU) 
                                             * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)))))) {
                    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[(0xfU 
                                                                                & (((IData)(0x5bU) 
                                                                                + 
                                                                                ((IData)(0x5dU) 
                                                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx))) 
                                                                                >> 5U))] 
                        = (((~ ((IData)(1U) << (0x1fU 
                                                & ((IData)(0x5bU) 
                                                   + 
                                                   ((IData)(0x5dU) 
                                                    * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)))))) 
                            & vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[
                            (0xfU & (((IData)(0x5bU) 
                                      + ((IData)(0x5dU) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx))) 
                                     >> 5U))]) | ((IData)(vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_hc69e7196__0) 
                                                  << 
                                                  (0x1fU 
                                                   & ((IData)(0x5bU) 
                                                      + 
                                                      ((IData)(0x5dU) 
                                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx))))));
                    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[(0xfU 
                                                                                & (((IData)(0x5bU) 
                                                                                + 
                                                                                ((IData)(0x5dU) 
                                                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx))) 
                                                                                >> 5U))] 
                        = (((~ ((IData)(1U) << (0x1fU 
                                                & ((IData)(0x5bU) 
                                                   + 
                                                   ((IData)(0x5dU) 
                                                    * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx)))))) 
                            & vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[
                            (0xfU & (((IData)(0x5bU) 
                                      + ((IData)(0x5dU) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx))) 
                                     >> 5U))]) | ((IData)(vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h033cbfa6__0) 
                                                  << 
                                                  (0x1fU 
                                                   & ((IData)(0x5bU) 
                                                      + 
                                                      ((IData)(0x5dU) 
                                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit_idx))))));
                }
            } else if (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__pass_through) {
                if (vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__wen) {
                    vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__wdata 
                        = ((8U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                            ? ((4U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                ? ((2U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                    ? vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__wdata
                                    : ((1U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                        ? vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__wdata
                                        : (0xffff0000U 
                                           & vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__wdata)))
                                : ((2U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                    ? vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__wdata
                                    : ((1U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                        ? vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__wdata
                                        : (0xff000000U 
                                           & vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__wdata))))
                            : ((4U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                ? ((2U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                    ? vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__wdata
                                    : ((1U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                        ? vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__wdata
                                        : (0xff0000U 
                                           & vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__wdata)))
                                : ((2U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                    ? ((1U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                        ? (0xffffU 
                                           & vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__wdata)
                                        : (0xff00U 
                                           & vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__wdata))
                                    : ((1U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                        ? (0xffU & vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__wdata)
                                        : vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__wdata))));
                }
            } else if ((((((IData)(vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__ren) 
                           | (IData)(vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__wen)) 
                          & (~ (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit))) 
                         & (~ ((0x173U >= (0x1ffU & 
                                           ((IData)(0x5bU) 
                                            + ((IData)(0x5dU) 
                                               * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))))) 
                               & (vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[
                                  (0xfU & (((IData)(0x5bU) 
                                            + ((IData)(0x5dU) 
                                               * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))) 
                                           >> 5U))] 
                                  >> (0x1fU & ((IData)(0x5bU) 
                                               + ((IData)(0x5dU) 
                                                  * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx)))))))) 
                        & (~ (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__pass_through)))) {
                vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_decoded_req_addr 
                    = ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xbU] 
                        << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                     >> 1U));
                vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_read_addr 
                    = (0xfffffff8U & ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xbU] 
                                       << 0x1fU) | 
                                      (0x7ffffff8U 
                                       & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                          >> 1U))));
            } else if ((((((IData)(vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__ren) 
                           | (IData)(vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__wen)) 
                          & (~ (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit))) 
                         & ((0x173U >= (0x1ffU & ((IData)(0x5bU) 
                                                  + 
                                                  ((IData)(0x5dU) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))))) 
                            & (vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[
                               (0xfU & (((IData)(0x5bU) 
                                         + ((IData)(0x5dU) 
                                            * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))) 
                                        >> 5U))] >> 
                               (0x1fU & ((IData)(0x5bU) 
                                         + ((IData)(0x5dU) 
                                            * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))))))) 
                        & (~ (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__pass_through)))) {
                vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_decoded_req_addr 
                    = ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xbU] 
                        << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                     >> 1U));
                vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_read_addr 
                    = ((((0x173U >= (0x1ffU & ((IData)(0x40U) 
                                               + ((IData)(0x5dU) 
                                                  * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx)))))
                          ? (0x7ffffffU & (((0U == 
                                             (0x1fU 
                                              & ((IData)(0x40U) 
                                                 + 
                                                 ((IData)(0x5dU) 
                                                  * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx)))))
                                             ? 0U : 
                                            (vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[
                                             (((IData)(0x1aU) 
                                               + (0x1ffU 
                                                  & ((IData)(0x40U) 
                                                     + 
                                                     ((IData)(0x5dU) 
                                                      * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))))) 
                                              >> 5U)] 
                                             << ((IData)(0x20U) 
                                                 - 
                                                 (0x1fU 
                                                  & ((IData)(0x40U) 
                                                     + 
                                                     ((IData)(0x5dU) 
                                                      * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))))))) 
                                           | (vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[
                                              (0xfU 
                                               & (((IData)(0x40U) 
                                                   + 
                                                   ((IData)(0x5dU) 
                                                    * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))) 
                                                  >> 5U))] 
                                              >> (0x1fU 
                                                  & ((IData)(0x40U) 
                                                     + 
                                                     ((IData)(0x5dU) 
                                                      * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx)))))))
                          : 0U) << 5U) | (0x18U & (
                                                   vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                   >> 1U)));
            }
        }
    } else {
        if ((1U != vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__state)) {
            if ((2U == vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__state)) {
                vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__wen = 1U;
                if ((2U == (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__word_num))) {
                    vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__wen = 0U;
                }
            } else if ((3U == vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__state)) {
                if ((((0x173U >= (0x1ffU & ((IData)(0x5cU) 
                                            + ((IData)(0x5dU) 
                                               * (3U 
                                                  & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                                     >> 1U)))))) 
                      & (vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[
                         (0xfU & (((IData)(0x5cU) + 
                                   ((IData)(0x5dU) 
                                    * (3U & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                             >> 1U)))) 
                                  >> 5U))] >> (0x1fU 
                                               & ((IData)(0x5cU) 
                                                  + 
                                                  ((IData)(0x5dU) 
                                                   * 
                                                   (3U 
                                                    & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                                       >> 1U))))))) 
                     & ((0x173U >= (0x1ffU & ((IData)(0x5bU) 
                                              + ((IData)(0x5dU) 
                                                 * 
                                                 (3U 
                                                  & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                                     >> 1U)))))) 
                        & (vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[
                           (0xfU & (((IData)(0x5bU) 
                                     + ((IData)(0x5dU) 
                                        * (3U & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                                 >> 1U)))) 
                                    >> 5U))] >> (0x1fU 
                                                 & ((IData)(0x5bU) 
                                                    + 
                                                    ((IData)(0x5dU) 
                                                     * 
                                                     (3U 
                                                      & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                                         >> 1U))))))))) {
                    vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__wen = 1U;
                }
            }
        }
        if ((1U == vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__state)) {
            vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h325132d4__0 = 0U;
            vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_hbf233a89__0 = 0U;
            if ((0x173U >= (0x1ffU & ((IData)(0x5cU) 
                                      + ((IData)(0x5dU) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx)))))) {
                vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[(0xfU 
                                                                                & (((IData)(0x5cU) 
                                                                                + 
                                                                                ((IData)(0x5dU) 
                                                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))) 
                                                                                >> 5U))] 
                    = (((~ ((IData)(1U) << (0x1fU & 
                                            ((IData)(0x5cU) 
                                             + ((IData)(0x5dU) 
                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx)))))) 
                        & vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[
                        (0xfU & (((IData)(0x5cU) + 
                                  ((IData)(0x5dU) * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))) 
                                 >> 5U))]) | ((IData)(vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h325132d4__0) 
                                              << (0x1fU 
                                                  & ((IData)(0x5cU) 
                                                     + 
                                                     ((IData)(0x5dU) 
                                                      * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))))));
                vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[(0xfU 
                                                                                & (((IData)(0x5cU) 
                                                                                + 
                                                                                ((IData)(0x5dU) 
                                                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))) 
                                                                                >> 5U))] 
                    = (((~ ((IData)(1U) << (0x1fU & 
                                            ((IData)(0x5cU) 
                                             + ((IData)(0x5dU) 
                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx)))))) 
                        & vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[
                        (0xfU & (((IData)(0x5cU) + 
                                  ((IData)(0x5dU) * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))) 
                                 >> 5U))]) | ((IData)(vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_hbf233a89__0) 
                                              << (0x1fU 
                                                  & ((IData)(0x5cU) 
                                                     + 
                                                     ((IData)(0x5dU) 
                                                      * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))))));
            }
            if ((2U == (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__word_num))) {
                vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_hbf233a89__1 = 1U;
                vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h003574db__0 
                    = (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__decoded_req_addr 
                       >> 5U);
                vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h325132d4__1 = 0U;
                if ((0x173U >= (0x1ffU & ((IData)(0x5cU) 
                                          + ((IData)(0x5dU) 
                                             * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx)))))) {
                    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[(0xfU 
                                                                                & (((IData)(0x5cU) 
                                                                                + 
                                                                                ((IData)(0x5dU) 
                                                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))) 
                                                                                >> 5U))] 
                        = (((~ ((IData)(1U) << (0x1fU 
                                                & ((IData)(0x5cU) 
                                                   + 
                                                   ((IData)(0x5dU) 
                                                    * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx)))))) 
                            & vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[
                            (0xfU & (((IData)(0x5cU) 
                                      + ((IData)(0x5dU) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))) 
                                     >> 5U))]) | ((IData)(vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_hbf233a89__1) 
                                                  << 
                                                  (0x1fU 
                                                   & ((IData)(0x5cU) 
                                                      + 
                                                      ((IData)(0x5dU) 
                                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))))));
                    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[(0xfU 
                                                                                & (((IData)(0x5cU) 
                                                                                + 
                                                                                ((IData)(0x5dU) 
                                                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))) 
                                                                                >> 5U))] 
                        = (((~ ((IData)(1U) << (0x1fU 
                                                & ((IData)(0x5cU) 
                                                   + 
                                                   ((IData)(0x5dU) 
                                                    * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx)))))) 
                            & vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[
                            (0xfU & (((IData)(0x5cU) 
                                      + ((IData)(0x5dU) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))) 
                                     >> 5U))]) | ((IData)(vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h325132d4__1) 
                                                  << 
                                                  (0x1fU 
                                                   & ((IData)(0x5cU) 
                                                      + 
                                                      ((IData)(0x5dU) 
                                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))))));
                }
                vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h7d1a0219__0 = 0U;
                if ((0x173U >= (0x1ffU & ((IData)(0x40U) 
                                          + ((IData)(0x5dU) 
                                             * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx)))))) {
                    VL_ASSIGNSEL_WI(372,27,(0x1ffU 
                                            & ((IData)(0x40U) 
                                               + ((IData)(0x5dU) 
                                                  * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite, vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h003574db__0);
                    VL_ASSIGNSEL_WI(372,27,(0x1ffU 
                                            & ((IData)(0x40U) 
                                               + ((IData)(0x5dU) 
                                                  * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask, vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h7d1a0219__0);
                }
            }
            if (((~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__busy)) 
                 & (2U != (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__word_num)))) {
                vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_hb7f2d31d__0 
                    = vlSymsp->TOP.rdata;
                vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_read_addr 
                    = ((IData)(4U) + vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__read_addr);
                vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_he3f90764__0 = 0U;
                if ((0x173U >= (0x1ffU & (((IData)(0x5dU) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx)) 
                                          + (0x3fU 
                                             & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__word_num) 
                                                << 5U)))))) {
                    VL_ASSIGNSEL_WI(372,32,(0x1ffU 
                                            & (((IData)(0x5dU) 
                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx)) 
                                               + (0x3fU 
                                                  & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__word_num) 
                                                     << 5U)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite, vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_hb7f2d31d__0);
                    VL_ASSIGNSEL_WI(372,32,(0x1ffU 
                                            & (((IData)(0x5dU) 
                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx)) 
                                               + (0x3fU 
                                                  & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__word_num) 
                                                     << 5U)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask, vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_he3f90764__0);
                }
            }
        } else if ((2U == vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__state)) {
            vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__wdata 
                = ((0x173U >= (0x1ffU & (((IData)(0x5dU) 
                                          * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx)) 
                                         + (0x3fU & 
                                            ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__word_num) 
                                             << 5U)))))
                    ? (((0U == (0x1fU & (((IData)(0x5dU) 
                                          * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx)) 
                                         + (0x3fU & 
                                            ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__word_num) 
                                             << 5U)))))
                         ? 0U : (vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[
                                 (((IData)(0x1fU) + 
                                   (0x1ffU & (((IData)(0x5dU) 
                                               * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx)) 
                                              + (0x3fU 
                                                 & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__word_num) 
                                                    << 5U))))) 
                                  >> 5U)] << ((IData)(0x20U) 
                                              - (0x1fU 
                                                 & (((IData)(0x5dU) 
                                                     * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx)) 
                                                    + 
                                                    (0x3fU 
                                                     & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__word_num) 
                                                        << 5U))))))) 
                       | (vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[
                          (0xfU & ((((IData)(0x5dU) 
                                     * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx)) 
                                    + (0x3fU & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__word_num) 
                                                << 5U))) 
                                   >> 5U))] >> (0x1fU 
                                                & (((IData)(0x5dU) 
                                                    * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx)) 
                                                   + 
                                                   (0x3fU 
                                                    & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__word_num) 
                                                       << 5U))))))
                    : 0U);
            if (((~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__busy)) 
                 & (2U != (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__word_num)))) {
                vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_read_addr 
                    = ((IData)(4U) + vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__read_addr);
            }
            if ((2U == (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__word_num))) {
                vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_hbe55c246__0 = 0U;
                vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h325527b6__0 = 0U;
                if ((0x173U >= (0x1ffU & ((IData)(0x5bU) 
                                          + ((IData)(0x5dU) 
                                             * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx)))))) {
                    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[(0xfU 
                                                                                & (((IData)(0x5bU) 
                                                                                + 
                                                                                ((IData)(0x5dU) 
                                                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))) 
                                                                                >> 5U))] 
                        = (((~ ((IData)(1U) << (0x1fU 
                                                & ((IData)(0x5bU) 
                                                   + 
                                                   ((IData)(0x5dU) 
                                                    * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx)))))) 
                            & vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[
                            (0xfU & (((IData)(0x5bU) 
                                      + ((IData)(0x5dU) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))) 
                                     >> 5U))]) | ((IData)(vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_hbe55c246__0) 
                                                  << 
                                                  (0x1fU 
                                                   & ((IData)(0x5bU) 
                                                      + 
                                                      ((IData)(0x5dU) 
                                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))))));
                    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[(0xfU 
                                                                                & (((IData)(0x5bU) 
                                                                                + 
                                                                                ((IData)(0x5dU) 
                                                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))) 
                                                                                >> 5U))] 
                        = (((~ ((IData)(1U) << (0x1fU 
                                                & ((IData)(0x5bU) 
                                                   + 
                                                   ((IData)(0x5dU) 
                                                    * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx)))))) 
                            & vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[
                            (0xfU & (((IData)(0x5bU) 
                                      + ((IData)(0x5dU) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))) 
                                     >> 5U))]) | ((IData)(vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h325527b6__0) 
                                                  << 
                                                  (0x1fU 
                                                   & ((IData)(0x5bU) 
                                                      + 
                                                      ((IData)(0x5dU) 
                                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))))));
                }
            }
        } else if ((3U == vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__state)) {
            if ((((0x173U >= (0x1ffU & ((IData)(0x5cU) 
                                        + ((IData)(0x5dU) 
                                           * (3U & 
                                              ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                               >> 1U)))))) 
                  & (vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[
                     (0xfU & (((IData)(0x5cU) + ((IData)(0x5dU) 
                                                 * 
                                                 (3U 
                                                  & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                                     >> 1U)))) 
                              >> 5U))] >> (0x1fU & 
                                           ((IData)(0x5cU) 
                                            + ((IData)(0x5dU) 
                                               * (3U 
                                                  & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                                     >> 1U))))))) 
                 & ((0x173U >= (0x1ffU & ((IData)(0x5bU) 
                                          + ((IData)(0x5dU) 
                                             * (3U 
                                                & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                                   >> 1U)))))) 
                    & (vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[
                       (0xfU & (((IData)(0x5bU) + ((IData)(0x5dU) 
                                                   * 
                                                   (3U 
                                                    & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                                       >> 1U)))) 
                                >> 5U))] >> (0x1fU 
                                             & ((IData)(0x5bU) 
                                                + ((IData)(0x5dU) 
                                                   * 
                                                   (3U 
                                                    & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                                       >> 1U))))))))) {
                vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__wdata 
                    = ((0x173U >= (0x1ffU & (((IData)(0x5dU) 
                                              * (3U 
                                                 & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                                    >> 1U))) 
                                             + (0x20U 
                                                & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                                   << 5U)))))
                        ? (((0U == (0x1fU & (((IData)(0x5dU) 
                                              * (3U 
                                                 & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                                    >> 1U))) 
                                             + (0x20U 
                                                & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                                   << 5U)))))
                             ? 0U : (vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[
                                     (((IData)(0x1fU) 
                                       + (0x1ffU & 
                                          (((IData)(0x5dU) 
                                            * (3U & 
                                               ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                                >> 1U))) 
                                           + (0x20U 
                                              & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                                 << 5U))))) 
                                      >> 5U)] << ((IData)(0x20U) 
                                                  - 
                                                  (0x1fU 
                                                   & (((IData)(0x5dU) 
                                                       * 
                                                       (3U 
                                                        & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                                           >> 1U))) 
                                                      + 
                                                      (0x20U 
                                                       & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                                          << 5U))))))) 
                           | (vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[
                              (0xfU & ((((IData)(0x5dU) 
                                         * (3U & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                                  >> 1U))) 
                                        + (0x20U & 
                                           ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                            << 5U))) 
                                       >> 5U))] >> 
                              (0x1fU & (((IData)(0x5dU) 
                                         * (3U & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                                  >> 1U))) 
                                        + (0x20U & 
                                           ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                            << 5U))))))
                        : 0U);
                if ((1U & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__busy)))) {
                    if ((1U & (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx))) {
                        vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h0f1df81b__0[0U] = 0U;
                        vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h0f1df81b__0[1U] = 0U;
                        vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h0f1df81b__0[2U] = 0U;
                        vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h1ee545ae__0[0U] = 0U;
                        vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h1ee545ae__0[1U] = 0U;
                        vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h1ee545ae__0[2U] = 0U;
                        if ((0x173U >= (0x1ffU & ((IData)(0x5dU) 
                                                  * 
                                                  (3U 
                                                   & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                                      >> 1U)))))) {
                            VL_ASSIGNSEL_WW(372,93,
                                            (0x1ffU 
                                             & ((IData)(0x5dU) 
                                                * (3U 
                                                   & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                                      >> 1U)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite, vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h0f1df81b__0);
                            VL_ASSIGNSEL_WW(372,93,
                                            (0x1ffU 
                                             & ((IData)(0x5dU) 
                                                * (3U 
                                                   & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                                      >> 1U)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask, vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h1ee545ae__0);
                        }
                    }
                }
            } else {
                vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h0f1df81b__1[0U] = 0U;
                vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h0f1df81b__1[1U] = 0U;
                vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h0f1df81b__1[2U] = 0U;
                vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h1ee545ae__1[0U] = 0U;
                vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h1ee545ae__1[1U] = 0U;
                vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h1ee545ae__1[2U] = 0U;
                if ((0x173U >= (0x1ffU & ((IData)(0x5dU) 
                                          * (3U & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                                   >> 1U)))))) {
                    VL_ASSIGNSEL_WW(372,93,(0x1ffU 
                                            & ((IData)(0x5dU) 
                                               * (3U 
                                                  & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                                     >> 1U)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite, vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h0f1df81b__1);
                    VL_ASSIGNSEL_WW(372,93,(0x1ffU 
                                            & ((IData)(0x5dU) 
                                               * (3U 
                                                  & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__flush_idx) 
                                                     >> 1U)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask, vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vlvbound_h1ee545ae__1);
                }
            }
        }
    }
    vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__busy = 1U;
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__mode__DOT__next_priv_level 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__mode__DOT__curr_priv_level;
    vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__priv_pc = 0U;
    vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus;
    if (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__intr) {
        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__mode__DOT__next_priv_level = 3U;
        vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__priv_pc 
            = (((1U == (3U & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mtvec)) 
                & (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mcause 
                   >> 0x1fU)) ? ((0xfffffffcU & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mtvec) 
                                 + (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mcause 
                                    << 2U)) : (0xfffffffcU 
                                               & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mtvec));
        vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
            = ((0xffffff7fU & vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus) 
               | (0x80U & (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                           << 4U)));
        vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
            = (0xfffffff7U & vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus);
        vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
            = ((0xffffe7ffU & vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus) 
               | ((IData)(vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__mode__DOT__curr_priv_level) 
                  << 0xbU));
    } else if (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__mret) {
        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__mode__DOT__next_priv_level 
            = (3U & (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                     >> 0xbU));
        vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__priv_pc 
            = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mepc;
        vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
            = (0xffffff7fU & vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus);
        vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
            = ((0xfffffff7U & vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus) 
               | (8U & (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                        >> 4U)));
        vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
            = (0xffffe7ffU & vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus);
        if ((3U != (3U & (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus 
                          >> 0xbU)))) {
            vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus 
                = (0xfffdffffU & vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus);
        }
    }
    vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__insert_pc 
        = ((IData)(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__mret) 
           | (IData)(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__intr));
    vlSelf->__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__intr 
        = ((~ (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__exception)) 
           & (IData)(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__intr));
    vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__dload_ext 
        = ((0x8000U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU])
            ? ((0x4000U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU])
                ? 0U : ((0x2000U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU])
                         ? ((3U == (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                             ? (0xffffU & vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__rdata)
                             : ((0xcU == (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                 ? (vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__rdata 
                                    >> 0x10U) : 0U))
                         : ((8U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                             ? ((4U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                 ? 0U : ((2U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                          ? 0U : ((1U 
                                                   & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                                   ? 0U
                                                   : 
                                                  (vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__rdata 
                                                   >> 0x18U))))
                             : ((4U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                 ? ((2U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                     ? 0U : ((1U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                              ? 0U : 
                                             (0xffU 
                                              & (vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__rdata 
                                                 >> 0x10U))))
                                 : ((2U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                     ? ((1U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                         ? 0U : (0xffU 
                                                 & (vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__rdata 
                                                    >> 8U)))
                                     : ((1U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                         ? (0xffU & vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__rdata)
                                         : 0U))))))
            : ((0x4000U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU])
                ? ((0x2000U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU])
                    ? 0U : vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__rdata)
                : ((0x2000U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU])
                    ? ((3U == (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                        ? VL_EXTENDS_II(32,16, (0xffffU 
                                                & vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__rdata))
                        : ((0xcU == (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                            ? VL_EXTENDS_II(32,16, 
                                            (vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__rdata 
                                             >> 0x10U))
                            : 0U)) : ((8U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                       ? ((4U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                           ? 0U : (
                                                   (2U 
                                                    & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                                    ? 0U
                                                    : 
                                                   ((1U 
                                                     & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                                     ? 0U
                                                     : 
                                                    VL_EXTENDS_II(32,8, 
                                                                  (vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__rdata 
                                                                   >> 0x18U)))))
                                       : ((4U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                           ? ((2U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                               ? 0U
                                               : ((1U 
                                                   & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                                   ? 0U
                                                   : 
                                                  VL_EXTENDS_II(32,8, 
                                                                (0xffU 
                                                                 & (vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__rdata 
                                                                    >> 0x10U)))))
                                           : ((2U & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                               ? ((1U 
                                                   & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                                   ? 0U
                                                   : 
                                                  VL_EXTENDS_II(32,8, 
                                                                (0xffU 
                                                                 & (vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__rdata 
                                                                    >> 8U))))
                                               : ((1U 
                                                   & (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__byte_en_standard))
                                                   ? 
                                                  VL_EXTENDS_II(32,8, 
                                                                (0xffU 
                                                                 & vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__rdata))
                                                   : 0U)))))));
    __Vilp = 0U;
    while ((__Vilp <= 0x2eU)) {
        vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory[__Vilp] 
            = vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[__Vilp];
        __Vilp = ((IData)(1U) + __Vilp);
    }
    if (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWEN) {
        vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT____Vlvbound_h9e60dea4__0[0U] 
            = ((vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[0U] 
                & (~ vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[0U])) 
               | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[0U] 
                  & ((0x5cfU >= (0x7ffU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL))))
                      ? (((0U == (0x1fU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL))))
                           ? 0U : (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[
                                   ((IData)(1U) + (0x3fU 
                                                   & (((IData)(0x174U) 
                                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)) 
                                                      >> 5U)))] 
                                   << ((IData)(0x20U) 
                                       - (0x1fU & ((IData)(0x174U) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)))))) 
                         | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[
                            (0x3fU & (((IData)(0x174U) 
                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)) 
                                      >> 5U))] >> (0x1fU 
                                                   & ((IData)(0x174U) 
                                                      * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)))))
                      : Vtop_core__ConstPool__CONST_h29f43d96_0[0U])));
        vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT____Vlvbound_h9e60dea4__0[1U] 
            = ((vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[1U] 
                & (~ vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[1U])) 
               | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[1U] 
                  & ((0x5cfU >= (0x7ffU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL))))
                      ? (((0U == (0x1fU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL))))
                           ? 0U : (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[
                                   ((IData)(2U) + (0x3fU 
                                                   & (((IData)(0x174U) 
                                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)) 
                                                      >> 5U)))] 
                                   << ((IData)(0x20U) 
                                       - (0x1fU & ((IData)(0x174U) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)))))) 
                         | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[
                            ((IData)(1U) + (0x3fU & 
                                            (((IData)(0x174U) 
                                              * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)) 
                                             >> 5U)))] 
                            >> (0x1fU & ((IData)(0x174U) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)))))
                      : Vtop_core__ConstPool__CONST_h29f43d96_0[1U])));
        vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT____Vlvbound_h9e60dea4__0[2U] 
            = ((vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[2U] 
                & (~ vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[2U])) 
               | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[2U] 
                  & ((0x5cfU >= (0x7ffU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL))))
                      ? (((0U == (0x1fU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL))))
                           ? 0U : (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[
                                   ((IData)(3U) + (0x3fU 
                                                   & (((IData)(0x174U) 
                                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)) 
                                                      >> 5U)))] 
                                   << ((IData)(0x20U) 
                                       - (0x1fU & ((IData)(0x174U) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)))))) 
                         | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[
                            ((IData)(2U) + (0x3fU & 
                                            (((IData)(0x174U) 
                                              * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)) 
                                             >> 5U)))] 
                            >> (0x1fU & ((IData)(0x174U) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)))))
                      : Vtop_core__ConstPool__CONST_h29f43d96_0[2U])));
        vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT____Vlvbound_h9e60dea4__0[3U] 
            = ((vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[3U] 
                & (~ vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[3U])) 
               | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[3U] 
                  & ((0x5cfU >= (0x7ffU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL))))
                      ? (((0U == (0x1fU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL))))
                           ? 0U : (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[
                                   ((IData)(4U) + (0x3fU 
                                                   & (((IData)(0x174U) 
                                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)) 
                                                      >> 5U)))] 
                                   << ((IData)(0x20U) 
                                       - (0x1fU & ((IData)(0x174U) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)))))) 
                         | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[
                            ((IData)(3U) + (0x3fU & 
                                            (((IData)(0x174U) 
                                              * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)) 
                                             >> 5U)))] 
                            >> (0x1fU & ((IData)(0x174U) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)))))
                      : Vtop_core__ConstPool__CONST_h29f43d96_0[3U])));
        vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT____Vlvbound_h9e60dea4__0[4U] 
            = ((vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[4U] 
                & (~ vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[4U])) 
               | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[4U] 
                  & ((0x5cfU >= (0x7ffU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL))))
                      ? (((0U == (0x1fU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL))))
                           ? 0U : (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[
                                   ((IData)(5U) + (0x3fU 
                                                   & (((IData)(0x174U) 
                                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)) 
                                                      >> 5U)))] 
                                   << ((IData)(0x20U) 
                                       - (0x1fU & ((IData)(0x174U) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)))))) 
                         | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[
                            ((IData)(4U) + (0x3fU & 
                                            (((IData)(0x174U) 
                                              * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)) 
                                             >> 5U)))] 
                            >> (0x1fU & ((IData)(0x174U) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)))))
                      : Vtop_core__ConstPool__CONST_h29f43d96_0[4U])));
        vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT____Vlvbound_h9e60dea4__0[5U] 
            = ((vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[5U] 
                & (~ vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[5U])) 
               | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[5U] 
                  & ((0x5cfU >= (0x7ffU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL))))
                      ? (((0U == (0x1fU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL))))
                           ? 0U : (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[
                                   ((IData)(6U) + (0x3fU 
                                                   & (((IData)(0x174U) 
                                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)) 
                                                      >> 5U)))] 
                                   << ((IData)(0x20U) 
                                       - (0x1fU & ((IData)(0x174U) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)))))) 
                         | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[
                            ((IData)(5U) + (0x3fU & 
                                            (((IData)(0x174U) 
                                              * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)) 
                                             >> 5U)))] 
                            >> (0x1fU & ((IData)(0x174U) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)))))
                      : Vtop_core__ConstPool__CONST_h29f43d96_0[5U])));
        vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT____Vlvbound_h9e60dea4__0[6U] 
            = ((vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[6U] 
                & (~ vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[6U])) 
               | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[6U] 
                  & ((0x5cfU >= (0x7ffU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL))))
                      ? (((0U == (0x1fU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL))))
                           ? 0U : (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[
                                   ((IData)(7U) + (0x3fU 
                                                   & (((IData)(0x174U) 
                                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)) 
                                                      >> 5U)))] 
                                   << ((IData)(0x20U) 
                                       - (0x1fU & ((IData)(0x174U) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)))))) 
                         | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[
                            ((IData)(6U) + (0x3fU & 
                                            (((IData)(0x174U) 
                                              * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)) 
                                             >> 5U)))] 
                            >> (0x1fU & ((IData)(0x174U) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)))))
                      : Vtop_core__ConstPool__CONST_h29f43d96_0[6U])));
        vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT____Vlvbound_h9e60dea4__0[7U] 
            = ((vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[7U] 
                & (~ vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[7U])) 
               | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[7U] 
                  & ((0x5cfU >= (0x7ffU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL))))
                      ? (((0U == (0x1fU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL))))
                           ? 0U : (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[
                                   ((IData)(8U) + (0x3fU 
                                                   & (((IData)(0x174U) 
                                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)) 
                                                      >> 5U)))] 
                                   << ((IData)(0x20U) 
                                       - (0x1fU & ((IData)(0x174U) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)))))) 
                         | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[
                            ((IData)(7U) + (0x3fU & 
                                            (((IData)(0x174U) 
                                              * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)) 
                                             >> 5U)))] 
                            >> (0x1fU & ((IData)(0x174U) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)))))
                      : Vtop_core__ConstPool__CONST_h29f43d96_0[7U])));
        vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT____Vlvbound_h9e60dea4__0[8U] 
            = ((vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[8U] 
                & (~ vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[8U])) 
               | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[8U] 
                  & ((0x5cfU >= (0x7ffU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL))))
                      ? (((0U == (0x1fU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL))))
                           ? 0U : (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[
                                   ((IData)(9U) + (0x3fU 
                                                   & (((IData)(0x174U) 
                                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)) 
                                                      >> 5U)))] 
                                   << ((IData)(0x20U) 
                                       - (0x1fU & ((IData)(0x174U) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)))))) 
                         | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[
                            ((IData)(8U) + (0x3fU & 
                                            (((IData)(0x174U) 
                                              * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)) 
                                             >> 5U)))] 
                            >> (0x1fU & ((IData)(0x174U) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)))))
                      : Vtop_core__ConstPool__CONST_h29f43d96_0[8U])));
        vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT____Vlvbound_h9e60dea4__0[9U] 
            = ((vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[9U] 
                & (~ vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[9U])) 
               | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[9U] 
                  & ((0x5cfU >= (0x7ffU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL))))
                      ? (((0U == (0x1fU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL))))
                           ? 0U : (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[
                                   ((IData)(0xaU) + 
                                    (0x3fU & (((IData)(0x174U) 
                                               * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)) 
                                              >> 5U)))] 
                                   << ((IData)(0x20U) 
                                       - (0x1fU & ((IData)(0x174U) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)))))) 
                         | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[
                            ((IData)(9U) + (0x3fU & 
                                            (((IData)(0x174U) 
                                              * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)) 
                                             >> 5U)))] 
                            >> (0x1fU & ((IData)(0x174U) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)))))
                      : Vtop_core__ConstPool__CONST_h29f43d96_0[9U])));
        vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT____Vlvbound_h9e60dea4__0[0xaU] 
            = ((vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[0xaU] 
                & (~ vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[0xaU])) 
               | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[0xaU] 
                  & ((0x5cfU >= (0x7ffU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL))))
                      ? (((0U == (0x1fU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL))))
                           ? 0U : (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[
                                   ((IData)(0xbU) + 
                                    (0x3fU & (((IData)(0x174U) 
                                               * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)) 
                                              >> 5U)))] 
                                   << ((IData)(0x20U) 
                                       - (0x1fU & ((IData)(0x174U) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)))))) 
                         | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[
                            ((IData)(0xaU) + (0x3fU 
                                              & (((IData)(0x174U) 
                                                  * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)) 
                                                 >> 5U)))] 
                            >> (0x1fU & ((IData)(0x174U) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)))))
                      : Vtop_core__ConstPool__CONST_h29f43d96_0[0xaU])));
        vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT____Vlvbound_h9e60dea4__0[0xbU] 
            = ((vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramWrite[0xbU] 
                & (~ vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[0xbU])) 
               | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramMask[0xbU] 
                  & ((0x5cfU >= (0x7ffU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL))))
                      ? (((0U == (0x1fU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL))))
                           ? 0U : (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[
                                   ((IData)(0xcU) + 
                                    (0x3fU & (((IData)(0x174U) 
                                               * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)) 
                                              >> 5U)))] 
                                   << ((IData)(0x20U) 
                                       - (0x1fU & ((IData)(0x174U) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)))))) 
                         | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__sramMemory[
                            ((IData)(0xbU) + (0x3fU 
                                              & (((IData)(0x174U) 
                                                  * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)) 
                                                 >> 5U)))] 
                            >> (0x1fU & ((IData)(0x174U) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL)))))
                      : Vtop_core__ConstPool__CONST_h29f43d96_0[0xbU])));
        if ((0x5cfU >= (0x7ffU & ((IData)(0x174U) * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL))))) {
            VL_ASSIGNSEL_WW(1488,372,(0x7ffU & ((IData)(0x174U) 
                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__sramSEL))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT__n_sramMemory, vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__SRAM__DOT____Vlvbound_h9e60dea4__0);
        }
    }
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_state 
        = vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__state;
    if ((0U == vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__state)) {
        if ((((IData)(vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__ren) 
              & (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit)) 
             & (~ (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__ifence_pulse)))) {
            vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__busy = 0U;
        } else if ((((IData)(vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__wen) 
                     & (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit)) 
                    & (~ (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__ifence_pulse)))) {
            vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__busy = 0U;
        } else if (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__pass_through) {
            vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__busy 
                = vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__busy;
        }
        if ((((((IData)(vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__ren) 
                | (IData)(vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__wen)) 
               & (~ (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit))) 
              & ((0x173U >= (0x1ffU & ((IData)(0x5bU) 
                                       + ((IData)(0x5dU) 
                                          * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))))) 
                 & (vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[
                    (0xfU & (((IData)(0x5bU) + ((IData)(0x5dU) 
                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))) 
                             >> 5U))] >> (0x1fU & ((IData)(0x5bU) 
                                                   + 
                                                   ((IData)(0x5dU) 
                                                    * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))))))) 
             & (~ (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__pass_through)))) {
            vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_state = 2U;
        } else if ((((((IData)(vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__ren) 
                       | (IData)(vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__wen)) 
                      & (~ (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__hit))) 
                     & (~ ((0x173U >= (0x1ffU & ((IData)(0x5bU) 
                                                 + 
                                                 ((IData)(0x5dU) 
                                                  * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))))) 
                           & (vlSelf->CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT____Vcellout__SRAM____pinNumber4[
                              (0xfU & (((IData)(0x5bU) 
                                        + ((IData)(0x5dU) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx))) 
                                       >> 5U))] >> 
                              (0x1fU & ((IData)(0x5bU) 
                                        + ((IData)(0x5dU) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__ridx)))))))) 
                    & (~ (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__pass_through)))) {
            vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_state = 1U;
        }
    } else if ((1U == vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__state)) {
        if ((((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xbU] 
               << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                            >> 1U)) != vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__decoded_req_addr)) {
            vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_state = 0U;
        } else if ((2U == (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__word_num))) {
            vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_state = 0U;
        }
    } else if ((2U == vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__state)) {
        if ((((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xbU] 
               << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                            >> 1U)) != vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__decoded_req_addr)) {
            vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_state = 0U;
        } else if ((2U == (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__word_num))) {
            vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_state = 1U;
        }
    } else if ((3U == vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__state)) {
        if (vlSelf->CORE__DOT__sep_caches__DOT____Vcellout__genblk1__DOT__dcache__flush_done) {
            vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_state = 0U;
        }
    }
    vlSelf->__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__wait_for_dmem 
        = (((IData)((0U != (0xc0000U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU]))) 
            & (IData)(vlSymsp->TOP__top_core__CORE__DOT__tspp_dcache_gen_bus_if.__PVT__busy)) 
           & (~ (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__exception)));
    vlSelf->__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__npc 
        = ((IData)(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__insert_pc)
            ? vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__priv_pc
            : ((1U & ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                       >> 0x10U) & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__fence_stall))))
                ? ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[6U] 
                    << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[5U] 
                                 >> 1U)) : ((IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__branch_jump)
                                             ? ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                 << 0x1fU) 
                                                | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xbU] 
                                                   >> 1U))
                                             : ((IData)(4U) 
                                                + vlSelf->__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc))));
    vlSelf->__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__ex_flush_hazard 
        = (1U & ((((((IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__intr) 
                     | (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__exception)) 
                    & (~ (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__wait_for_dmem))) 
                   | (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__exception)) 
                  | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                     >> 6U)) | ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                 >> 0x10U) & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__fence_stall)))));
    vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__ex_mem_stall 
        = (1U & (((IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__wait_for_dmem) 
                  | (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__fence_stall)) 
                 | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                    >> 0xeU)));
    vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__suppress_iren 
        = (1U & ((((IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__branch_jump) 
                   | (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__ex_flush_hazard)) 
                  | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                     >> 6U)) | (IData)(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__insert_pc)));
    vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__valid_write 
        = ((~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__ex_mem_stall)) 
           & (0U != (0x3800U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])));
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_last_used 
        = vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__last_used;
    vlSymsp->TOP__top_core__CORE__DOT__tspp_icache_gen_bus_if.__PVT__busy = 1U;
    vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__byte_en = 0xfU;
    vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__wen = 0U;
    vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__addr = 0U;
    vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__ren = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[0U] = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[1U] = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[2U] = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[3U] = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[4U] = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[5U] = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[6U] = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[7U] = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[8U] = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[9U] = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[0xaU] = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[0xbU] = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[0U] = 0xffffffffU;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[1U] = 0xffffffffU;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[2U] = 0xffffffffU;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[3U] = 0xffffffffU;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[4U] = 0xffffffffU;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[5U] = 0xffffffffU;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[6U] = 0xffffffffU;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[7U] = 0xffffffffU;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[8U] = 0xffffffffU;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[9U] = 0xffffffffU;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[0xaU] = 0xffffffffU;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[0xbU] = 0xfffffU;
    vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__wdata = 0U;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_read_addr 
        = vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__read_addr;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_decoded_req_addr 
        = vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__decoded_req_addr;
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx 
        = (3U & ((IData)(1U) + (1U & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__last_used) 
                                      >> (1U & (vlSelf->__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc 
                                                >> 3U))))));
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__inject_mcycle = 0U;
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__inject_minstret = 0U;
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__inject_minstreth = 0U;
    vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pmp_if.__PVT__csr_active 
        = (((~ (IData)(vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__invalid_csr_priv)) 
            & (IData)(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__valid_write)) 
           & (IData)(vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__csr_operation));
    vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__if_ex_stall 
        = (((IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__ex_mem_stall) 
            | (((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                 >> 0x11U) & ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                               >> 0x13U) | (IData)(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__valid_write))) 
               & ((((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                              >> 0xfU)) == (0x1fU & 
                                            (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                             >> 0x13U))) 
                   & (0U != (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                      >> 0x13U)))) 
                  | (((0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[2U] 
                                >> 0x14U)) == (0x1fU 
                                               & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                  >> 0x13U))) 
                     & (0U != (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                        >> 0x13U))))))) 
           | (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__fence_stall));
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus;
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mtvec_next 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mtvec;
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie;
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip;
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mscratch_next 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mscratch;
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mepc_next 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mepc;
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mtval_next 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mtval;
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren;
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit;
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcause_next 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcause;
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val 
        = ((0x2000U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])
            ? ((0x400U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])
                ? (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                            >> 0x18U)) : ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                           << 0x1fU) 
                                          | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[9U] 
                                             >> 1U)))
            : ((0x800U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])
                ? (((0x400U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])
                     ? (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                 >> 0x18U)) : ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                << 0x1fU) 
                                               | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[9U] 
                                                  >> 1U))) 
                   | vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__old_csr_val)
                : ((0x1000U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])
                    ? ((~ ((0x400U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])
                            ? (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                        >> 0x18U)) : 
                           ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                             << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[9U] 
                                          >> 1U)))) 
                       & vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__old_csr_val)
                    : ((0x400U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])
                        ? (0x1fU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                    >> 0x18U)) : ((
                                                   vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                   << 0x1fU) 
                                                  | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[9U] 
                                                     >> 1U))))));
    if ((1U & (~ (IData)(((0x1800U == (0x1800U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU])) 
                          & (~ (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                >> 9U))))))) {
        if (((3U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                    >> 9U)) <= (IData)(vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__mode__DOT__curr_priv_level))) {
            if (vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__valid_write) {
                if ((1U & (~ ((((((((0x300U == (0xfffU 
                                                & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                   >> 1U))) 
                                    | (0x305U == (0xfffU 
                                                  & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                     >> 1U)))) 
                                   | (0x304U == (0xfffU 
                                                 & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                    >> 1U)))) 
                                  | (0x344U == (0xfffU 
                                                & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                   >> 1U)))) 
                                 | (0x340U == (0xfffU 
                                               & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                  >> 1U)))) 
                                | (0x341U == (0xfffU 
                                              & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                 >> 1U)))) 
                               | (0x343U == (0xfffU 
                                             & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                >> 1U)))) 
                              | (0x306U == (0xfffU 
                                            & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                               >> 1U))))))) {
                    if ((0x320U != (0xfffU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                              >> 1U)))) {
                        if ((0x342U != (0xfffU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                  >> 1U)))) {
                            if ((0xb00U != (0xfffU 
                                            & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                               >> 1U)))) {
                                if ((0xb02U != (0xfffU 
                                                & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                   >> 1U)))) {
                                    if ((0xb80U == 
                                         (0xfffU & 
                                          (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                           >> 1U)))) {
                                        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__inject_mcycleh = 1U;
                                    }
                                    if ((0xb80U != 
                                         (0xfffU & 
                                          (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                           >> 1U)))) {
                                        if ((0xb82U 
                                             == (0xfffU 
                                                 & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                    >> 1U)))) {
                                            vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__inject_minstreth = 1U;
                                        }
                                    }
                                }
                                if ((0xb02U == (0xfffU 
                                                & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                   >> 1U)))) {
                                    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__inject_minstret = 1U;
                                }
                            }
                            if ((0xb00U == (0xfffU 
                                            & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                               >> 1U)))) {
                                vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__inject_mcycle = 1U;
                            }
                        }
                    }
                }
                if (((((((((0x300U == (0xfffU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                 >> 1U))) 
                           | (0x305U == (0xfffU & (
                                                   vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                   >> 1U)))) 
                          | (0x304U == (0xfffU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                  >> 1U)))) 
                         | (0x344U == (0xfffU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                 >> 1U)))) 
                        | (0x340U == (0xfffU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                >> 1U)))) 
                       | (0x341U == (0xfffU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                               >> 1U)))) 
                      | (0x343U == (0xfffU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                              >> 1U)))) 
                     | (0x306U == (0xfffU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                             >> 1U))))) {
                    if ((0x300U == (0xfffU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                              >> 1U)))) {
                        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                            = ((0xffffe7ffU & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next) 
                               | ((((2U == (3U & ((
                                                   (0x400U 
                                                    & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])
                                                    ? 
                                                   (0x1fU 
                                                    & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                       >> 0x18U))
                                                    : 
                                                   ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                     << 0x1fU) 
                                                    | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[9U] 
                                                       >> 1U))) 
                                                  >> 0xbU))) 
                                    | (1U == (3U & 
                                              (((0x400U 
                                                 & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])
                                                 ? 
                                                (0x1fU 
                                                 & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                    >> 0x18U))
                                                 : 
                                                ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                  << 0x1fU) 
                                                 | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[9U] 
                                                    >> 1U))) 
                                               >> 0xbU))))
                                    ? 0U : (3U & (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val 
                                                  >> 0xbU))) 
                                  << 0xbU));
                        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                            = ((0xfffffff7U & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next) 
                               | (8U & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val));
                        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                            = ((0xffffff7fU & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next) 
                               | (0x80U & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val));
                        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                            = ((0xfffdffffU & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next) 
                               | (0x20000U & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val));
                        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                            = ((0xffdfffffU & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next) 
                               | (0x200000U & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val));
                    } else if ((0x305U == (0xfffU & 
                                           (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                            >> 1U)))) {
                        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mtvec_next 
                            = ((0xfffffffcU & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mtvec_next) 
                               | ((1U < (3U & ((0x400U 
                                                & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU])
                                                ? (0x1fU 
                                                   & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                      >> 0x18U))
                                                : (
                                                   (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                                    << 0x1fU) 
                                                   | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[9U] 
                                                      >> 1U)))))
                                   ? 0U : (3U & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val)));
                        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mtvec_next 
                            = ((3U & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mtvec_next) 
                               | (0xfffffffcU & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val));
                    } else if ((0x304U == (0xfffU & 
                                           (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                            >> 1U)))) {
                        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                            = ((0xfffffff7U & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next) 
                               | (8U & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val));
                        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                            = ((0xffffff7fU & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next) 
                               | (0x80U & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val));
                        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next 
                            = ((0xfffff7ffU & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mie_next) 
                               | (0x800U & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val));
                    } else if ((0x344U == (0xfffU & 
                                           (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                            >> 1U)))) {
                        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                            = ((0xfffffff7U & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next) 
                               | (8U & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val));
                        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                            = ((0xffffff7fU & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next) 
                               | (0x80U & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val));
                        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
                            = ((0xfffff7ffU & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next) 
                               | (0x800U & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val));
                    } else if ((0x340U == (0xfffU & 
                                           (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                            >> 1U)))) {
                        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mscratch_next 
                            = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val;
                    } else if ((0x341U == (0xfffU & 
                                           (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                            >> 1U)))) {
                        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mepc_next 
                            = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val;
                    } else if ((0x343U == (0xfffU & 
                                           (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                            >> 1U)))) {
                        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mtval_next 
                            = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val;
                    } else {
                        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounteren_next 
                            = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val;
                    }
                } else if ((0x320U == (0xfffU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                 >> 1U)))) {
                    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit_next 
                        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val;
                } else if ((0x342U == (0xfffU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                 >> 1U)))) {
                    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcause_next 
                        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val;
                }
            }
        }
    }
    if (((IData)(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__intr) 
         | (IData)(vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__mret))) {
        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
            = vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mstatus;
    }
    if ((1U & ((((((((IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__mal_l) 
                     | (IData)(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__prot_fault_l)) 
                    | (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__mal_s)) 
                   | (IData)(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__prot_fault_s)) 
                  | (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__illegal_insn)) 
                 | (IData)(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__fault_insn)) 
                | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                   >> 0x12U)) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                 >> 8U)))) {
        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mtval_next 
            = ((IData)((0U != (0x60000U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU])))
                ? ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[4U] 
                    << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[3U] 
                                 >> 1U)) : ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xbU] 
                                             << 0x1fU) 
                                            | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xaU] 
                                               >> 1U)));
    }
    if (((IData)(vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__int_ex_handler__DOT__exception) 
         | (IData)(vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__int_ex_handler__DOT__interrupt_fired))) {
        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mepc_next 
            = ((IData)(((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                         >> 0x17U) & (~ (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__intr))))
                ? ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[7U] 
                    << 0x1fU) | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[6U] 
                                 >> 1U)) : ((8U & vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[5U])
                                             ? vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__fetch_ex_if.__PVT__fetch_ex_reg[4U]
                                             : vlSelf->__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc));
        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcause_next 
            = vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mcause;
    }
    if (((IData)(vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__int_ex_handler__DOT__interrupt) 
         | (((IData)(vlSymsp->TOP.timer_int_clear) 
             | (IData)(vlSymsp->TOP.soft_int_clear)) 
            | (IData)(vlSymsp->TOP.ext_int_clear)))) {
        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mip_next 
            = vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__prv_intern_if.__PVT__next_mip;
    }
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
        = ((0x7fffffffU & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next) 
           | ((((3U == (3U & (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                              >> 9U))) | (3U == (3U 
                                                 & (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                                                    >> 0xdU)))) 
               | (3U == (3U & (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mstatus_next 
                               >> 0xfU)))) << 0x1fU));
    if ((0U == vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__state)) {
        if ((((~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__suppress_iren)) 
              & (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__hit)) 
             & (~ (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__ifence_pulse)))) {
            vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_last_used 
                = (((~ ((IData)(1U) << (1U & (vlSelf->__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc 
                                              >> 3U)))) 
                    & (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_last_used)) 
                   | (3U & ((1U & (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__hit_idx)) 
                            << (1U & (vlSelf->__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc 
                                      >> 3U)))));
            vlSymsp->TOP__top_core__CORE__DOT__tspp_icache_gen_bus_if.__PVT__rdata 
                = (IData)((vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__hit_data 
                           >> (0x20U & (vlSelf->__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc 
                                        << 3U))));
            vlSymsp->TOP__top_core__CORE__DOT__tspp_icache_gen_bus_if.__PVT__busy = 0U;
        } else if (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__pass_through) {
            vlSymsp->TOP__top_core__CORE__DOT__tspp_icache_gen_bus_if.__PVT__rdata 
                = vlSymsp->TOP.rdata;
            vlSymsp->TOP__top_core__CORE__DOT__tspp_icache_gen_bus_if.__PVT__busy 
                = vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__busy;
        }
    }
    vlSelf->__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__wait_for_imem 
        = ((IData)(vlSymsp->TOP__top_core__CORE__DOT__tspp_icache_gen_bus_if.__PVT__busy) 
           & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__suppress_iren)));
    if ((0U == vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__state)) {
        if ((1U & (~ (((~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__suppress_iren)) 
                       & (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__hit)) 
                      & (~ (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__ifence_pulse)))))) {
            if (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__pass_through) {
                vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__byte_en = 0xfU;
                vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__wen = 0U;
            }
        }
    } else if ((1U != vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__state)) {
        if ((2U == vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__state)) {
            vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__wen = 1U;
            if ((2U == (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__word_num))) {
                vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__wen = 0U;
            }
        } else if ((3U == vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__state)) {
            if ((((0x173U >= (0x1ffU & ((IData)(0x5cU) 
                                        + ((IData)(0x5dU) 
                                           * (3U & 
                                              ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                               >> 1U)))))) 
                  & (vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[
                     (0xfU & (((IData)(0x5cU) + ((IData)(0x5dU) 
                                                 * 
                                                 (3U 
                                                  & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                     >> 1U)))) 
                              >> 5U))] >> (0x1fU & 
                                           ((IData)(0x5cU) 
                                            + ((IData)(0x5dU) 
                                               * (3U 
                                                  & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                     >> 1U))))))) 
                 & ((0x173U >= (0x1ffU & ((IData)(0x5bU) 
                                          + ((IData)(0x5dU) 
                                             * (3U 
                                                & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                   >> 1U)))))) 
                    & (vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[
                       (0xfU & (((IData)(0x5bU) + ((IData)(0x5dU) 
                                                   * 
                                                   (3U 
                                                    & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                       >> 1U)))) 
                                >> 5U))] >> (0x1fU 
                                             & ((IData)(0x5bU) 
                                                + ((IData)(0x5dU) 
                                                   * 
                                                   (3U 
                                                    & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                       >> 1U))))))))) {
                vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__wen = 1U;
            }
        }
    }
    vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__wen 
        = ((0U != vlSelf->__PVT__CORE__DOT__mc__DOT__current_state) 
           & ((1U == vlSelf->__PVT__CORE__DOT__mc__DOT__current_state)
               ? (IData)(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__wen)
               : ((2U == vlSelf->__PVT__CORE__DOT__mc__DOT__current_state)
                   ? (IData)(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__wen)
                   : ((3U != vlSelf->__PVT__CORE__DOT__mc__DOT__current_state) 
                      & ((4U == vlSelf->__PVT__CORE__DOT__mc__DOT__current_state)
                          ? (IData)(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__wen)
                          : ((5U == vlSelf->__PVT__CORE__DOT__mc__DOT__current_state) 
                             & (IData)(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__wen)))))));
    if ((0U == vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__state)) {
        if ((1U & (~ (((~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__suppress_iren)) 
                       & (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__hit)) 
                      & (~ (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__ifence_pulse)))))) {
            if (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__pass_through) {
                vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__addr 
                    = vlSelf->__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc;
                vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__ren 
                    = (1U & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__suppress_iren)));
            }
        }
    } else if ((1U == vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__state)) {
        vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__addr 
            = vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__read_addr;
        vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__ren = 1U;
        if ((2U == (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__word_num))) {
            vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__ren = 0U;
        }
    } else if ((2U == vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__state)) {
        vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__addr 
            = vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__read_addr;
    } else if ((3U == vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__state)) {
        if ((((0x173U >= (0x1ffU & ((IData)(0x5cU) 
                                    + ((IData)(0x5dU) 
                                       * (3U & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                >> 1U)))))) 
              & (vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[
                 (0xfU & (((IData)(0x5cU) + ((IData)(0x5dU) 
                                             * (3U 
                                                & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                   >> 1U)))) 
                          >> 5U))] >> (0x1fU & ((IData)(0x5cU) 
                                                + ((IData)(0x5dU) 
                                                   * 
                                                   (3U 
                                                    & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                       >> 1U))))))) 
             & ((0x173U >= (0x1ffU & ((IData)(0x5bU) 
                                      + ((IData)(0x5dU) 
                                         * (3U & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                  >> 1U)))))) 
                & (vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[
                   (0xfU & (((IData)(0x5bU) + ((IData)(0x5dU) 
                                               * (3U 
                                                  & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                     >> 1U)))) 
                            >> 5U))] >> (0x1fU & ((IData)(0x5bU) 
                                                  + 
                                                  ((IData)(0x5dU) 
                                                   * 
                                                   (3U 
                                                    & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                       >> 1U))))))))) {
            vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__addr 
                = ((((0x173U >= (0x1ffU & ((IData)(0x40U) 
                                           + ((IData)(0x5dU) 
                                              * (3U 
                                                 & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                    >> 1U))))))
                      ? (0x7ffffffU & (((0U == (0x1fU 
                                                & ((IData)(0x40U) 
                                                   + 
                                                   ((IData)(0x5dU) 
                                                    * 
                                                    (3U 
                                                     & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                        >> 1U))))))
                                         ? 0U : (vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[
                                                 (((IData)(0x1aU) 
                                                   + 
                                                   (0x1ffU 
                                                    & ((IData)(0x40U) 
                                                       + 
                                                       ((IData)(0x5dU) 
                                                        * 
                                                        (3U 
                                                         & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                            >> 1U)))))) 
                                                  >> 5U)] 
                                                 << 
                                                 ((IData)(0x20U) 
                                                  - 
                                                  (0x1fU 
                                                   & ((IData)(0x40U) 
                                                      + 
                                                      ((IData)(0x5dU) 
                                                       * 
                                                       (3U 
                                                        & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                           >> 1U)))))))) 
                                       | (vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[
                                          (0xfU & (
                                                   ((IData)(0x40U) 
                                                    + 
                                                    ((IData)(0x5dU) 
                                                     * 
                                                     (3U 
                                                      & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                         >> 1U)))) 
                                                   >> 5U))] 
                                          >> (0x1fU 
                                              & ((IData)(0x40U) 
                                                 + 
                                                 ((IData)(0x5dU) 
                                                  * 
                                                  (3U 
                                                   & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                      >> 1U))))))))
                      : 0U) << 5U) | ((0x18U & (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx)) 
                                      | (4U & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                               << 2U))));
        }
    }
    vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__ren 
        = ((0U != vlSelf->__PVT__CORE__DOT__mc__DOT__current_state) 
           & ((1U == vlSelf->__PVT__CORE__DOT__mc__DOT__current_state)
               ? (IData)(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__ren)
               : ((2U == vlSelf->__PVT__CORE__DOT__mc__DOT__current_state)
                   ? (IData)(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__ren)
                   : ((3U != vlSelf->__PVT__CORE__DOT__mc__DOT__current_state) 
                      & ((4U == vlSelf->__PVT__CORE__DOT__mc__DOT__current_state)
                          ? (IData)(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__ren)
                          : ((5U == vlSelf->__PVT__CORE__DOT__mc__DOT__current_state) 
                             & (IData)(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__ren)))))));
    if ((0U == vlSelf->__PVT__CORE__DOT__mc__DOT__current_state)) {
        vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__byte_en 
            = vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__byte_en;
        vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__addr = 0U;
        vlSelf->__PVT__CORE__DOT__mc__DOT__next_state 
            = (((IData)(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__ren) 
                | (IData)(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__wen))
                ? 4U : ((IData)(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__ren)
                         ? 1U : 0U));
    } else if ((1U == vlSelf->__PVT__CORE__DOT__mc__DOT__current_state)) {
        vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__byte_en 
            = vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__byte_en;
        vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__addr 
            = vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__addr;
        vlSelf->__PVT__CORE__DOT__mc__DOT__next_state 
            = ((IData)(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__ren)
                ? (((IData)(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__ren) 
                    | (IData)(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__wen))
                    ? 2U : 3U) : 0U);
    } else if ((2U == vlSelf->__PVT__CORE__DOT__mc__DOT__current_state)) {
        vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__byte_en 
            = vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__byte_en;
        vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__addr 
            = vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__addr;
        vlSelf->__PVT__CORE__DOT__mc__DOT__next_state 
            = ((IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__busy)
                ? 2U : 6U);
    } else {
        if ((3U == vlSelf->__PVT__CORE__DOT__mc__DOT__current_state)) {
            vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__byte_en 
                = vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__byte_en;
            vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__addr = 0U;
        } else {
            vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__byte_en 
                = vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__byte_en;
            vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__addr 
                = ((4U == vlSelf->__PVT__CORE__DOT__mc__DOT__current_state)
                    ? vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__addr
                    : ((5U == vlSelf->__PVT__CORE__DOT__mc__DOT__current_state)
                        ? vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__addr
                        : 0U));
        }
        vlSelf->__PVT__CORE__DOT__mc__DOT__next_state 
            = ((4U == vlSelf->__PVT__CORE__DOT__mc__DOT__current_state)
                ? ((IData)(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__ren)
                    ? 5U : 6U) : ((5U == vlSelf->__PVT__CORE__DOT__mc__DOT__current_state)
                                   ? ((1U & ((~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__ren)) 
                                             & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__busy))))
                                       ? 0U : ((IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__busy)
                                                ? 5U
                                                : 3U))
                                   : ((3U == vlSelf->__PVT__CORE__DOT__mc__DOT__current_state)
                                       ? ((IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__busy)
                                           ? (((IData)(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__ren) 
                                               | (IData)(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__wen))
                                               ? 2U
                                               : ((IData)(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__ren)
                                                   ? 3U
                                                   : 0U))
                                           : (((IData)(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__ren) 
                                               | (IData)(vlSymsp->TOP__top_core__CORE__DOT__dcache_mc_if.__PVT__wen))
                                               ? 4U
                                               : 0U))
                                       : ((6U == vlSelf->__PVT__CORE__DOT__mc__DOT__current_state)
                                           ? ((IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline_trans_if.__PVT__busy)
                                               ? ((IData)(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__ren)
                                                   ? 5U
                                                   : 6U)
                                               : ((IData)(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__ren)
                                                   ? 1U
                                                   : 0U))
                                           : 0U))));
    }
    __Vilp = 0U;
    while ((__Vilp <= 0x2eU)) {
        vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory[__Vilp] 
            = vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[__Vilp];
        __Vilp = ((IData)(1U) + __Vilp);
    }
    if ((0U == vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__state)) {
        vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_read_addr 
            = vlSelf->__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc;
        if ((1U & (~ (((~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__suppress_iren)) 
                       & (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__hit)) 
                      & (~ (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__ifence_pulse)))))) {
            if ((1U & (~ (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__pass_through)))) {
                if ((1U & ((((~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__suppress_iren)) 
                             & (~ (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__hit))) 
                            & (~ ((0x173U >= (0x1ffU 
                                              & ((IData)(0x5bU) 
                                                 + 
                                                 ((IData)(0x5dU) 
                                                  * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))))) 
                                  & (vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[
                                     (0xfU & (((IData)(0x5bU) 
                                               + ((IData)(0x5dU) 
                                                  * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))) 
                                              >> 5U))] 
                                     >> (0x1fU & ((IData)(0x5bU) 
                                                  + 
                                                  ((IData)(0x5dU) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx)))))))) 
                           & (~ (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__pass_through))))) {
                    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_decoded_req_addr 
                        = vlSelf->__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc;
                    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_read_addr 
                        = (0xfffffff8U & vlSelf->__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc);
                } else if (((((~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__suppress_iren)) 
                              & (~ (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__hit))) 
                             & ((0x173U >= (0x1ffU 
                                            & ((IData)(0x5bU) 
                                               + ((IData)(0x5dU) 
                                                  * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))))) 
                                & (vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[
                                   (0xfU & (((IData)(0x5bU) 
                                             + ((IData)(0x5dU) 
                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))) 
                                            >> 5U))] 
                                   >> (0x1fU & ((IData)(0x5bU) 
                                                + ((IData)(0x5dU) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))))))) 
                            & (~ (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__pass_through)))) {
                    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_decoded_req_addr 
                        = vlSelf->__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc;
                    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_read_addr 
                        = ((((0x173U >= (0x1ffU & ((IData)(0x40U) 
                                                   + 
                                                   ((IData)(0x5dU) 
                                                    * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx)))))
                              ? (0x7ffffffU & (((0U 
                                                 == 
                                                 (0x1fU 
                                                  & ((IData)(0x40U) 
                                                     + 
                                                     ((IData)(0x5dU) 
                                                      * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx)))))
                                                 ? 0U
                                                 : 
                                                (vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[
                                                 (((IData)(0x1aU) 
                                                   + 
                                                   (0x1ffU 
                                                    & ((IData)(0x40U) 
                                                       + 
                                                       ((IData)(0x5dU) 
                                                        * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))))) 
                                                  >> 5U)] 
                                                 << 
                                                 ((IData)(0x20U) 
                                                  - 
                                                  (0x1fU 
                                                   & ((IData)(0x40U) 
                                                      + 
                                                      ((IData)(0x5dU) 
                                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))))))) 
                                               | (vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[
                                                  (0xfU 
                                                   & (((IData)(0x40U) 
                                                       + 
                                                       ((IData)(0x5dU) 
                                                        * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))) 
                                                      >> 5U))] 
                                                  >> 
                                                  (0x1fU 
                                                   & ((IData)(0x40U) 
                                                      + 
                                                      ((IData)(0x5dU) 
                                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx)))))))
                              : 0U) << 5U) | (0x18U 
                                              & vlSelf->__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc));
                }
            }
        }
    } else if ((1U == vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__state)) {
        vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_h325132d4__0 = 0U;
        vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_hbf233a89__0 = 0U;
        if ((0x173U >= (0x1ffU & ((IData)(0x5cU) + 
                                  ((IData)(0x5dU) * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx)))))) {
            vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[(0xfU 
                                                                                & (((IData)(0x5cU) 
                                                                                + 
                                                                                ((IData)(0x5dU) 
                                                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))) 
                                                                                >> 5U))] 
                = (((~ ((IData)(1U) << (0x1fU & ((IData)(0x5cU) 
                                                 + 
                                                 ((IData)(0x5dU) 
                                                  * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx)))))) 
                    & vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[
                    (0xfU & (((IData)(0x5cU) + ((IData)(0x5dU) 
                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))) 
                             >> 5U))]) | ((IData)(vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_h325132d4__0) 
                                          << (0x1fU 
                                              & ((IData)(0x5cU) 
                                                 + 
                                                 ((IData)(0x5dU) 
                                                  * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))))));
            vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[(0xfU 
                                                                                & (((IData)(0x5cU) 
                                                                                + 
                                                                                ((IData)(0x5dU) 
                                                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))) 
                                                                                >> 5U))] 
                = (((~ ((IData)(1U) << (0x1fU & ((IData)(0x5cU) 
                                                 + 
                                                 ((IData)(0x5dU) 
                                                  * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx)))))) 
                    & vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[
                    (0xfU & (((IData)(0x5cU) + ((IData)(0x5dU) 
                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))) 
                             >> 5U))]) | ((IData)(vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_hbf233a89__0) 
                                          << (0x1fU 
                                              & ((IData)(0x5cU) 
                                                 + 
                                                 ((IData)(0x5dU) 
                                                  * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))))));
        }
        if ((2U == (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__word_num))) {
            vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_hbf233a89__1 = 1U;
            vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_h003574db__0 
                = (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__decoded_req_addr 
                   >> 5U);
            if ((0x173U >= (0x1ffU & ((IData)(0x5cU) 
                                      + ((IData)(0x5dU) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx)))))) {
                vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[(0xfU 
                                                                                & (((IData)(0x5cU) 
                                                                                + 
                                                                                ((IData)(0x5dU) 
                                                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))) 
                                                                                >> 5U))] 
                    = (((~ ((IData)(1U) << (0x1fU & 
                                            ((IData)(0x5cU) 
                                             + ((IData)(0x5dU) 
                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx)))))) 
                        & vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[
                        (0xfU & (((IData)(0x5cU) + 
                                  ((IData)(0x5dU) * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))) 
                                 >> 5U))]) | ((IData)(vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_hbf233a89__1) 
                                              << (0x1fU 
                                                  & ((IData)(0x5cU) 
                                                     + 
                                                     ((IData)(0x5dU) 
                                                      * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))))));
                vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_h325132d4__1 = 0U;
                vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[(0xfU 
                                                                                & (((IData)(0x5cU) 
                                                                                + 
                                                                                ((IData)(0x5dU) 
                                                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))) 
                                                                                >> 5U))] 
                    = (((~ ((IData)(1U) << (0x1fU & 
                                            ((IData)(0x5cU) 
                                             + ((IData)(0x5dU) 
                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx)))))) 
                        & vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[
                        (0xfU & (((IData)(0x5cU) + 
                                  ((IData)(0x5dU) * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))) 
                                 >> 5U))]) | ((IData)(vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_h325132d4__1) 
                                              << (0x1fU 
                                                  & ((IData)(0x5cU) 
                                                     + 
                                                     ((IData)(0x5dU) 
                                                      * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))))));
            } else {
                vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_h325132d4__1 = 0U;
            }
            vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_h7d1a0219__0 = 0U;
            if ((0x173U >= (0x1ffU & ((IData)(0x40U) 
                                      + ((IData)(0x5dU) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx)))))) {
                VL_ASSIGNSEL_WI(372,27,(0x1ffU & ((IData)(0x40U) 
                                                  + 
                                                  ((IData)(0x5dU) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite, vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_h003574db__0);
                VL_ASSIGNSEL_WI(372,27,(0x1ffU & ((IData)(0x40U) 
                                                  + 
                                                  ((IData)(0x5dU) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask, vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_h7d1a0219__0);
            }
        }
        if (((~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__busy)) 
             & (2U != (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__word_num)))) {
            vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_hb7f2d31d__0 
                = vlSymsp->TOP.rdata;
            vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_read_addr 
                = ((IData)(4U) + vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__read_addr);
            vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_he3f90764__0 = 0U;
            if ((0x173U >= (0x1ffU & (((IData)(0x5dU) 
                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx)) 
                                      + (0x3fU & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__word_num) 
                                                  << 5U)))))) {
                VL_ASSIGNSEL_WI(372,32,(0x1ffU & (((IData)(0x5dU) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx)) 
                                                  + 
                                                  (0x3fU 
                                                   & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__word_num) 
                                                      << 5U)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite, vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_hb7f2d31d__0);
                VL_ASSIGNSEL_WI(372,32,(0x1ffU & (((IData)(0x5dU) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx)) 
                                                  + 
                                                  (0x3fU 
                                                   & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__word_num) 
                                                      << 5U)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask, vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_he3f90764__0);
            }
        }
    } else if ((2U == vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__state)) {
        vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__wdata 
            = ((0x173U >= (0x1ffU & (((IData)(0x5dU) 
                                      * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx)) 
                                     + (0x3fU & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__word_num) 
                                                 << 5U)))))
                ? (((0U == (0x1fU & (((IData)(0x5dU) 
                                      * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx)) 
                                     + (0x3fU & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__word_num) 
                                                 << 5U)))))
                     ? 0U : (vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[
                             (((IData)(0x1fU) + (0x1ffU 
                                                 & (((IData)(0x5dU) 
                                                     * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx)) 
                                                    + 
                                                    (0x3fU 
                                                     & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__word_num) 
                                                        << 5U))))) 
                              >> 5U)] << ((IData)(0x20U) 
                                          - (0x1fU 
                                             & (((IData)(0x5dU) 
                                                 * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx)) 
                                                + (0x3fU 
                                                   & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__word_num) 
                                                      << 5U))))))) 
                   | (vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[
                      (0xfU & ((((IData)(0x5dU) * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx)) 
                                + (0x3fU & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__word_num) 
                                            << 5U))) 
                               >> 5U))] >> (0x1fU & 
                                            (((IData)(0x5dU) 
                                              * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx)) 
                                             + (0x3fU 
                                                & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__word_num) 
                                                   << 5U))))))
                : 0U);
        if (((~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__busy)) 
             & (2U != (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__word_num)))) {
            vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_read_addr 
                = ((IData)(4U) + vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__read_addr);
        }
        if ((2U == (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__word_num))) {
            vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_hbe55c246__0 = 0U;
            vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_h325527b6__0 = 0U;
            if ((0x173U >= (0x1ffU & ((IData)(0x5bU) 
                                      + ((IData)(0x5dU) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx)))))) {
                vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[(0xfU 
                                                                                & (((IData)(0x5bU) 
                                                                                + 
                                                                                ((IData)(0x5dU) 
                                                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))) 
                                                                                >> 5U))] 
                    = (((~ ((IData)(1U) << (0x1fU & 
                                            ((IData)(0x5bU) 
                                             + ((IData)(0x5dU) 
                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx)))))) 
                        & vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[
                        (0xfU & (((IData)(0x5bU) + 
                                  ((IData)(0x5dU) * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))) 
                                 >> 5U))]) | ((IData)(vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_hbe55c246__0) 
                                              << (0x1fU 
                                                  & ((IData)(0x5bU) 
                                                     + 
                                                     ((IData)(0x5dU) 
                                                      * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))))));
                vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[(0xfU 
                                                                                & (((IData)(0x5bU) 
                                                                                + 
                                                                                ((IData)(0x5dU) 
                                                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))) 
                                                                                >> 5U))] 
                    = (((~ ((IData)(1U) << (0x1fU & 
                                            ((IData)(0x5bU) 
                                             + ((IData)(0x5dU) 
                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx)))))) 
                        & vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[
                        (0xfU & (((IData)(0x5bU) + 
                                  ((IData)(0x5dU) * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))) 
                                 >> 5U))]) | ((IData)(vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_h325527b6__0) 
                                              << (0x1fU 
                                                  & ((IData)(0x5bU) 
                                                     + 
                                                     ((IData)(0x5dU) 
                                                      * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))))));
            }
        }
    } else if ((3U == vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__state)) {
        if ((((0x173U >= (0x1ffU & ((IData)(0x5cU) 
                                    + ((IData)(0x5dU) 
                                       * (3U & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                >> 1U)))))) 
              & (vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[
                 (0xfU & (((IData)(0x5cU) + ((IData)(0x5dU) 
                                             * (3U 
                                                & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                   >> 1U)))) 
                          >> 5U))] >> (0x1fU & ((IData)(0x5cU) 
                                                + ((IData)(0x5dU) 
                                                   * 
                                                   (3U 
                                                    & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                       >> 1U))))))) 
             & ((0x173U >= (0x1ffU & ((IData)(0x5bU) 
                                      + ((IData)(0x5dU) 
                                         * (3U & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                  >> 1U)))))) 
                & (vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[
                   (0xfU & (((IData)(0x5bU) + ((IData)(0x5dU) 
                                               * (3U 
                                                  & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                     >> 1U)))) 
                            >> 5U))] >> (0x1fU & ((IData)(0x5bU) 
                                                  + 
                                                  ((IData)(0x5dU) 
                                                   * 
                                                   (3U 
                                                    & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                       >> 1U))))))))) {
            vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__wdata 
                = ((0x173U >= (0x1ffU & (((IData)(0x5dU) 
                                          * (3U & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                   >> 1U))) 
                                         + (0x20U & 
                                            ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                             << 5U)))))
                    ? (((0U == (0x1fU & (((IData)(0x5dU) 
                                          * (3U & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                   >> 1U))) 
                                         + (0x20U & 
                                            ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                             << 5U)))))
                         ? 0U : (vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[
                                 (((IData)(0x1fU) + 
                                   (0x1ffU & (((IData)(0x5dU) 
                                               * (3U 
                                                  & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                     >> 1U))) 
                                              + (0x20U 
                                                 & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                    << 5U))))) 
                                  >> 5U)] << ((IData)(0x20U) 
                                              - (0x1fU 
                                                 & (((IData)(0x5dU) 
                                                     * 
                                                     (3U 
                                                      & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                         >> 1U))) 
                                                    + 
                                                    (0x20U 
                                                     & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                        << 5U))))))) 
                       | (vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[
                          (0xfU & ((((IData)(0x5dU) 
                                     * (3U & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                              >> 1U))) 
                                    + (0x20U & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                << 5U))) 
                                   >> 5U))] >> (0x1fU 
                                                & (((IData)(0x5dU) 
                                                    * 
                                                    (3U 
                                                     & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                        >> 1U))) 
                                                   + 
                                                   (0x20U 
                                                    & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                       << 5U))))))
                    : 0U);
            if ((1U & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__icache_mc_if.__PVT__busy)))) {
                if ((1U & (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx))) {
                    vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_h0f1df81b__0[0U] = 0U;
                    vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_h0f1df81b__0[1U] = 0U;
                    vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_h0f1df81b__0[2U] = 0U;
                    vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_h1ee545ae__0[0U] = 0U;
                    vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_h1ee545ae__0[1U] = 0U;
                    vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_h1ee545ae__0[2U] = 0U;
                    if ((0x173U >= (0x1ffU & ((IData)(0x5dU) 
                                              * (3U 
                                                 & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                    >> 1U)))))) {
                        VL_ASSIGNSEL_WW(372,93,(0x1ffU 
                                                & ((IData)(0x5dU) 
                                                   * 
                                                   (3U 
                                                    & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                       >> 1U)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite, vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_h0f1df81b__0);
                        VL_ASSIGNSEL_WW(372,93,(0x1ffU 
                                                & ((IData)(0x5dU) 
                                                   * 
                                                   (3U 
                                                    & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                       >> 1U)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask, vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_h1ee545ae__0);
                    }
                }
            }
        } else {
            vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_h0f1df81b__1[0U] = 0U;
            vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_h0f1df81b__1[1U] = 0U;
            vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_h0f1df81b__1[2U] = 0U;
            vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_h1ee545ae__1[0U] = 0U;
            vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_h1ee545ae__1[1U] = 0U;
            vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_h1ee545ae__1[2U] = 0U;
            if ((0x173U >= (0x1ffU & ((IData)(0x5dU) 
                                      * (3U & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                               >> 1U)))))) {
                VL_ASSIGNSEL_WW(372,93,(0x1ffU & ((IData)(0x5dU) 
                                                  * 
                                                  (3U 
                                                   & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                      >> 1U)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite, vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_h0f1df81b__1);
                VL_ASSIGNSEL_WW(372,93,(0x1ffU & ((IData)(0x5dU) 
                                                  * 
                                                  (3U 
                                                   & ((IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__flush_idx) 
                                                      >> 1U)))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask, vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vlvbound_h1ee545ae__1);
            }
        }
    }
    if (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWEN) {
        vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT____Vlvbound_h9e60dea4__0[0U] 
            = ((vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[0U] 
                & (~ vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[0U])) 
               | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[0U] 
                  & ((0x5cfU >= (0x7ffU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL))))
                      ? (((0U == (0x1fU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL))))
                           ? 0U : (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[
                                   ((IData)(1U) + (0x3fU 
                                                   & (((IData)(0x174U) 
                                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)) 
                                                      >> 5U)))] 
                                   << ((IData)(0x20U) 
                                       - (0x1fU & ((IData)(0x174U) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)))))) 
                         | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[
                            (0x3fU & (((IData)(0x174U) 
                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)) 
                                      >> 5U))] >> (0x1fU 
                                                   & ((IData)(0x174U) 
                                                      * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)))))
                      : Vtop_core__ConstPool__CONST_h29f43d96_0[0U])));
        vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT____Vlvbound_h9e60dea4__0[1U] 
            = ((vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[1U] 
                & (~ vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[1U])) 
               | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[1U] 
                  & ((0x5cfU >= (0x7ffU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL))))
                      ? (((0U == (0x1fU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL))))
                           ? 0U : (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[
                                   ((IData)(2U) + (0x3fU 
                                                   & (((IData)(0x174U) 
                                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)) 
                                                      >> 5U)))] 
                                   << ((IData)(0x20U) 
                                       - (0x1fU & ((IData)(0x174U) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)))))) 
                         | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[
                            ((IData)(1U) + (0x3fU & 
                                            (((IData)(0x174U) 
                                              * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)) 
                                             >> 5U)))] 
                            >> (0x1fU & ((IData)(0x174U) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)))))
                      : Vtop_core__ConstPool__CONST_h29f43d96_0[1U])));
        vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT____Vlvbound_h9e60dea4__0[2U] 
            = ((vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[2U] 
                & (~ vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[2U])) 
               | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[2U] 
                  & ((0x5cfU >= (0x7ffU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL))))
                      ? (((0U == (0x1fU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL))))
                           ? 0U : (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[
                                   ((IData)(3U) + (0x3fU 
                                                   & (((IData)(0x174U) 
                                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)) 
                                                      >> 5U)))] 
                                   << ((IData)(0x20U) 
                                       - (0x1fU & ((IData)(0x174U) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)))))) 
                         | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[
                            ((IData)(2U) + (0x3fU & 
                                            (((IData)(0x174U) 
                                              * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)) 
                                             >> 5U)))] 
                            >> (0x1fU & ((IData)(0x174U) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)))))
                      : Vtop_core__ConstPool__CONST_h29f43d96_0[2U])));
        vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT____Vlvbound_h9e60dea4__0[3U] 
            = ((vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[3U] 
                & (~ vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[3U])) 
               | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[3U] 
                  & ((0x5cfU >= (0x7ffU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL))))
                      ? (((0U == (0x1fU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL))))
                           ? 0U : (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[
                                   ((IData)(4U) + (0x3fU 
                                                   & (((IData)(0x174U) 
                                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)) 
                                                      >> 5U)))] 
                                   << ((IData)(0x20U) 
                                       - (0x1fU & ((IData)(0x174U) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)))))) 
                         | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[
                            ((IData)(3U) + (0x3fU & 
                                            (((IData)(0x174U) 
                                              * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)) 
                                             >> 5U)))] 
                            >> (0x1fU & ((IData)(0x174U) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)))))
                      : Vtop_core__ConstPool__CONST_h29f43d96_0[3U])));
        vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT____Vlvbound_h9e60dea4__0[4U] 
            = ((vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[4U] 
                & (~ vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[4U])) 
               | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[4U] 
                  & ((0x5cfU >= (0x7ffU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL))))
                      ? (((0U == (0x1fU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL))))
                           ? 0U : (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[
                                   ((IData)(5U) + (0x3fU 
                                                   & (((IData)(0x174U) 
                                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)) 
                                                      >> 5U)))] 
                                   << ((IData)(0x20U) 
                                       - (0x1fU & ((IData)(0x174U) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)))))) 
                         | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[
                            ((IData)(4U) + (0x3fU & 
                                            (((IData)(0x174U) 
                                              * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)) 
                                             >> 5U)))] 
                            >> (0x1fU & ((IData)(0x174U) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)))))
                      : Vtop_core__ConstPool__CONST_h29f43d96_0[4U])));
        vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT____Vlvbound_h9e60dea4__0[5U] 
            = ((vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[5U] 
                & (~ vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[5U])) 
               | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[5U] 
                  & ((0x5cfU >= (0x7ffU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL))))
                      ? (((0U == (0x1fU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL))))
                           ? 0U : (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[
                                   ((IData)(6U) + (0x3fU 
                                                   & (((IData)(0x174U) 
                                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)) 
                                                      >> 5U)))] 
                                   << ((IData)(0x20U) 
                                       - (0x1fU & ((IData)(0x174U) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)))))) 
                         | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[
                            ((IData)(5U) + (0x3fU & 
                                            (((IData)(0x174U) 
                                              * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)) 
                                             >> 5U)))] 
                            >> (0x1fU & ((IData)(0x174U) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)))))
                      : Vtop_core__ConstPool__CONST_h29f43d96_0[5U])));
        vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT____Vlvbound_h9e60dea4__0[6U] 
            = ((vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[6U] 
                & (~ vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[6U])) 
               | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[6U] 
                  & ((0x5cfU >= (0x7ffU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL))))
                      ? (((0U == (0x1fU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL))))
                           ? 0U : (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[
                                   ((IData)(7U) + (0x3fU 
                                                   & (((IData)(0x174U) 
                                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)) 
                                                      >> 5U)))] 
                                   << ((IData)(0x20U) 
                                       - (0x1fU & ((IData)(0x174U) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)))))) 
                         | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[
                            ((IData)(6U) + (0x3fU & 
                                            (((IData)(0x174U) 
                                              * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)) 
                                             >> 5U)))] 
                            >> (0x1fU & ((IData)(0x174U) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)))))
                      : Vtop_core__ConstPool__CONST_h29f43d96_0[6U])));
        vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT____Vlvbound_h9e60dea4__0[7U] 
            = ((vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[7U] 
                & (~ vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[7U])) 
               | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[7U] 
                  & ((0x5cfU >= (0x7ffU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL))))
                      ? (((0U == (0x1fU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL))))
                           ? 0U : (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[
                                   ((IData)(8U) + (0x3fU 
                                                   & (((IData)(0x174U) 
                                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)) 
                                                      >> 5U)))] 
                                   << ((IData)(0x20U) 
                                       - (0x1fU & ((IData)(0x174U) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)))))) 
                         | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[
                            ((IData)(7U) + (0x3fU & 
                                            (((IData)(0x174U) 
                                              * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)) 
                                             >> 5U)))] 
                            >> (0x1fU & ((IData)(0x174U) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)))))
                      : Vtop_core__ConstPool__CONST_h29f43d96_0[7U])));
        vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT____Vlvbound_h9e60dea4__0[8U] 
            = ((vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[8U] 
                & (~ vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[8U])) 
               | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[8U] 
                  & ((0x5cfU >= (0x7ffU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL))))
                      ? (((0U == (0x1fU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL))))
                           ? 0U : (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[
                                   ((IData)(9U) + (0x3fU 
                                                   & (((IData)(0x174U) 
                                                       * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)) 
                                                      >> 5U)))] 
                                   << ((IData)(0x20U) 
                                       - (0x1fU & ((IData)(0x174U) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)))))) 
                         | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[
                            ((IData)(8U) + (0x3fU & 
                                            (((IData)(0x174U) 
                                              * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)) 
                                             >> 5U)))] 
                            >> (0x1fU & ((IData)(0x174U) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)))))
                      : Vtop_core__ConstPool__CONST_h29f43d96_0[8U])));
        vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT____Vlvbound_h9e60dea4__0[9U] 
            = ((vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[9U] 
                & (~ vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[9U])) 
               | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[9U] 
                  & ((0x5cfU >= (0x7ffU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL))))
                      ? (((0U == (0x1fU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL))))
                           ? 0U : (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[
                                   ((IData)(0xaU) + 
                                    (0x3fU & (((IData)(0x174U) 
                                               * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)) 
                                              >> 5U)))] 
                                   << ((IData)(0x20U) 
                                       - (0x1fU & ((IData)(0x174U) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)))))) 
                         | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[
                            ((IData)(9U) + (0x3fU & 
                                            (((IData)(0x174U) 
                                              * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)) 
                                             >> 5U)))] 
                            >> (0x1fU & ((IData)(0x174U) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)))))
                      : Vtop_core__ConstPool__CONST_h29f43d96_0[9U])));
        vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT____Vlvbound_h9e60dea4__0[0xaU] 
            = ((vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[0xaU] 
                & (~ vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[0xaU])) 
               | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[0xaU] 
                  & ((0x5cfU >= (0x7ffU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL))))
                      ? (((0U == (0x1fU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL))))
                           ? 0U : (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[
                                   ((IData)(0xbU) + 
                                    (0x3fU & (((IData)(0x174U) 
                                               * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)) 
                                              >> 5U)))] 
                                   << ((IData)(0x20U) 
                                       - (0x1fU & ((IData)(0x174U) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)))))) 
                         | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[
                            ((IData)(0xaU) + (0x3fU 
                                              & (((IData)(0x174U) 
                                                  * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)) 
                                                 >> 5U)))] 
                            >> (0x1fU & ((IData)(0x174U) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)))))
                      : Vtop_core__ConstPool__CONST_h29f43d96_0[0xaU])));
        vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT____Vlvbound_h9e60dea4__0[0xbU] 
            = ((vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramWrite[0xbU] 
                & (~ vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[0xbU])) 
               | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramMask[0xbU] 
                  & ((0x5cfU >= (0x7ffU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL))))
                      ? (((0U == (0x1fU & ((IData)(0x174U) 
                                           * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL))))
                           ? 0U : (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[
                                   ((IData)(0xcU) + 
                                    (0x3fU & (((IData)(0x174U) 
                                               * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)) 
                                              >> 5U)))] 
                                   << ((IData)(0x20U) 
                                       - (0x1fU & ((IData)(0x174U) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)))))) 
                         | (vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__sramMemory[
                            ((IData)(0xbU) + (0x3fU 
                                              & (((IData)(0x174U) 
                                                  * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)) 
                                                 >> 5U)))] 
                            >> (0x1fU & ((IData)(0x174U) 
                                         * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL)))))
                      : Vtop_core__ConstPool__CONST_h29f43d96_0[0xbU])));
        if ((0x5cfU >= (0x7ffU & ((IData)(0x174U) * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL))))) {
            VL_ASSIGNSEL_WW(1488,372,(0x7ffU & ((IData)(0x174U) 
                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__sramSEL))), vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT__n_sramMemory, vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__SRAM__DOT____Vlvbound_h9e60dea4__0);
        }
    }
    vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_state 
        = vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__state;
    if ((0U == vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__state)) {
        if (((((~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__suppress_iren)) 
               & (~ (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__hit))) 
              & ((0x173U >= (0x1ffU & ((IData)(0x5bU) 
                                       + ((IData)(0x5dU) 
                                          * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))))) 
                 & (vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[
                    (0xfU & (((IData)(0x5bU) + ((IData)(0x5dU) 
                                                * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))) 
                             >> 5U))] >> (0x1fU & ((IData)(0x5bU) 
                                                   + 
                                                   ((IData)(0x5dU) 
                                                    * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))))))) 
             & (~ (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__pass_through)))) {
            vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_state = 2U;
        } else if ((1U & ((((~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__suppress_iren)) 
                            & (~ (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__hit))) 
                           & (~ ((0x173U >= (0x1ffU 
                                             & ((IData)(0x5bU) 
                                                + ((IData)(0x5dU) 
                                                   * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))))) 
                                 & (vlSelf->CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT____Vcellout__SRAM____pinNumber4[
                                    (0xfU & (((IData)(0x5bU) 
                                              + ((IData)(0x5dU) 
                                                 * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx))) 
                                             >> 5U))] 
                                    >> (0x1fU & ((IData)(0x5bU) 
                                                 + 
                                                 ((IData)(0x5dU) 
                                                  * (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__ridx)))))))) 
                          & (~ (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__pass_through))))) {
            vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_state = 1U;
        }
    } else if ((1U == vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__state)) {
        if ((vlSelf->__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc 
             != vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__decoded_req_addr)) {
            vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_state = 0U;
        } else if ((2U == (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__word_num))) {
            vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_state = 0U;
        }
    } else if ((2U == vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__state)) {
        if ((vlSelf->__PVT__CORE__DOT__pipeline__DOT__fetch_stage_i__DOT__pc 
             != vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__decoded_req_addr)) {
            vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_state = 0U;
        } else if ((2U == (IData)(vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__word_num))) {
            vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_state = 1U;
        }
    } else if ((3U == vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__state)) {
        if (vlSelf->CORE__DOT__sep_caches__DOT____Vcellout__genblk2__DOT__icache__flush_done) {
            vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_state = 0U;
        }
    }
    if (vlSelf->__PVT__CORE__DOT__pipeline__DOT__mem_stage_i__DOT__ifence_pulse) {
        vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk1__DOT__dcache__DOT__next_state = 3U;
        vlSelf->__PVT__CORE__DOT__sep_caches__DOT__genblk2__DOT__icache__DOT__next_state = 3U;
    }
    vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__ex_mem_flush 
        = (((IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__ex_flush_hazard) 
            | (IData)(vlSelf->__PVT__CORE__DOT__pipeline__DOT__hazard_unit_i__DOT__branch_jump)) 
           | ((IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__if_ex_stall) 
              & (~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__ex_mem_stall))));
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__cf_next 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__cycles_full;
    if ((1U & (~ vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit))) {
        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__cf_next 
            = (1ULL + vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__cycles_full);
    }
    if (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__inject_mcycle) {
        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__cf_next 
            = (((QData)((IData)((vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__cycles_full 
                                 >> 0x20U))) << 0x20U) 
               | (QData)((IData)(vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val)));
    }
    if (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__inject_mcycleh) {
        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__cf_next 
            = (((QData)((IData)(vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val)) 
                << 0x20U) | (QData)((IData)(vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__cycles_full)));
    }
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[0U] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[0U];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[1U] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[1U];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[2U] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[2U];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[3U] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[3U];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[4U] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[4U];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[5U] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[5U];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[6U] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[6U];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[7U] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[7U];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[8U] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[8U];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[9U] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[9U];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[0xaU] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[0xaU];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[0xbU] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[0xbU];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[0xcU] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[0xcU];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[0xdU] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[0xdU];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[0xeU] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[0xeU];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr[0xfU] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_addr_regs[0xfU];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[0U] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[0U];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[1U] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[1U];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[2U] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[2U];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg[3U] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[3U];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val;
    if (vlSymsp->TOP__top_core__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__priv_ext_pmp_if.__PVT__csr_active) {
        if ((0x3a0U != (0xffcU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                  >> 1U)))) {
            if ((0x3b0U == (0xff0U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                      >> 1U)))) {
                if ((1U & (~ (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[
                              (3U & (((IData)(7U) + 
                                      ((0x60U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                 << 2U)) 
                                       + (0x18U & (
                                                   vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                   << 2U)))) 
                                     >> 5U))] >> (0x1fU 
                                                  & ((IData)(7U) 
                                                     + 
                                                     ((0x60U 
                                                       & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                          << 2U)) 
                                                      + 
                                                      (0x18U 
                                                       & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                          << 2U))))))))) {
                    if ((0xfU != (0xfU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                          >> 1U)))) {
                        if ((1U != (3U & (((0U == (0x1fU 
                                                   & ((IData)(3U) 
                                                      + 
                                                      ((0x60U 
                                                        & (((IData)(1U) 
                                                            + 
                                                            (0xfU 
                                                             & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                                >> 1U))) 
                                                           << 3U)) 
                                                       + 
                                                       (0x18U 
                                                        & (((IData)(1U) 
                                                            + 
                                                            (0xfU 
                                                             & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                                >> 1U))) 
                                                           << 3U))))))
                                            ? 0U : 
                                           (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[
                                            (((IData)(1U) 
                                              + (0x7fU 
                                                 & ((IData)(3U) 
                                                    + 
                                                    ((0x60U 
                                                      & (((IData)(1U) 
                                                          + 
                                                          (0xfU 
                                                           & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                              >> 1U))) 
                                                         << 3U)) 
                                                     + 
                                                     (0x18U 
                                                      & (((IData)(1U) 
                                                          + 
                                                          (0xfU 
                                                           & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                              >> 1U))) 
                                                         << 3U)))))) 
                                             >> 5U)] 
                                            << ((IData)(0x20U) 
                                                - (0x1fU 
                                                   & ((IData)(3U) 
                                                      + 
                                                      ((0x60U 
                                                        & (((IData)(1U) 
                                                            + 
                                                            (0xfU 
                                                             & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                                >> 1U))) 
                                                           << 3U)) 
                                                       + 
                                                       (0x18U 
                                                        & (((IData)(1U) 
                                                            + 
                                                            (0xfU 
                                                             & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                                >> 1U))) 
                                                           << 3U)))))))) 
                                          | (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[
                                             (3U & 
                                              (((IData)(3U) 
                                                + (
                                                   (0x60U 
                                                    & (((IData)(1U) 
                                                        + 
                                                        (0xfU 
                                                         & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                            >> 1U))) 
                                                       << 3U)) 
                                                   + 
                                                   (0x18U 
                                                    & (((IData)(1U) 
                                                        + 
                                                        (0xfU 
                                                         & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                            >> 1U))) 
                                                       << 3U)))) 
                                               >> 5U))] 
                                             >> (0x1fU 
                                                 & ((IData)(3U) 
                                                    + 
                                                    ((0x60U 
                                                      & (((IData)(1U) 
                                                          + 
                                                          (0xfU 
                                                           & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                              >> 1U))) 
                                                         << 3U)) 
                                                     + 
                                                     (0x18U 
                                                      & (((IData)(1U) 
                                                          + 
                                                          (0xfU 
                                                           & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                              >> 1U))) 
                                                         << 3U)))))))))) {
                            VL_ASSIGNSEL_WI(512,32,
                                            (0x1e0U 
                                             & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                << 4U)), vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr, vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val);
                        } else if ((1U & (~ (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[
                                             (3U & 
                                              (((IData)(7U) 
                                                + (
                                                   (0x60U 
                                                    & (((IData)(1U) 
                                                        + 
                                                        (0xfU 
                                                         & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                            >> 1U))) 
                                                       << 3U)) 
                                                   + 
                                                   (0x18U 
                                                    & (((IData)(1U) 
                                                        + 
                                                        (0xfU 
                                                         & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                            >> 1U))) 
                                                       << 3U)))) 
                                               >> 5U))] 
                                             >> (0x1fU 
                                                 & ((IData)(7U) 
                                                    + 
                                                    ((0x60U 
                                                      & (((IData)(1U) 
                                                          + 
                                                          (0xfU 
                                                           & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                              >> 1U))) 
                                                         << 3U)) 
                                                     + 
                                                     (0x18U 
                                                      & (((IData)(1U) 
                                                          + 
                                                          (0xfU 
                                                           & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                              >> 1U))) 
                                                         << 3U))))))))) {
                            VL_ASSIGNSEL_WI(512,32,
                                            (0x1e0U 
                                             & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                << 4U)), vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_addr, vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val);
                        }
                    }
                }
            }
        }
        if ((0x3a0U == (0xffcU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                  >> 1U)))) {
            vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                = (0xffffff9fU & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg);
            vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                = (0xffff9fffU & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg);
            vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                = (0xff9fffffU & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg);
            vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                = (0x9fffffffU & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg);
            if ((IData)((2U == (3U & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg)))) {
                vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                    = (0xfffffffdU & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg);
            }
            if ((IData)((0x200U == (0x300U & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg)))) {
                vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                    = (0xfffffdffU & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg);
            }
            if ((IData)((0x20000U == (0x30000U & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg)))) {
                vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                    = (0xfffdffffU & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg);
            }
            if ((IData)((0x2000000U == (0x3000000U 
                                        & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg)))) {
                vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                    = (0xfdffffffU & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg);
            }
            if ((1U & (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[
                       (3U & (((IData)(7U) + (0x60U 
                                              & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                 << 4U))) 
                              >> 5U))] >> (0x1fU & 
                                           ((IData)(7U) 
                                            + (0x60U 
                                               & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                  << 4U))))))) {
                vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                    = ((0xffffff00U & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg) 
                       | (0xffU & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[
                          (3U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                 >> 1U))]));
            }
            if ((1U & (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[
                       (3U & (((IData)(0xfU) + (0x60U 
                                                & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                   << 4U))) 
                              >> 5U))] >> (0x1fU & 
                                           ((IData)(0xfU) 
                                            + (0x60U 
                                               & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                  << 4U))))))) {
                vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                    = ((0xffff00ffU & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg) 
                       | (0xff00U & ((((0U == (0x1fU 
                                               & ((IData)(8U) 
                                                  + 
                                                  (0x60U 
                                                   & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                      << 4U)))))
                                        ? 0U : (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[
                                                (((IData)(7U) 
                                                  + 
                                                  (0x7fU 
                                                   & ((IData)(8U) 
                                                      + 
                                                      (0x60U 
                                                       & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                          << 4U))))) 
                                                 >> 5U)] 
                                                << 
                                                ((IData)(0x20U) 
                                                 - 
                                                 (0x1fU 
                                                  & ((IData)(8U) 
                                                     + 
                                                     (0x60U 
                                                      & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                         << 4U))))))) 
                                      | (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[
                                         (3U & (((IData)(8U) 
                                                 + 
                                                 (0x60U 
                                                  & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                     << 4U))) 
                                                >> 5U))] 
                                         >> (0x1fU 
                                             & ((IData)(8U) 
                                                + (0x60U 
                                                   & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                      << 4U)))))) 
                                     << 8U)));
            }
            if ((1U & (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[
                       (3U & (((IData)(0x17U) + (0x60U 
                                                 & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                    << 4U))) 
                              >> 5U))] >> (0x1fU & 
                                           ((IData)(0x17U) 
                                            + (0x60U 
                                               & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                  << 4U))))))) {
                vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                    = ((0xff00ffffU & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg) 
                       | (0xff0000U & ((((0U == (0x1fU 
                                                 & ((IData)(0x10U) 
                                                    + 
                                                    (0x60U 
                                                     & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                        << 4U)))))
                                          ? 0U : (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[
                                                  (((IData)(7U) 
                                                    + 
                                                    (0x7fU 
                                                     & ((IData)(0x10U) 
                                                        + 
                                                        (0x60U 
                                                         & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                            << 4U))))) 
                                                   >> 5U)] 
                                                  << 
                                                  ((IData)(0x20U) 
                                                   - 
                                                   (0x1fU 
                                                    & ((IData)(0x10U) 
                                                       + 
                                                       (0x60U 
                                                        & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                           << 4U))))))) 
                                        | (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[
                                           (3U & (((IData)(0x10U) 
                                                   + 
                                                   (0x60U 
                                                    & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                       << 4U))) 
                                                  >> 5U))] 
                                           >> (0x1fU 
                                               & ((IData)(0x10U) 
                                                  + 
                                                  (0x60U 
                                                   & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                      << 4U)))))) 
                                       << 0x10U)));
            }
            if ((1U & (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[
                       (3U & (((IData)(0x1fU) + (0x60U 
                                                 & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                    << 4U))) 
                              >> 5U))] >> (0x1fU & 
                                           ((IData)(0x1fU) 
                                            + (0x60U 
                                               & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                  << 4U))))))) {
                vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg 
                    = ((0xffffffU & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg) 
                       | ((((0U == (0x1fU & ((IData)(0x18U) 
                                             + (0x60U 
                                                & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                   << 4U)))))
                             ? 0U : (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[
                                     (((IData)(7U) 
                                       + (0x7fU & ((IData)(0x18U) 
                                                   + 
                                                   (0x60U 
                                                    & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                       << 4U))))) 
                                      >> 5U)] << ((IData)(0x20U) 
                                                  - 
                                                  (0x1fU 
                                                   & ((IData)(0x18U) 
                                                      + 
                                                      (0x60U 
                                                       & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                          << 4U))))))) 
                           | (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__pmp_cfg_regs[
                              (3U & (((IData)(0x18U) 
                                      + (0x60U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                  << 4U))) 
                                     >> 5U))] >> (0x1fU 
                                                  & ((IData)(0x18U) 
                                                     + 
                                                     (0x60U 
                                                      & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                                         << 4U)))))) 
                          << 0x18U));
            }
            VL_ASSIGNSEL_WI(128,32,(0x60U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                             << 4U)), vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__nxt_pmp_cfg, vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pmp__DOT__new_cfg);
        }
    }
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__if_next 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__instret_full;
    if ((1U & (~ (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__mcounterinhibit 
                  >> 2U)))) {
        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__if_next 
            = (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__instret_full 
               + (QData)((IData)(((((~ (IData)(vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__hazard_if.__PVT__if_ex_stall)) 
                                    | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                       >> 0xfU)) | 
                                   (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xdU] 
                                    >> 0x16U)) & (0U 
                                                  != 
                                                  ((vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[8U] 
                                                    << 0x1fU) 
                                                   | (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[7U] 
                                                      >> 1U)))))));
    }
    if (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__inject_minstret) {
        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__if_next 
            = (((QData)((IData)((vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__instret_full 
                                 >> 0x20U))) << 0x20U) 
               | (QData)((IData)(vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val)));
    }
    if (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__inject_minstreth) {
        vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__if_next 
            = (((QData)((IData)(vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val)) 
                << 0x20U) | (QData)((IData)(vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__instret_full)));
    }
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0U] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0U];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[1U] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[1U];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[2U] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[2U];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[3U] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[3U];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[4U] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[4U];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[5U] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[5U];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[6U] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[6U];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[7U] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[7U];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[8U] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[8U];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[9U] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[9U];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xaU] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xaU];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xbU] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xbU];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xcU] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xcU];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xdU] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xdU];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xeU] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xeU];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs[0xfU] 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__pma_regs[0xfU];
    vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
        = vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__nxt_csr_val;
    if ((0xbcU == (0xffU & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                            >> 5U)))) {
        if ((((~ (IData)(vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__invalid_csr_priv)) 
              & (IData)(vlSymsp->TOP__top_core__CORE__DOT__prv_pipe_if.__PVT__valid_write)) 
             & (IData)(vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__csr__DOT__csr_operation))) {
            if ((3U == (3U & (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                              >> 3U)))) {
                vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                    = (0xffffffe7U & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val);
            }
            if ((3U == (3U & (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                              >> 0x13U)))) {
                vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                    = (0xffe7ffffU & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val);
            }
            if ((7U == (7U & (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                              >> 8U)))) {
                vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                    = (0x300U | (0xfffff8ffU & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val));
            }
            if ((7U == (7U & (vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                              >> 0x18U)))) {
                vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val 
                    = (0x3000000U | (0xf8ffffffU & vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val));
            }
            VL_ASSIGNSEL_WI(512,32,(0x1e0U & (vlSymsp->TOP__top_core__CORE__DOT__pipeline__DOT__mem_pipe_if.__PVT__ex_mem_reg[0xcU] 
                                              << 4U)), vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__nxt_pma_regs, vlSelf->__PVT__CORE__DOT__priv_wrapper_i__DOT__priv_block_i__DOT__pma__DOT__new_val);
        }
    }
}
