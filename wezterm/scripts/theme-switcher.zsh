#!/bin/zsh

/opt/homebrew/bin/tmux popup -E \
  "(cat ~/dotfiles/wezterm/data/colors.txt; fd . ~/dotfiles/wezterm/colors --type f --exec basename {} .toml) \
  | fzf --color=bg+:-1 --reverse --preview-window=down,1 \
  --preview='source ~/dotfiles/wezterm/scripts/theme-switcher.zsh && write_colorscheme {}'"

function write_colorscheme() {
  value="$1"
  echo $value

  gawk -i inplace -v new_scheme="$value" '/^colorscheme = / { $0 = "colorscheme = \"" new_scheme "\"" } { print }' ~/dotfiles/wezterm/globals.toml
}
