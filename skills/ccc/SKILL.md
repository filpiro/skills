---
name: ccc
description: "ALWAYS use this skill when you need to discover, locate, explore, or understand code in the codebase by meaning or structure. Use for questions like 'where is X handled?', 'how does Y work?', 'find code related to Z', call-site or AST-pattern searches, and refactor-oriented discovery. Prefer ccc over plain grep/glob for exploratory code search. Do NOT invoke for a known file/path or a simple exact literal lookup."
---

# ccc — Codebase Search

Use `ccc` when the task requires **discovering where relevant code is**.

## Choose the right search

### Semantic / conceptual → `ccc search`

Use for behavior, concepts, responsibilities, implementations, or unfamiliar code:

```bash
ccc search --lang <language> <natural language query>
```

Examples:

```bash
ccc search --lang typescript authentication session handling
ccc search --lang python retry logic for failed requests
```

Rules:

* `--lang` is required. Use full language names such as `typescript`, `javascript`, `python`, `rust`.
* Query by **meaning**, not exact syntax.
* Multiple languages: repeat `--lang`.
* Results are discovery hints. Start with the best few matches, then read or grep them to confirm.
* Search is scoped to the current directory. Use `--path '**'` for the whole repository or `--path 'src/**'` to narrow it.
* If a language-filtered search unexpectedly returns nothing, retry without `--lang` and inspect the language labels in the results.

### Structural / AST → `ccc grep`

Use when looking for a code shape, call pattern, or refactor target:

```bash
ccc grep '<pattern>' --lang <language>
```

Examples:

```bash
ccc grep 'def \NAME(\(ARGS*\)):' --lang python
ccc grep 'const \X = \Y' --lang typescript
```

`\NAME` matches one syntax node;
`\(ARGS*\)` matches a variable-length sequence.

## When not to use ccc

Use ordinary grep/glob/read tools directly when:

* `ccc` is not already initialized for the project;
* searching for an exact literal string;
* the filename or path is already known;
* the relevant file has already been identified and only needs inspection.

For exploratory codebase questions, **do not start with plain grep or glob**.

Assume `ccc` is already initialized, indexed, and working. Do not manage initialization, indexing, daemon state, or diagnostics as part of normal code search.
