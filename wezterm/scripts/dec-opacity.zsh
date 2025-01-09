#!/bin/zsh

/opt/homebrew/bin/gawk -i inplace '
  /^opacity = / {
    opacity = $3 - 0.1
    if (opacity < 0.5) opacity = 0.5
    $0 = "opacity = " opacity
  }
  { print }
' ~/dotfiles/wezterm/globals.toml
