# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# Theme
ZSH_THEME=""

# Styling
zstyle ':completion:*' menu select

# Plugins
plugins=(
  git
  gh
  z
  docker
  dotenv
  macos
  npm
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
  ag
)

autoload -U compinit && compinit

# Reload changes
source $ZSH/oh-my-zsh.sh

# Aliases
alias c="code ."
alias pull="git stash && git pull && git stash pop"
alias gprune="git remote prune origin && git branch -vv | grep 'origin/.*: gone]' | awk '{print $1}' | xargs git branch -D"
# Machine-local settings and secrets (not in git)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

source ~/.bash_aliases

eval "$(starship init zsh)"

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# --- Claude Code profiles (private vs work) ---
alias claude-privat='CLAUDE_CONFIG_DIR=$HOME/.claude-privat claude'
alias claude-jobb='claude'

# Atlassian API (token from macOS keychain, service "atlassian-api")
export ATLASSIAN_EMAIL="nils.magne.lunde@solea.no"
export ATLASSIAN_TOKEN="$(security find-generic-password -a "$USER" -s atlassian-api -w 2>/dev/null)"
