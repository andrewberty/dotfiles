#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Restart Raycast
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔄

# Kill Raycast if running
pkill -x "Raycast"

# Wait a moment to ensure it's fully closed
sleep 1

# Reopen Raycast
open -a "Raycast"

echo "Raycast has been restarted."
