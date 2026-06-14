---
name: shell-workflow
description: Use when writing, refactoring, or debugging shell scripts in bash or fish.
---

# Shell Workflow

Conventions for this project's shell scripts.

## Bash

- Extension: `.bash`
- Shebang: `#!/usr/bin/env bash`
- Options: `set -euo pipefail`
- Use functions over top-level code; prefix with `_` for "private" helpers.
- Parse CLI args with `getopts` for simple cases, `while [[ $# -gt 0 ]]; do; case` for complex.
- Prefer `[[ ]]` over `[ ]`; `$( )` over backticks.
- Quote all variable expansions: `"$var"`, `"$@"`.
- Use `local` in functions.
- `trap cleanup EXIT` for temp files.
- Validate arguments early, fail fast with readable error messages.

## Fish

- Extension: `.fish`
- Shebang: `#!/usr/bin/env fish`
- Options: `set -euo pipefail` is the default behavior.
- Use `argparse` for CLI options.
- Use `set -l` for local variables, `set -g` for global.
- Fish is interactive-first; avoid fish-specific scripts for reusable tooling unless the team uses fish.
- Prefer bash for CI/CD, cross-platform, or reusable scripts.

## Layout for a multi-script project

```
scripts/
  <name>.bash       # executable, public
  lib/<name>.bash   # source'd helpers (no shebang, not executable)
  <name>.fish       # fish alternative (same interface)
```

## Best practices

- Validate config at start; fail early.
- Never eval user input.
- Use `readonly` / `declare -r` for constants in bash.
- Print errors to stderr: `echo "error: ..." >&2`.
- Support `--help` and `--dry-run` where useful.
