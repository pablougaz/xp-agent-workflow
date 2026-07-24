---
name: xp-plan-feature
description: Use when trying the packaged XP workflow to plan XP work. Classify work shape, create the smallest useful epic/feature/story structure, and define BEHAVIOR CHANGE or REFACTOR tasks.
argument-hint: '<feature-name>'
---

# Feature Planning

Create a plan for **$ARGUMENTS:Feature name**. Keep `plan.md` and story files succinct: numbered bullet lists, single-sentence descriptions, and no long narrative.

Before creating files, classify the work shape. Read `references/work-shapes.md` if there is any ambiguity.

## Feature Folder Setup

- Check if the feature folder exists in `./pensieve/` or `./plan/`.
- If not found, ask which priority folder to use: `0-Now`, `1-Next`, `2-Later`, `3-Backlog`, or `9-Completed`.
- Default to `3-Backlog` when the user has no preference.
- Create the smallest useful structure:
  - epic folder when the work contains multiple features.
  - feature folder with multiple story files when the work contains multiple shippable behaviors.
  - feature folder with one story file when the work is a single-story feature.
- Check for `brainstorm.md` in the feature folder.
- If `brainstorm.md` is missing, ask the user to run `/xp-brainstorm-feature` first or provide enough context if the feature is small.

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
- Do not create stories inside stories.
- Do not force a tiny feature into multiple stories; use one story with tasks.
- Use fewer than 10 stories, ideally around 5.
- If a feature needs more than 10 stories, suggest splitting it into an epic with features.
- Do not create abstraction-only stories; abstractions emerge through REFACTOR tasks.
- Order stories from simplest observable behavior to most complex.
- Use statuses: Not Started, Next, In Progress, Completed.
- Start all stories as Not Started except the recommended first story, which is Next.
- Name story files as `story-##-description.md`.

## TDD Task Rules

Each story task is one of:

- REFACTOR: extract or rearrange code while all existing tests stay green.
- BEHAVIOR CHANGE: add or modify one test, make it pass, then refactor.

Do not create separate task files. Tasks live in the story markdown file, first in the task status table and then in the task detail section.

A BEHAVIOR CHANGE task is the full TDD cycle. Do not split "write test" and "make test pass" into separate tasks.

For BEHAVIOR CHANGE - CHANGE EXISTING, intentionally change the existing assertion or expectation to the new desired behavior first. Run the test and confirm RED, then make the minimum production change to pass.

If adding a behavior feels awkward, add a REFACTOR task first to make the change easy. Read `references/refactoring-mechanics.md` and `references/design-for-change.md` when drafting REFACTOR tasks.

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
- Name the refactoring mechanic.
- Explain why the refactor makes the next behavior change easier.
- Name the existing test command or test case that proves behavior is preserved before and after the step.
