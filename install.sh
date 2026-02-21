#!/usr/bin/env bash
# Install claude-sounds and hook settings.
# Usage: ./install.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$HOME/claude-sounds"
SETTINGS_DIR="$HOME/.claude"
SETTINGS_FILE="$SETTINGS_DIR/settings.json"

echo "Installing claude-sounds to $TARGET_DIR ..."

mkdir -p "$TARGET_DIR"
cp -r "$SCRIPT_DIR"/easter-egg "$TARGET_DIR/"
cp -r "$SCRIPT_DIR"/error "$TARGET_DIR/"
cp -r "$SCRIPT_DIR"/notification "$TARGET_DIR/"
cp -r "$SCRIPT_DIR"/pre-tool "$TARGET_DIR/"
cp -r "$SCRIPT_DIR"/stop "$TARGET_DIR/"
cp "$SCRIPT_DIR"/play-random.sh "$TARGET_DIR/"
chmod +x "$TARGET_DIR/play-random.sh"

echo "Installing Claude Code settings to $SETTINGS_FILE ..."

mkdir -p "$SETTINGS_DIR"
if [[ -f "$SETTINGS_FILE" ]]; then
    echo "  Backing up existing settings to $SETTINGS_FILE.bak"
    cp "$SETTINGS_FILE" "$SETTINGS_FILE.bak"
fi
cp "$SCRIPT_DIR/claude-settings.json" "$SETTINGS_FILE"

echo "Done! Restart Claude Code to activate sound hooks."
