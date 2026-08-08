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
   symbols, story tasks, commits, or a diff range. Review that code even when it
   is absent from the current Git diff.
2. Without explicit scope, inspect staged and unstaged Git changes.
3. If the working tree has no relevant changes, use the latest commit as the
   bounded fallback, such as `git diff HEAD~1 HEAD`.
4. Resolve paths and repository state with tools. Do not assume a language,
   framework, integration branch, planning-folder name, or test command.
5. Read enough surrounding code to understand behavior and existing patterns;
   do not judge changed lines without their context.

If no bounded code scope can be established, stop and request a scope instead
of reviewing the whole repository.

## Establish green

Discover the narrowest relevant test command from repository guidance and
existing tooling. Run it before reviewing and require the tests to be green.
If relevant tests fail, report the failures and stop: refactoring starts from
observed behavior that already passes.

## Review test code first

Review tests, test helpers, fixtures, and test doubles with the same rigor as
production code.

- Make business behavior clear from test names, setup, actions, and assertions.
- Keep an expressive Arrange-Act-Assert (AAA) flow. Prefer whitespace and
  intention-revealing helpers over `Arrange`, `Act`, or `Assert` comments.
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
- Replace explanatory comments with clearer structure and names. Preserve only
  comments required for non-obvious business rules, safety constraints,
  algorithms, licensing, or generated interfaces.
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

- Priority: Must, Should, or Consider.
- Area: Tests or Production.
- Location: file and the narrowest useful symbol or line.
- Evidence: the concrete smell and why it impedes understanding or change.
- Mechanical refactoring: name the operation, such as Rename, Extract Function,
  Move Function, Introduce Parameter Object, Replace Primitive with Value
  Object, or Split Phase.
- Preservation proof: the existing test command or test case to run before and
  after the change.

Order test-code findings before production-code findings. State explicitly when
no worthwhile refactoring is found.

When the repository has an unambiguous active feature or story planning folder,
write or update `refactoring.md` there. Otherwise return the review directly;
do not invent a planning tree.
