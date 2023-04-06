// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Primary model header
//
// This header should be included by all source files instantiating the design.
// The class here is then constructed to instantiate the design.
// See the Verilator manual for examples.

#ifndef VERILATED_VTOP_CORE_H_
#define VERILATED_VTOP_CORE_H_  // guard

#include "verilated.h"
#include "svdpi.h"

class Vtop_core__Syms;
class Vtop_core___024root;
class VerilatedFstC;
class Vtop_core_top_core;


// This class is the main interface to the Verilated model
class Vtop_core VL_NOT_FINAL : public VerilatedModel {
  private:
    // Symbol table holding complete model state (owned by this class)
    Vtop_core__Syms* const vlSymsp;

  public:

    // PORTS
    // The application code writes and reads these signals to
    // propagate new values into/out from the Verilated model.
    VL_IN8(&CLK,0,0);
    VL_IN8(&nRST,0,0);
    VL_OUT8(&wfi,0,0);
    VL_OUT8(&halt,0,0);
    VL_IN8(&busy,0,0);
    VL_OUT8(&ren,0,0);
    VL_OUT8(&wen,0,0);
    VL_OUT8(&byte_en,3,0);
    VL_IN8(&ext_int,0,0);
    VL_IN8(&ext_int_clear,0,0);
    VL_IN8(&soft_int,0,0);
    VL_IN8(&soft_int_clear,0,0);
    VL_IN8(&timer_int,0,0);
    VL_IN8(&timer_int_clear,0,0);
    VL_IN(&rdata,31,0);
    VL_OUT(&addr,31,0);
    VL_OUT(&wdata,31,0);
    VL_IN64(&mtime,63,0);

    // CELLS
    // Public to allow access to /* verilator public */ items.
    // Otherwise the application code can consider these internals.
    Vtop_core_top_core* const top_core;

    // Root instance pointer to allow access to model internals,
    // including inlined /* verilator public_flat_* */ items.
    Vtop_core___024root* const rootp;

    // CONSTRUCTORS
    /// Construct the model; called by application code
    /// If contextp is null, then the model will use the default global context
    /// If name is "", then makes a wrapper with a
    /// single model invisible with respect to DPI scope names.
    explicit Vtop_core(VerilatedContext* contextp, const char* name = "TOP");
    explicit Vtop_core(const char* name = "TOP");
    /// Destroy the model; called (often implicitly) by application code
    virtual ~Vtop_core();
  private:
    VL_UNCOPYABLE(Vtop_core);  ///< Copying not allowed

  public:
    // API METHODS
    /// Evaluate the model.  Application must call when inputs change.
    void eval() { eval_step(); }
    /// Evaluate when calling multiple units/models per time step.
    void eval_step();
    /// Evaluate at end of a timestep for tracing, when using eval_step().
    /// Application must call after all eval() and before time changes.
    void eval_end_step() {}
    /// Simulation complete, run final blocks.  Application must call on completion.
    void final();
    /// Are there scheduled events to handle?
    bool eventsPending();
    /// Returns time at next time slot. Aborts if !eventsPending()
    uint64_t nextTimeSlot();
    /// Trace signals in the model; called by application code
    void trace(VerilatedFstC* tfp, int levels, int options = 0);
    /// Retrieve name of this model instance (as passed to constructor).
    const char* name() const;

    // Abstract methods from VerilatedModel
    const char* hierName() const override final;
    const char* modelName() const override final;
    unsigned threads() const override final;
    std::unique_ptr<VerilatedTraceConfig> traceConfig() const override final;
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

#endif  // guard
