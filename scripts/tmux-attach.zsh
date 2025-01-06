#!/bin/zsh

# Check if there are any tmux sessions
if tmux ls 2>/dev/null; then
    # If there are, attach to the latest session
    tmux attach-session -t `tmux ls | tail -n 1 | cut -d: -f1`
else
    # If no sessions exist, create a new one
    tmux new-session -s new-session
fi
