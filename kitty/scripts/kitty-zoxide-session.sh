#!/usr/bin/env bash

set -euo pipefail

export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

kitty_bin="/Applications/kitty.app/Contents/MacOS/kitty"
script_path="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)/$(basename -- "${BASH_SOURCE[0]}")"
session_dir="/tmp/kitty-zoxide-sessions"
live_paths_file="/tmp/kitty-zoxide-live-paths.tmp"

base_color=$'\033[38;5;4m'
live_color=$'\033[38;5;2m'
reset_color=$'\033[0m'

normalize_path() {
  local p="$1"
  if command -v realpath >/dev/null 2>&1; then
    realpath "$p"
  elif command -v python3 >/dev/null 2>&1; then
    python3 -c "import os,sys; print(os.path.realpath(sys.argv[1]))" "$p"
  else
    printf "%s" "$p"
  fi
}

hash_path() {
  local p="$1"
  if command -v shasum >/dev/null 2>&1; then
    printf "%s" "$p" | shasum -a 256 | awk '{print $1}'
  elif command -v python3 >/dev/null 2>&1; then
    python3 -c "import hashlib,sys; print(hashlib.sha256(sys.argv[1].encode()).hexdigest())" "$p"
  else
    printf "%s" "$p"
  fi
}

list_dirs() {
  printf "%s\n" "$HOME"
  local dirs=(~/dotfiles ~/dev ~/dev/internal ~/code)
  for dir in "${dirs[@]}"; do
    [[ -d "$dir" ]] || continue
    printf "%s\n" "$dir"
    for sub in "$dir"/*/; do
      [[ -d "$sub" ]] && printf "%s\n" "${sub%/}"
    done
  done
}

print_menu_lines() {
  local live_file="${1:-/dev/null}"
  list_dirs | awk \
    -v color="${base_color}" \
    -v live_color="${live_color}" \
    -v reset="${reset_color}" \
    -v home="$HOME" \
    -v live_file="${live_file}" \
    'BEGIN {
      while ((getline line < live_file) > 0) live[line] = 1
      lc = 0; oc = 0
    }
    {
      path=$0
      n=split(path, parts, "/")
      base=(path == home) ? "home" : parts[n]
      if (base == "") base=path
      display=path
      sub("^" home, "~", display)
      if (path in live) {
        live_lines[lc++] = sprintf("%s\t%s●%s %s%s%s  %s", path, live_color, reset, color, base, reset, display)
      } else {
        other_lines[oc++] = sprintf("%s\t  %s%s%s  %s", path, color, base, reset, display)
      }
    }
    END {
      for (i=0; i<lc; i++) print live_lines[i]
      for (i=0; i<oc; i++) print other_lines[i]
    }'
}

if [[ "${1:-}" == "--reload" ]]; then
  print_menu_lines "$live_paths_file"
  exit 0
fi

if ! command -v fzf >/dev/null 2>&1; then
  echo "fzf is not installed or not in PATH. Install: brew install fzf"
  exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
  echo "jq is not installed or not in PATH. Install: brew install jq"
  exit 1
fi

if [[ ! -x "$kitty_bin" ]]; then
  echo "kitty binary not found at: $kitty_bin"
  exit 1
fi

sock=""
for f in /tmp/mykitty-*; do [[ -S "$f" ]] && { sock="$f"; break; }; done
if [[ -z "$sock" ]]; then
  echo "No kitty socket found at /tmp/mykitty-* (kitty not running, or remote control not available)."
  exit 1
fi

find_session_for_path() {
  local target="$1"
  [[ -d "$session_dir" ]] || return 1
  for f in "$session_dir"/*.kitty-session; do
    [[ -f "$f" ]] || continue
    local file_path
    file_path="$(grep '^cd ' "$f" | head -1 | sed 's/^cd //')"
    [[ -z "$file_path" ]] && continue
    local real
    real="$(normalize_path "$file_path" 2>/dev/null || true)"
    if [[ "$real" == "$target" ]]; then
      basename "$f" .kitty-session
      return 0
    fi
  done
  return 1
}

session_is_alive() {
  local name="$1"
  local count
  count="$("$kitty_bin" @ --to "unix:${sock}" ls --match "session:${name}" 2>/dev/null | jq '[.[]?.tabs[]?.windows[]?] | length' 2>/dev/null || echo 0)"
  [[ "$count" -gt 0 ]]
}

build_live_paths() {
  session_is_alive "home" && printf "%s\n" "$HOME"
  [[ -d "$session_dir" ]] || return 0
  for f in "$session_dir"/*.kitty-session; do
    [[ -f "$f" ]] || continue
    local name
    name="$(basename "$f" .kitty-session)"
    session_is_alive "$name" || continue
    local file_path real
    file_path="$(grep '^cd ' "$f" | head -1 | sed 's/^cd //')"
    [[ -z "$file_path" ]] && continue
    real="$(normalize_path "$file_path" 2>/dev/null || printf "%s" "$file_path")"
    printf "%s\n" "$real"
  done
}

focus_or_launch_dir() {
  local selected_path="$1"
  local selected_real base safe_base hash short_name session_name session_file

  if [[ ! -d "$selected_path" ]]; then
    echo "Directory not found: $selected_path"
    exit 1
  fi

  selected_real="$(normalize_path "$selected_path")"

  if [[ "$selected_real" == "$HOME" ]] && session_is_alive "home"; then
    "$kitty_bin" @ --to "unix:${sock}" action goto_session "home"
    return 0
  fi

  local existing_name
  if existing_name="$(find_session_for_path "$selected_real")"; then
    if session_is_alive "$existing_name"; then

      "$kitty_bin" @ --to "unix:${sock}" action goto_session "$existing_name"
      return 0
    fi
  fi

  base="$(basename "$selected_path")"
  safe_base="$(printf "%s" "$base" | tr -cs 'A-Za-z0-9._-' '_')"
  hash="$(hash_path "$selected_real")"
  hash="${hash:0:4}"
  short_name="${safe_base}"

  if session_is_alive "$short_name"; then
    session_name="${short_name}-${hash}"
  else
    session_name="$short_name"
  fi

  mkdir -p "$session_dir"
  session_file="${session_dir}/${session_name}.kitty-session"

  cat >"$session_file" <<EOF
layout tall
cd ${selected_real}
launch --title "${base}"
focus
focus_os_window
EOF

  "$kitty_bin" @ --to "unix:${sock}" action goto_session "$session_file"
  bump_zoxide_score "$selected_real"
}

build_live_paths > "$live_paths_file"

set +e
printf '\033[2J\033[H'
fzf_out="$(
  fzf --exact --ansi --height=50% --reverse \
    --no-header \
    --prompt="Session > " \
    --no-multi \
    --with-nth=2.. \
    --no-sort \
    --tiebreak=index \
    --border=none \
    --pointer=">" \
    --highlight-line \
    --no-scrollbar \
    --color="bg+:-1,pointer:cyan,separator:0" \
    --bind 'esc:abort' \
    --bind "start:reload:${script_path} --reload" \
    --bind "change:reload:${script_path} --reload"
)"
fzf_rc=$?
set -e

[[ $fzf_rc -ne 0 || -z "${fzf_out:-}" ]] && exit 0

selected_path="$(printf "%s" "$fzf_out" | awk -F'\t' '{print $1}')"
[[ -z "$selected_path" ]] && exit 0

focus_or_launch_dir "$selected_path"
