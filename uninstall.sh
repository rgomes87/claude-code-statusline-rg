#!/usr/bin/env bash
set -euo pipefail

CLAUDE_DIR="$HOME/.claude"
SETTINGS="$CLAUDE_DIR/settings.json"

echo "Uninstalling claude-code-statusline-rg..."

rm -f "$CLAUDE_DIR/statusline.sh"
echo "  ✓ removed statusline.sh"

rm -f "$CLAUDE_DIR/commands/rg-statusline-help.md"
echo "  ✓ removed rg-statusline-help.md"

if [ -f "$SETTINGS" ]; then
  python3 - "$SETTINGS" <<'PYEOF'
import json, sys

path = sys.argv[1]
with open(path) as f:
    data = json.load(f)

if "statusLine" in data:
    del data["statusLine"]
    with open(path, "w") as f:
        json.dump(data, f, indent=2)
    print("  ✓ statusLine removed from settings.json")
else:
    print("  — statusLine not found in settings.json, nothing to remove")
PYEOF
fi

echo ""
echo "Done. Restart Claude Code to deactivate."
