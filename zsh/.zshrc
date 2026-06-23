# ── Shared (macOS & Linux) ──

alias vi="nvim"
alias vim="nvim"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

autoload -Uz compinit
compinit

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

# ── macOS ──
if [[ "$(uname)" == "Darwin" ]]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

  # fzf
  [[ -s "/opt/homebrew/opt/fzf/shell/key-bindings.zsh" ]] && source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
  [[ -s "/opt/homebrew/opt/fzf/shell/completion.zsh" ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh"

  # Zsh-vi-mode
  [[ -s "/opt/homebrew/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh" ]] && \
    source /opt/homebrew/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

  # fzf Ctrl+R in vi mode
  bindkey -M viins '^R' fzf-history-widget

  export PNPM_HOME="${HOME}/Library/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME/bin:"*) ;;
    *) export PATH="$PNPM_HOME/bin:$PATH" ;;
  esac

  export PATH="${HOME}/.local/bin:$PATH"

  # NVM (Node Version Manager)
  export NVM_DIR="${HOME}/.nvm"
  [[ -s "/opt/homebrew/opt/nvm/nvm.sh" ]] && source "/opt/homebrew/opt/nvm/nvm.sh"
  [[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ]] && source "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
fi

# ── Linux ──
if [[ "$(uname)" == "Linux" ]]; then
  source /usr/share/nvm/init-nvm.sh

  distro_id=$(lsb_release -is 2>/dev/null)
  if [[ "$distro_id" == "Arch" ]]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    # fzf
    [[ -s "/usr/share/fzf/key-bindings.zsh" ]] && source "/usr/share/fzf/key-bindings.zsh"
    [[ -s "/usr/share/fzf/completion.zsh" ]] && source "/usr/share/fzf/completion.zsh"

    source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
  elif [[ "$distro_id" == "Gentoo" ]]; then
    source /usr/share/zsh/site-functions/zsh-autosuggestions.zsh
    source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh
  fi
fi