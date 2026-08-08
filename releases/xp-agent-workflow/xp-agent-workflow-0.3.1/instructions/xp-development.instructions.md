---
description: Apply strict XP, TDD, refactoring, and commit workflow rules when planning or implementing code changes.
---

# XP Development Workflow

All coding work follows Extreme Programming practices.

## Task Types

Every task is one of two types:

- BEHAVIOR CHANGE: add or modify a test, watch it fail, then write the minimum production code to pass.
- REFACTOR: preserve behavior while changing structure; all existing tests stay green.

Do not mix behavior changes and refactoring in the same step.

## TDD Cycle

For every behavior change:

1. Write the failing test first.
2. Run the targeted test and confirm RED.
3. Write the minimum production code to pass.
4. Run the targeted test and confirm GREEN.
5. Refactor test code for expressive business behavior and a clear
   Arrange-Act-Assert flow, then rerun the targeted tests and keep them green.
6. Refactor production code into simple, clean, self-documenting units, then
   rerun the targeted tests and keep them green.

Never write production code for non-trivial behavior without a failing test driving it.

Treat `Arrange`, `Act`, and `Assert` comments as test-design failures; express
the phases through whitespace and intention-revealing helpers. Make assertions
express meaningful observable outcomes.

Treat comments as a design failure by default. Do not add comments to explain
code; refactor toward expressive names, types, and structure. Comments are
permitted only in exceptional cases: licensing, generated interfaces, external
protocol constraints, or irreducible safety or business rationale that cannot
be encoded in code. Require each exception to explain why.

When changing existing behavior, RED usually means changing an existing assertion or expectation to the new desired behavior, running the test, and seeing it fail for the expected reason.

## Refactoring Mechanics

- Preserve behavior.
- Prove preservation by running existing tests before and after each refactoring step.
- Add new implementation alongside old implementation.
- Migrate callers incrementally.
- Delete old implementation only after callers are migrated and tests pass.
- Keep one concept per change.
- Do not change production code and test code at the same time during a refactor.
- Prefer named mechanical refactorings: rename, extract function, extract class or module, move function, introduce parameter object, replace primitive with value object, split phase, or move side effects to a boundary.

## Momentum Workflow

1. Make a tiny change.
2. Run the targeted test immediately.
3. If it passes, continue.
4. If it fails, fix immediately or revert the tiny change.
5. Commit frequently after small, working progress.

All tests must pass before final handoff or commit.

After all story tasks are implemented and green, run
`$xp-review-refactoring`. Resolve worthwhile findings one mechanical refactoring
at a time with the relevant tests green before and after each change. Rerun the
story test suite before completion.

## Status Discipline

After finishing a task or story, update the plan/story status before final handoff. Reload the plan first so the status update is grounded in the current work item.

## Code Style

- Write self-documenting code with intent-revealing names and small cohesive
  units.
- Extract structure instead of explaining unclear code with comments.
- Treat every comment as an exceptional constraint that must justify why the
  code cannot express the same intent.
