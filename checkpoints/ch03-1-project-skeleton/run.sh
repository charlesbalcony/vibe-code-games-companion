#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

if command -v godot4 >/dev/null 2>&1; then
  GODOT_BIN="$(command -v godot4)"
elif command -v godot >/dev/null 2>&1; then
  GODOT_BIN="$(command -v godot)"
else
  echo "Error: Could not find a Godot binary (godot4/godot) on PATH." >&2
  exit 1
fi

exec "$GODOT_BIN" --path "$SCRIPT_DIR" "$@"
