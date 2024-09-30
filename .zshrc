path=(
    $path
    /Applications/XAMPP/bin
)

# Remove duplicate entries and non-existent directories
typeset -U path
path=($^path(N-/))

export PATH

export EDITOR="/opt/homebrew/bin/nvim"
export EZA_ICON_SPACING=2

set -o vi

setopt HIST_IGNORE_SPACE  # Don't save when prefixed with space
setopt HIST_IGNORE_DUPS   # Don't save duplicate lines
setopt SHARE_HISTORY      # Share history between sessions

zstyle ':completion:*' menu select

# ALIASES
alias cl=clear
alias gst="git status"
alias lg="lazygit"
alias x=exit
alias t="tmux"
alias v="nvim $*"
alias lazyvim="NVIM_APPNAME=nvim-lazyvim nvim"
alias yy='yazi ~/Downloads'
alias ls="eza --icons -a -l --no-filesize --no-user --no-time"
alias so="source ~/.zshrc"
alias myfiglet="figlet -f ~/dotfiles/figlet/ANSI-SHADOW.flf $*"

# DOTFILES
alias alacrittyconf="nvim ~/dotfiles/alacritty/alacritty.toml"
alias kittyconf="nvim ~/dotfiles/kitty/kitty.conf"
alias wezconf="nvim ~/dotfiles/wezterm/wezterm.lua"
alias zconf="nvim ~/dotfiles/.zshrc"
alias tmuxconf="nvim ~/dotfiles/tmux/tmux.conf"
alias starshipconf="nvim ~/.config/starship.toml"

# SCRIPTS
alias at="alacritty-themes"

fpath+=${ZDOTDIR:-~}/.zsh_functions

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(fzf --zsh)"
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# function yy() {
#     local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
#     yazi "$@" --cwd-file="$tmp"
#     if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
#         cd -- "$cwd"
#     fi
#     rm -f -- "$tmp"
# }

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
#     tmux attach || tmux new -s 0
# fi
