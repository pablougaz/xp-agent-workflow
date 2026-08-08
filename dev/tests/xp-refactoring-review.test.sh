#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
PACKAGE="$REPO_ROOT/packages/xp-agent-workflow"
SKILL="$PACKAGE/.apm/skills/xp-review-refactoring/SKILL.md"
OPENAI_METADATA="$PACKAGE/.apm/skills/xp-review-refactoring/agents/openai.yaml"
PLAN_SKILL="$PACKAGE/.apm/skills/xp-plan-feature/SKILL.md"
PLAN_REVIEW_SKILL="$PACKAGE/.apm/skills/xp-review-feature-plan/SKILL.md"
STATUS_SKILL="$PACKAGE/.apm/skills/xp-update-feature-status/SKILL.md"
XP_INSTRUCTIONS="$PACKAGE/.apm/instructions/xp-development.instructions.md"
PENSIEVE_INSTRUCTIONS="$PACKAGE/.apm/instructions/pensieve-planning.instructions.md"
PACKAGE_MANIFEST="$PACKAGE/apm.yml"
README="$REPO_ROOT/README.md"
USAGE="$REPO_ROOT/docs/workflow-usage.md"

fail() {
    echo "FAIL: $1" >&2
    exit 1
}

whole_file_matches() {
    local pattern="$1"
    local file="$2"
    tr '\n' ' ' < "$file" | grep -qi "$pattern"
}

[[ -f "$SKILL" ]] || fail "xp-review-refactoring skill is missing"
[[ -f "$OPENAI_METADATA" ]] || fail "xp-review-refactoring UI metadata is missing"

grep -q '^name: xp-review-refactoring$' "$SKILL" || fail "skill name does not match its directory"
grep -qi 'explicit.*scope.*takes precedence\|explicit.*scope.*wins' "$SKILL" || fail "explicit review scope is not authoritative"
grep -qi 'staged.*unstaged\|unstaged.*staged' "$SKILL" || fail "Git working changes are not a fallback scope"
grep -qi 'latest commit\|HEAD~1' "$SKILL" || fail "latest commit is not a bounded fallback scope"
grep -qi 'tests.*green\|green.*tests' "$SKILL" || fail "review does not require green tests"
grep -qi 'test code.*production code\|tests.*production code' "$SKILL" || fail "review does not cover tests before production code"
grep -qi 'arrange.*act.*assert\|AAA' "$SKILL" || fail "review omits expressive AAA test structure"
grep -qi 'mechanical refactor' "$SKILL" || fail "findings do not name a mechanical refactoring"
grep -qi 'do not implement\|does not implement' "$SKILL" || fail "review/implementation boundary is unclear"

for caller in "$PLAN_SKILL" "$PLAN_REVIEW_SKILL" "$STATUS_SKILL" "$XP_INSTRUCTIONS" "$PENSIEVE_INSTRUCTIONS"; do
    grep -q '\$xp-review-refactoring' "$caller" || fail "$caller does not integrate the final review"
done

whole_file_matches 'test code.*production code\|tests.*production code' "$XP_INSTRUCTIONS" || fail "per-task cleanup is not ordered test-first"
grep -qi 'arrange.*act.*assert\|AAA' "$XP_INSTRUCTIONS" || fail "per-task test cleanup omits expressive AAA"
grep -qi 'self-documenting' "$XP_INSTRUCTIONS" || fail "per-task production cleanup omits self-documenting code"
grep -qi 'final.*REFACTOR task\|final story task.*REFACTOR' "$PLAN_SKILL" || fail "plans do not end stories with a review-and-resolve REFACTOR task"
grep -qi 'cannot.*Completed\|do not.*Completed' "$STATUS_SKILL" || fail "status can complete before the final review"
grep -q '^version: 0.3.0$' "$PACKAGE_MANIFEST" || fail "XP package version is not 0.3.0"
grep -q '`xp-review-refactoring`' "$README" || fail "README does not list the new skill"
grep -q '/xp-review-refactoring' "$USAGE" || fail "workflow usage does not show the new command"

echo "PASS: XP refactoring review is portable and integrated into story completion"
