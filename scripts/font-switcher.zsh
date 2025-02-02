#!/bin/zsh

local config_path
local config_key

if [[ "$SSH_AUTH_SOCK" == *wez* ]]; then
  config_path=~/dotfiles/wezterm/globals.toml
  config_key="font"
else
  config_path=~/dotfiles/ghostty/dynamic-config
  config_key="font-family"
fi

/opt/homebrew/bin/tmux popup -E \
  "fc-list :spacing=100 family \
  | grep -v '^\\.' \
  | cut -d ',' -f1 \
  | sort -u \
  | fzf --color=bg+:-1 --reverse  --preview-window=down,1 \
  --preview='source ~/dotfiles/scripts/font-switcher.zsh && write_font {}'"

function write_font() {
  value="$1"
  echo $value

  gawk -i inplace -v new_font="$value" -v config_key="$config_key" \
  "/^($config_key) = / { \$0 = \"$config_key = \\\"\" new_font \"\\\"\" } { print }" "$config_path"
}

