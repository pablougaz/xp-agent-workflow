---
name: brainstorm-feature
description: Use when the user wants to brainstorm a vague or early feature before planning stories. Ask focused questions and document the answers in a feature brainstorm file.
argument-hint: '<feature-name>'
---

# Feature Brainstorm Session

Facilitate a feature brainstorming session for: **$ARGUMENTS:Feature name**.

Create a `brainstorm.md` file in the feature folder, such as `./pensieve/1-Next/<feature-name>/brainstorm.md`, documenting the Q&A session and conclusions.

## Process

- Ask one question at a time.
- Prefer simple yes/no questions when possible.
- Use multiple choice with 3-5 options when exploring alternatives.
- Build incrementally: use each answer to inform the next question.
- Balance user-observable behavior with technical design and testability.
- Document continuously in `brainstorm.md`.

## Useful Questions

- "Should the first behavior be: <specific behavior>?"
- "Is this an important behavior: <specific behavior>?"
- "Do we need this abstraction or interface for testability: <specific abstraction>?"
- "Which approach works best: a) <option>, b) <option>, c) <option>?"

End with concise conclusions that can drive `/plan-feature`.
