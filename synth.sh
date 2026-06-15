#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# synth.sh
# ============================================================
#
# Synthesis script for RISCVBusiness.
#
# Synthesis is intentionally disabled for the first CI integration pass.
#
# Initial CI goal:
#
#   setup -> build -> test -> lint -> synth placeholder
#
# Once the build/test/lint flow is stable, real synthesis can be enabled
# separately by setting:
#
#   SYNTH_ENABLED=1
#
# and adding a RISCVBusiness-specific synthesis flow.
#
# ============================================================

if [ ! -f "./config.env" ]; then
    echo "ERROR: config.env not found" >&2
    exit 1
fi

source ./config.env

mkdir -p "${SYNTH_OUT_DIR:-synth_out}"

main() {
    if [ "${SYNTH_ENABLED:-0}" != "1" ]; then
        echo "Synthesis disabled by config.env, skipping"
        echo "Set SYNTH_ENABLED=1 after a RISCVBusiness synthesis flow is added"
        exit 0
    fi

    if [ -n "${SYNTH_CMD:-}" ]; then
        echo "Running custom synthesis command"
        bash -lc "$SYNTH_CMD"
        echo "Synthesis complete"
        exit 0
    fi

    echo "ERROR: SYNTH_ENABLED=1 but no RISCVBusiness synthesis flow is configured" >&2
    echo "Set SYNTH_CMD or add a dedicated RISCVBusiness synthesis implementation" >&2
    exit 1
}

main "$@"