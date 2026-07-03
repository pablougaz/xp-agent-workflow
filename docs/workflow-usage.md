# XP Agent Workflow Usage

This package ships an experimental, namespaced XP workflow that can run beside existing hand-copied prompts.

## Commands

Use these commands to try the packaged workflow:

```text
/xp-brainstorm-feature
/xp-plan-feature
/xp-review-feature-plan
/xp-update-feature-status
```

Existing prompts such as `/plan-feature` are not replaced.

## Workflow

```mermaid
flowchart TD
    Start["Work request"] --> Brain{"Clear enough to plan?"}
    Brain -->|No| Brainstorm["/xp-brainstorm-feature"]
    Brain -->|Yes| Shape["Classify work shape"]
    Brainstorm --> Shape
    Shape --> Epic["Epic: multiple features"]
    Shape --> Feature["Feature: multiple stories"]
    Shape --> Single["Single-story feature"]
    Shape --> RefactorOnly["Refactor-only story"]
    Shape --> Spike["Research spike"]
    Epic --> Plan["/xp-plan-feature"]
    Feature --> Plan
    Single --> Plan
    RefactorOnly --> Plan
    Spike --> Plan
    Plan --> Review["/xp-review-feature-plan"]
    Review --> Execute["Implement task"]
    Execute --> TaskType{"Task type"}
    TaskType --> Behavior["BEHAVIOR CHANGE"]
    TaskType --> Refactor["REFACTOR"]
    Behavior --> Red["RED: new test or changed existing assertion"]
    Red --> Green["GREEN: minimum code"]
    Green --> Cleanup["Refactor while tests pass"]
    Refactor --> Preserve["Existing tests pass before and after"]
    Cleanup --> Status["/xp-update-feature-status"]
    Preserve --> Status
    Status --> Next["Advance next task/story"]
```

## Work Shape Vs Task Type

Work shape answers "how big is this work?"

- Epic: multiple features.
- Feature: several independently shippable stories.
- Single-story feature: one shippable behavior with multiple tasks.
- Refactor-only story: structural change with no behavior change.
- Research spike: unknowns must be resolved before planning stories.

Task type answers "what kind of step is this?"

- BEHAVIOR CHANGE: add a new test or change an existing assertion to the new expected behavior, confirm RED, then make it pass.
- REFACTOR: preserve behavior; existing tests pass before and after each small mechanical step.

## Package Boundary

This package should own reusable workflow behavior:

- XP/TDD discipline.
- Work-shape classification.
- Story/task planning conventions.
- Status update discipline.
- Refactoring mechanics.

Repos should own local facts:

- Test commands.
- Architecture.
- Ports.
- Runtime versions.
- Repo-specific conventions.

## Side-By-Side Evaluation

Use old and new prompts on similar planning tasks:

```text
/plan-feature some-feature
/xp-plan-feature some-feature
```

Compare:

- Did the new workflow classify work size correctly?
- Did it avoid unnecessary story nesting?
- Did it distinguish BEHAVIOR CHANGE from REFACTOR clearly?
- Did it remember status updates?
- Did it stay lightweight enough to use repeatedly?
