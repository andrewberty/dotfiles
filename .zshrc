export EDITOR="/opt/homebrew/bin/nvim"

# ALIASES
alias cl=clear
alias gst="git status"
alias lg="lazygit"
alias x=exit
alias tn="tmux new -s $*"
alias v="nvim $*"
alias lazyvim="NVIM_APPNAME=nvim-lazyvim nvim"
alias ls="eza --icons -la"
alias so="source ~/.zshrc"
# alias clock="tty-clock -s -c -t -D"
alias myfiglet="figlet -f ~/dotfiles/figlet/ANSI-SHADOW.flf $*"

# function tmuxattach() {
#   if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#     tmux attach -t 0 || tmux new -s 0
#   fi
# }


# DOTFILES
alias alacrittyconf="nvim ~/dotfiles/alacritty/alacritty.toml"
alias kittyconf="nvim ~/dotfiles/kitty/kitty.conf"
alias wezconf="nvim ~/dotfiles/wezterm/wezterm.lua"
alias zconf="nvim ~/dotfiles/.zshrc"
alias tmuxconf="nvim ~/dotfiles/tmux/tmux.conf"
alias starshipconf="nvim ~/.config/starship.toml"
alias tmux="tmux a || tmux"

# SCRIPTS
# alias weztheme="cd ~/code/scripts && node weztheme.js $1"
alias at="alacritty-themes"

fpath+=${ZDOTDIR:-~}/.zsh_functions

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(fzf --zsh)"
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

function yy() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

if type brew &>/dev/null
then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

    autoload -Uz compinit
    compinit
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#     tmux attach -t 0 || tmux new -s 0
# fi
