---
name: eat-it
description: Use when the user wants to implement a plan. Triggers on "implement", "eat it", "implement this plan", or when a plan file or chat plan is ready to be executed. Reads the full plan (from XML file or chat), executes it session by session, and produces a final summary with modified files and testing instructions.
---

## Input

Accept either:
- **File**: user passes an XML file — read it entirely before starting
- **Chat**: use the confirmed plan from the current conversation

## Execution

Execute sessions in order. Show progress inline:

```
▶ Session 1 — <title>
  ✓ <task>
  ✓ <task>

▶ Session 2 — <title>
  ✓ <task>
  ...
```

Do not stop between sessions unless explicitly asked.

## Summary

After all sessions are complete, produce a summary in chat:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
DONE: <plan title>
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Modified files:
  • path/to/file.ts — <one-line description of change>
  • path/to/file.ts — <one-line description of change>

Notes: <only if something worth flagging — omit if none>

How to test:
  • <concrete step>
  • <concrete step>
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
