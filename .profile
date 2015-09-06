set -o vi # set vi mode

alias g="git"
alias c="cd"
alias ..="cd .."
alias ...="cd ../.."
alias ls="ls -G"
alias l="ls"
alias ll="ls -al"
alias tree="tree -I 'node_modules|.git' -P '*|.*' -a"
alias t="tree"
alias cl="clear"
alias v="vim"
alias n="npm"
alias ni="npm install"
alias nt="npm test"
alias nr="npm run"

if command -v tmux>/dev/null; then
  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && tmux new-session -s core -n editor -d && tmux new-window -t core:2 -n tests && tmux new-window -t core:3 -n server && tmux new-window -t core:4 -n console && tmux select-window -t core:1 && tmux -2 attach-session -t core
fi

[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh               # load NVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # load RVM

export PATH=$HOME/bin:/usr/local/bin:$PATH

source ~/.config/bash/.git-prompt.sh
GIT_PS1_SHOWCOLORHINTS=true
PROMPT_COMMAND='__git_ps1 "[\w]:" "\\n\\[\e[0;37m\]$\[\e[0m\] "'