---
name: python-workflow
description: Use when writing, testing, or packaging Python code.
---

# Python Workflow

## Nix + Python

This project may provide a Nix flake with a development shell. ALWAYS check for a `flake.nix` before setting up manually.

- Enter the shell: `nix develop` (or `nix develop .#python` if multiple shells exist)
- Inside the shell, `python`, `uv`, `ruff`, `mypy`, and `pytest` are available — no venv needed.
- If the project has no flake, fall back to manual setup (see below).

## Project setup (manual)

- `uv init` or `python -m venv .venv`
- Use `pyproject.toml` for project metadata
- Pin deps via `uv lock`

## Development loop

- `ruff check` — lint
- `ruff format` — format
- `pytest` — run tests
- `mypy .` — type check
- `python -m build` — build package

## Key libraries

- `pydantic` — data validation
- `rich` — beautiful terminal output
- `click` / `typer` — CLI
- `polars` / `pandas` — data frames
- `httpx` — HTTP client

---

*Loaded by the **python-dev** subagent.* See agent/python-dev.md for the agent prompt.
