---
name: plan-feature
description: Use when the user wants to break a feature into testable, shippable XP story increments with behavior-driven tasks.
argument-hint: '<feature-name>'
---

# Feature Planning

Create a plan for **$ARGUMENTS:Feature name**. Keep `plan.md` and story files succinct: numbered bullet lists, single-sentence descriptions, and no long narrative.

## Feature Folder Setup

- Check if the feature folder exists in `./pensieve/` or `./plan/`.
- If not found, ask which priority folder to use: `0-Now`, `1-Next`, `2-Later`, `3-Backlog`, or `9-Completed`.
- Default to `3-Backlog` when the user has no preference.
- Create a folder named `./pensieve/<chosen-folder>/feature-<NNN>-<feature-name>/` using the next available 3-digit number.
- Check for `brainstorm.md` in the feature folder.
- If `brainstorm.md` is missing, ask the user to run `/brainstorm-feature` first or provide enough context if the feature is small.

## plan.md Structure

Create `plan.md` with:

- Feature title.
- Brief overview, 2-3 sentences maximum.
- Story tracking table: Story | Description | Status.
- Implementation Notes section covering abstractions, patterns, and testability approach.

## Story Breakdown Rules

- Behavior-driven, not implementation-driven.
- First question: "What is the first behavior test I want to write?"
- Use Given-When-Then for behavior tasks.
- Keep stories small and shippable.
- Use fewer than 10 stories, ideally around 5.
- If a feature needs more than 10 stories, suggest splitting it.
- Do not create abstraction-only stories; abstractions emerge through REFACTOR tasks.
- Order stories from simplest observable behavior to most complex.
- Use statuses: Not Started, Next, In Progress, Completed.
- Start all stories as Not Started except the recommended first story, which is Next.
- Name story files as `story-##-description.md`.

## TDD Task Rules

Each story task is one of:

- REFACTOR: extract or rearrange code while all existing tests stay green.
- BEHAVIOR CHANGE: add or modify one test, make it pass, then refactor.

A BEHAVIOR CHANGE task is the full TDD cycle. Do not split "write test" and "make test pass" into separate tasks.

If adding a behavior feels awkward, add a REFACTOR task first to make the change easy.

## Story File Structure

Each story file contains:

- Story title.
- Brief description, 1-2 sentences.
- Task status table: # | Task | Type | Status.
- Task details section below the table.

Use this task heading format:

```text
Task ##: Task Name - TYPE DETAIL
```

For BEHAVIOR CHANGE - NEW TEST:

- Name the new behavior in Given-When-Then format.
- Include test file and test name.
- End with a Refactor bullet describing cleanup after GREEN.

For BEHAVIOR CHANGE - CHANGE EXISTING:

- Describe the behavior change.
- Include test file and test name being modified.
- End with a Refactor bullet describing cleanup after GREEN.

For REFACTOR:

- State what abstraction or structure changes.
- Explain why all existing behavior remains unchanged.
