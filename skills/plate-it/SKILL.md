---
name: plate-it
description: Turn a grilled WWHW feature into a compact, self-contained execution brief a smaller agent can follow without re-planning.
---

# Plate It

You are not brainstorming. You are compiling.

Take the current `grill-me` result for a WWHW prompt and produce a **single execution brief** that is safe for a smaller implementation agent to follow with minimal reinterpretation.

## Operating mode
- Do not reopen approved decisions.
- Do not add new architecture unless required by a clearly documented blocker.
- Do not ask exploratory questions unless the feature directory cannot be identified.
- If information is missing, mark it explicitly under `Open Questions`.
- Prefer **precision and compression** over completeness theater.

## Target resolution
Determine the feature directory from the prompt currently in context.

Expected location:
- `.agents/specs/<feature>/` or `.agents/specs/<feature>-vN/`

Output rules:
- Write the brief in the **same directory** as the prompt used during `grill-me`.
- If the current feature version is ambiguous, stop and ask.
- Do not create parallel folders.

## Output files
Create or update these files in the feature directory:

1. `spec.md` → stable, self-contained execution brief
2. `notes.md` → optional scratch references only if needed

`spec.md` is the source of truth.

## `spec.md` contract
Use exactly this structure.

# <feature-name>
Date: YYYY-MM-DD
Status: Ready for execution
Source: grill-me

## 1. Goal
- Concrete problem
- Why it matters
- Observable success outcome

## 2. Scope
### In
- Explicit implementation targets

### Out
- Explicit exclusions

## 3. Locked Decisions
- Approved decisions only
- Atomic, normative statements
- No alternatives

## 4. Constraints
- Hard technical or architectural constraints only
- No soft preferences

## 5. Repo Map
### Entry points
- file/path → role

### Reusable pieces
- file/path → what can be reused

### Touch points
- likely files to modify

Keep this focused. Only list items relevant to execution.

## 6. Execution Plan
A short ordered list of implementation steps.

Rules:
- dependency-ordered
- each step must produce a meaningful checkpoint
- each step must be small enough to verify and commit
- avoid meta-steps like “analyze codebase” unless truly needed

For each step use:
- Step N — title
- Objective
- Files
- Change
- Verify
- Commit message

## 7. Allowed Autonomy
List what the executor may decide without asking.
Examples:
- minor naming
- local extraction inside an edited file
- obvious file placement following repo conventions
- tiny UI/detail choices not affecting product behavior

## 8. Open Questions
Only unresolved items that materially affect execution.
For each item include:
- missing information
- impact
- temporary assumption allowed? yes/no

## 9. Verification
Define required checks.
Prefer repository-native verification.
If a mandatory repo script is known, name it.
Include key functional checks and important edge cases.

## 10. Done
Binary checklist only.

## Writing rules
- Be terse.
- Use bullets over prose.
- Avoid repeating the same fact in multiple sections.
- Do not mention the grilling conversation.
- Do not include chain-of-thought.
- Do not pad the document.

## Failure handling
If the brief cannot be completed safely:
- still create `spec.md`
- mark `Status: Blocked`
- make blockers explicit in `Open Questions`
- do not invent decisions

## Goal
Produce a brief that lets a smaller agent implement the feature with:
- no product reinterpretation
- minimal architectural guessing
- clear step/checkpoint boundaries
