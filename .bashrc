alias g="git"
alias c="cd"
alias ..="cd .."
alias ...="cd ../.."
alias ls="ls -G"
alias ll="ls -al"
alias tree="tree -I 'node_modules|.git' -P '*|.*' -a"

[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh               # load NVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # load RVM

