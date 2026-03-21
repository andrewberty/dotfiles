#!/bin/zsh -il

dir=$(
    eval "$FZF_ALT_C_COMMAND" | sed "s|$HOME|~|" | fzf \
        --height=50% \
        --layout=reverse \
        --border=none \
        --pointer=">" \
        --ansi \
        --highlight-line \
        --no-scrollbar \
        --color="bg+:-1,pointer:cyan,separator:0"
) || exit 0

wid=$(kitty @ launch --type=os-window --cwd "$dir")
# kitty @ launch --cwd "$dir" --location=hsplit --bias=25 --match id:$wid
