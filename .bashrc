alias g="git"
alias c="cd"
alias ..="cd .."
alias ...="cd ../.."
alias ls="ls -G"
alias l="ls"
alias ll="ls -al"
alias tree="tree -I 'node_modules|.git' -P '*|.*' -a"
alias v="vim"
alias n="npm"
alias ni="npm install"

[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh               # load NVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # load RVM

source ~/.config/bash/.git-prompt.sh
export PS1='[\w:$(__git_ps1 " (%s)")]\n\$ '
