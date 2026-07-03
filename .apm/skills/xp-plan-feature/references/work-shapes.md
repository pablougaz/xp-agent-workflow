# Work Shapes

Classify the size and uncertainty of the work before creating plan files. Work shape is separate from task type.

## Work Shape

### Epic

Use an epic when the work contains multiple features, has multiple release phases, or spans several repos with separate shippable outcomes.

Recommended structure:

```text
epic-###-name/
  plan.md
  feature-###-name/
    plan.md
    story-01-name.md
```

### Feature

Use a feature when the work has several independently shippable behaviors. Most planned work should be this shape.

Recommended structure:

```text
feature-###-name/
  plan.md
  story-01-name.md
  story-02-name.md
```

### Single-Story Feature

Use a single-story feature when the user calls it a feature but it is really one shippable behavior with multiple tasks.

Recommended structure:

```text
feature-###-name/
  plan.md
  story-01-name.md
```

Do not create extra story files just to satisfy a template.

### Refactor-Only Story

Use a refactor-only story when the work changes structure without changing observable behavior. All tasks are REFACTOR tasks. Existing tests are the behavior proof.

### Research Spike

Use a research spike when the unknowns prevent responsible story planning. The spike output is a decision, recommendation, or follow-up plan, not production behavior.

## Task Type

Task type is not work shape. Inside a story, tasks are normally one of:

- BEHAVIOR CHANGE
- REFACTOR

Occasionally a task can be SUPPORT, SETUP, or CHORE when it truly cannot be expressed as a behavior change or refactor. These should be rare and justified in the task detail.

Do not create separate task files by default. Keep tasks in the story file unless a single task grows large enough to need its own durable artifact, such as a research report or migration checklist.

## Planning Rule

If the work has one shippable behavior, create one story. If it has several shippable behaviors, create several stories. If it has several features, create an epic.
