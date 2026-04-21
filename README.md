# pure-ai — Spec-Driven Development System

A lightweight spec-driven workflow for Claude Code. Designed to reduce
ambiguity, improve prompt quality, and produce deterministic code output.

---

## Core Principle

> The WWW prompt template is your complexity meter.
> If you fill it in 2 minutes → simple task.
> If you struggle → you need brain or spec.

---

## The Flow

```
! prompt <feature-name>         ← always start here
         ↓
    fill WWW template
         ↓
    2 min / clear    →  SIMPLE   → @prompt-file.md to CCode (one shot)
    5-10 min / clear →  MEDIUM   → @prompt-file.md to plan mode
    struggle / doubt →  COMPLEX  → @brain @prompt-file.md → spec → exec
```

---

## Skills

| Name   | Trigger              | Purpose                                      |
|--------|----------------------|----------------------------------------------|
| `brain`| "brain", "@brain"    | Interview + design gate → Brainstorming Summary |
| `spec` | "spec", "@spec"      | Summary or WWW file → spec+plan files on disk |
| `exec` | "exec", "execute"    | spec+plan files → deterministic implementation |

---

## WWW Prompt Template

Created by `! prompt <feature-name>`. Lives in `specs/<feature-name>/`.

```markdown
# <feature-name>
Date: YYYYMMDD

## Why
Da dove nasce l'esigenza. Cosa triggera questa feature.

## What
Cosa ti aspetti che faccia. Comportamento atteso.

## Where
File o modulo di partenza. Es: src/modules/checkout
```

---

## Filesystem Structure

All files live under `specs/`:

```
specs/
└── <feature-name>/
    ├── prompt-<feature-name>-<YYYYMMDD>.md   ← WWW template (entry point)
    ├── spec-<feature-name>-<YYYYMMDD>.md     ← functional contract
    ├── plan-<feature-name>-<YYYYMMDD>.md     ← technical plan + task list
    └── review-<feature-name>-<YYYYMMDD>.md   ← post-exec observations
```

If `specs/<feature-name>/` already exists when creating a new prompt or spec,
the folder is versioned automatically: `-v2`, `-v3`, etc.

---

## Detailed Flows

### Simple — One Shot

```bash
! prompt stripe-payment
# fill Why/What/Where
# in Claude Code:
@specs/stripe-payment/prompt-stripe-payment-20260413.md
implement this
```

### Medium — Plan Mode

```bash
! prompt stripe-payment
# fill Why/What/Where
# in Claude Code:
@specs/stripe-payment/prompt-stripe-payment-20260413.md
plan mode
```

Plan mode reads the WWW file as context, scans the codebase, generates
and executes a plan natively. No spec or plan files written to disk.

### Complex — Full Spec-Driven

```bash
! prompt stripe-payment
# fill Why/What/Where — if it takes 10+ min or you have doubts:
# in Claude Code:
@brain @specs/stripe-payment/prompt-stripe-payment-20260413.md
# brain interviews you, presents design, waits for approval
# after approval:
spec
# spec writes spec+plan files, then:
exec
# exec implements, writes review
```

---

## brain — How It Works

1. Reads WWW file (or verbal description)
2. Asks targeted questions one at a time on gaps only
3. Presents its interpretation — waits for your approval
4. Refines if you push back
5. Produces Brainstorming Summary after explicit approval
6. Prompts you to run `spec`

**Does not close until you say it's correct.**

---

## spec — How It Works

Accepts two inputs:

- Brainstorming Summary from brain (current session)
- WWW file directly: `@spec @prompt-file.md`

Runs gap checks, resolves ambiguities in chat, then writes exactly two files:
`spec-*.md` (functional contract) and `plan-*.md` (task list with FR references
and explicit dependencies).

---

## exec — How It Works

1. Reads ALL `spec-*` files before starting — mandatory
2. Maps every task to its FR reference
3. Builds dependency graph from `[depends on: ...]` fields
4. Executes tasks in order

**Block classification:**

- **Blocking** — stops all execution: missing architectural decision,
  broken dependency, task references non-existent FR
- **Non-blocking** — skips and continues: isolated missing detail,
  uncovered edge case

Writes one review file at the end. Never modifies spec or plan.

---

## Review File

Post-exec observations. Compact format:

```
BLOCKED: <T-id: reason> | none
ISSUES:  <spec or plan problem: impact> | none
GAPS:    <uncovered edge case> | none
NOTES:   <optimization or improvement> | none
```

Lines with nothing to report are omitted.
The review is for your eyes — exec never acts on it autonomously.

---

## prompt.sh

```bash
! prompt <feature-name>
```

Creates `specs/<feature-name>/prompt-<feature-name>-<YYYYMMDD>.md` and opens
it in your editor.

**Editor options** (edit the script to switch):

```bash
# Option A — lazyvim in tmux vertical split (comment in to activate)
tmux split-window -h -l 50% "nvim '$FILEPATH'"

# Option B — $EDITOR default (active by default)
${EDITOR:-vi} "$FILEPATH"
```

---

## Complexity Decision Guide

| Signal                                  | Path              |
|-----------------------------------------|-------------------|
| WWW filled in < 2 min, no doubts        | One shot          |
| WWW filled in 5-10 min, mostly clear    | Plan mode         |
| Stuck on Why or What                    | brain             |
| Architectural impact, multi-session     | brain → spec → exec |
| Wrong assumption = expensive refactor   | brain → spec → exec |

---

## File Naming

All feature names are **kebab-case**: lowercase, hyphens, no spaces, no special
characters. `prompt.sh` normalizes automatically.

---

## Skill Versions

Current versions: `brain v5`, `spec v4`, `exec v3`.
spec and plan files include `skill-version` in frontmatter.
exec verifies version compatibility before running.
