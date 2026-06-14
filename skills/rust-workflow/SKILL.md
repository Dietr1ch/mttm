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

- `cargo build` / `cargo run`
- `cargo test` — run tests
- `cargo clippy` — lint
- `cargo fmt` — format
- `cargo doc --open` — build and open docs

## Key crates

- `anyhow` / `thiserror` — error handling
- `serde` / `serde_json` — serialization
- `clap` — CLI argument parsing
- `tokio` — async runtime
- `rayon` — data parallelism
- `tracing` — structured logging
