#!/usr/bin/env bash
set -euo pipefail

REPO="https://raw.githubusercontent.com/rgomes87/claude-code-statusline-rg/main"
CLAUDE_DIR="$HOME/.claude"
COMMANDS_DIR="$CLAUDE_DIR/commands"
SETTINGS="$CLAUDE_DIR/settings.json"

echo "Installing claude-code-statusline-rg..."

# 1. Download statusline script
curl -fsSL "$REPO/statusline.sh" -o "$CLAUDE_DIR/statusline.sh"
chmod +x "$CLAUDE_DIR/statusline.sh"
echo "  ✓ statusline.sh → $CLAUDE_DIR/statusline.sh"

# 2. Download slash command
mkdir -p "$COMMANDS_DIR"
curl -fsSL "$REPO/commands/rg-statusline-help.md" -o "$COMMANDS_DIR/rg-statusline-help.md"
echo "  ✓ rg-statusline-help.md → $COMMANDS_DIR/rg-statusline-help.md"

# 3. Patch settings.json
if [ ! -f "$SETTINGS" ]; then
  echo '{}' > "$SETTINGS"
fi

python3 - "$SETTINGS" <<'PYEOF'
import json, sys

path = sys.argv[1]
with open(path) as f:
    data = json.load(f)

if "statusLine" in data:
    print("  ⚠  statusLine already set in settings.json — skipping (edit manually if needed)")
else:
    data["statusLine"] = {
        "type": "command",
        "command": "bash ~/.claude/statusline.sh"
    }
    with open(path, "w") as f:
        json.dump(data, f, indent=2)
    print("  ✓ statusLine added to settings.json")
PYEOF

echo ""
echo "Done. Restart Claude Code to activate the statusline."
echo "Type /rg-statusline-help inside Claude Code for a legend."
