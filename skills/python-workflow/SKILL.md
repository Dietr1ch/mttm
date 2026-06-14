---
name: python-workflow
description: Use when writing, testing, or packaging Python code.
---

# Python Workflow

## Project setup

- `uv init` or `python -m venv .venv`
- Use `pyproject.toml` for project metadata
- Pin deps via `uv lock` or `pip freeze > requirements.txt`

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
