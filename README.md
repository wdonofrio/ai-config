# Codex Config (Shareable)

This repo is a shareable, version-controlled Codex CLI configuration. Clone it,
customize it, and symlink it into your local Codex config directory so Codex
uses these rules and skills directly.

## Recommended Setup (Symlink)

1. Clone this repo:
```bash
git clone git@github.com:wdonofrio/codex.git ~/projects/codex
```

2. Point Codex to this repo via symlinks:
```bash
ln -s ~/projects/codex/config.toml ~/.codex/config.toml
ln -s ~/projects/codex/rules ~/.codex/rules
ln -s ~/projects/codex/skills ~/.codex/skills
```

If your Codex config lives elsewhere, replace `~/.codex` or set `CODEX_HOME`.

## What's Inside

- `config.toml`: Codex config
- `rules/`: lightweight, language-agnostic rule checklists
- `skills/`: reusable workflow skills (planning, review, TDD, doc updates)
- `AGENTS.md`: repo-level Codex instructions for this project

## Local-Only Files

Local state (auth, sessions, logs) should not be committed; they stay in
`~/.codex` and are ignored here.
