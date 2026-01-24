# Codex Config Repo

This repo is a versioned home for Codex CLI configuration. It is meant to be
symlinked into your live Codex config directory so edits here immediately affect
Codex behavior.

## How It Works

Tracked items in this repo are symlinks into `$CODEX_HOME` (defaults to
`~/.codex`). That means:
- Editing files in this repo changes live Codex config.
- Updating live Codex config updates this repo.

Currently linked:
- `config.toml` -> `$CODEX_HOME/config.toml`
- `rules/` -> `$CODEX_HOME/rules`
- `skills/` -> `$CODEX_HOME/skills`

## Bootstrap / Verify Symlinks

Use the helper script to create or verify the symlinks:

```bash
./scripts/link-codex-config.sh
```

If you keep Codex config elsewhere, set `CODEX_HOME`:

```bash
CODEX_HOME=/path/to/codex ./scripts/link-codex-config.sh
```

## Notes

- `AGENTS.md` at repo root configures Codex CLI for this repo.
- Local-only files (auth, sessions, logs) are intentionally ignored.
