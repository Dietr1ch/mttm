---
name: documentation-workflow
description: Use when writing, reviewing, or structuring documentation — READMEs, API docs, tutorials, changelogs, and user guides.
---

# Documentation Workflow

## Principles

- **Know your audience.** End-users need different docs than contributors or API
  consumers. State the intended audience early.
- **Be concise but complete.** Say everything necessary, nothing more.
- **Consistent terminology.** Don't switch between synonyms for the same concept.
- **Examples over abstraction.** A concrete example is worth ten paragraphs of
  explanation.
- **Progressive disclosure.** Start simple, then layer on detail and edge cases.

## README structure

A good README answers these questions in order:

1. **What is this?** — project name, one-line description, badges (CI, version, license)
2. **Why would I use it?** — problem it solves, how it's different from alternatives
3. **How do I get started?** — installation, minimal working example
4 **How do I use it?** — common usage patterns, configuration reference
5. **Where do I go for help?** — link to docs, issues, discussions
6. **How do I contribute?** — link to CONTRIBUTING.md
7. **What's the license?** — brief note

## API documentation

- Document all public functions, types, constants, and modules.
- Every function doc includes: signature, description, parameters, return value,
  at least one example, and error conditions.
- Use consistent doc-comment style for the language (rustdoc, Haddock, pydoc,
  JSDoc).
- Keep docs close to the code they describe.
- When reviewing API docs, verify they match the actual signatures.

## Changelog

Follow <https://keepachangelog.com>:

```
# Changelog

## [Unreleased]

### Added
- New features

### Changed
- Changes in existing functionality

### Deprecated
- Soon-to-be removed features

### Removed
- Removed features

### Fixed
- Bug fixes

### Security
- Vulnerability fixes
```

## Contributing guide structure

- Setup instructions (clone, build, test)
- Coding conventions and style guide
- Pull request process
- How to report issues
- Code of conduct reference

## Style guide

| Element                | Convention                                           |
|------------------------+------------------------------------------------------|
| Voice                  | Active ("The tool parses JSON" not "JSON is parsed") |
| Person                 | Second person ("you") for user docs                  |
| Code blocks            | Always annotate the language: ```rust                |
| Headings               | ATX-style (`##`), no skipped levels                  |
| Line length            | 80-100 chars in prose, unlimited in code blocks      |
| Lists                  | Use `-` for unordered, `1.` for ordered              |
| Emphasis               | `*italic*` for terms, `**bold**` for emphasis        |
| Links                  | Reference-style for repeated links                   |
| File names             | `filename` in backticks                              |
| Terminal commands      | `$` prefix for shell, `>` prefix for REPL            |

---

*Loaded by the **doc-dev** subagent.* See agent/doc-dev.md for the agent prompt.
