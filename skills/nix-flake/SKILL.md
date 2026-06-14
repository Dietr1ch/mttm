---
name: nix-flake
description: Use when setting up or modifying Nix flake environments for reproducible dev shells.
---

# Nix Flake

This project uses Nix flakes for reproducible development environments.

## Structure

```
flake.nix          # Entry point
flake.lock         # Pinned dependencies (auto-generated)
nix/               # Supporting Nix files
```

## Common commands

- `nix develop` — enter the dev shell
- `nix build` — build the project
- `nix flake update` — update all inputs
- `nix flake check` — check flake evaluation

## Best practices

- Pin all inputs via `flake.lock`.
- Keep `flake.nix` minimal; split logic into `nix/` modules.
- Use `nixpkgs-fmt` for formatting Nix files.
- Prefer `nix-shell` compatibility via `devShells.default`.
