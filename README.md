# claude-code-statusline-rg

A colourful, information-dense 7-line status area for [Claude Code CLI](https://claude.ai/code), built with bash.

Uses the native `statusLine.command` hook — no tmux, no wrappers.

## Preview

```
✓ Edit ×3  ✓ Read ×2
❮■■■■■|□□□□□❯ 106k - 53%  ⚡38%  🗜 1
Claude Sonnet 4.6 · high ∷ ~/project  🌿 main ✎2
🟢 5h ▮▮▮▮▮▮▮▮▯▯ 83% ⏱️ 4h 40m @ 03:28
🟡 7d ▮▮▮▮▮▮▯▯▯▯ 60% ⏱️ 1d 22h 50m @ 21:38 Thu
📖 read 131k · ✏️ wrote 1k · 🎯 hit 99% · 🗒 346 · 25h 6m
📋 3 · 🔌 2 · 🪝 1 · ⚙️ 42
Tip: type /rg-statusline-help for more info
```

---

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/rgomes87/claude-code-statusline-rg/main/install.sh | bash
```

Then restart Claude Code. The statusline appears immediately.

### What the installer does

1. Downloads `statusline.sh` → `~/.claude/statusline.sh`
2. Downloads the `/rg-statusline-help` slash command → `~/.claude/commands/rg-statusline-help.md`
3. Adds the `statusLine` block to `~/.claude/settings.json`

### Manual install

If you prefer to install manually:

```bash
# 1. Download the script
curl -fsSL https://raw.githubusercontent.com/rgomes87/claude-code-statusline-rg/main/statusline.sh \
  -o ~/.claude/statusline.sh
chmod +x ~/.claude/statusline.sh

# 2. Download the slash command
mkdir -p ~/.claude/commands
curl -fsSL https://raw.githubusercontent.com/rgomes87/claude-code-statusline-rg/main/commands/rg-statusline-help.md \
  -o ~/.claude/commands/rg-statusline-help.md

# 3. Add to ~/.claude/settings.json
{
  "statusLine": {
    "type": "command",
    "command": "bash ~/.claude/statusline.sh"
  }
}
```

---

## Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/rgomes87/claude-code-statusline-rg/main/uninstall.sh | bash
```

---

## Requirements

- **Claude Code CLI** — `npm install -g @anthropic-ai/claude-code` or the desktop app
- `bash`
- `python3` — for JSON parsing (standard on macOS and most Linux distros)
- `jq` — for session data parsing (`brew install jq` / `apt install jq`)
- `git` — for branch and status info

---

## Line-by-line guide

### Line 1 — Active tools

```
✓ Edit ×3  ◐ Bash  ✓ Read
```

| Element | Meaning |
|---------|---------|
| `◐ ToolName` | Tool currently executing (amber) |
| `✓ ToolName` | Tool completed recently (green) |
| `×N` | Called N times in this batch |
| Blue | Read / Write / Edit / NotebookEdit |
| Orange | Bash |
| Cyan | WebFetch / WebSearch |
| Purple | Agent / Task / Plan / Explore |
| Magenta | MCP tool (last segment only) |

---

### Line 2 — Context window

```
❮■■■■■|□□□□□❯ 106k - 53%  ⚡38%  🗜 1
```

| Element | Meaning |
|---------|---------|
| `❮■■░░❯` | 10-cell bar, green → red as context fills |
| `\|` | 100k token marker (turns amber when crossed) |
| `106k - 53%` | Tokens in use and % of 200k limit |
| `⚡38%` | Headroom before autocompact fires |
| `🗜 N` | Times context was compacted this session |

---

### Line 3 — Model, effort & location

```
Claude Sonnet 4.6 · high ∷ ~/project  🌿 main ⊕2 ✎1 ↑3
```

| Element | Meaning |
|---------|---------|
| Model name | Orange = Sonnet · Green = Haiku · Red = Opus |
| `· effort` | Current effort level |
| `∷` | Separator between config and filesystem |
| `~/project` | Working directory (last 2 components) |
| `🌿 branch` | Git branch |
| `⊕N` | Staged files |
| `✎N` | Unstaged changes |
| `↑N / ↓N` | Commits ahead / behind remote |

---

### Line 4 — 5-hour rate limit

```
🟢 5h ▮▮▮▮▮▮▮▮▯▯ 83% ⏱️ 4h 40m @ 03:28
```

Starts full, drains as you use your allowance. 🟢 >75% · 🟡 >50% · 🟠 >25% · 🔴 >0% · ⭕ exhausted.

---

### Line 5 — 7-day rate limit

Same format as line 4. Reset label: **today** / **tomorrow** / weekday name.

---

### Line 6 — Prompt cache & session stats

```
📖 read 131k · ✏️ wrote 1k · 🎯 hit 99% · 🗒 346 · 25h 6m
```

| Element | Meaning |
|---------|---------|
| `📖 read N` | Tokens served from cache (cheap) |
| `✏️ wrote N` | Tokens written to cache |
| `🎯 hit N%` | Cache hit rate — green ≥80% · yellow ≥50% · red <50% |
| `🗒 N` | Assistant turns this session |
| duration | Session age |

---

### Line 7 — Config context

```
📋 3 · 🔌 2 · 🪝 1 · ⚙️ 42  🎙
```

| Element | Meaning |
|---------|---------|
| `📋 N` | CLAUDE.md files loaded |
| `🔌 N` | MCP servers connected |
| `🪝 N` | Hooks configured |
| `⚙️ N` | Permission rules in settings.json |
| `🎙` | Voice mode active (only shown when on) |

---

## Slash command

Once installed, type `/rg-statusline-help` inside Claude Code to print the full legend inline.

---

## License

MIT
