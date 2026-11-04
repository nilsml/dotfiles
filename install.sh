#!/usr/bin/env bash
# Link dotfiles into $HOME. Safe to re-run.
# Anything already at a target (that isn't our link) is moved to ~/.dotfiles_backup/<timestamp>/.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP="$HOME/.dotfiles_backup/$(date +%Y%m%d-%H%M%S)"

# link <source in repo> <target>
link() {
  local src="$1" dst="$2"
  [[ -e "$src" ]] || return 0
  if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
    echo "ok      $dst"
    return 0
  fi
  if [[ -e "$dst" || -L "$dst" ]]; then
    mkdir -p "$BACKUP"
    mv "$dst" "$BACKUP/"
    echo "backup  $dst -> $BACKUP/"
  fi
  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  echo "linked  $dst"
}

link_home() {
  local f
  for f in zshrc bash_aliases gitconfig vimrc tmux.conf; do
    link "$DOTFILES/$f" "$HOME/.$f"
  done
}

# One link per subfolder, never the whole ~/.config.
link_config() {
  local d
  for d in "$DOTFILES"/config/*/; do
    d="${d%/}"
    [[ "$(basename "$d")" == iTerm ]] && continue  # colour scheme, imported manually
    link "$d" "$HOME/.config/$(basename "$d")"
  done
}

# Only config. Sessions, history and credentials stay out of git.
link_claude() {
  local f
  for f in settings.json CLAUDE.md keybindings.json statusline-command.sh agents commands skills hooks; do
    link "$DOTFILES/claude/$f" "$HOME/.claude/$f"
  done
  link "$DOTFILES/claude/claude_desktop_config.json" \
    "$HOME/Library/Application Support/Claude/claude_desktop_config.json"
}

# ~/.claude.json holds app state too, so merge mcpServers instead of linking.
merge_mcp() {
  local src="$DOTFILES/claude/mcp.json" dst="$HOME/.claude.json" tmp
  [[ -f "$src" ]] || return 0
  command -v jq >/dev/null || { echo "skip    MCP merge (jq missing)"; return 0; }
  [[ -f "$dst" ]] || echo '{}' >"$dst"
  tmp="$(mktemp)"
  jq --slurpfile m "$src" '.mcpServers = ((.mcpServers // {}) + $m[0])' "$dst" >"$tmp" && mv "$tmp" "$dst"
  echo "merged  MCP servers into $dst"
}

main() {
  link_home
  link_config
  link_claude
  merge_mcp
  [[ -f "$HOME/.zshrc.local" ]] || echo "tip     put secrets/env in ~/.zshrc.local (not in git)"
}

main "$@"
