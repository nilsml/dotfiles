export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export TERM=xterm-color

c_cyan=`tput setaf 6`
c_red=`tput setaf 1`
c_green=`tput setaf 2`
c_sgr0=`tput sgr0`

#if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
#    . "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
#fi

if [ -f $HOME/.bash_aliases ]
then
  . $HOME/.bash_aliases
fi


[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [[ "$TERM_PROGRAM" == "vscode" ]]; then
  # ~/.profile is run by the login shell (this is what ssh uses)
  # ~/.bashrc is run by the interactive shell (this is what vscode uses)
  # Therefore, we only need to change the shell to zsh here since
  # vscode will run ~/.bashrc for us.
  exec zsh -l
fi
