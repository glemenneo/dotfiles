# ── Shared (macOS & Linux) ──

typeset -U PATH path FPATH fpath  # drop duplicate PATH/fpath entries
export PATH="${HOME}/.local/bin:$PATH"

# >>> grok installer >>>
export PATH="$HOME/.grok/bin:$PATH"
fpath=(~/.grok/completions/zsh $fpath)
# <<< grok installer <<<
fpath=(~/.zsh/completions $fpath)  # user completions (e.g. OpenSpec)

# History (required for zsh-autosuggestions' `history` strategy to work)
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY       # record timestamp of each command
setopt SHARE_HISTORY          # share and sync history across running shells
setopt HIST_IGNORE_DUPS       # don't record a command that repeats the previous
setopt HIST_IGNORE_SPACE      # don't record commands that start with a space
setopt HIST_REDUCE_BLANKS     # strip redundant whitespace before saving
setopt HIST_VERIFY            # on history expansion, reload the line instead of running it

alias vi="nvim"
alias vim="nvim"

# kitty: copy terminfo to the remote on connect so keys aren't garbled
command -v kitten >/dev/null 2>&1 && alias kssh='kitten ssh'

# Drop-in replacements, only where installed
(( $+commands[bfs] )) && alias find=bfs
(( $+commands[jaq] )) && alias jq=jaq
if (( $+commands[moor] )); then
  export PAGER=moor
  export DELTA_PAGER=less    # delta's n/N file jumps need less
  export SYSTEMD_PAGER=less  # journalctl -e needs less to start at the end
fi

# Tokyo Night file-type colours for ls, fd and Tab completion
(( $+commands[vivid] )) && export LS_COLORS="$(vivid generate tokyonight-night)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# fzf in colour names, so Ctrl-R, Ctrl-T, Alt-C and fzf-tab follow the terminal theme
export FZF_DEFAULT_OPTS='--color=fg:-1,bg:-1,hl:blue,fg+:bright-white,bg+:bright-black,hl+:cyan,info:yellow,prompt:magenta,pointer:magenta,marker:green,spinner:cyan,header:bright-black,border:bright-black,gutter:-1'
zstyle ':fzf-tab:*' use-fzf-default-opts yes

eval "$(starship init zsh)"

autoload -Uz compinit
# full security check at most once a day, cached otherwise
() { (( $# )) && compinit || compinit -C } ${ZDOTDIR:-$HOME}/.zcompdump(N.mh+24)

# After compinit, so `cd gen<Space><Tab>` gets zoxide's picker
eval "$(zoxide init zsh --cmd cd)"

# Alt+Z: pick a frecent dir with zoxide and insert it at the cursor (ls, cp, nvim, yazi...)
zoxide-insert() {
  local dir
  dir=$(zoxide query -i) && LBUFFER+="${(q)dir} "
  zle reset-prompt
}
zle -N zoxide-insert

# y: yazi that leaves the shell in the last folder on q (Q quits without cd); from the yazi docs
function y() {
  local tmp cwd; tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd" || builtin true
  command rm -f -- "$tmp"
}

# Once per kitty window: not in splits, tmux panes or SSH sessions
[[ -z $TMUX && $KITTY_WINDOW_ID == 1 ]] && fastfetch

# SSH: set safe TERM and fallback editor when on a remote host
if [[ -n $SSH_CONNECTION ]]; then
  export TERM='xterm-256color'
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Machine-specific config (not tracked in dotfiles repo)
[[ -s "${HOME}/.zshrc.local" ]] && source "${HOME}/.zshrc.local"

# NVM (Node Version Manager)
export NVM_DIR="${HOME}/.nvm"
if [[ "$(uname)" == "Darwin" ]]; then
  [[ -s "/opt/homebrew/opt/nvm/nvm.sh" ]] && source "/opt/homebrew/opt/nvm/nvm.sh"
  [[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ]] && source "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
else
  [[ -s "/usr/share/nvm/init-nvm.sh" ]] && source "/usr/share/nvm/init-nvm.sh"
fi

# Zsh-vi-mode callback to bind fzf key-bindings after initialization
function zvm_after_init() {
  # macOS
  [[ -s "/opt/homebrew/opt/fzf/shell/key-bindings.zsh" ]] && source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
  
  # Linux (Arch)
  [[ -s "/usr/share/fzf/key-bindings.zsh" ]] && source "/usr/share/fzf/key-bindings.zsh"

  bindkey '^[z' zoxide-insert
}

# ── macOS ──
if [[ "$(uname)" == "Darwin" ]]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

  # fzf
  [[ -s "/opt/homebrew/opt/fzf/shell/completion.zsh" ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh"

  # Zsh-vi-mode
  [[ -s "/opt/homebrew/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh" ]] && \
    source /opt/homebrew/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  # must be last

  export PNPM_HOME="${HOME}/Library/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME/bin:"*) ;;
    *) export PATH="$PNPM_HOME/bin:$PATH" ;;
  esac
fi

# ── Linux ──
if [[ "$(uname)" == "Linux" ]]; then
  alias ls='ls --color=auto'  # GNU ls; colours come from LS_COLORS
  if [[ -f /etc/arch-release ]]; then
    # fzf-tab: after compinit, before widget-wrapping plugins (fzf's ** completion falls through to it)
    [[ -s /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.plugin.zsh ]] && \
      source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.plugin.zsh
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    # fzf
    [[ -s "/usr/share/fzf/completion.zsh" ]] && source "/usr/share/fzf/completion.zsh"

    source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  # must be last
  elif [[ -f /etc/gentoo-release ]]; then
    source /usr/share/zsh/site-functions/zsh-autosuggestions.zsh
    source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh
  fi
fi
# >>> Codex installer >>>
export PATH="/home/glemenneo/.local/bin:$PATH"
# <<< Codex installer <<<

# bun completions
[ -s "/home/glemenneo/.bun/_bun" ] && source "/home/glemenneo/.bun/_bun"
