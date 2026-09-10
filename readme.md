# dotfiles

    git clone https://github.com/jasonbellamy/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles && ./install.sh

`install.sh` symlinks everything into `$HOME`, backing up any existing file to
`<name>.bak`. It is idempotent — re-run it any time.

## Requirements

- [Git](https://git-scm.com/)
- [Vim](https://www.vim.org/) 9.1+ — 9.1 is the floor for the bundled `osc52`
  package; on macOS use `brew install vim`, since Apple's build lacks
  `+python3`
- [Tmux](https://github.com/tmux/tmux)
- Zsh, plus [oh-my-zsh](https://ohmyz.sh/) for the prompt (guarded — the shell
  still works without it)

## Layout

| Path | Links to |
| --- | --- |
| `.zprofile` | `~/.zprofile` — Homebrew PATH, Apple Silicon or Intel |
| `.zshrc` | `~/.zshrc` — sources `.aliases` |
| `.aliases` | `~/.aliases` — aliases, exports and functions for zsh *and* bash |
| `.profile` | `~/.profile` — bash-only prompt and completions |
| `.vimrc`, `.vim/` | `~/.vimrc`, `~/.vim/` |
| `.tmux.conf` | `~/.tmux.conf` |
| `.gitconfig` | `~/.gitconfig` |
| `bin/` | `~/bin/` |
| `.config/herdr/config.toml` | `~/.config/herdr/config.toml` |
| `.config/ghostty/config` | `~/.config/ghostty/config` |

Shell config is split deliberately: `.aliases` holds everything that works
under both shells, `.profile` keeps the bash-only pieces (`__git_ps1`,
`PROMPT_COMMAND`, completions). Zsh never reads `.profile`.

## Plugins

Vim uses [vim-plug](https://github.com/junegunn/vim-plug), vendored at
`.vim/autoload/plug.vim`. `install.sh` runs `:PlugInstall` when it has a tty;
otherwise run `vim +PlugInstall +qall` once.

Tmux uses [tpm](https://github.com/tmux-plugins/tpm), cloned by `install.sh`
into `bin/tmux/plugins/` (gitignored). Press `prefix + I` once inside tmux.

## Terminal

[herdr](https://herdr.dev) provides the tabs, splits and panes, so the terminal
emulator underneath only has to be fast and correct.

[Ghostty](https://ghostty.org) is the one to install on a new machine
(`brew install --cask ghostty`): it speaks the kitty graphics protocol, which
is what [terminal-browser](https://github.com/zenbu-labs/terminal-browser) needs
to render. Apple's Terminal.app supports no image protocol at all. kitty and
WezTerm work too.

Note that Ghostty sets `TERM=xterm-ghostty`, which older remote hosts will not
have in their terminfo database — `ssh -t host 'TERM=xterm-256color bash -l'`
is the quick workaround.

## herdr plugins

Plugins are cloned into `~/.config/herdr/plugins/` and are not tracked here.
Reinstall them on a new machine with:

```
herdr plugin install zenbu-labs/terminal-browser/herdr-plugin
```

The keybinding for its `open-split` action lives in `.config/herdr/config.toml`.
It needs the `terminal-browser` binary as well
(`brew install --cask terminal-browser`).

## Signing

`.gitconfig` sets `gpg.program`. If you turn `commit.gpgsign` back on, the
machine needs a key or every commit fails — `install.sh` warns when that
combination is detected.
