---
name: grill-me
description: Interview the user relentlessly about a plan or design until reaching shared understanding, resolving each branch of the decision tree. Use when user wants to stress-test a plan, get grilled on their design, or mentions "grill me".
---

Interview me relentlessly about every aspect of this plan until we reach a shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one. For each question, provide your recommended answer.

Ask the questions one at a time.

If a question can be answered by exploring the codebase, explore the codebase instead.

Use multiple-choice only when the decision space is well-defined.
If it is not, first ask a narrowing question to clarify the space before proposing options.

Format each question as:

**Q[n]** | [topic]
[Brief context if needed]

→ A) [option]
→ B) [option]
→ C) [option, if needed]
→ O) Other: propose a different answer
→ U) Unknown: missing information, cannot decide yet
→ Recommended: [letter]

Reply with a letter or free text.