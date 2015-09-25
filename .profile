set -o vi # set vi mode

alias g="git"
alias c="cd"
alias ..="cd .."
alias ...="cd ../.."
alias ls="ls -G"
alias l="ls -al"
alias tree="tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRX;"
alias t="tree"
alias cl="clear"
alias v="vim"
alias n="npm"
alias ni="npm install"
alias nt="npm test"
alias nr="npm run"
alias x="tmux_prompt"

[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh # load NVM

source ~/bin/bash/.tmux-prompt.sh
source ~/bin/bash/.git-prompt.sh
source ~/bin/bash/.git-completion.sh

GIT_PS1_SHOWCOLORHINTS=true
PROMPT_COMMAND='__git_ps1 "[\W]:" " \[\e[0;37m\]λ\[\e[0m\] "'
