---
name: review-feature-plan
description: Use when the user wants an existing feature plan reviewed against the current codebase and revised into realistic XP story increments.
---

# Review Feature Plan

- Identify which feature to review.
- If it is not obvious, ask the user and state the feature name so they can correct it.
- Read the feature `plan.md` and story files.
- Inspect the relevant code before changing the plan.
- Check whether the plan fits the existing code instead of assuming a greenfield implementation.
- Look for stories that create new structures when existing code should be extended.
- Ask focused questions when trade-offs or product behavior are unclear.
- Prefer concise recommendations and direct plan edits.

## Review Criteria

- Stories describe observable behavior.
- Story increments are small and shippable.
- Tasks are either REFACTOR or BEHAVIOR CHANGE.
- BEHAVIOR CHANGE tasks name test file, test name, and Given-When-Then behavior.
- REFACTOR tasks preserve behavior and keep existing tests green.
- The order makes the first useful behavior easy to test.
- The plan uses existing code patterns where appropriate.

## Outputs

- Update `plan.md` and story files when changes are straightforward.
- Create `review-feature.md` in the feature folder only when the recommendations are larger than a few direct edits.
- If creating `review-feature.md`, keep it succinct with single-sentence numbered bullets.
