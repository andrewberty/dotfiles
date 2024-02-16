# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration
# Example aliases
alias cl=clear
alias gst="git status"
alias x=exit
alias z=zoxide
alias tn="tmux new -s $*"
# alias v="kitty @ set-spacing padding=0 && nvim $* && kitty @ set-spacing padding=default"
alias v="nvim $*"
alias ls="exa --icons -a -l"
alias r=ranger
alias zj="zellij"
alias zjc="zellij -l compact"
alias clock="tty-clock -s -c -t -D"
alias myfiglet="figlet -f ANSI-SHADOW"

# navigation aliases
# wsl nav
alias alacrittyconf="cd /mnt/c/Users/Andrew/.config/alacritty && nvim alacritty.toml"
alias wezconf="cd /mnt/c/Users/Andrew/.config/wezterm && nvim wezterm.lua"
alias terminalconf="nvim /mnt/c/Users/Andrew/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"

alias alacOLED="node ~/code/scripts/alacritty-OLED.js"

alias zconf="nvim ~/.zshrc"
alias tmuxconf="cd ~/.config/tmux && nvim tmux.conf"


eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   exec tmux
# fi

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
