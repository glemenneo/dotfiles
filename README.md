# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Install

```bash
brew install stow        # macOS
# or: pacman -S stow     # Arch
# or: emerge stow        # Gentoo
```

Tools the configs use (Arch):

```bash
sudo pacman -S --needed \
  stow zsh zsh-autosuggestions zsh-syntax-highlighting fzf zoxide starship nvm \
  vivid bfs jaq moor \
  kitty ttf-jetbrains-mono-nerd shader-slang tmux fastfetch \
  git git-delta git-lfs gitleaks jq \
  neovim tree-sitter-cli gcc ripgrep fd wl-clipboard go nodejs npm unzip \
  yazi tdf glow mediainfo trash-cli udisks2 resvg ffmpeg 7zip poppler imagemagick chafa
yay -S zsh-vi-mode fzf-tab-git
```

| Package | Tools |
|---------|-------|
| `zsh` | autosuggestions, syntax-highlighting, zsh-vi-mode, fzf-tab, fzf, zoxide, starship, nvm; vivid, bfs, jaq, moor are used only if installed |
| `kitty` | JetBrainsMono Nerd Font; shader-slang for the cursor-trail shader |
| `git` | delta (pager), git-lfs, gitleaks (secret scan before every commit) |
| `claude` | jq |
| `nvim` | tree-sitter-cli + gcc (parsers), ripgrep + fd (fzf-lua), wl-clipboard, go (gopls, delve), nodejs/npm (TypeScript), unzip (mason) |
| `yazi` | tdf (PDFs), glow (Markdown), mediainfo, trash-cli (restore), udisks2 (mount), resvg, ffmpeg, 7zip, poppler, imagemagick, chafa |

Neovim installs its plugins, language servers and parsers on first start;
yazi plugins come from `ya pkg install` after stowing.

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
| `yazi`    | `.config/yazi/` Tokyo Night theme, plugins pinned in package.toml (run `ya pkg install` after stowing; needs tdf, glow, mediainfo, trash-cli) | both |
| `git`     | `.gitconfig`, `.config/git/` (global ignore, hooks: gitleaks before every commit) | both |