#!/bin/zsh

local config_path
local config_key

if [[ "$SSH_AUTH_SOCK" == *wez* ]]; then
  config_path=~/dotfiles/wezterm/globals.toml
  config_key="colorscheme"

  /opt/homebrew/bin/tmux popup -E \
  "(cat ~/dotfiles/wezterm/data/colors.txt; fd . ~/dotfiles/wezterm/colors --type f --exec basename {} .toml) \
  | fzf --color=bg+:-1 --reverse --preview-window=down,1 \
  --preview='source ~/dotfiles/scripts/theme-switcher.zsh && write_colorscheme {}'"

else
  config_path=~/dotfiles/ghostty/dynamic-config
  config_key="theme"

  /opt/homebrew/bin/tmux popup -E \
  "ghostty +list-themes | sed -E 's/\s*\((resources|user)\)//g' | fzf --color=bg+:-1 --reverse --preview-window=down,1 \
  --preview='source ~/dotfiles/scripts/theme-switcher.zsh && write_colorscheme {}'"
fi

function write_colorscheme() {
  value="$(echo "$1" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')" # trim whitespace
  echo $value
  gawk -i inplace -v new_scheme="$value" -v config_key="$config_key" \
  "/^($config_key) = / { \$0 = \"$config_key = \\\"\" new_scheme \"\\\"\" } { print }" "$config_path" \
  && osascript -e 'tell application "System Events" to keystroke "," using {command down, shift down}'
}
