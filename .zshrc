export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

export EDITOR="/usr/local/bin/nvim"
plugins=(git nvm zsh-autosuggestions zsh-syntax-highlighting)


source $ZSH/oh-my-zsh.sh

# User configuration
alias cl=clear
alias gst="git status"
alias x=exit
# alias z=zoxide
alias tn="tmux new -s $*"
# alias v="kitty @ set-spacing padding=0 && nvim $* && kitty @ set-spacing padding=default"
alias v="nvim $*"
alias ls="exa --icons -a -l"
alias so="source ~/.zshrc"
alias zj="zellij"
alias zjc="zellij -l compact"
alias clock="tty-clock -s -c -t -D"
alias myfiglet="figlet -f ANSI-SHADOW"

# navigation aliases
alias alacrittyconf="cd /mnt/c/Users/Andrew/AppData/Roaming/alacritty && nvim alacritty.toml"
alias wezconf="cd /mnt/c/Users/Andrew/.config/wezterm && nvim wezterm.lua"
alias terminalconf="nvim /mnt/c/Users/Andrew/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"

alias zjconf="cd ~/.config/zellij && nvim config.kdl"
alias zconf="nvim ~/.zshrc"
alias tmuxconf="cd ~/.config/tmux && nvim tmux.conf"
alias starshipconf="starship config"

# scripts
alias weztheme="cd ~/code/scripts && ./weztheme.js"
alias at="alacritty-themes"


eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"
# eval "$(zellij setup --generate-auto-start zsh)"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

fpath+=${ZDOTDIR:-~}/.zsh_functions
