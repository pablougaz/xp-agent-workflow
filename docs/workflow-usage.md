# XP Workflow Usage

The `xp-agent-workflow` package ships a namespaced XP workflow that can run
beside independently installed base skills and existing hand-copied prompts.

## Commands

Use these commands to try the packaged workflow:

```text
/xp-brainstorm-feature
/xp-plan-feature
/xp-review-feature-plan
/xp-review-refactoring
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
    Shape --> Epic["Epic folder"]
    Epic --> EpicFeatures["contains feature folders"]
    Shape --> Feature["Feature folder"]
    Shape --> Single["Single-story feature folder"]
    Shape --> RefactorOnly["Refactor-only story"]
    Shape --> Spike["Research spike"]
    EpicFeatures --> Plan["/xp-plan-feature"]
    Feature --> Stories["contains story files"]
    Single --> OneStory["contains one story file"]
    RefactorOnly --> RefactorStory["story file"]
    Stories --> Story["story-##.md"]
    OneStory --> Story
    RefactorStory --> Story
    Story --> TaskTable["task table in story file"]
    Spike --> Plan
    Plan --> Review["/xp-review-feature-plan"]
    Review --> TaskTable
    TaskTable --> Execute["Implement next task"]
    Execute --> TaskType{"Task type"}
    TaskType --> Behavior["BEHAVIOR CHANGE"]
    TaskType --> Refactor["REFACTOR"]
    Behavior --> Red["RED: new test or changed existing assertion"]
    Red --> Green["GREEN: minimum code"]
    Green --> TestCleanup["Refactor tests: expressive behavior and AAA"]
    TestCleanup --> CodeCleanup["Refactor production: simple self-documenting code"]
    Refactor --> Preserve["Existing tests pass before and after"]
    CodeCleanup --> Status["/xp-update-feature-status"]
    Preserve --> Status
    Status --> More{"More implementation tasks?"}
    More -->|Yes| Next["Advance next task"]
    More -->|No| FinalReview["/xp-review-refactoring"]
    FinalReview --> Resolve["Resolve worthwhile findings while green"]
    Resolve --> Complete["Complete story"]
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

Tasks live in the story markdown file, in the story's task table and task detail sections. The workflow does not create separate task files.

After every behavior change reaches green, clean up test code first for
business-readable Arrange-Act-Assert flow, then production code for simple,
self-documenting design. Rerun targeted tests after each refactoring step.

Every story ends with a REFACTOR task that runs
`/xp-review-refactoring`, resolves worthwhile findings one mechanical change at
a time, and reruns the relevant story suite before completion.

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
