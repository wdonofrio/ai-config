#!/usr/bin/env bash
set -euo pipefail

# Link ai-config to Claude Code config directory
# Usage: ./scripts/link-claude-config.sh

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
claude_home="${CLAUDE_HOME:-$HOME/.claude}"

if [[ ! -d "$claude_home" ]]; then
  echo "Creating $claude_home"
  mkdir -p "$claude_home"
fi

link_one() {
  local name="$1"
  local source="$2"
  local target="$claude_home/$name"

  if [[ -L "$target" ]]; then
    local existing
    existing="$(readlink "$target")"
    if [[ "$existing" == "$source" ]]; then
      echo "ok: $name -> $existing"
      return 0
    fi
    echo "updating: $name -> $source (was $existing)"
    rm "$target"
  elif [[ -e "$target" ]]; then
    echo "warning: $target exists and is not a symlink, skipping" >&2
    return 0
  fi

  ln -s "$source" "$target"
  echo "linked: $name -> $source"
}

link_one "skills" "$repo_root/shared/skills"

# Link settings if local settings.json exists
if [[ -f "$repo_root/claude/settings.json" ]]; then
  link_one "settings.json" "$repo_root/claude/settings.json"
fi

echo ""
echo "Done. Shared skills are now available to Claude Code."
if [[ ! -f "$repo_root/claude/settings.json" ]]; then
  echo "Tip: Copy claude/settings.example.json to claude/settings.json to also link settings."
fi
