---
name: xp-update-feature-status
description: Use when trying the packaged XP workflow after implementation, review, test, or planning progress changes story/task/plan status. Reload the plan, update completed work, and advance the next item.
argument-hint: '<feature-name>'
---

# Update Feature Status

- Find the relevant feature and story.
- Use git history if helpful.
- Ask the user only if the feature or completed work is genuinely unclear.
- Reload the current `plan.md` and active story before changing status.
- Update the task status table in the story file.
- Update the story status table in `plan.md` when a story is completed.
- Before final handoff, verify the plan and story status match the work just completed.
- A story cannot move to `Completed` until its final REFACTOR task has run
  `$xp-review-refactoring`, resolved or explicitly dispositioned actionable
  findings, and passed the relevant story test suite.

Task and story statuses progress:

```text
Not Started -> Next -> In Progress -> Completed
```

Typically move two items at a time:

- When one item moves `Next -> In Progress`, move another from `Not Started -> Next`.
- When one item moves `In Progress -> Completed`, move the next work item forward.

If all stories are completed, ask whether to move the feature folder to `pensieve/9-Completed`.

If the user wants to change feature priority, move the feature folder between:

- `0-Now`
- `1-Next`
- `2-Later`
- `3-Backlog`
- `9-Completed`

When this skill is already in context after completing a task, update statuses without waiting for another prompt.

## Status Anchor

Treat status update as part of finishing work, not as optional bookkeeping:

1. Reload the active story and plan.
2. Move completed work to `Completed`.
3. Move the next planned item to `Next` or `In Progress`.
4. Mention the status update in the final handoff.
