---
name: reasoning-workflow
description: Use when modeling logic problems, constraint satisfaction, or optimization tasks with Prolog or MiniZinc.
---

# Reasoning Workflow

## Prolog

- Use SWI-Prolog for general logic programming
- Facts + rules + queries paradigm
- Use DCGs for parsing
- Use `findall/3`, `setof/3`, `bagof/3` for collection

## MiniZinc

- Constraint modeling language, solver-agnostic
- `.mzn` = model file, `.dzn` = data file
- `minizinc --solver <solver> model.mzn data.dzn`
- Common solvers: Gecode, Chuffed, OR-Tools

## Tips

- Start with a clear declarative spec of the problem
- Separate model from data
- Use `constraint` and `solve` blocks explicitly
- Optimize with `solve minimize` / `solve maximize`
