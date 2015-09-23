#!/bin/bash
tmux_prompt() {
  if command -v tmux>/dev/null; then
    # create a new tmux session
    tmux new-session -s "$1" -n editor -d

    # names of the windows to open
    sessions[1]='editor'
    sessions[2]='test'
    sessions[3]='server'
    sessions[4]='console'

    for i in "${!sessions[@]}"; do
      tmux new-window -t "$1:$i" -n "${sessions[$i]}"
    done

    # select the first window and attach to the session.
    tmux select-window -t "$1:1"
    tmux -2 attach-session -t "$1"
  fi
}
