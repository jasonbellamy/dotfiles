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
- [Ghostty](https://ghostty.org)

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
[herdr](https://herdr.dev) is installed by `install.sh` into `~/.local/bin`, along with the terminal-browser plugin. To install by hand:

```
curl -fsSL https://herdr.dev/install.sh | sh
herdr plugin install --yes zenbu-labs/terminal-browser/herdr-plugin
```

Update with `herdr update`.

## Cursor CLI
The [Cursor CLI](https://cursor.com/docs/cli/overview) is installed by `install.sh` into `~/.local/bin`. To install by hand:

```
curl https://cursor.com/install -fsS | bash
```

## Claude Code
[Claude Code](https://code.claude.com/docs/en/install) is installed by `install.sh` into `~/.local/bin`. To install by hand:

```
curl -fsSL https://claude.ai/install.sh | bash
```

## ink
[ink](https://github.com/borghei/ink) renders markdown in the terminal, including Mermaid as ASCII; `md` is aliased to `ink`. It ships no install script, so `install.sh` downloads the binary for your OS and architecture into `~/.local/bin`. To install by hand, take a binary from the [releases](https://github.com/borghei/ink/releases) page and put it there as `ink`.

Update by deleting `~/.local/bin/ink` and re-running `install.sh`.

herdr, Cursor, Claude Code and ink all live in `~/.local/bin`. `.zprofile` and `.zshrc` put that directory on PATH; do not append it from their installers. `install.sh` also exports it for the current run.

## Agent configs
Agent skills, agents and plugins for Claude Code and Cursor live in a separate private repo, `agent-configs`, which also links the skills that ship with herdr, terminal-browser and hunk. Set it up once, after this repo:

```
gh auth login
gh repo clone jasonbellamy/agent-configs ~/Documents/projects/agent-configs
~/Documents/projects/agent-configs/install.sh personal   # or: work | personal work
```

From then on, `install.sh` here re-runs it with the same profiles. Until it's set up, `install.sh` prints a `skip` line for it.
