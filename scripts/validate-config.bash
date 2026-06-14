#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
errors=0

check_frontmatter() {
    local file="$1"
    local name="$2"
    if [[ ! -f "$file" ]]; then
        echo "MISSING: $name ($file)"
        return 1
    fi
    # Check it starts with ---
    if ! head -1 "$file" | grep -q '^---$'; then
        echo "BAD FRONTMATTER: $name — missing opening ---"
        return 1
    fi
    # Check description field exists
    if ! grep -q '^description: ' "$file"; then
        echo "BAD FRONTMATTER: $name — missing description"
        return 1
    fi
}

echo "=== Checking agents ==="
for agent in "$root"/agent/*.md; do
    name="$(basename "$agent")"
    check_frontmatter "$agent" "$name" || ((errors++))
done

echo "=== Checking skills ==="
for skill in "$root"/skills/*/SKILL.md; do
    name="$(basename "$(dirname "$skill")")"
    check_frontmatter "$skill" "skills/$name" || ((errors++))
    # Check name field matches directory
    if ! grep -q "^name: $name\$" "$skill"; then
        echo "MISMATCH: skills/$name — SKILL.md name != directory name"
        ((errors++))
    fi
done

echo "=== Checking model consistency ==="
jsonc="$root/opencode.jsonc"
if [[ -f "$jsonc" ]]; then
    small_model=$(grep '"small_model"' "$jsonc" | sed 's/.*"small_model": *"\(.*\)",*/\1/')
    for agent in "$root"/agent/*.md; do
        agent_model=$(grep '^model: ' "$agent" | sed 's/^model: //')
        name="$(basename "$agent")"
        # Warn if subagent uses small_model but agent_model differs
        if grep -q 'mode: subagent' "$agent"; then
            if [[ "$agent_model" =~ ^ollama/ && "$agent_model" != "$small_model" ]]; then
                echo "NOTE: $name uses $agent_model (small_model is $small_model)"
            fi
        fi
    done
fi

echo "=== Summary ==="
if ((errors > 0)); then
    echo "FAILED: $errors error(s) found"
    exit 1
else
    echo "OK: all checks passed"
fi
