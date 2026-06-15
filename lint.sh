#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# lint.sh
# ============================================================
#
# Lint script for RISCVBusiness.
#
# This script keeps the existing lint behavior and adds CI structure:
#
#   1. Verible lint using .rules.verible_lint
#   2. FuseSoC/Verilator lint using the existing FuseSoC lint target
#
# The existing .rules.verible_lint file is preserved and used directly.
#
# Lint can be made non-blocking with:
#
#   LINT_STRICT=0
#
# This is useful during initial CI integration when the repo already has
# existing lint debt, but we still want CI to report lint output.
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

run_verible_lint() {
    if [ "${VERIBLE_LINT_ENABLED:-1}" != "1" ]; then
        echo "Verible lint disabled, skipping"
        return 0
    fi

    check_tool verible-verilog-lint

    local rules_file="${VERIBLE_RULES_FILE:-.rules.verible_lint}"

    if [ ! -f "$rules_file" ]; then
        echo "ERROR: Verible rules file not found: $rules_file" >&2
        exit 1
    fi

    echo "Running Verible lint"
    echo "Rules file: $rules_file"

    local find_args=()
    local ext

    for ext in ${VERIBLE_LINT_EXTENSIONS:-sv v vh}; do
        if [ "${#find_args[@]}" -eq 0 ]; then
            find_args+=( -name "*.${ext}" )
        else
            find_args+=( -o -name "*.${ext}" )
        fi
    done

    local prune_args=()
    local dir

    for dir in ${VERIBLE_LINT_EXCLUDE_DIRS:-rvb_out fusesoc_libraries riscv-tests embench-1.0 .git}; do
        prune_args+=( -path "./${dir}" -o )
    done

    local files_file="logs/verible_lint_files.txt"

    find . \
        \( "${prune_args[@]}" -false \) -prune -o \
        -type f \( "${find_args[@]}" \) -print \
        | sort > "$files_file"

    if [ ! -s "$files_file" ]; then
        echo "No Verilog/SystemVerilog files found for Verible lint"
        return 0
    fi

    echo "Files checked:"
    cat "$files_file"

    set +e
    xargs -a "$files_file" verible-verilog-lint \
        --rules_config="$rules_file" \
        2>&1 | tee logs/verible_lint.log
    local lint_status=${PIPESTATUS[0]}
    set -e

    if [ "$lint_status" -ne 0 ]; then
        if [ "${LINT_STRICT:-1}" = "1" ]; then
            echo "ERROR: Verible lint failed and LINT_STRICT=1" >&2
            exit "$lint_status"
        fi

        echo "WARNING: Verible lint failed, but LINT_STRICT=0 so continuing"
    fi
}

run_fusesoc_lint() {
    if [ "${FUSESOC_LINT_ENABLED:-1}" != "1" ]; then
        echo "FuseSoC lint disabled, skipping"
        return 0
    fi

    check_tool fusesoc

    if [ -n "${LINT_CMD:-}" ]; then
        echo "Running custom lint command"

        set +e
        bash -lc "$LINT_CMD" 2>&1 | tee logs/fusesoc_lint.log
        local lint_status=${PIPESTATUS[0]}
        set -e

        if [ "$lint_status" -ne 0 ]; then
            if [ "${LINT_STRICT:-1}" = "1" ]; then
                echo "ERROR: custom lint command failed and LINT_STRICT=1" >&2
                exit "$lint_status"
            fi

            echo "WARNING: custom lint command failed, but LINT_STRICT=0 so continuing"
        fi

        return 0
    fi

    if [ -z "${FUSESOC_CORE:-}" ]; then
        echo "ERROR: FUSESOC_CORE is empty" >&2
        exit 1
    fi

    echo "Running FuseSoC lint"
    echo "Core:       ${FUSESOC_CORE}"
    echo "Target:     ${FUSESOC_LINT_TARGET:-lint}"
    echo "Tool:       ${FUSESOC_LINT_TOOL:-verilator}"
    echo "Build root: ${FUSESOC_LINT_BUILD_ROOT:-rvb_out}"

    local cmd=(
        fusesoc
        --cores-root "${FUSESOC_CORES_ROOT:-.}"
        run
        --setup
        --build
        --build-root "${FUSESOC_LINT_BUILD_ROOT:-rvb_out}"
        --target "${FUSESOC_LINT_TARGET:-lint}"
        --tool "${FUSESOC_LINT_TOOL:-verilator}"
        "$FUSESOC_CORE"
    )

    if [ -n "${FUSESOC_LINT_EXTRA_ARGS:-}" ]; then
        # shellcheck disable=SC2206
        local extra_args=( ${FUSESOC_LINT_EXTRA_ARGS} )
        cmd+=( "${extra_args[@]}" )
    fi

    if [ -n "${FUSESOC_LINT_VERILATOR_OPTIONS:-${FUSESOC_VERILATOR_OPTIONS:-}}" ]; then
        cmd+=( "--verilator_options=${FUSESOC_LINT_VERILATOR_OPTIONS:-${FUSESOC_VERILATOR_OPTIONS}}" )
    fi

    echo "Command:"
    printf '  %q' "${cmd[@]}"
    echo

    set +e
    "${cmd[@]}" 2>&1 | tee logs/fusesoc_lint.log
    local lint_status=${PIPESTATUS[0]}
    set -e

    if [ "$lint_status" -ne 0 ]; then
        if [ "${LINT_STRICT:-1}" = "1" ]; then
            echo "ERROR: FuseSoC lint failed and LINT_STRICT=1" >&2
            exit "$lint_status"
        fi

        echo "WARNING: FuseSoC lint failed, but LINT_STRICT=0 so continuing"
    fi
}

main() {
    if [ "${LINT_ENABLED:-1}" != "1" ]; then
        echo "Lint disabled by config.env, skipping"
        exit 0
    fi

    echo "Linting ${PROJECT_NAME:-RISCVBusiness}"

    run_verible_lint
    run_fusesoc_lint

    echo "Lint complete"
}

main "$@"