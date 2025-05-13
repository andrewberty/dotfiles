#/bin/bash

root="$HOME/dotfiles/zed"
target="$HOME/.config/zed"

echo "Installing Zed"

echo "linking settings.json"
ln -s "$root/settings.json" "$target"

echo "linking keymap.json"
ln -s "$root/keymap.json" "$target"

echo "linking tasks.json"
ln -s "$root/tasks.json" "$target"

echo "linking themes/"
ln -s "$root/themes/" "$target"

echo "linking snippets/"
ln -s "$root/snippets/" "$target"

echo "Installed Zed Successfully"
