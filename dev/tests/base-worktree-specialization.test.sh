#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
START_SKILL="$REPO_ROOT/packages/base-workflows/.apm/skills/start-worktree/SKILL.md"
CLEAN_SKILL="$REPO_ROOT/packages/base-workflows/.apm/skills/clean-worktree/SKILL.md"

for skill in "$START_SKILL" "$CLEAN_SKILL"; do
    if ! grep -qi "more-specific.*worktree" "$skill"; then
        echo "FAIL: $skill does not discover a more-specific worktree workflow" >&2
        exit 1
    fi

    if ! grep -qi "invoke.*stop\|delegate.*stop\|defer.*stop" "$skill"; then
        echo "FAIL: $skill does not stop after handing off to a specialized workflow" >&2
        exit 1
    fi

    if grep -qi "trada\|tradamatic\|broker-service" "$skill"; then
        echo "FAIL: $skill contains private repository knowledge" >&2
        exit 1
    fi
done

echo "PASS: generic worktree skills expose a private-safe specialization point"
