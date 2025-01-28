#!/bin/zsh

/opt/homebrew/bin/gawk -i inplace '
  /^OLED = / {
    if ($3 == "true") {
      $0 = "OLED = false"
    } else {
      $0 = "OLED = true"
    }
  }
  { print }
' ~/dotfiles/wezterm/globals.toml
