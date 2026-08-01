---
name: multi-agent
description: Use when orchestrating tasks across subagents, defining handoff protocols, or structuring multi-agent workflows.
---

# Multi-Agent Orchestration

This project uses a primary orchestrator agent with specialized subagents.

## Architecture

- **orchestrator** (primary) — understands the full system, routes tasks
- **subagents** — domain specialists with focused prompts and permissions
- **reviewer** — independent, read-only diff reviewer used before commits

## Task decomposition

When the orchestrator receives a request:

1. Break it into domain-specific subtasks.
2. Delegate each subtask to the appropriate subagent using the `task` tool.
3. Collect results and integrate them into a coherent response.

Default to delegating, even for small tasks: a specialist with domain skills
usually beats the orchestrator doing it inline. Dispatch independent
subtasks in parallel. Only handle a task directly when it is a pure question,
an edit to the configuration itself, or too small to justify a round-trip.

## Handoff conventions

- Each subagent receives a clear, self-contained task description.
- The orchestrator provides relevant context (files, schemas, prior decisions).
- Subagents return results; they do not make cross-domain changes.
- The orchestrator reviews and resolves conflicts between subagent outputs.

## Review before commit

- The orchestrator inspects `git diff` before committing every unit.
- Substantial, cross-domain, or security-sensitive changes get an independent
  pass from @reviewer.
- The reviewer reports findings with severity (BLOCKING / NON-BLOCKING / NIT);
  it never edits and never commits.
- For security-sensitive changes, the reviewer loads the **security-review**
  skill and audits against its checklist.
- Blocking findings are fixed (possibly by re-delegating to the specialist)
  before the commit.

## Commits

- The orchestrator owns git operations and never delegates commits to a
  subagent — a dedicated committer would lose the context the orchestrator
  already holds.
- Commits are small and unit-scoped: one logical change per commit, no
  unrelated changes bundled.
- Message: `<area>: <concise imperative summary>` with a body explaining what
  and why (not how).

---

*Loaded by the **orchestrator** when decomposing complex requests.* See agent/orchestrator.md for context.
