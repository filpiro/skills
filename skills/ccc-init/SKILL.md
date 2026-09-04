---

name: ccc-init
description: "Initialize or optimize ccc configuration for the current project. Use ONLY when the user explicitly asks to initialize, configure, update, refresh, or optimize ccc indexing for a repository. Never invoke automatically as part of normal code search."
disable-model-invocation: true
------------------------------

# CCC Project Initialization

Initialize or update `ccc` for the current repository and configure it to index only useful project files.

Do not use this skill for normal code search. Use it only when explicitly requested by the user.

## Workflow

1. Find the project root and inspect the repository structure, manifests, existing ignore files, and file types.
2. If `.cocoindex_code/settings.yml` does not exist, run:

```bash
ccc init
```

3. If the configuration already exists, preserve it and update it rather than replacing it blindly.
4. Review and refine `include_patterns` and `exclude_patterns` using the checklist below.
5. Ensure `.cocoindex_code/` is present in the repository `.gitignore`.
6. Validate the resulting file selection with:

```bash
ccc doctor
```

7. Fix obvious configuration problems if the matched files do not reflect the actual project.
8. Build or update the index:

```bash
ccc index
```

## Inclusion rules

`include_patterns` should describe this repository, not every file type supported by ccc.

* Detect languages and relevant file types from the repository itself.
* Include source code used by the project.
* Include relevant templates, schemas, configuration, or similar text files when they are useful for understanding the codebase.
* Do not keep generic default extensions that are not present or relevant to the project.

## Exclusion checklist

Evaluate the repository before editing `exclude_patterns`.

Exclude:

* dependency directories such as `node_modules`, `vendor`, virtual environments, and equivalent package-manager directories;
* hidden directories and tool metadata that contain no project source;
* plugins, packages, SDKs, themes, or other components downloaded or mirrored from external repositories when they are not maintained as part of this project;
* generated code and generated assets that can be reproduced from source;
* build output such as `dist`, `build`, `target`, coverage output, bundles, compiled files, and framework-specific generated directories;
* caches, temporary files, logs, tool state, and irrelevant dotfiles;
* media and media directories such as images, video, audio, fonts, uploads, and other binary assets.

Adapt these exclusions to the actual framework and build system. Do not exclude a directory only because its name resembles a generated directory if it contains maintained source code.

## Existing ignore files

Inspect `.gitignore` and other relevant ignore files such as `.dockerignore` or tool-specific ignore files.

Use them as signals for dependencies, generated output, caches, and local artifacts that should also be excluded from ccc.

Do not copy ignore rules blindly: something ignored by Git may still be useful source code for semantic search.

## Final checks

Before indexing, verify that:

* project source files are included;
* unrelated language/file types are not included;
* dependencies and external downloaded code are excluded;
* generated/build output is excluded;
* caches and irrelevant dotfiles are excluded;
* media is excluded;
* `.cocoindex_code/` is ignored by Git.

Then run `ccc index`.
