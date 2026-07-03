---
name: brainstorm-feature
description: Use when the user wants to clarify vague work before planning. Classify work size, separate business behavior from design/test approach when useful, and document decisions in a brainstorm file.
argument-hint: '<feature-name>'
---

# Feature Brainstorm Session

Facilitate a feature brainstorming session for: **$ARGUMENTS:Feature name**.

Create a `brainstorm.md` file in the feature folder, such as `./pensieve/1-Next/<feature-name>/brainstorm.md`, documenting the Q&A session and conclusions.

First clarify the work shape. If the size is ambiguous, read `../plan-feature/references/work-shapes.md`.

## Process

- Ask one question at a time.
- Prefer simple yes/no questions when possible.
- Use multiple choice with 3-5 options when exploring alternatives.
- Build incrementally: use each answer to inform the next question.
- Start by classifying the work as epic, feature, single-story feature, refactor-only story, or research spike.
- Separate business behavior questions from design/test approach questions when both are needed.
- Document continuously in `brainstorm.md`.

## Work Shape Questions

- "Is this one shippable behavior, several stories, or several features?"
- "Does this need an epic with feature folders, or a feature with stories?"
- "Is this a single-story feature with multiple tasks?"
- "Is this refactor-only, or will it change observable behavior?"
- "Are there unknowns that require a research spike before planning?"

## Business Behavior Questions

- "What is the first observable behavior the user or system should get?"
- "What should be true after this behavior ships?"
- "What edge case would make the behavior incomplete?"

## Design And Test Approach Questions

- "What existing test should change, or what new test should be written first?"
- "Does the design need a refactor before the first behavior change is easy?"
- "Which boundary, dependency, or domain concept makes this hard to test today?"

## Useful Questions

- "Should the first behavior be: <specific behavior>?"
- "Is this an important behavior: <specific behavior>?"
- "Do we need this abstraction or interface for testability: <specific abstraction>?"
- "Which approach works best: a) <option>, b) <option>, c) <option>?"

End with concise conclusions that can drive `/plan-feature`.
