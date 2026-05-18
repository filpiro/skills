---
name: grill-me
description: Use when the user wants to explore, stress-test, or define a plan before implementing. Triggers on "brainstorm", "grill me", "help me think through", "let's plan", or any request to clarify a feature/system before building. Explores the codebase, interviews the user with structured questions, then produces a session-based implementation plan ready for inline review.
---

## Phase 1 — Explore

Before asking anything, explore the codebase in this order:

1. `ccc search <topic>` — semantic orientation, find relevant files and concepts
2. `ccc describe <path>` — summarize key files identified in step 1
3. If structural patterns need verification (impact analysis, existing conventions, anti-patterns): `ast-grep --lang [language] -p '<pattern>'`. Avoid using text-only search tools unless a plain-text search is explicitly requested.

Use findings to skip questions the code already answers.

## Phase 2 — Q&A

Interview the user on every aspect not resolved by Phase 1. Walk the decision tree, resolving dependencies one by one. One question per turn (any answer format is valid).

Every question uses exactly one of these formats:

**Multiple options:**
```
[Qn] <question>
→ A) option  B) option  C) option
★ Recommend: X — <one-line reason>
```

**Binary:**
```
[Qn] <question>
→ Yes / No
★ Recommend: Yes — <one-line reason>
```

**Open:**
```
[Qn] <question>
★ Recommend: <concise answer>
```

Only ask if the answer materially changes the plan. Stop when the decision tree is fully resolved.

## Phase 3 — Plan

Produce the plan in chat. Include only the recommended approach.

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PLAN: <title>

Context: <2-3 lines summarizing key findings from Phase 1>
Constraints: <bullet list — only if present>
Risks: <bullet list — only if emerged from Q&A>
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Session 1 — <title>
Goal: <one line, only if not obvious from title>
  • <task>
  • <task>
Files: path/to/file.ts, path/to/other.ts

Session 2 — <title>
Goal: <one line, only if not obvious from title>
  • <task>
  • <task>
Files: path/to/file.ts
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Confirmed? Edit inline or type `stamp` for XML.
```

`Constraints` and `Risks` are optional — omit if empty. Re-render the full plan after any inline edit.

## Stamp (optional)

Only if the user types `stamp`:

```xml
<plan title="...">
  <context>...</context>
  <constraints>
    <item>...</item>
  </constraints>
  <risks>
    <item>...</item>
  </risks>
  <session id="1" title="..." goal="...">
    <task>...</task>
    <files>
      <file>path/to/file.ts</file>
    </files>
  </session>
</plan>
```
