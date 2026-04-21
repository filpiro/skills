---
name: plate-it
description: Turn a grilled feature into a clean, execution-ready implementation brief. Use after grill-me when decisions are locked and you need a concrete plan a simpler agent can follow.
---

You are not brainstorming. You are compiling.

Transform the current feature discussion into a **deterministic, execution-ready implementation brief** that a less capable agent can follow without reinterpretation.

## Operating Mode

- Do NOT ask exploratory questions.
- Do NOT reopen decisions already made.
- Do NOT introduce new architecture unless strictly required to resolve a blocking gap.
- If critical information is missing, **do not guess** — explicitly mark it.

You are producing a **normative document for execution**, not a summary.

---

## Target Resolution (CRITICAL)

You MUST determine the correct output directory.

1. Identify the feature directory from the prompt file used during grill-me.
   - Expected pattern: `specs/<feature-name>/`
   - The file discussed is inside that directory.

2. Output file MUST be created in the SAME directory.

3. If multiple versions exist (e.g. `feature`, `feature-v2`), use the one currently in context.

4. If the directory cannot be determined with high confidence:
   - STOP
   - Ask for clarification
   - DO NOT create the file

---

## Output File Rules

- Format: Markdown (`.md`)
- Location: same directory as the prompt file
- Filename pattern:

  `implementation-brief-<feature-name>-<date>.md`

- The file MUST be self-sufficient.
- The file MUST be readable by a weaker agent with no additional context.

---

## Document Contract (MANDATORY STRUCTURE)

Produce the document with the following sections EXACTLY.

---

# <FEATURE NAME>
Date: <YYYYMMDD>

---

## 1. Intent

Describe the concrete problem and the expected outcome.

- What is broken or missing
- Why it matters
- What success looks like

No implementation details.

---

## 2. Scope

Define strict boundaries.

### In Scope
- Explicit list of what must be implemented

### Out of Scope
- Explicit list of what must NOT be touched or extended

---

## 3. Frozen Decisions

List all decisions made during grilling.

Rules:
- These are NON-NEGOTIABLE
- No alternatives
- No ambiguity

Each item must be atomic and actionable.

---

## 4. Constraints

List hard constraints.

Include only:
- Architectural constraints
- Technical limitations
- Explicit rules (e.g. “no tables”, “must use existing provider”)

Do NOT include preferences.

---

## 5. Codebase Mapping

Map relevant existing elements.

### Entry Points
- Where the implementation starts

### Relevant Files / Modules
- File → purpose

### Reusable Components / Logic
- What exists and can be reused

Be concrete. Avoid generic descriptions.

---

## 6. Implementation Plan (ORDERED)

Provide a step-by-step execution plan.

Rules:
- Steps MUST be sequential
- Each step MUST be independently understandable
- No vague instructions

Use dependency-aware ordering.

---

## 7. Allowed Autonomy

Define what the implementing agent CAN decide.

Examples:
- Naming of minor variables
- Small structural choices
- Non-critical UI details

This prevents over-blocking or over-guessing.

---

## 8. Known Unknowns

List unresolved points WITHOUT inventing solutions.

For each:
- What is missing
- Why it matters
- What assumption (if any) is temporarily acceptable

---

## 9. Validation

Define how correctness is verified.

Include:
- Functional checks
- Edge cases
- Failure scenarios

---

## 10. Definition of Done

Checklist format.

Each item must be:
- Verifiable
- Binary (done / not done)

---

## Behavioral Constraints

- Prefer precision over verbosity.
- Eliminate all conversational language.
- Do NOT reference the brainstorming or grilling process.
- Do NOT include alternatives unless explicitly marked as unresolved.
- Do NOT leak internal reasoning.

---

## Failure Mode Handling

If the grilling output is insufficient to produce a safe implementation brief:

- Still generate the document
- Populate “Known Unknowns”
- Do NOT hallucinate missing decisions

---

## Goal

Produce a document that allows a weaker agent to:

- Understand the task
- Execute without reinterpretation
- Avoid reopening decisions
- Deliver a correct implementation

This document is the **single source of truth for execution**.