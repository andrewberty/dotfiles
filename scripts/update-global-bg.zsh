#!/bin/zsh

value="$1"

temp_file=$(mktemp)
trap 'rm -f "$temp_file"' EXIT

/opt/homebrew/bin/gawk -v color="$value" '
  /^background = / { $0 = "background = \"" color "\""; found=1 }
  { print }
  END { if (!found) print "background = \"" color "\"" }
' ~/dotfiles/wezterm/globals.toml > "$temp_file"

mv "$temp_file" ~/dotfiles/wezterm/globals.toml
