# AI Config Repository

This repo provides shared, version-controlled configuration for AI coding assistants (Claude Code, Codex CLI).

## Structure

- `shared/guidelines/` - Language-agnostic coding standards (security, testing, performance, etc.)
- `shared/skills/` - Reusable workflow skills (code-review, commit, debugging, TDD, etc.)
- `claude/` - Claude Code-specific settings and hooks
- `codex/` - Codex CLI-specific config and permission rules
- `scripts/` - Setup and utility scripts

## Conventions

- All guidelines and skills are language-agnostic unless explicitly scoped to a framework.
- Skills use markdown with YAML frontmatter and live in `shared/skills/{name}/SKILL.md`.
- Guidelines are standalone markdown files in `shared/guidelines/`.
- Local config files (without `.example`) are gitignored and contain user-specific paths.
- Follow Conventional Commits for all changes to this repo.

## When editing

- Keep guidelines concise and actionable. Avoid verbose explanations when a checklist suffices.
- Cross-reference other guidelines where relevant (e.g., security checks in code-review skill).
- Test setup scripts on both macOS and Linux when modifying them.
- Do not add secrets, credentials, or user-specific paths to tracked files.
