#!/usr/bin/env bash
# Run on the OLD Mac: copy current Claude config into this repo so it can be committed.
# Review `git diff` before committing: MCP and Desktop configs may contain secrets.
set -euo pipefail

REPO_CLAUDE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$HOME/.claude"
DESKTOP="$HOME/Library/Application Support/Claude/claude_desktop_config.json"

# Skip anything that is already a link into this repo.
copy() {
  local src="$1" dst="$2"
  [[ -e "$src" && ! -L "$src" ]] || return 0
  rm -rf "$dst"
  cp -R "$src" "$dst"
  echo "copied  $src"
}

main() {
  local f
  for f in CLAUDE.md keybindings.json statusline-command.sh agents commands skills hooks; do
    copy "$SRC/$f" "$REPO_CLAUDE/$f"
  done

  # autoMode.environment describes customer orgs/repos: keep it out of a public repo.
  if [[ -f "$SRC/settings.json" && ! -L "$SRC/settings.json" ]]; then
    jq 'del(.autoMode)' "$SRC/settings.json" >"$REPO_CLAUDE/settings.json"
    echo "copied  settings.json (without autoMode)"
  fi

  if [[ -f "$HOME/.claude.json" ]]; then
    jq '.mcpServers // {}' "$HOME/.claude.json" >"$REPO_CLAUDE/mcp.json"
    echo "copied  mcpServers -> mcp.json"
  fi

  copy "$DESKTOP" "$REPO_CLAUDE/claude_desktop_config.json"

  echo
  echo "Possible secrets (replace with \${ENV_VAR} before committing):"
  grep -rnEi '"[^"]*(token|secret|key|password|auth)[^"]*"\s*:\s*"[^$][^"]{8,}"' "$REPO_CLAUDE" || echo "  none found"
}

main "$@"
