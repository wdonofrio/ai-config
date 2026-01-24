#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
codex_home="${CODEX_HOME:-$HOME/.codex}"

if [[ ! -d "$codex_home" ]]; then
  echo "CODEX_HOME not found: $codex_home" >&2
  exit 1
fi

link_one() {
  local name="$1"
  local target="$codex_home/$name"
  local link_path="$repo_root/$name"

  if [[ -L "$link_path" ]]; then
    local existing
    existing="$(readlink "$link_path")"
    if [[ "$existing" == "$target" ]]; then
      echo "ok: $name -> $existing"
      return 0
    fi
    echo "error: $link_path points to $existing (expected $target)" >&2
    exit 1
  fi

  if [[ -e "$link_path" ]]; then
    echo "error: $link_path exists and is not a symlink" >&2
    exit 1
  fi

  ln -s "$target" "$link_path"
  echo "linked: $name -> $target"
}

link_one "config.toml"
link_one "rules"
link_one "skills"
