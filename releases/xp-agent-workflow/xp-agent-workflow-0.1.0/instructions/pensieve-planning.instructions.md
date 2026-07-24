---
description: Apply pensieve feature planning conventions when creating or updating feature plans and story files.
---

# Pensieve Planning Workflow

Feature plans live in `pensieve/` when a repository uses this workflow.

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

Stories describe observable behavior, not implementation details.

Story tasks are either:

- REFACTOR
- BEHAVIOR CHANGE

Every BEHAVIOR CHANGE task names the test file, test name, and Given-When-Then behavior.

Use statuses consistently:

- Not Started
- Next
- In Progress
- Completed
