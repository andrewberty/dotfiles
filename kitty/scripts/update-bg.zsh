#!/bin/zsh

CONF="$HOME/.config/kitty/local.conf"

printf '\n'
printf '\033[1;36m  Background Color\033[0m\n'
printf '\033[0;90m  Enter a hex color or press enter to clear\033[0m\n'
printf '\n'
printf '\033[1;35m  > \033[0m#'
color=""
while IFS= read -rsk1 char; do
    if [[ "$char" == $'\e' ]]; then
        printf '\n'
        exit 0
    elif [[ "$char" == $'\n' ]]; then
        break
    elif [[ "$char" == $'\x7f' || "$char" == $'\b' ]]; then
        if [[ -n "$color" ]]; then
            color="${color%?}"
            printf '\b \b'
        fi
    else
        color+="$char"
        printf '%s' "$char"
    fi
done
printf '\n'

if [[ -n "$color" ]]; then
    # Strip leading # if present
    color="${color#\#}"
    value="background #${color}"
else
    value="background"
fi

if [[ -f "$CONF" ]] && grep -q '^background' "$CONF"; then
    sed -i '' "s/^background.*/$value/" "$CONF"
else
    echo "$value" >>"$CONF"
fi

# Reload kitty config
kitty @ load-config
