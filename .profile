set -o vi # set vi mode

alias g="git"
alias c="cd"
alias ..="cd .."
alias ...="cd ../.."
alias ls="ls -G"
alias l="ls -al"
alias tree="tree -aC -I '.git|node_modules|bower_components' --dirsfirst"
alias t="tree"
alias cl="clear"
alias v="vim"
alias n="npm"
alias ni="npm install"
alias nt="npm test"
alias nr="npm run"
alias x="tmux_prompt"

[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

export GHC_DOT_APP="/Applications/ghc-7.10.2.app"
if [ -d "$GHC_DOT_APP" ]; then
  export PATH="${HOME}/.local/bin:${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
fi

source ~/bin/bash/.tmux-prompt.sh
source ~/bin/bash/.git-prompt.sh
source ~/bin/bash/.git-completion.sh

GIT_PS1_SHOWCOLORHINTS=true
PROMPT_COMMAND='__git_ps1 "[\W]:" " \[\e[0;37m\]λ\[\e[0m\] "'
