export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH
export EDITOR="/opt/homebrew/bin/nvim"

# User configuration
alias cl=clear
alias gst="git status"
alias x=exit
alias tn="tmux new -s $*"
alias v="nvim $*"
alias ls="eza --icons -la"
alias so="source ~/.zshrc"
# alias zj="zellij"
# alias zjc="zellij -l compact"
# alias clock="tty-clock -s -c -t -D"
# alias myfiglet="figlet -f ANSI-SHADOW"

# navigation aliases
alias alacrittyconf="cd ~/dotfiles/alacritty && nvim alacritty.toml"
alias kittyconf="cd ~/dotfiles/kitty && nvim kitty.conf"
alias wezconf="cd ~/dotfiles/wezterm && nvim wezterm.lua"

# alias zjconf="cd ~/.config/zellij && nvim config.kdl"
alias zconf="nvim ~/dotfiles/.zshrc"
alias tmuxconf="cd ~/dotfiles/tmux && nvim tmux.conf"
alias starshipconf="starship config"

# scripts
# alias weztheme="cd ~/code/scripts && node weztheme.js $1"
# alias at="alacritty-themes"




fpath+=${ZDOTDIR:-~}/.zsh_functions



# eval "$(zellij setup --generate-auto-start zsh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t new-session || tmux new -s new-session
fi
