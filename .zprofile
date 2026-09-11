# Homebrew — works on both Apple Silicon (/opt/homebrew) and Intel (/usr/local)
for _brew in /opt/homebrew/bin/brew /usr/local/bin/brew; do
  if [ -x "$_brew" ]; then
    eval "$("$_brew" shellenv zsh)"
    break
  fi
done
unset _brew

# Personal binaries take precedence. herdr installs itself to ~/.local/bin,
# which macOS does not put on PATH by default.
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
export PATH

# Drop duplicate PATH entries (zsh keeps $path and $PATH in sync)
typeset -U path
