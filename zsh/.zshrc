source_if_exists() {
    [ -r "$1" ] && source "$1"
}

source_if_exists ~/dotfiles/zsh/private.zsh
source_if_exists ~/dotfiles/zsh/aliases.zsh
source_if_exists ~/dotfiles/zsh/path.zsh
source_if_exists ~/dotfiles/zsh/options.zsh

export EDITOR="/opt/homebrew/bin/nvim"
export EZA_ICON_SPACING=2

fpath+=${ZDOTDIR:-~}/.zsh_functions

eval "$(/opt/homebrew/bin/brew shellenv)"
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export HOMEBREW_NO_ENV_HINTS=1

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

eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(fzf --zsh)"
