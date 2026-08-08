---
name: xp-review-refactoring
description: Use this skill when reviewing green code for worthwhile refactoring opportunities after a story or requested code change, including when another XP workflow requests its final cleanup review. Accept explicit files, symbols, tasks, commits, or diffs; otherwise inspect current Git changes. Review tests and production code, report actionable refactorings, and do not implement behavior changes.
---

# Review Refactoring

Review completed, passing work for improvements that preserve behavior. Produce
an evidence-based cleanup advisory; do not implement the findings.

## Resolve the review scope

Explicit review scope wins over Git-derived scope.

1. Treat an explicit scope as authoritative when the caller names files,
   symbols, story tasks, commits, or a diff range. Include the relevant tests,
   test doubles, and production collaborators that exercise that scope.
2. For story-end review, read the active story and plan, then use Git history to
   resolve the complete story boundary. Include staged and unstaged work. Use a
   merge-base only when the discovered branch is dedicated to that story.
   Never assume the latest commit represents the entire story.
3. For non-story work without explicit scope, inspect staged and unstaged
   changes.
4. Resolve paths and repository state with tools. Do not assume a language,
   framework, integration branch, planning-folder name, or test command.
5. Read enough surrounding code to understand behavior and existing patterns;
   do not judge changed lines without their context.

If no bounded code scope can be established, stop and request a scope instead
of reviewing the whole repository.

## Establish green

Discover test commands from repository guidance and the active story. For a
story, run its complete declared suite; otherwise run the complete suite that
exercises the review scope. A targeted test is not a completion gate. Require
the suite to be green before reviewing. If it fails, report the failures and
stop: refactoring starts from observed behavior that already passes.

## Review test code first

Review tests, test helpers, fixtures, and test doubles with the same rigor as
production code.

- Make business behavior clear from test names, setup, actions, and assertions.
- Keep an expressive Arrange-Act-Assert (AAA) flow. Treat `Arrange`, `Act`, and
  `Assert` comments as test-design failures; express the phases through
  whitespace and intention-revealing helpers.
- Assert observable outcomes and meaningful domain values, not implementation
  details or incidental call sequences.
- Keep each test focused while avoiding helper abstractions that hide the
  behavior being specified.
- Remove irrelevant setup and duplication when doing so improves understanding.
- Give test data, builders, fakes, and mocks names that explain their business
  role.

## Review production code second

Apply Simple Design, SOLID, DRY, and YAGNI in service of the behavior currently
under test.

- Prefer intention-revealing names, small cohesive units, guard clauses, and
  explicit domain concepts.
- Find mixed responsibilities, hidden dependencies, duplicated knowledge,
  primitive obsession, complex conditionals, unnecessary mutation, and dead or
  speculative code.
- Treat comments as a design failure by default. Do not add or rewrite comments
  to explain code; refactor toward expressive names, types, and structure.
  Allow comments only in exceptional cases: licensing, generated interfaces,
  external protocol constraints, or irreducible safety or business rationale
  that cannot be encoded in code. Require each exception to explain why.
- Favor composition and clear dependency boundaries where the current design
  pressure justifies them; do not introduce abstractions for hypothetical use.
- Treat method length and similar metrics as investigation signals, not hard
  thresholds.

Do not disguise a behavior change as cleanup. Report behavior gaps separately
as out of scope for this refactoring-only review.

## Report findings

Report only changes whose readability, design, or maintainability value exceeds
their cost. Avoid speculative, formatting-only, and preference-only findings.

For every finding include:

- Stable finding ID, such as `RF-01`.
- Priority: `Must` blocks story completion; `Should` requires a fix or written
  deferral; `Consider` is optional and non-blocking.
- Area: Tests or Production.
- Location: file and the narrowest useful symbol or line.
- Evidence: the concrete smell and why it impedes understanding or change.
- Mechanical refactoring: name the operation, such as Rename, Extract Function,
  Move Function, Introduce Parameter Object, Replace Primitive with Value
  Object, or Split Phase.
- Preservation proof: the existing test command or test case to run before and
  after the change.
- Status and Disposition: start `Open`; record `Resolved`, `Deferred`, or
  `Rejected` with the result or rationale.

Order test-code findings before production-code findings. State explicitly when
no worthwhile refactoring is found.

When the repository has an unambiguous active feature or story planning folder,
write or update `refactoring.md` there. Otherwise return the review directly;
do not invent a planning tree.
