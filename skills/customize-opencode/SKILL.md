---
name: customize-opencode
description: Use ONLY when the user is editing or creating opencode's own configuration: opencode.jsonc, agent/*.md, skills/*/SKILL.md, or adding new agents/skills. Do not use for user application code.
---

# Customizing OpenCode Configuration

This skill activates when you are editing this opencode configuration repo.

## Project structure

```
opencode.jsonc          # Main config: models, default agent, instructions
agent/
  orchestrator.md       # Primary agent — routes tasks to subagents
  rust-dev.md           # Subagent: Rust specialist
  python-dev.md         # Subagent: Python specialist
  haskell-dev.md        # Subagent: Haskell specialist
  web-dev.md            # Subagent: Web (vanilla HTML/CSS/JS)
  data-engineer.md      # Subagent: Postgres/DuckDB
  reasoning-engineer.md # Subagent: Prolog/MiniZinc
skills/
  <name>/SKILL.md       # Domain skill (loaded on demand via skill tool)
```

## Conventions

- Each agent `.md` file has YAML frontmatter with `description`, `mode`, `model`, `permission`.
- Use `mode: primary` for orchestrator, `mode: subagent` for specialists.
- `small_model` in opencode.jsonc should match the model used by subagents.
- Permissions follow least-privilege: only allow file types the agent should edit.
- Skills go under `skills/<name>/SKILL.md`. The frontmatter `name` + `description` is what appears in the agent's available skills list.

## Validation checklist after changes

1. `opencode.jsonc` is valid JSON (comments are allowed in `.jsonc`).
2. Every agent referenced in `orchestrator.md` has a corresponding `.md` file in `agent/`.
3. Every skill's `name` in its frontmatter matches the directory name.
4. Model strings in agent frontmatter are consistent with `opencode.jsonc`.
5. Permission patterns are specific — avoid bare `"*": "allow"`.

---

*Loaded by the **orchestrator** when editing this configuration project itself.* See agent/orchestrator.md for context.
