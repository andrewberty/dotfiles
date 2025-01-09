#!/bin/zsh

/opt/homebrew/bin/gawk -i inplace '
  /^opacity = / {
    $0 = "opacity = 0.999" 
  }
  { print }
' ~/dotfiles/wezterm/globals.toml
