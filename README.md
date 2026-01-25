# AI Config (Shareable)

Shareable, version-controlled configuration for AI coding assistants. Currently supports:
- **Codex CLI** (`~/.codex`)
- **Claude Code** (`~/.claude`)

Clone it, customize it, and symlink it so both tools share skills and guidelines.

## Directory Structure

```
ai-config/
├── codex/                    # Codex CLI specific
│   ├── config.example.toml   # Example config (copy to config.toml)
│   ├── rules/                # Permission rules
│   └── skills/               # Codex-only skills (.system)
├── claude/                   # Claude Code specific
│   └── settings.example.json # Example settings (copy to settings.json)
└── shared/                   # Shared between both tools
    ├── skills/               # Reusable workflow skills
    └── guidelines/           # Coding standards, security, etc.
```

## Setup

### 1. Clone this repo

```bash
git clone <your-repo-url> ~/projects/ai-config
```

### 2. Create local config files

```bash
# Codex
cp ~/projects/ai-config/codex/config.example.toml ~/projects/ai-config/codex/config.toml
cp ~/projects/ai-config/codex/rules/default.example.rules ~/projects/ai-config/codex/rules/default.rules
# Edit these files with your local paths and preferences

# Claude (optional - Claude works without settings.json)
cp ~/projects/ai-config/claude/settings.example.json ~/projects/ai-config/claude/settings.json
```

### 3. Symlink to config directories

#### Codex CLI

```bash
# Remove existing files/symlinks if present
rm -f ~/.codex/config.toml ~/.codex/rules ~/.codex/skills 2>/dev/null

# Create symlinks
ln -s ~/projects/ai-config/codex/config.toml ~/.codex/config.toml
ln -s ~/projects/ai-config/codex/rules ~/.codex/rules
ln -s ~/projects/ai-config/shared/skills ~/.codex/skills
```

#### Claude Code

```bash
# Remove existing if present
rm -rf ~/.claude/skills 2>/dev/null

# Create symlinks
ln -s ~/projects/ai-config/shared/skills ~/.claude/skills
# Optional: ln -s ~/projects/ai-config/claude/settings.json ~/.claude/settings.json
```

## What's Shared

### Skills (`shared/skills/`)
Reusable workflow skills with compatible format for both Codex and Claude:
- `code-review/` - Structured code review with priorities and checklists
- `commit/` - Conventional commits workflow
- `debugging/` - Systematic debugging process
- `planning-workflow/` - Implementation planning with SDLC phases
- `refactoring/` - Safe refactoring with patterns and smells
- `skill-lookup/` - Find and install skills from prompts.chat
- `tdd-workflow/` - Test-driven development cycle
- `update-docs/` - Documentation update workflow (Next.js focused)

### Guidelines (`shared/guidelines/`)
Language-agnostic standards and checklists:
- `coding-style.md` - Readability, data flow, organization
- `error-handling.md` - Error patterns and best practices
- `git-workflow.md` - [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/), branching, PRs
- `performance.md` - When and how to optimize
- `security.md` - OWASP-style security checklist
- `testing.md` - Test pyramid, quality, coverage

## Local-Only Files

These files contain user-specific paths and are gitignored:
- `codex/config.toml` - Codex configuration with local paths
- `codex/rules/default.rules` - Permission rules with local paths
- `claude/settings.json` - Claude settings

Copy from the `.example` versions and customize locally.

### Managing Sensitive Files with Chezmoi

For user-specific config files that contain paths or sensitive data, use [chezmoi](https://www.chezmoi.io/) to manage them in a **private** repository:

```bash
# Add your local config files to chezmoi (stored in private dotfiles repo)
chezmoi add ~/projects/ai-config/codex/config.toml
chezmoi add ~/projects/ai-config/codex/rules/default.rules
chezmoi add ~/projects/ai-config/claude/settings.json

# Use templates for machine-specific values
chezmoi edit ~/projects/ai-config/codex/config.toml
# Then use {{ .chezmoi.homeDir }} instead of hardcoded paths
```

This keeps sensitive/personal configuration version-controlled privately while sharing the public skills and guidelines through this repo.

## Notification Hooks

The `scripts/notify.sh` script provides cross-platform notifications for Claude Code hooks:

**Supported platforms:**
- **macOS**: Uses `terminal-notifier` (preferred) or `osascript`
- **Windows/WSL**: Uses PowerShell toast notifications
- **VS Code terminals**: Uses terminal bell + title update
- **Linux**: Uses `notify-send`

**Setup:**
1. Copy the example settings to create your local config:
   ```bash
   cp ~/projects/ai-config/claude/settings.example.json ~/projects/ai-config/claude/settings.json
   ```

2. Symlink to Claude's config directory:
   ```bash
   ln -s ~/projects/ai-config/claude/settings.json ~/.claude/settings.json
   ```

**Hook events configured:**
- `Stop`: Notifies when Claude finishes a task
- `Notification` (idle_prompt): Notifies when Claude is waiting for input

**macOS setup:**
```bash
# Install terminal-notifier for better notifications
brew install terminal-notifier
```

**Customizing notifications:**
Edit `claude/settings.json` to modify hook events or notification messages.

## Adding New Skills

Skills use a compatible markdown format:

```markdown
---
name: my-skill
description: What this skill does
---

# My Skill

Instructions here...
```

Place in `shared/skills/my-skill/SKILL.md` to make available in both tools.
