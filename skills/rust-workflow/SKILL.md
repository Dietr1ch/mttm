---
name: rust-workflow
description: Use when writing, building, or debugging Rust code with Cargo.
permission:
  read:
    "**/*.rs": allow
  edit:
    "**/*.rs": allow
  bash:
    "cargo clean *": ask
    "cargo doc *": allow
    "cargo clippy *": allow
    "cargo fmt *": allow
    "cargo nextest *": allow
    "cargo check *": allow
    "cargo build *": allow
    "cargo search *": allow
    "cargo add *": ask
    "cargo remove *": ask
    "cargo run *": ask
    "cargo test *": ask
---

# Rust Workflow

## Project setup

- `cargo new <name>` or `cargo init`
- Use `cargo add` / `cargo rm` for adjusting dependencies
- Prefer `workspace` for multi-crate projects

## Development loop

- `cargo check` / `cargo build` / `cargo run`
- `cargo nextest run` — run tests
- `cargo clippy` — lint
- `cargo fmt` — format
- `cargo doc --open` — build and open docs

## Key crates

- `clap` with `derive` for argument parsing and `env` to read environment variables. This subsumes `dotenvy`. Pair with `humantime` to parse durations.
- `config` for configuration
- `thiserror` for error handling in libraries. `eyre` is preferred in `src/bin/`
- `log` for logging in library code. `tracing` + `tracing-subscriber` + `tracing-log` in application
- `googletest` and `proptest` for testing.
- `serde` + `serde_ron` / `serde_json` for serialization
  - Use `googletest_json_serde` to write patterns for JSON data.
- `rayon` for parallelism
- `tokio` for async
- `reqwest` for HTTP clients
- `axum` for HTTP servers
  - Also use `axum-test` when testing.
- `duckdb`, `polars`, `arrow` for dealing with data
- `diesel-async` using `bb8` and `migrations` for applications using databases and owning the schemas.
- `sqlx` for using databases where we don't own the schema.

---

*Loaded by the **rust-dev** subagent.* See agent/rust-dev.md for the agent prompt.
