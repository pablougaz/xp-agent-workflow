# Refactoring Mechanics

Refactoring preserves behavior. The operational proof is that existing tests pass before and after each small step.

## Rules

- Do not change observable behavior.
- Do not add or change tests during a pure refactor.
- Run the relevant existing tests before the refactor step.
- Make one mechanical change.
- Run the relevant existing tests again.
- If tests fail, fix immediately or revert the step.

## Common Mechanics

- Rename variable, function, class, file, or module.
- Extract function.
- Inline function.
- Extract class or module.
- Move function or field.
- Introduce parameter object.
- Replace primitive with value object.
- Replace conditional with polymorphism or dispatch table.
- Encapsulate collection.
- Split phase.
- Separate query from modifier.
- Introduce adapter or port.
- Move side effect to boundary.
- Add new implementation alongside old, migrate callers, then delete old.

## Refactor Task Template

```text
Task ##: Name - REFACTOR

Purpose: Make the next behavior change easier by <design pressure>.
Mechanic: <named refactoring>.
Behavior proof: Run <existing test command/test name> before and after; both stay green.
Rollback: Revert this mechanical step if the proof fails.
```

## Non-Refactor Warning

If the task needs a new assertion, changed assertion, new test fixture, or new production behavior, it is a BEHAVIOR CHANGE task, not a REFACTOR.
