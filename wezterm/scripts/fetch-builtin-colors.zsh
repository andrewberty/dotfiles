curl -s -H "Accept: application/json" https://raw.githubusercontent.com/wez/wezterm/refs/heads/main/docs/colorschemes/data.json | jq -r '.[].metadata.name' > ~/dotfiles/wezterm/data/colors.txt
