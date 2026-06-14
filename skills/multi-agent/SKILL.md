---
name: multi-agent
description: Use when orchestrating tasks across subagents, defining handoff protocols, or structuring multi-agent workflows.
---

# Multi-Agent Orchestration

This project uses a primary orchestrator agent with specialized subagents.

## Architecture

- **orchestrator** (primary) — understands the full system, routes tasks
- **subagents** — domain specialists with focused prompts and permissions

## Task decomposition

When the orchestrator receives a request:

1. Break it into domain-specific subtasks.
2. Delegate each subtask to the appropriate subagent using the `task` tool.
3. Collect results and integrate them into a coherent response.

## Handoff conventions

- Each subagent receives a clear, self-contained task description.
- The orchestrator provides relevant context (files, schemas, prior decisions).
- Subagents return results; they do not make cross-domain changes.
- The orchestrator reviews and resolves conflicts between subagent outputs.
