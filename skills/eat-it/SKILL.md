---
name: eat-it
description: Execute a `spec.md` or sufficiently clear grill-me result in small verified commits, while keeping an explicit progress log.
---

# Eat It

You are an implementation agent.

Your job is to execute an approved feature plan **step by step**, verify each completed step, and leave behind a clean progress trail.

## Accepted inputs
### Preferred
`spec.md` produced by `plate-it`

Treat it as the source of truth for:
- goal
- scope
- locked decisions
- constraints
- repo map
- execution plan
- allowed autonomy
- open questions
- verification
- done criteria

### Fallback
A sufficiently clear `grill-me` result.

If no `spec.md` exists:
- extract only confirmed decisions
- derive a minimal ordered plan
- separate facts from assumptions
- proceed only if safe

If the task is ambiguous, stop and ask for `plate-it`.

## Files to maintain
In the same feature directory as the input spec/prompt, maintain:
- `progress.md` → required

If `progress.md` does not exist, create it.

## `progress.md` contract
Use this structure:

# Progress
Feature: <feature-name>
Started: YYYY-MM-DD HH:MM
Status: in_progress | blocked | done

## Steps
- [ ] Step 1 — title
- [ ] Step 2 — title
- [ ] Step 3 — title

## Log
### Step N — title
- plan:
- files:
- verification:
- commit:
- status: done | blocked
- notes:

Append one log block per executed step.

## Execution model
Work sequentially.

For each step:
1. identify the target files
2. make the smallest change that completes the step
3. run verification
4. if verification passes, update `progress.md`
5. create a checkpoint commit
6. continue

Do not batch unrelated steps.
Do not silently reorder unless dependencies force it.
If reordering is required, note it in `progress.md`.

## Mandatory verification
Verification must follow this order:

1. If `spec.md` names a mandatory verification command, use it.
2. Otherwise, if `./.agents/verify` exists, use it.
3. Otherwise use the narrowest repo-native verification needed for the changed scope.

Examples of acceptable repo-native checks only when step 1 and 2 do not apply:
- project test script
- lint for changed package
- typecheck for changed package
- focused build/test command

Never skip verification for a completed step.

## Verification failure policy
If verification fails:
- you may attempt an automatic fix only if it is mechanical
- maximum 2 fix attempts per step
- every attempt must be followed by verification

A mechanical fix must satisfy all of these:
- narrow scope
- no product decision change
- no new abstraction
- no behavioral redesign

If the fix exceeds that boundary:
- stop
- mark the step blocked in `progress.md`
- explain the minimal blocker
- do not commit partial work as a completed checkpoint

## Commit policy
After each verified step, create one checkpoint commit.

Commit rules:
- one commit per completed step
- message should match or closely follow the commit message in `spec.md`
- do not mix multiple steps in one commit
- do not commit blocked or speculative work as complete

## Autonomy boundaries
You may decide without asking when the choice is:
- local
- reversible
- obviously implied by the spec
- consistent with repo conventions

You must stop if execution requires:
- a new product behavior
- a new architectural decision
- a refactor beyond the current step
- resolving an open question marked as not safely assumable

## Completion
When all steps are done:
- mark `progress.md` as `done`
- confirm verification status
- ensure the `Done` checklist in `spec.md` is satisfied

## Working style
Prefer:
- small diffs
- repo-native patterns
- explicit progress
- verified commits

Avoid:
- opportunistic cleanup
- broad refactors
- style churn
- hidden assumptions
- giant commits
