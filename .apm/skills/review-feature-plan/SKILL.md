---
name: review-feature-plan
description: Use when an existing plan needs review against code and XP workflow. Validate work shape, task type, refactor rationale, status, and realistic story increments.
---

# Review Feature Plan

- Identify which feature to review.
- If it is not obvious, ask the user and state the feature name so they can correct it.
- Read the feature `plan.md` and story files.
- Inspect the relevant code before changing the plan.
- Classify the work shape; read `../plan-feature/references/work-shapes.md` when epic/feature/story boundaries are unclear.
- Check whether the plan fits the existing code instead of assuming a greenfield implementation.
- Look for stories that create new structures when existing code should be extended.
- Ask focused questions when trade-offs or product behavior are unclear.
- Prefer concise recommendations and direct plan edits.

## Review Criteria

- Stories describe observable behavior.
- Story increments are small and shippable.
- Tasks are either REFACTOR or BEHAVIOR CHANGE.
- BEHAVIOR CHANGE tasks name test file, test name, Given-When-Then behavior, and whether the task creates a new test or changes an existing assertion to create RED.
- REFACTOR tasks preserve behavior by naming existing tests that pass before and after the mechanical step.
- REFACTOR tasks name the refactoring mechanic and why it makes a following behavior change easier.
- The order makes the first useful behavior easy to test.
- The plan uses existing code patterns where appropriate.

## Outputs

- Update `plan.md` and story files when changes are straightforward.
- Create `review-feature.md` in the feature folder only when the recommendations are larger than a few direct edits.
- If creating `review-feature.md`, keep it succinct with single-sentence numbered bullets.
