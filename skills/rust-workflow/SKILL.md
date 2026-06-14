---
name: rust-workflow
description: Use when writing, building, or debugging Rust code with Cargo.
---

# Rust Workflow

## Project setup

- `cargo new <name>` or `cargo init`
- Use `cargo add` for dependencies
- Prefer `workspace` for multi-crate projects

## Development loop

- `cargo check` / `cargo build` / `cargo run`
- `cargo nextest run` — run tests
- `cargo clippy` — lint
- `cargo fmt` — format
- `cargo doc --open` — build and open docs

## Key crates

- `clap` with `derive` for argument parsing and `env` to read environment variables
- `config` for configuration
- `thiserror` for error handling in libraries. `eyre` is preferred in `src/bin/`
- `log` for logging in library code. `tracing` + `tracing-subscriber` + `tracing-log` in application
- `serde` + `serde_ron` / `serde_json` for serialization
- `rayon` for parallelism
- `tokio` for async
- `reqwest` for HTTP clients
- `axum` for HTTP servers
- `duckdb`, `polars`, `arrow` for dealing with data
- `sqlx` for dealing with data

---

*Loaded by the **rust-dev** subagent.* See agent/rust-dev.md for the agent prompt.
