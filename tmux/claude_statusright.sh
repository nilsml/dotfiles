#!/bin/zsh
for i in {1..20}; do
  CURRENT=$(tmux show-options -gv status-right)
  [[ "$CURRENT" == *"#H"* ]] && break
  sleep 0.2
done
NEW=$(echo "$CURRENT" | sed 's/#H/Claude: #(~\/.tmux\/claude_usage.sh)/')
tmux set -g status-right "$NEW"
