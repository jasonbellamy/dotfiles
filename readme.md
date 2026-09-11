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

## Hunk
[Hunk](https://hunk.dev) is installed by `install.sh` into `~/.hunk`. To install it by hand:

```
curl -fsSL https://hunk.dev/install.sh | sh -s -- --no-modify-path
```

`--no-modify-path` stops the installer editing `.zshrc` and `.profile`, which are tracked here. `.zprofile` already puts `~/.hunk/bin` on your PATH. Update with `hunk update`.

## herdr
Plugins aren't tracked here. This one also installs `terminal-browser`:

```
herdr plugin install zenbu-labs/terminal-browser/herdr-plugin
```

## Agent configs
Agent skills, agents and plugins for Claude Code and Cursor live in a separate private repo, `agent-configs`, which also links the skills that ship with herdr, terminal-browser and hunk. Set it up once, after this repo:

```
gh auth login
gh repo clone jasonbellamy/agent-configs ~/Documents/projects/agent-configs
~/Documents/projects/agent-configs/install.sh personal   # or: work | personal work
```

From then on, `install.sh` here re-runs it with the same profiles. Until it's set up, `install.sh` prints a `skip` line for it.
