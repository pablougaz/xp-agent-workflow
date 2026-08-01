---
name: start-worktree
description: Use this skill when the user wants to create, start, or prepare an isolated Git worktree for a feature, fix, experiment, or parallel task. Resolve repository conventions, defer to a matching repository-specific worktree workflow when available, otherwise choose a safe sibling path and new branch, install dependencies using detected tooling, and copy only explicitly approved local configuration. Do not use for ordinary branch creation or container environments.
---

# Start an Isolated Worktree

Create a worktree through supervised Git and filesystem operations. Inspect first, mutate second, and verify the result.

## Procedure

1. Resolve the main repository root with `git rev-parse --show-toplevel` and inspect `git worktree list --porcelain`.
2. Normalize the requested task identifier for paths and branch names. Preserve an explicit user-supplied branch or path.
3. Discover repo-local conventions from `AGENTS.md`, contributor documentation, existing worktrees, and branch names.
4. Inspect the available skills and repository guidance for a more-specific worktree workflow matching the current repository or workspace. If found, invoke it and stop this generic workflow before creating anything.
5. Choose defaults only when the repository supplies none:
   - Place the worktree in a sibling directory named `<repo>-<task>`.
   - Name the branch `worktree/<task>`.
   - Base it on the current `HEAD`.
6. Before creating anything, verify that the target path does not exist and the branch is not already checked out. If either exists, report the exact collision and stop unless the user has clearly requested reuse.
7. Create the worktree with Git using the resolved absolute path and branch. Do not construct a destructive command from an unresolved variable.
8. Discover setup commands from the repository:
   - Prefer explicit local documentation or scripts.
   - Otherwise infer the package manager from lockfiles (`npm ci`, `pnpm install --frozen-lockfile`, `yarn install --immutable`, and equivalents).
   - Do not assume the repository is a Node project.
9. Run the detected non-destructive setup. If setup fails, preserve the created worktree, report the failure, and give the exact recovery or retry step.
10. Treat secrets and environment files as sensitive:
   - Copy only files explicitly named by repo-local instructions or requested by the user.
   - Never print their contents.
   - Preserve file permissions where practical.
11. Verify the worktree path, checked-out branch, and concise Git status.
12. Report the full path, branch, base revision, setup result, and the cleanup skill name (`$clean-worktree`).

Do not overwrite an existing directory, reuse a checked-out branch, or silently copy broad `.env*` globs.
