export EDITOR="/opt/homebrew/bin/nvim"
export EZA_ICON_SPACING=2
export CONFIG_DIR="$HOME/.config/lazygit"

path=(
    $HOME/.local/bin
    $HOME/.bun/bin
    /Applications/Postgres.app/Contents/Versions/latest/bin
    /opt/homebrew/opt/trash/bin
    $HOME/.cargo/bin
    $path
    /Applications/Docker.app/Contents/Resources/bin
)

typeset -U path

export PATH

fpath+=${ZDOTDIR:-~}/.zsh_functions

eval "$(/opt/homebrew/bin/brew shellenv)"

export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_AUTO_UPDATE=1

if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

    autoload -Uz compinit
    compinit
fi

if command -v ngrok &>/dev/null; then
    eval "$(ngrok completion)"
fi

alias cl=clear
alias cc="claude --allow-dangerously-skip-permissions"
alias oc=opencode
alias gp="gitpane --root ."
alias lg=lazygit
alias x=exit
alias v='nvim "$@"'
alias ls="eza --icons -a -l --no-filesize --no-user --no-time"
alias lt="eza --icons -a -l --no-filesize --no-user --no-time -T -L 2"
alias so="source ~/.zshrc"
alias dev='npm run dev'
alias build='npm run build'
alias ssh-staging='ssh -i ~/.ssh/staging-instances.pem'

# bun completions
[ -s "~/.bun/_bun" ] && source "~/.bun/_bun"

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

setopt HIST_IGNORE_SPACE # Don't save when prefixed with space
setopt HIST_IGNORE_DUPS  # Don't save duplicate lines
setopt SHARE_HISTORY     # Share history between sessions

zstyle ':completion:*' menu select

eval "$(starship init zsh)"
eval "$(zoxide init --no-cmd zsh)"
# eval "$(zoxide init --cmd cd zsh)"
export FZF_ALT_C_COMMAND='echo ~/dotfiles && for dir in ~/dotfiles ~/dev ~/dev/internal ~/code; do [ -d "$dir" ] && find "$dir" -mindepth 1 -maxdepth 1 -type d; done'
eval "$(fzf --zsh)"

eval "$(fnm env --use-on-cd --shell zsh)"

# Revert to default node when cd'ing somewhere with no .nvmrc/.node-version up the tree.
_fnm_revert_to_default() {
    local dir=$PWD
    while [[ -n $dir ]]; do
        [[ -f $dir/.nvmrc || -f $dir/.node-version ]] && return
        [[ $dir == / ]] && break
        dir=${dir:h}
    done
    fnm use default --silent-if-unchanged >/dev/null 2>&1
}
autoload -U add-zsh-hook
add-zsh-hook chpwd _fnm_revert_to_default
