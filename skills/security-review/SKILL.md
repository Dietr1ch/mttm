---
name: security-review
description: Use when reviewing changes for security issues — auth, injection, secrets, deserialization, crypto, dependency vulnerabilities.
---

# Security Review

Use this checklist when auditing a diff for security. Cover only what the
changed surface can plausibly touch; do not pad the review with generic
findings.

## Authentication & authorization

- Every state-changing endpoint re-checks authorization — the caller is
  allowed to act on that specific resource. Look for IDOR: object IDs from
  URLs must be verified against the caller's ownership or role.
- New endpoints use the same auth middleware/session handling as their
  neighbors.
- No hardcoded credentials, API keys, or default passwords.
- Sessions/tokens: proper expiry and revocation; no tokens in
  client-visible storage (`localStorage` is a red flag).
- Login/register paths: rate limiting, no user enumeration via distinct
  error messages.

## Injection & input handling

- SQL: parameterized queries or an ORM — never string-concatenated user
  input. Check new query-building code (`raw` SQL, `.execute`, `format!`-ed
  SQL, `.where` with interpolation).
- HTML/JS: output is encoded; untrusted content is not injected via
  `innerHTML`, `eval`, `document.write`, or template interpolation.
- Command execution: no user input in shell commands without proper
  argument separation; prefer argument arrays over string commands.
- Filesystem: user-supplied paths are canonicalized and constrained to the
  intended directory (path traversal).
- Validation: inputs are length- and type-limited; JSON/XML parsing is
  hardened (no entity expansion, no prototype pollution).
- No `curl ... | sh` style remote-execution patterns added to scripts or
  docs.

## Secrets & data protection

- No secrets committed, echoed, or logged — including in comments, example
  configs, or test fixtures. Flag anything that looks like a real
  token/key/password.
- PII and tokens are not added to logs.
- Secrets come from environment variables or a secret manager, with defaults
  that fail closed.

## Deserialization & crypto

- No unsafe deserialization: `pickle`, `yaml.load` (use `safe_load`), JSON
  parsers with prototype merging, or reflection-based loading of untrusted
  input.
- Crypto: established libraries with secure defaults; no hand-rolled
  ciphers/hashes; TLS in transport.
- Passwords hashed with a memory-hard KDF (argon2, bcrypt, scrypt); never
  stored or compared in plaintext.
- Security-sensitive randomness (tokens, nonces) uses a CSPRNG.

## Dependencies & supply chain

- New dependencies are pinned to concrete, maintained versions.
- No known-vulnerable packages introduced; flag obvious high-risk additions.
- Build/deploy scripts do not fetch and execute remote code.

## Web-specific (HTTP/UI changes)

- CSRF protection on state-changing requests.
- SSRF: user-supplied URLs are restricted (no internal-metadata access).
- CORS: narrow origins, no wildcard with credentials.
- Security headers (CSP, X-Content-Type-Options, X-Frame-Options) not
  weakened by the change.
- Open redirects: no unvalidated `redirect` parameters.
- File uploads: type/size validated, stored outside executable paths.

## Reporting

Report only what the diff can plausibly touch. Map the most severe findings
to the relevant OWASP category so the orchestrator can judge severity.
