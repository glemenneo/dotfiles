# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Install

```bash
brew install stow        # macOS
# or: pacman -S stow     # Arch
# or: emerge stow        # Gentoo
```

## Deploy

```bash
cd ~/Documents/dotfiles

# macOS
stow -t ~ zsh starship nvim kitty tmux skhd yabai

# Linux
stow -t ~ zsh starship nvim kitty tmux hypr waybar fastfetch claude

# Both; git needs delta, git-lfs and gitleaks installed. No folding keeps the
# folders real, so files tools add there (yazi plugins, git credentials) stay out of this repo.
stow --no-folding -t ~ git yazi
```

The `-t ~` flag is required because the stow directory lives inside
`~/Documents`, not directly in `~`.

## Contents

| Package   | Configs                                          | Platform    |
|-----------|--------------------------------------------------|-------------|
| `zsh`     | `.zshrc`                                          | both        |
| `starship`| `.config/starship.toml`                          | both        |
| `nvim`    | `.config/nvim/` (lazy.nvim)                      | both        |
| `kitty`   | `.config/kitty/`                                 | both        |
| `tmux`    | `.tmux.conf`                                      | both        |
| `skhd`    | `.config/skhd/skhdrc`                            | macOS only  |
| `yabai`   | `.config/yabai/yabairc`                          | macOS only  |
| `hypr`    | `.config/hypr/`                                  | Linux only  |
| `waybar`  | `.config/waybar/`                                | Linux only  |
| `fastfetch`| `.config/fastfetch/config.jsonc`                | Linux only  |
| `claude`  | `.claude/statusline.sh` (Claude Code status line) | Linux only  |
| `yazi`    | `.config/yazi/` Tokyo Night theme, git and smart-enter plugins (run `ya pkg install` after stowing) | both |
| `git`     | `.gitconfig`, `.config/git/` (global ignore, hooks: gitleaks before every commit) | both |