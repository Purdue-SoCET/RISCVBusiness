#!/usr/bin/env bash
set -euo pipefail

RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

info_print() {
    echo -e "${BLUE}$1${NC}"
}

error_print() {
    echo -e "${RED}ERROR: $1${NC}" >&2
}

success_print() {
    echo -e "${GREEN}$1${NC}"
}

warn_print() {
    echo -e "${YELLOW}WARNING: $1${NC}"
}

check_tool() {
    local tool="$1"

    if ! command -v "$tool" >/dev/null 2>&1; then
        error_print "$tool not found"
        exit 1
    fi
}

if [ ! -f "./config.env" ]; then
    error_print "config.env not found"
    exit 1
fi

source ./config.env

clean_fusesoc_state() {
    if [ "${SETUP_CLEAN_FUSESOC:-1}" != "1" ]; then
        warn_print "FuseSoC cleanup disabled, skipping"
        return 0
    fi

    if [ -d "./fusesoc_libraries" ]; then
        info_print "Cleaning old FuseSoC libraries"
        rm -rf ./fusesoc_libraries
    fi

    if [ -f "./fusesoc.conf" ]; then
        info_print "Cleaning old fusesoc.conf"
        rm -f ./fusesoc.conf
    fi
}

install_fusesoc_libraries() {
    local entry
    local name
    local repo

    if [ "${INSTALL_FUSESOC_LIBRARIES:-1}" != "1" ]; then
        warn_print "FuseSoC library installation disabled, skipping"
        return 0
    fi

    check_tool fusesoc

    if [ -z "${FUSESOC_LIBRARIES:-}" ]; then
        warn_print "FUSESOC_LIBRARIES is empty, skipping FuseSoC library installation"
        return 0
    fi

    info_print "Installing FuseSoC libraries"

    while IFS= read -r entry || [ -n "$entry" ]; do
        # Skip blank lines and comments.
        if [ -z "${entry// }" ]; then
            continue
        fi

        if [[ "$entry" =~ ^[[:space:]]*# ]]; then
            continue
        fi

        name="${entry%%|*}"
        repo="${entry#*|}"

        if [ -z "$name" ] || [ -z "$repo" ] || [ "$name" = "$repo" ]; then
            error_print "Invalid FUSESOC_LIBRARIES entry: $entry"
            error_print "Expected format: name|git_url"
            exit 1
        fi

        info_print "Installing $name"

        if ! fusesoc library add "$name" "$repo"; then
            error_print "Failed to fetch $name from $repo"
            error_print "If this is a private repo, ensure your SSH key has repository permissions"
            exit 1
        fi
    done <<< "$FUSESOC_LIBRARIES"
}

install_precommit_hook() {
    if [ "${INSTALL_PRECOMMIT_HOOK:-0}" != "1" ]; then
        warn_print "Pre-commit hook installation disabled, skipping"
        return 0
    fi

    if [ -z "${PRECOMMIT_HOOK_SRC:-}" ] || [ -z "${PRECOMMIT_HOOK_DST:-}" ]; then
        error_print "INSTALL_PRECOMMIT_HOOK=1 but PRECOMMIT_HOOK_SRC or PRECOMMIT_HOOK_DST is empty"
        exit 1
    fi

    if [ ! -f "$PRECOMMIT_HOOK_SRC" ]; then
        error_print "Pre-commit hook source not found: $PRECOMMIT_HOOK_SRC"
        exit 1
    fi

    info_print "Installing pre-commit hook"
    mkdir -p "$(dirname "$PRECOMMIT_HOOK_DST")"
    cp "$PRECOMMIT_HOOK_SRC" "$PRECOMMIT_HOOK_DST"
    chmod +x "$PRECOMMIT_HOOK_DST"
}

main() {
    if [ "${SETUP_ENABLED:-1}" != "1" ]; then
        warn_print "Setup disabled by config.env, skipping"
        exit 0
    fi

    info_print "Initializing ${PROJECT_NAME:-Repository}"

    clean_fusesoc_state
    install_fusesoc_libraries
    install_precommit_hook

    success_print "Initialization Complete!"
}

main "$@"