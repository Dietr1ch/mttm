#!/usr/bin/env fish

set SCRIPT_NAME (basename (status filename))

function usage
    echo "Usage: $SCRIPT_NAME [options] <arg>"
    echo ""
    echo "Description of what this script does."
    echo ""
    echo "Options:"
    echo "  -h, --help      Show this help"
    echo "  -v, --verbose   Verbose output"
    echo "  --dry-run       Print what would be done without doing it"
    exit 0
end

function die
    echo "error: $argv" >&2
    exit 1
end

argparse 'h/help' 'v/verbose' 'dry-run' -- $argv
or begin
    usage
end

if set -q _flag_help
    usage
end

set verbose (set -q _flag_verbose; and echo true; or echo false)
set dry_run (set -q _flag_dry_run; and echo true; or echo false)

set arg $argv[1]
test -n "$arg"; or die "missing required argument"

echo "verbose=$verbose, dry_run=$dry_run, arg=$arg"
