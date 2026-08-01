#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
errors=0
warnings=0

# All valid top-level permission keys. Any other key under `permission:`
# (e.g. a misspelled or retired key like `write`) is a config bug.
readonly KNOWN_PERMS="read edit bash task skill webfetch websearch question glob grep"

# Expected model per agent file, mirroring README.org's Model Strategy.
declare -A EXPECTED_MODELS=(
    [orchestrator.md]=deepseek/deepseek-v4-flash
    [rust-dev.md]=deepseek/deepseek-v4-flash
    [haskell-dev.md]=deepseek/deepseek-v4-flash
    [python-dev.md]=deepseek/deepseek-v4-flash
    [web-dev.md]=deepseek/deepseek-v4-flash
    [doc-dev.md]=deepseek/deepseek-v4-flash
    [data-engineer.md]=deepseek/deepseek-v4-flash
    [reasoning-engineer.md]=deepseek/deepseek-v4-pro
    [reviewer.md]=deepseek/deepseek-v4-pro
)

_fail() {
    echo "ERROR: $*" >&2
    errors=$((errors + 1))
}

_warn() {
    echo "WARN: $*" >&2
    warnings=$((warnings + 1))
}

# A permission mapping block's rules are evaluated last-match-wins, so a
# "*" catch-all must come first; a late catch-all would nullify the
# specific allows listed before it.
_check_catchall_order() {
    local name="$1" block="$2"
    shift 2
    local first_rule="${1:-}" rule has_catch=0
    for rule in "$@"; do
        if [[ "$rule" == *'"*"'* ]]; then
            has_catch=1
            break
        fi
    done
    if [[ $has_catch -eq 1 && "$first_rule" != *'"*"'* ]]; then
        _fail "$name: permission.$block: \"*\" catch-all must precede specific rules (last-match-wins)"
    fi
}

# Validate a `permission:` block: every key must be a known permission,
# and mapping blocks must keep their "*" catch-all first.
check_permissions() {
    local file="$1" name="$2"
    local perm_sec line key
    perm_sec="$(awk '/^permission:/{p=1; next} p && /^[^ ]/{exit} p{print}' "$file")"
    [[ -z "$perm_sec" ]] && return 0

    local in_block=0 block_name=""
    local rule_re='^[[:space:]]{4}"'
    local -a block=()
    while IFS= read -r line; do
        if [[ "$line" =~ ^[[:space:]]{2}[a-z]+: ]]; then
            if [[ $in_block -eq 1 ]]; then
                _check_catchall_order "$name" "$block_name" "${block[@]}"
                in_block=0
            fi
            key="${line%%:*}"
            key="${key// /}"
            if [[ " $KNOWN_PERMS " != *" $key "* ]]; then
                _fail "$name: unknown permission key '$key'"
            fi
            block_name="$key"
        elif [[ "$line" =~ $rule_re ]]; then
            if [[ $in_block -eq 0 ]]; then
                in_block=1
                block=()
            fi
            block+=("$line")
        fi
    done <<< "$perm_sec"
    if [[ $in_block -eq 1 ]]; then
        _check_catchall_order "$name" "$block_name" "${block[@]}"
    fi
}

check_frontmatter() {
    local file="$1" name="$2"
    if [[ ! -f "$file" ]]; then
        _fail "$name: missing file ($file)"
        return 1
    fi
    if ! head -1 "$file" | grep -q '^---$'; then
        _fail "$name: missing opening ---"
        return 1
    fi
    if ! grep -q '^description: ' "$file"; then
        _fail "$name: missing description"
        return 1
    fi
    # A closing --- must appear after the opening one.
    if ! awk 'NR > 1 && /^---$/ { found = 1; exit } END { exit !found }' "$file"; then
        _fail "$name: missing closing ---"
        return 1
    fi
    return 0
}

check_model() {
    local file="$1" name="$2"
    local agent_model expected
    agent_model="$(grep -m1 '^model: ' "$file" | sed 's/^model: //' || true)"
    if [[ -z "$agent_model" ]]; then
        _fail "$name: missing model"
        return
    fi
    expected="${EXPECTED_MODELS[$name]:-}"
    if [[ -n "$expected" && "$agent_model" != "$expected" ]]; then
        _fail "$name: model '$agent_model' != expected '$expected'"
    fi
}

check_mode() {
    local file="$1" name="$2"
    local mode
    mode="$(grep -m1 '^mode: ' "$file" | sed 's/^mode: //' || true)"
    if [[ "$name" == "orchestrator.md" ]]; then
        [[ "$mode" == "primary" ]] || _fail "$name: mode '$mode' != primary"
    else
        [[ "$mode" == "subagent" ]] || _fail "$name: mode '$mode' != subagent"
    fi
}

# The main config's model must match the orchestrator's, and small_model
# must be set to something distinct from it.
check_main_config() {
    local jsonc="$1"
    local main_model small_model orch_model
    main_model="$(sed -n 's/^[[:space:]]*"model": *"\([^"]*\)",*/\1/p' "$jsonc" | head -1)"
    small_model="$(sed -n 's/^[[:space:]]*"small_model": *"\([^"]*\)",*/\1/p' "$jsonc" | head -1)"
    orch_model="$(grep -m1 '^model: ' "$root/agent/orchestrator.md" 2>/dev/null | sed 's/^model: //' || true)"

    if [[ -z "$main_model" ]]; then
        _fail "opencode.jsonc: missing \"model\""
    elif [[ -n "$orch_model" && "$main_model" != "$orch_model" ]]; then
        _fail "opencode.jsonc: model '$main_model' != orchestrator model '$orch_model'"
    fi
    if [[ -z "$small_model" ]]; then
        _fail "opencode.jsonc: missing \"small_model\""
    elif [[ "$small_model" == "$main_model" ]]; then
        _warn "opencode.jsonc: small_model equals model"
    fi
}

echo "=== Checking agents ==="
for agent in "$root"/agent/*.md; do
    name="$(basename "$agent")"
    if check_frontmatter "$agent" "$name"; then
        check_permissions "$agent" "$name"
        check_model "$agent" "$name"
        check_mode "$agent" "$name"
    fi
done

echo "=== Checking skills ==="
for skill in "$root"/skills/*/SKILL.md; do
    name="$(basename "$(dirname "$skill")")"
    if check_frontmatter "$skill" "skills/$name"; then
        check_permissions "$skill" "skills/$name"
        if ! grep -q "^name: $name\$" "$skill"; then
            _fail "skills/$name: SKILL.md name != directory name"
        fi
    fi
done

echo "=== Checking main config ==="
jsonc="$root/opencode.jsonc"
if [[ -f "$jsonc" ]]; then
    check_main_config "$jsonc"
else
    _fail "missing opencode.jsonc"
fi

echo "=== Summary ==="
if ((errors > 0)); then
    echo "FAILED: $errors error(s) found" >&2
    exit 1
elif ((warnings > 0)); then
    echo "OK: $warnings warning(s)"
else
    echo "OK: all checks passed"
fi
