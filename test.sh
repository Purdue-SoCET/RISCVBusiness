#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# test.sh
# ============================================================
#
# Test script for RISCVBusiness.
#
# This script is intentionally config-driven so CI can choose whether to:
#
#   * run the RISC-V test setup step
#   * run the RISC-V test command
#   * skip tests entirely
#
# The default first-pass CI flow is:
#
#   ./setup-riscv-tests.sh
#   ./run_riscv_tests.py --isa i --environment p
#
# This starts with a small ISA-I regression before expanding CI to larger
# ISA groups.
#
# ============================================================

if [ ! -f "./config.env" ]; then
    echo "ERROR: config.env not found" >&2
    exit 1
fi

source ./config.env

mkdir -p logs

check_tool() {
    local tool="$1"

    if ! command -v "$tool" >/dev/null 2>&1; then
        echo "ERROR: $tool not found" >&2
        exit 1
    fi
}

run_riscv_test_setup() {
    if [ "${RISCV_TEST_SETUP_ENABLED:-0}" != "1" ]; then
        echo "RISC-V test setup disabled, skipping"
        return 0
    fi

    if [ -z "${RISCV_TEST_SETUP_CMD:-}" ]; then
        echo "ERROR: RISCV_TEST_SETUP_ENABLED=1 but RISCV_TEST_SETUP_CMD is empty" >&2
        exit 1
    fi

    echo "Running RISC-V test setup"
    bash -lc "$RISCV_TEST_SETUP_CMD" 2>&1 | tee logs/riscv_test_setup.log
}

run_command_test() {
    if [ -z "${TEST_CMD:-}" ]; then
        echo "ERROR: TEST_MODE=command but TEST_CMD is empty" >&2
        exit 1
    fi

    echo "Running test command"
    echo "$TEST_CMD"

    timeout "${TEST_TIMEOUT_SECONDS:-1800}" bash -lc "$TEST_CMD" 2>&1 | tee logs/test.log

    if [ -n "${PASS_REGEX:-}" ]; then
        echo "Checking test output for PASS_REGEX: $PASS_REGEX"

        if ! grep -E "$PASS_REGEX" logs/test.log >/dev/null; then
            echo "ERROR: test completed, but pass regex was not found" >&2
            exit 1
        fi
    else
        echo "No PASS_REGEX set; clean command exit counts as pass"
    fi
}

main() {
    if [ "${TEST_ENABLED:-1}" != "1" ]; then
        echo "Tests disabled by config.env, skipping"
        exit 0
    fi

    echo "Testing ${PROJECT_NAME:-RISCVBusiness}"

    case "${TEST_MODE:-none}" in
        command)
            check_tool timeout
            run_riscv_test_setup
            run_command_test
            ;;

        none)
            echo "TEST_MODE=none, skipping tests"
            ;;

        *)
            echo "ERROR: unsupported TEST_MODE for RISCVBusiness: ${TEST_MODE}" >&2
            echo "Supported modes for this repo integration: command, none" >&2
            exit 1
            ;;
    esac

    echo "Test complete"
}

main "$@"