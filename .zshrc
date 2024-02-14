export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

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

# navigation aliases
# wsl nav
alias alacrittyconf="cd /mnt/c/Users/Andrew/.config/alacritty && nvim alacritty.toml"
alias wezconf="cd /mnt/c/Users/Andrew/.config/wezterm && nvim wezterm.lua"

alias alacOLED="node ~/code/scripts/alacritty-OLED.js"

alias zconf="nvim ~/.zshrc"
alias tmuxconf="cd ~/.config/tmux && nvim tmux.conf"


eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
