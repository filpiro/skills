---
name: to-plan
description: Turn a resolved discussion, grilled specification, or chat history into an implementation plan that another agent can execute.
---

# To Plan

Your goal is to transform the current discussion into an implementation plan.

Assume the discussion already contains the necessary context and decisions.

Do not restart discovery.

Do not reopen settled decisions unless they are contradictory, unsafe, or impossible to implement.

Ask questions only if a missing answer would materially change the implementation.

## Output

Produce an implementation plan containing:

* Goal
* Confirmed Decisions
* Open Questions
* Technical Approach
* Implementation Phases
* Testing Strategy
* Risks
* Agent Handoff Notes

The plan should be detailed enough that another agent can implement the feature without rereading the original discussion or repeating discovery work.

Preserve:

* decisions
* assumptions
* trade-offs
* constraints
* architectural boundaries

The plan should reduce implementation ambiguity as much as possible.

Think like a technical lead preparing work for an implementation engineer.

## Context Sources

Use the discussion as the primary source of truth.

When planning a feature, consult documentation related to the affected subsystem when available, including:

- CONTEXT.md
- ADRs
- architecture documentation
- previous plans
- project conventions

Avoid broad documentation discovery.

If documentation conflicts with the repository or established decisions, note the discrepancy and prefer the repository.