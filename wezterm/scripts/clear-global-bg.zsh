#!/bin/zsh

/opt/homebrew/bin/gawk -i inplace '
  !/^background = /
' ~/dotfiles/wezterm/globals.toml
