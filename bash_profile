# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
for file in ~/.{bashrc,bash_aliases}; do
  [ -r "$file" ] && source "$file"
done
unset file

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Add tab completion for git alias g
complete -o default -o nospace -F _git g
