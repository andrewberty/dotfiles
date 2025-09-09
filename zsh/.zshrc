export EDITOR="/opt/homebrew/bin/nvim"
export EZA_ICON_SPACING=2
export CONFIG_DIR="$HOME/.config/lazygit"

path=(
    /opt/homebrew/opt/trash/bin
    $path
    /Applications/XAMPP/bin
    /Applications/Docker.app/Contents/Resources/bin
)

# Remove duplicate entries and non-existent directories
typeset -U path
path=($^path(N-/))

export PATH

fpath+=${ZDOTDIR:-~}/.zsh_functions

eval "$(/opt/homebrew/bin/brew shellenv)"

export HOMEBREW_NO_ENV_HINTS=1

if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

    autoload -Uz compinit
    compinit
fi

alias cl=clear
alias cc=claude
alias lg=lazygit
alias x=exit
alias v='nvim "$@"'
alias ls="eza --icons -a -l --no-filesize --no-user --no-time"
alias lt="eza --icons -a -l --no-filesize --no-user --no-time -T -L 2"
alias so="source ~/.zshrc"
alias dev='npm run dev'
alias build='npm run build'

# bun completions
[ -s "~/.bun/_bun" ] && source "~/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

set -o vi

setopt HIST_IGNORE_SPACE # Don't save when prefixed with space
setopt HIST_IGNORE_DUPS  # Don't save duplicate lines
setopt SHARE_HISTORY     # Share history between sessions

zstyle ':completion:*' menu select

eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(fzf --zsh)"
eval "$(fnm env --use-on-cd --shell zsh)"
