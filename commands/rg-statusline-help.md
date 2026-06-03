---
description: Print the Claude Code statusline icon reference
---

Print the following statusline legend exactly, no additions:

```
STATUSLINE LEGEND
─────────────────────────────────────────────────────

LINE 1 — Active tools
  ◐ Name       Tool currently running (amber)
  ✓ Name       Recently completed tool (green)
  ×N           Called N times
  blue         Read / Write / Edit / NotebookEdit
  orange       Bash
  cyan         WebFetch / WebSearch
  purple       Agent / Task / Plan / Explore
  magenta      MCP tool (name truncated to last segment)
  Ns           Elapsed seconds for completed tool

LINE 2 — Context window
  ❮■■░░❯       10-cell bar — green → red as context fills
  |            100k token boundary (turns amber when crossed)
  106k - 53%   Tokens in context window and % of 200k limit
  ⚡N%          Headroom before autocompact fires (green/yellow/red)
  🗜 N          Times context was compacted this session

LINE 3 — Model & location
  Model name   Orange = Sonnet · Green = Haiku · Red = Opus
  · effort     low/medium/high/xhigh/max
  ∷            Separator between config and filesystem
  ~/path       Working directory (last 2 components)
  🌿 branch    Git branch
  ⊕N           Staged files (green)
  ✎N           Unstaged files (orange)
  ?N           Untracked files (grey)
  ↑N / ↓N      Commits ahead / behind remote

LINE 4 — 5-hour rate limit
  🟢🟡🟠🔴⭕   Remaining: >75% · >50% · >25% · >0% · empty
  ▮▯           Bar drains as allowance is consumed
  ⏱️ Xh Ym     Countdown to reset
  @ HH:MM      Wall-clock reset time

LINE 5 — 7-day rate limit
  Same as line 4. Reset label: today / tomorrow / weekday

LINE 6 — Cache & session
  📖 read N    Tokens served from cache (green = cheap/fast)
  ✏️ wrote N   Tokens written to cache (blue)
  🎯 hit N%    Cache hit rate (green ≥80% · yellow ≥50% · red <50%)
  🗒 N         Assistant turns this session
  ⏳ Xh Ym     Session age

LINE 7 — Config context
  📋 N         CLAUDE.md files loaded (walking up to $HOME)
  🔌 N         MCP servers connected
  🪝 N         Hooks configured
  ⚙️ N         Permission rules in settings.json
  🎙           Voice mode active (only shown when on)
```
