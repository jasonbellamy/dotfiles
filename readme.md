# Installation

```
git clone https://github.com/jasonbellamy/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./install.sh
```

`install.sh` symlinks everything into `$HOME` and backs up any existing file to `<name>.bak`. It's safe to re-run.

## Basic
You'll need to install the following software to make full use of these dotfiles.

- [Git](https://git-scm.com/)
- [Vim](https://www.vim.org/) (9.1+, `brew install vim` on macOS)
- [Tmux](https://github.com/tmux/tmux)
- Zsh, with [oh-my-zsh](https://ohmyz.sh/) for the prompt
- [Ghostty](https://ghostty.org) and [herdr](https://herdr.dev)

## Vim
All of the Vim plugins are managed using [vim-plug](https://github.com/junegunn/vim-plug). `install.sh` installs them, or run `vim +PlugInstall +qall`.

## Tmux
All of the Tmux plugins are managed using [tpm](https://github.com/tmux-plugins/tpm), so you'll need to press `prefix + I` to fetch the plugins the first time you open Tmux.

## herdr
Plugins aren't tracked here. This one also installs `terminal-browser`:

```
herdr plugin install zenbu-labs/terminal-browser/herdr-plugin
```
