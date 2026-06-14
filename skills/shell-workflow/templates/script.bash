#!/usr/bin/env bash
set -euo pipefail

readonly SCRIPT_NAME="$(basename "$0")"

usage() {
    cat <<EOF
Usage: $SCRIPT_NAME [options] <arg>

Description of what this script does.

Options:
  -h, --help      Show this help
  -v, --verbose   Verbose output
  --dry-run       Print what would be done without doing it
EOF
    exit 0
}

die() {
    echo "error: $*" >&2
    exit 1
}

cleanup() {
    # Remove temp files, kill background processes
    :
}

trap cleanup EXIT

main() {
    local verbose=false
    local dry_run=false

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help) usage ;;
            -v|--verbose) verbose=true ;;
            --dry-run) dry_run=true ;;
            --) shift; break ;;
            -*) die "unknown option: $1" ;;
            *) break ;;
        esac
        shift
    done

    local arg="${1:-}"
    [[ -z "$arg" ]] && die "missing required argument"

    echo "verbose=$verbose, dry_run=$dry_run, arg=$arg"
}

main "$@"
