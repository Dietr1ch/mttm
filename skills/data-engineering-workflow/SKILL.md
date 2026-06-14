---
name: data-engineering-workflow
description: Use when designing schemas, writing queries, or building data pipelines with Postgres or DuckDB.
---

# Data Engineering Workflow

## DuckDB

- Great for analytics, CSV/Parquet/JSON querying, in-process
- `duckdb` CLI or Python `duckdb` module
- Supports direct querying of Parquet files

## Postgres

- Transactional workloads, multi-user, ACID
- Use `pgAdmin`, `psql`, or `dbeaver` for management
- Design with normalized schemas and appropriate indexes

## Patterns

- CTEs over subqueries
- Use `EXPLAIN ANALYZE` to debug slow queries
- Partition large tables by date
- Materialized views for expensive aggregations

---

*Loaded by the **data-engineer** subagent.* See agent/data-engineer.md for the agent prompt.
