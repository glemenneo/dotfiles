# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/glemenneo/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
  export TERM='xterm-color'
else
  export EDITOR='nvim'
fi

alias vi="nvim"
alias vim="nvim"

source /usr/share/nvm/init-nvm.sh

distro_id=$(lsb_release -is)
if [[ "$distro_id" == "Arch" ]]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ "$distro_id" == "Gentoo" ]]; then
    source /usr/share/zsh/site-functions/zsh-autosuggestions.zsh
    source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh
fi

fastfetch

eval "$(starship init zsh)"

