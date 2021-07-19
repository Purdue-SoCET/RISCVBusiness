// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vtop_core.h"
#include "Vtop_core__Syms.h"
#include "verilated_fst_c.h"
#include "verilated_dpi.h"

//============================================================
// Constructors

Vtop_core::Vtop_core(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vtop_core__Syms(contextp(), _vcname__, this)}
    , CLK{vlSymsp->TOP.CLK}
    , nRST{vlSymsp->TOP.nRST}
    , wfi{vlSymsp->TOP.wfi}
    , halt{vlSymsp->TOP.halt}
    , busy{vlSymsp->TOP.busy}
    , ren{vlSymsp->TOP.ren}
    , wen{vlSymsp->TOP.wen}
    , byte_en{vlSymsp->TOP.byte_en}
    , ext_int{vlSymsp->TOP.ext_int}
    , ext_int_clear{vlSymsp->TOP.ext_int_clear}
    , soft_int{vlSymsp->TOP.soft_int}
    , soft_int_clear{vlSymsp->TOP.soft_int_clear}
    , timer_int{vlSymsp->TOP.timer_int}
    , timer_int_clear{vlSymsp->TOP.timer_int_clear}
    , rdata{vlSymsp->TOP.rdata}
    , addr{vlSymsp->TOP.addr}
    , wdata{vlSymsp->TOP.wdata}
    , mtime{vlSymsp->TOP.mtime}
    , top_core{vlSymsp->TOP.top_core}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

Vtop_core::Vtop_core(const char* _vcname__)
    : Vtop_core(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vtop_core::~Vtop_core() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vtop_core___024root___eval_debug_assertions(Vtop_core___024root* vlSelf);
#endif  // VL_DEBUG
void Vtop_core___024root___eval_static(Vtop_core___024root* vlSelf);
void Vtop_core___024root___eval_initial(Vtop_core___024root* vlSelf);
void Vtop_core___024root___eval_settle(Vtop_core___024root* vlSelf);
void Vtop_core___024root___eval(Vtop_core___024root* vlSelf);

void Vtop_core::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vtop_core::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vtop_core___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_activity = true;
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vtop_core___024root___eval_static(&(vlSymsp->TOP));
        Vtop_core___024root___eval_initial(&(vlSymsp->TOP));
        Vtop_core___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vtop_core___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
}

//============================================================
// Events and timing
bool Vtop_core::eventsPending() { return false; }

uint64_t Vtop_core::nextTimeSlot() {
    VL_FATAL_MT(__FILE__, __LINE__, "", "%Error: No delays in the design");
    return 0;
}

//============================================================
// Utilities

const char* Vtop_core::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vtop_core___024root___eval_final(Vtop_core___024root* vlSelf);

VL_ATTR_COLD void Vtop_core::final() {
    Vtop_core___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vtop_core::hierName() const { return vlSymsp->name(); }
const char* Vtop_core::modelName() const { return "Vtop_core"; }
unsigned Vtop_core::threads() const { return 1; }
std::unique_ptr<VerilatedTraceConfig> Vtop_core::traceConfig() const {
    return std::unique_ptr<VerilatedTraceConfig>{new VerilatedTraceConfig{false, false, false}};
};

//============================================================
// Trace configuration

void Vtop_core___024root__trace_init_top(Vtop_core___024root* vlSelf, VerilatedFst* tracep);

VL_ATTR_COLD static void trace_init(void* voidSelf, VerilatedFst* tracep, uint32_t code) {
    // Callback from tracep->open()
    Vtop_core___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtop_core___024root*>(voidSelf);
    Vtop_core__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (!vlSymsp->_vm_contextp__->calcUnusedSigs()) {
        VL_FATAL_MT(__FILE__, __LINE__, __FILE__,
            "Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vlSymsp->__Vm_baseCode = code;
    tracep->scopeEscape(' ');
    tracep->pushNamePrefix(std::string{vlSymsp->name()} + ' ');
    Vtop_core___024root__trace_init_top(vlSelf, tracep);
    tracep->popNamePrefix();
    tracep->scopeEscape('.');
}

VL_ATTR_COLD void Vtop_core___024root__trace_register(Vtop_core___024root* vlSelf, VerilatedFst* tracep);

VL_ATTR_COLD void Vtop_core::trace(VerilatedFstC* tfp, int levels, int options) {
    if (tfp->isOpen()) {
        vl_fatal(__FILE__, __LINE__, __FILE__,"'Vtop_core::trace()' shall not be called after 'VerilatedFstC::open()'.");
    }
    if (false && levels && options) {}  // Prevent unused
    tfp->spTrace()->addModel(this);
    tfp->spTrace()->addInitCb(&trace_init, &(vlSymsp->TOP));
    Vtop_core___024root__trace_register(&(vlSymsp->TOP), tfp->spTrace());
}
