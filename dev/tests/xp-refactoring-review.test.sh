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
RELEASE="$REPO_ROOT/releases/xp-agent-workflow/xp-agent-workflow-0.3.1"

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
grep -qi 'complete story\|entire story' "$SKILL" || fail "story-end review does not resolve the complete story boundary"
grep -qi 'story.*plan.*Git history\|Git history.*story.*plan' "$SKILL" || fail "story scope is not grounded in the plan and Git history"
grep -qi 'relevant tests\|tests.*exercise' "$SKILL" || fail "explicit scope does not include its collaborating tests"
if grep -qi 'latest commit.*fallback\|HEAD~1 HEAD' "$SKILL"; then fail "latest commit is still treated as the story boundary"; fi
grep -qi 'tests.*green\|green.*tests' "$SKILL" || fail "review does not require green tests"
grep -qi 'complete.*suite\|full.*suite' "$SKILL" || fail "review does not require the complete relevant suite"
grep -qi 'targeted test.*not.*gate\|targeted tests.*not.*gate' "$SKILL" || fail "targeted tests can still substitute for the story green gate"
grep -qi 'test code.*production code\|tests.*production code' "$SKILL" || fail "review does not cover tests before production code"
grep -qi 'arrange.*act.*assert\|AAA' "$SKILL" || fail "review omits expressive AAA test structure"
grep -qi 'comments.*design failure\|comments.*design defect' "$SKILL" || fail "comments are not treated as a design failure"
grep -qi 'exceptional' "$SKILL" || fail "exceptional comment cases are not bounded"
grep -qi 'mechanical refactor' "$SKILL" || fail "findings do not name a mechanical refactoring"
grep -qi 'finding ID\|stable ID' "$SKILL" || fail "findings do not have stable IDs"
grep -qi 'Status.*Disposition\|Disposition.*Status' "$SKILL" || fail "findings cannot be tracked through disposition"
grep -qi 'Must.*block' "$SKILL" || fail "blocking priority is undefined"
grep -qi 'do not implement\|does not implement' "$SKILL" || fail "review/implementation boundary is unclear"

for caller in "$PLAN_SKILL" "$PLAN_REVIEW_SKILL" "$STATUS_SKILL" "$XP_INSTRUCTIONS" "$PENSIEVE_INSTRUCTIONS"; do
    grep -q '\$xp-review-refactoring' "$caller" || fail "$caller does not integrate the final review"
done

whole_file_matches 'test code.*production code\|tests.*production code' "$XP_INSTRUCTIONS" || fail "per-task cleanup is not ordered test-first"
grep -qi 'arrange.*act.*assert\|AAA' "$XP_INSTRUCTIONS" || fail "per-task test cleanup omits expressive AAA"
grep -qi 'self-documenting' "$XP_INSTRUCTIONS" || fail "per-task production cleanup omits self-documenting code"
grep -qi 'comments.*design failure\|comments.*design defect' "$XP_INSTRUCTIONS" || fail "XP instructions do not treat comments as a design failure"
grep -qi 'exceptional' "$XP_INSTRUCTIONS" || fail "XP instructions do not bound exceptional comments"
grep -qi 'final.*REFACTOR task\|final story task.*REFACTOR' "$PLAN_SKILL" || fail "plans do not end stories with a review-and-resolve REFACTOR task"
grep -qi 'cannot.*Completed\|do not.*Completed' "$STATUS_SKILL" || fail "status can complete before the final review"
grep -q '^version: 0.3.1$' "$PACKAGE_MANIFEST" || fail "XP package version is not 0.3.1"
grep -q '`xp-review-refactoring`' "$README" || fail "README does not list the new skill"
grep -q '/xp-review-refactoring' "$USAGE" || fail "workflow usage does not show the new command"
[[ -f "$RELEASE/plugin.json" ]] || fail "XP 0.3.1 release bundle is missing"
[[ -f "$RELEASE/skills/xp-review-refactoring/SKILL.md" ]] || fail "release bundle omits the new skill"
grep -q '"version": "0.3.1"' "$RELEASE/plugin.json" || fail "release metadata is not version 0.3.1"
[[ ! -e "$RELEASE/skills/remind-me" ]] || fail "release bundle leaks a base-workflows skill"

echo "PASS: XP refactoring review is portable and integrated into story completion"
