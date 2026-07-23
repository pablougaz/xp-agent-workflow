---
name: remind-me
description: Use this skill when the user wants to resume repository work, recall where a coding session stopped, understand recent progress, or choose the next planned task. Inspect Git history, branch and working-tree state, and the repository's active planning folders. Do not use for calendar reminders, notifications, or general repository summaries unrelated to resuming work.
---

# Resume Repository Work

Ground the summary in the current repository instead of relying on conversational memory.

## Procedure

1. Resolve the repository root with Git. If the current directory is not in a Git repository, explain that repository history is unavailable and inspect only planning context that is explicitly in scope.
2. Read the current branch, concise working-tree status, and the last 20 commits. Do not mutate the repository.
3. Discover the repository's planning convention from local guidance and existing folders. Prefer `pensieve/`; also recognize aliases such as `plans/`, `plan/`, or `docs/`.
4. If a priority-folder convention exists, inspect the contents and relevant plan/status files in the active and next queues. Common names are `0-Now` and `1-Next`; do not require them.
5. Correlate commits, branch names, uncommitted changes, and plan statuses. Clearly label uncertainty when evidence is incomplete or conflicting.
6. Return a succinct summary:
   - **Last session**: recent work supported by commits and branch context.
   - **Current state**: uncommitted, staged, or in-progress work.
   - **Up next**: the next planned work supported by planning files.
   - **Suggested next step**: one concrete recommendation.

Mention the exact evidence used without dumping raw command output. Never claim a plan item is current solely because its folder name suggests priority; inspect its status content when available.
