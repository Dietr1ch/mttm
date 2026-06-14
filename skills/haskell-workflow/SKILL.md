---
name: haskell-workflow
description: Use when writing, building, or debugging Haskell code with Cabal or Stack.
---

# Haskell Workflow

## Project setup

- `cabal init` or `stack new`
- Use Cabal files or `package.yaml` (hpack) for dependencies

## Development loop

- `cabal build` / `cabal run`
- `cabal test` — run tests
- `cabal repl` — GHCi REPL
- `cabal haddock` — build docs
- `ormolu --mode inplace` — format

## Key libraries

- `mtl` / `effectful` — effect systems
- `text` / `bytestring` — string types
- `aeson` — JSON handling
- `hspec` / `tasty` — testing
- `megaparsec` — parsing
- `optparse-applicative` — CLI
