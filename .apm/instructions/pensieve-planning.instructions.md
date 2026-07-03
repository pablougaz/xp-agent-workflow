---
description: Apply pensieve feature planning conventions when creating or updating feature plans and story files.
---

# Pensieve Planning Workflow

Feature plans live in `pensieve/` when a repository uses this workflow. A repo may use an alias such as `plans/` or `docs/`; follow the repo-local convention when it exists.

Use these priority folders:

- `0-Now`
- `1-Next`
- `2-Later`
- `3-Backlog`
- `9-Completed`

Each feature folder contains:

- `brainstorm.md` when requirements were explored interactively.
- `plan.md` with a concise overview, story tracking table, and implementation notes.
- `story-##-description.md` files for individual story increments.

Use the smallest useful work shape:

- Epic: multiple features.
- Feature: several independently shippable stories.
- Single-story feature: one shippable behavior with multiple tasks.
- Refactor-only story: structural change with no behavior change.
- Research spike: unknowns must be resolved before planning stories.

Stories describe observable behavior, not implementation details.

Story tasks are either:

- REFACTOR
- BEHAVIOR CHANGE

Tasks live inside story markdown files. Each story file has a task status table near the top and task details below it. Do not create separate task files.

Every BEHAVIOR CHANGE task names the test file, test name, and Given-When-Then behavior.

For an existing behavior change, the task names the existing assertion or expectation to change first to create RED.

Every REFACTOR task names the existing tests that prove behavior is preserved before and after the mechanical step.

Use statuses consistently:

- Not Started
- Next
- In Progress
- Completed

Status updates are part of the work. After completing a task, update the story and plan status before final handoff.
