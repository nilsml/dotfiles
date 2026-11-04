# dotfiles

Config for my Mac. Installed apps live in [mac-setup](https://github.com/nilsml/mac-setup), which clones this repo and runs `install.sh` at the end.

## Install

```bash
git clone https://github.com/nilsml/dotfiles.git ~/Dev/dotfiles
~/Dev/dotfiles/install.sh
```

`install.sh` symlinks everything into place and can be re-run. Existing files are moved to `~/.dotfiles_backup/<timestamp>/`.

| Repo | Linked to |
|---|---|
| `zshrc`, `bash_aliases`, `gitconfig`, `vimrc`, `tmux.conf` | `~/.<name>` |
| `config/<app>/` | `~/.config/<app>/` |
| `claude/settings.json`, `CLAUDE.md`, `agents/`, `skills/`, `hooks/`, … | `~/.claude/` |
| `claude/claude_desktop_config.json` | `~/Library/Application Support/Claude/` |
| `claude/mcp.json` | merged into `mcpServers` in `~/.claude.json` |

Secrets and machine-specific env go in `~/.zshrc.local`, which is not in git.

## Claude

Before switching Mac, run on the old one:

```bash
./claude/capture.sh
git diff
```

It copies the Claude Code config, MCP servers and Claude Desktop config into `claude/`, and lists anything that looks like a secret. Replace those with `${ENV_VAR}` and export the value in `~/.zshrc.local`.

`autoMode` is removed from `settings.json` because it describes customer orgs and repos, and this repo is public. Add it again on the new machine.

Projects, memory and Cowork live in claude.ai and follow the account.
