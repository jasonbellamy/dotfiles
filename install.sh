#!/usr/bin/env bash
# Symlink these dotfiles into $HOME. Idempotent: existing real files are
# backed up to <name>.bak, existing correct symlinks are left alone.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FAILED=0

link() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    printf '  ok      %s\n' "$dest"; return
  fi
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    mv "$dest" "$dest.bak"
    printf '  backup  %s -> %s.bak\n' "$dest" "$dest"
  fi
  ln -sfn "$src" "$dest"
  printf '  link    %s\n' "$dest"
}

echo "Linking dotfiles from $DOTFILES"
for f in .aliases .gitconfig .profile .tmux.conf .vim .vimrc .zprofile .zshrc bin; do
  link "$DOTFILES/$f" "$HOME/$f"
done
# nested configs are linked file-by-file so we never clobber ~/.config itself
link "$DOTFILES/.config/herdr/config.toml" "$HOME/.config/herdr/config.toml"
link "$DOTFILES/.config/ghostty/config" "$HOME/.config/ghostty/config"
link "$DOTFILES/.config/hunk/config.toml" "$HOME/.config/hunk/config.toml"

# .vimrc sets undodir here; vim does not create it itself
mkdir -p "$HOME/.vim/tmp/undo"
echo "  mkdir   $HOME/.vim/tmp/undo"

# herdr, Cursor CLI and Claude Code install to ~/.local/bin. macOS does not
# put it on PATH by default; .zprofile/.zshrc do, but this process is bash.
mkdir -p "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"

echo
echo "Fetching plugin managers"
TPM="$DOTFILES/bin/tmux/plugins/tpm"
if [ -d "$TPM/.git" ]; then
  echo "  ok      tpm"
else
  if git clone -q https://github.com/tmux-plugins/tpm "$TPM"; then
    echo "  clone   tpm"
  else
    echo "  FAILED  tpm clone — check network, then re-run ./install.sh"
    FAILED=1
  fi
fi

echo
echo "Installing hunk"
# --no-modify-path: the installer would otherwise append to .zshrc/.profile,
# which are symlinks into this repo. .zprofile puts ~/.hunk/bin on PATH instead.
if [ -x "$HOME/.hunk/bin/hunk" ] || command -v hunk >/dev/null 2>&1; then
  echo "  ok      hunk (update with: hunk update)"
elif curl -fsSL https://hunk.dev/install.sh | sh -s -- --no-modify-path >/dev/null; then
  echo "  install hunk"
else
  echo "  FAILED  hunk install — check network, then re-run ./install.sh"
  FAILED=1
fi

echo
echo "Installing herdr"
if [ -x "$HOME/.local/bin/herdr" ] || command -v herdr >/dev/null 2>&1; then
  echo "  ok      herdr (update with: herdr update)"
elif curl -fsSL https://herdr.dev/install.sh | sh; then
  echo "  install herdr"
else
  echo "  FAILED  herdr install — check network, then re-run ./install.sh"
  FAILED=1
fi

echo
echo "Installing herdr plugins"
if ! command -v herdr >/dev/null 2>&1; then
  echo "  skip    herdr not on PATH"
elif herdr plugin install --yes zenbu-labs/terminal-browser/herdr-plugin; then
  echo "  ok      terminal-browser"
else
  echo "  FAILED  herdr plugin install — check network, then re-run ./install.sh"
  FAILED=1
fi

echo
echo "Installing Cursor CLI"
if [ -x "$HOME/.local/bin/cursor" ] || command -v cursor >/dev/null 2>&1; then
  echo "  ok      cursor"
elif curl -fsS https://cursor.com/install | bash; then
  echo "  install cursor"
else
  echo "  FAILED  cursor install — check network, then re-run ./install.sh"
  FAILED=1
fi

echo
echo "Installing Claude Code"
if [ -x "$HOME/.local/bin/claude" ] || command -v claude >/dev/null 2>&1; then
  echo "  ok      claude"
elif curl -fsSL https://claude.ai/install.sh | bash; then
  echo "  install claude"
else
  echo "  FAILED  claude install — check network, then re-run ./install.sh"
  FAILED=1
fi

echo
echo "Agent configs"
# Agent plugins and skills live in the private agent-configs repo. Its
# install.sh records where it was cloned and which profiles this machine
# uses, so it can be re-run here. It comes after hunk, whose skill it links.
AGENT_CONFIGS="$HOME/.config/agent-configs"
if [ -f "$AGENT_CONFIGS/repo" ] && [ -f "$AGENT_CONFIGS/profiles" ] \
   && [ -x "$(cat "$AGENT_CONFIGS/repo")/install.sh" ]; then
  if ! "$(cat "$AGENT_CONFIGS/repo")/install.sh"; then
    echo "  FAILED  agent-configs install.sh"
    FAILED=1
  fi
else
  echo "  skip    agent-configs — not set up (clone it and run its install.sh <profile>)"
fi

echo
echo "Installing vim plugins (vim-plug is vendored in .vim/autoload)"
if [ -t 1 ]; then
  vim -c 'PlugInstall --sync' -c 'qa!' </dev/tty >/dev/tty 2>&1 || true
  echo "  done"
else
  echo "  skipped — no tty. Run: vim +PlugInstall +qall"
fi

echo
if [ "$(git config --get commit.gpgsign 2>/dev/null)" = "true" ] \
   && [ -z "$(gpg --list-secret-keys 2>/dev/null)" ]; then
  cat <<'WARN'
  WARNING: commit.gpgsign is true but no GPG secret key was found.
           Commits will fail with "gpg: signing failed: No secret key".
           Fix with either:
             gpg --full-generate-key && git config --global user.signingkey <KEY_ID>
             git config --global commit.gpgsign false
WARN
fi

if [ "$FAILED" -ne 0 ]; then
  echo "Finished WITH ERRORS — see FAILED lines above."
else
  echo "Done."
fi

cat <<'NEXT'

  Requires: git, vim 9.1+, tmux, zsh (+ oh-my-zsh for the prompt)
  In tmux, press prefix + I once to fetch tmux plugins.
  New shells pick up ~/.local/bin from .zprofile/.zshrc.
  This shell: source ~/.zshrc
NEXT
