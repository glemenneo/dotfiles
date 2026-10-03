# ── Shared (macOS & Linux) ──

typeset -U PATH path FPATH fpath  # drop duplicate PATH/fpath entries
export PATH="${HOME}/.local/bin:$PATH"

# >>> grok installer >>>
export PATH="$HOME/.grok/bin:$PATH"
fpath=(~/.grok/completions/zsh $fpath)
# <<< grok installer <<<

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

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

autoload -Uz compinit
# full security check at most once a day, cached otherwise
() { (( $# )) && compinit || compinit -C } ${ZDOTDIR:-$HOME}/.zcompdump(N.mh+24)

fastfetch

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
  if [[ -f /etc/arch-release ]]; then
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
