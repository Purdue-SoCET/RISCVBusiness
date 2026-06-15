#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# build.sh
# ============================================================
#
# Build script for RISCVBusiness.
#
# This script replaces the old Makefile flow:
#
#   make config
#   make verilate
#
# with config.env-controlled CI steps.
#
# The default build flow is:
#
#   python3 scripts/config_core.py example.yml
#
# followed by:
#
#   fusesoc --cores-root . run --setup --build --build-root rvb_out \
#       --target sim --tool verilator socet:riscv:RISCVBusiness \
#       --make_options='-j'
#
# FuseSoC backend/tool arguments such as --make_options and
# --verilator_options must be placed after the core name. That is why
# FUSESOC_EXTRA_ARGS and FUSESOC_VERILATOR_OPTIONS are appended after
# FUSESOC_CORE below.
#
# ============================================================

if [ ! -f "./config.env" ]; then
    echo "ERROR: config.env not found" >&2
    exit 1
fi

source ./config.env

check_tool() {
    local tool="$1"

    if ! command -v "$tool" >/dev/null 2>&1; then
        echo "ERROR: $tool not found" >&2
        exit 1
    fi
}

run_config_step() {
    if [ "${CONFIG_STEP_ENABLED:-0}" != "1" ]; then
        echo "Core configuration disabled, skipping"
        return 0
    fi

    if [ -z "${RISCV_CONFIG_SCRIPT:-}" ]; then
        echo "ERROR: CONFIG_STEP_ENABLED=1 but RISCV_CONFIG_SCRIPT is empty" >&2
        exit 1
    fi

    if [ -z "${RISCV_CONFIG_FILE:-}" ]; then
        echo "ERROR: CONFIG_STEP_ENABLED=1 but RISCV_CONFIG_FILE is empty" >&2
        exit 1
    fi

    if [ ! -f "$RISCV_CONFIG_SCRIPT" ]; then
        echo "ERROR: RISCV config script not found: $RISCV_CONFIG_SCRIPT" >&2
        exit 1
    fi

    if [ ! -f "$RISCV_CONFIG_FILE" ]; then
        echo "ERROR: RISCV config file not found: $RISCV_CONFIG_FILE" >&2
        exit 1
    fi

    check_tool python3

    echo "Running RISCVBusiness core configuration"
    python3 "$RISCV_CONFIG_SCRIPT" "$RISCV_CONFIG_FILE"
}

run_pre_build_hook() {
    if [ -z "${PRE_BUILD_CMD:-}" ]; then
        return 0
    fi

    echo "Running pre-build command"
    bash -lc "$PRE_BUILD_CMD"
}

run_post_build_hook() {
    if [ -z "${POST_BUILD_CMD:-}" ]; then
        return 0
    fi

    echo "Running post-build command"
    bash -lc "$POST_BUILD_CMD"
}

run_fusesoc_build() {
    if [ "${FUSESOC_BUILD_ENABLED:-1}" != "1" ]; then
        echo "FuseSoC build disabled, skipping"
        return 0
    fi

    check_tool fusesoc

    if [ -n "${FUSESOC_BUILD_CMD:-}" ]; then
        echo "Running custom FuseSoC build command"
        bash -lc "$FUSESOC_BUILD_CMD"
        return 0
    fi

    if [ -z "${FUSESOC_CORE:-}" ]; then
        echo "ERROR: FUSESOC_CORE is empty" >&2
        exit 1
    fi

    echo "Running FuseSoC Verilator build"
    echo "Core:       ${FUSESOC_CORE}"
    echo "Target:     ${FUSESOC_TARGET:-sim}"
    echo "Tool:       ${FUSESOC_TOOL:-verilator}"
    echo "Build root: ${FUSESOC_BUILD_ROOT:-rvb_out}"

    local cmd=(
        fusesoc
        --cores-root "${FUSESOC_CORES_ROOT:-.}"
        run
        --setup
        --build
        --build-root "${FUSESOC_BUILD_ROOT:-rvb_out}"
        --target "${FUSESOC_TARGET:-sim}"
        --tool "${FUSESOC_TOOL:-verilator}"
        "$FUSESOC_CORE"
    )

    if [ -n "${FUSESOC_EXTRA_ARGS:-}" ]; then
        # shellcheck disable=SC2206
        local extra_args=( ${FUSESOC_EXTRA_ARGS} )
        cmd+=( "${extra_args[@]}" )
    fi

    if [ -n "${FUSESOC_VERILATOR_OPTIONS:-}" ]; then
        cmd+=( "--verilator_options=${FUSESOC_VERILATOR_OPTIONS}" )
    fi

    echo "Command:"
    printf '  %q' "${cmd[@]}"
    echo

    "${cmd[@]}"
}

main() {
    if [ "${BUILD_ENABLED:-1}" != "1" ]; then
        echo "Build disabled by config.env, skipping"
        exit 0
    fi

    echo "Building ${PROJECT_NAME:-RISCVBusiness}"

    run_config_step
    run_pre_build_hook
    run_fusesoc_build
    run_post_build_hook

    echo "Build complete"
}

main "$@"