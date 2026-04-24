---
name: eat-it
description: Execute an approved spec.md step by step. Use this skill when a feature has already been planned and the agent must implement it exactly as specified, update progress.md during execution, verify every step before committing, and run final verification at the end.
---

# eat-it

Execute an existing `spec.md` exactly as written.

`eat-it` is the implementation skill for a spec-driven workflow. It does not plan, redesign, reinterpret, or expand the feature. It implements the approved spec step by step, verifies every step before commit, commits each completed step, and keeps `progress.md` updated during execution.

---

## Source of truth

`spec.md` is the only source of truth for scope and implementation steps.

Before doing anything, you MUST:

1. Locate `spec.md`.
2. Read `spec.md` fully.
3. Extract the ordered implementation steps.
4. Use only those steps for execution.

If `spec.md` is missing, incomplete, contradictory, or does not contain actionable implementation steps, STOP and report the blocker.

Do not rely on chat history, memory, assumptions, or external interpretation when they conflict with `spec.md`.

---

## Required files

Work inside the feature workspace, usually:

```text
.agents/specs/<feature>/
```

Expected files:

```text
prompt.md      Original WWHW prompt, for reference only
spec.md        Approved execution contract
progress.md    Execution journal, updated step by step
```

`prompt.md` is informational only.  
`spec.md` governs scope and ordered steps.  
`progress.md` records actual execution state.

---

## Execution loop

For each step from `spec.md`, in order:

1. Update `progress.md` and mark the step as `in_progress`.
2. Implement only the smallest change needed for that step.
3. Run step verification.
4. Fix only issues directly related to the current step.
5. Re-run step verification until it passes or a blocker is found.
6. Commit the completed step.
7. Update `progress.md` immediately with:
   - step status: `completed`
   - step verification command/result
   - commit hash or commit message
   - relevant notes or blocker, if any

Do not start the next step until `progress.md` has been updated for the completed step.

If `progress.md` cannot be updated, STOP.

---

## Step verification

Step verification is mandatory before every commit.

For each step:

1. If `./.agents/verify` exists, use it.
2. Otherwise, use the narrowest repo-native verification needed for the changed scope.

Acceptable repo-native checks, only when `./.agents/verify` does not exist:

- focused test script for the affected area
- lint for the changed package
- typecheck for the changed package
- focused build/test command

Never commit a step without passing step verification.

If verification fails, fix only what is required for the current step and re-run verification.

If no valid step verification can be identified, STOP and report the blocker.

---

## Final verification

Final verification validates the whole implementation after all steps are completed.

When all steps are completed:

1. If `spec.md` defines a mandatory final verification command, run it.
2. Otherwise, run the broadest reasonable repo-native verification available.
3. Update `progress.md` with the final verification command/result.

Do not use the `spec.md` final verification command as the per-step verification gate unless `spec.md` explicitly says so.

If final verification fails, fix only issues caused by the completed implementation, re-run final verification, and update `progress.md`.

---

## Commit policy

Commit after every completed step.

Each commit must represent one logical step from `spec.md`.

Commit message format:

```text
<type>: <short step summary>
```

Examples:

```text
feat: add product filter schema
fix: handle empty search state
refactor: isolate editor block parser
test: cover checkout validation rules
```

Do not batch multiple unrelated steps into one commit.

If committing is impossible, STOP and report the blocker.

---

## Autonomy limits

You MAY:
- inspect files needed for the current step
- make minimal local fixes required for step verification
- update `progress.md`
- create or modify tests required by the step

You MUST NOT:
- redesign the solution
- add unrequested features
- reorder steps
- skip verification
- skip commits
- silently change scope
- use `notes.md` or chat context as source of truth

If the spec is wrong or impossible to implement safely, STOP and explain the blocker.

---

## Progress format

Keep `progress.md` concise and append-friendly.

Recommended format:

```markdown
# Progress

## Current status
- Active step:
- Last completed step:
- Last step verification:
- Last commit:
- Final verification:

## Steps

### Step 1 — <title>
Status: pending | in_progress | completed | blocked
Step verification:
Commit:
Notes:

### Step 2 — <title>
Status: pending | in_progress | completed | blocked
Step verification:
Commit:
Notes:
```

Update the relevant step before and after each implementation cycle.

---

## Completion report

After final verification passes, report only:

- completed steps
- final verification result
- commits created
- remaining known issues, if any

Do not provide a long narrative unless requested.
