---
name: clean-worktree
description: Use this skill when the user wants to remove, clean up, or retire a completed Git worktree and its associated local branch. Resolve the exact registered worktree, verify dirty state and merge or containment status, then remove only the confirmed targets. Do not use for deleting arbitrary directories, cleaning build artifacts, or pruning unrelated branches.
---

# Clean Up a Git Worktree

This workflow removes data. Resolve exact targets and preserve recoverability before acting.

## Procedure

1. Resolve the repository root and read `git worktree list --porcelain`.
2. Match the user's task, branch, or path to exactly one registered worktree. Never infer a deletion target from a broad glob or unresolved environment variable.
3. Identify:
   - The absolute worktree path.
   - Its checked-out branch and current commit.
   - The repository's primary integration branch from local configuration or remote HEAD; do not assume `main`.
4. Inspect the target worktree with `git status --short --branch`.
5. If tracked or untracked changes exist, stop and ask for explicit direction. Show filenames/statuses without printing file contents.
6. Fetching is not implicit. Determine merge safety against the available local integration branch and state when remote freshness has not been verified.
7. Verify that the worktree branch is merged into the chosen integration branch, or that all branch commits are otherwise contained. If not, stop and explain which commits would become unreferenced.
8. Remove the registered worktree with `git worktree remove <absolute-path>`.
9. Delete the exact local branch with the safe deletion mode. Never force-delete unless the user explicitly authorizes it after seeing the unmerged-commit warning.
10. Run `git worktree list` and branch inspection again to verify both targets are gone.
11. Report:
    - The removed worktree path.
    - The deleted branch.
    - Whether untracked or unmerged work was encountered.
    - Whether remote merge freshness was verified.

If worktree removal succeeds but branch deletion fails, report the partial result precisely and leave the branch intact.
