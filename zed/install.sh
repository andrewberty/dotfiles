#/bin/bash

root="$HOME/dotfiles/zed"
target="$HOME/.config/zed"

echo "Installing Zed"

ln -s "$root/settings.json" "$target"
ln -s "$root/keymap.json" "$target"
ln -s "$root/themes/" "$target"
ln -s "$root/snippets/" "$target"

echo "Installed Zed Successfully"
