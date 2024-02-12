# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="robbyrussell"
# ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration
# Example aliases
alias cl=clear
alias gst="git status"
alias x=exit
alias z=zoxide
# alias v="kitty @ set-spacing padding=0 && nvim $* && kitty @ set-spacing padding=default"
alias v="nvim $*"
alias ls="exa --icons -a -l"
alias r=ranger
alias zj="zellij"
alias zjc="zellij -l compact"
alias clock="tty-clock -s -c -t -D"

# navigation aliases
alias zconf="nvim ~/.zshrc"
alias aperture="cd ~/code/projects/aperture && nvim"
alias vconf="cd ~/.config/nvim && nvim"


eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
