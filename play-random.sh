#!/usr/bin/env bash
# Play a random sound (.mp3/.wav) from the given directory, cross-platform.
# Usage: play-random.sh <directory>

dir="$1"
[[ -d "$dir" ]] || exit 0

shopt -s nullglob globstar
files=("$dir"/**/*.mp3 "$dir"/**/*.wav)
[[ ${#files[@]} -gt 0 ]] || exit 0

file="${files[RANDOM % ${#files[@]}]}"

if [[ "$(uname -s)" == "Darwin" ]]; then
    afplay "$file" &
elif grep -qi microsoft /proc/version 2>/dev/null; then
    # WSL2: convert to Windows path and play via PowerShell
    wslpath_win="$(wslpath -w "$file")"
    powershell.exe -NoProfile -Command "Add-Type -AssemblyName presentationCore; \$p = New-Object System.Windows.Media.MediaPlayer; \$p.Open([Uri]'$wslpath_win'); \$p.Play(); Start-Sleep -Seconds 5" &
elif command -v mpv &>/dev/null; then
    mpv --no-video --really-quiet "$file" &
elif command -v paplay &>/dev/null; then
    paplay "$file" &
elif command -v aplay &>/dev/null; then
    aplay "$file" &
fi
