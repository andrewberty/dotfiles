#!/usr/bin/env bash
tmux new-window "npm run dev"
tmux select-window -p
tmux send-keys "nvim" Enter
