export EDITOR="/opt/homebrew/bin/nvim"
export EZA_ICON_SPACING=2
export CONFIG_DIR="$HOME/.config/lazygit"

path=(
    /Applications/Postgres.app/Contents/Versions/latest/bin
    /opt/homebrew/opt/trash/bin
    $path
    /Applications/XAMPP/bin
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
alias cc=claude
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

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

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
export PATH="$HOME/.local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# detect nvmrc and automatically use the right node version
autoload -U add-zsh-hook

load-nvmrc() {
    local nvmrc_path
    nvmrc_path="$(nvm_find_nvmrc)"

    if [ -n "$nvmrc_path" ]; then
        local nvmrc_node_version
        nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

        if [ "$nvmrc_node_version" = "N/A" ]; then
            nvm install
        elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
            nvm use
        fi
    elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
        echo "Reverting to nvm default version"
        nvm use default
    fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

_set_title_to_cwd() {
    printf '\033]2;%s\007' "${PWD/#$HOME/~}"
}
add-zsh-hook chpwd _set_title_to_cwd
_set_title_to_cwd
