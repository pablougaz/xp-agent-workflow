# ai-workflows

Personal APM package for portable base skills and reusable XP-style planning
and implementation workflows across agent harnesses.

This package contains shared, repo-agnostic agent context and skills:

- Session resumption with `remind-me`
- Safe Git worktree creation and cleanup
- XP/TDD development discipline
- Pensieve feature planning conventions
- Feature brainstorming, planning, status update, and plan review skills

Keep repo-specific commands, architecture, ports, services, and test names in each repo's own `AGENTS.md` or equivalent harness file.

## What Is Pensieve?

`pensieve/` is the workspace memory folder for agent-assisted development. The name comes from the Harry Potter memory storage/retrieval device: it is where the agent and human keep feature plans, brainstorm notes, story breakdowns, work status, and durable progress context between sessions.

Many repos might call this folder `plans/`, `docs/`, or `work/`. This workflow uses `pensieve/` because it is descriptive for agent memory and unlikely to collide with an existing project directory.

## Install Into A Repo

After this package is published to GitHub, consume it from a project `apm.yml`:

```yaml
dependencies:
  apm:
    - pablougaz/ai-workflows#v0.3.0
```

Then run:

```bash
apm install
```

Skills install to APM's shared `.agents/skills/` location by default. Instruction files are staged for compilation; run this when you want APM to merge them into the harness context file:

```bash
apm compile --target codex
```

The packaged skills are namespaced with an `xp-` prefix so they can run alongside older hand-copied prompts:

```text
/xp-brainstorm-feature
/xp-plan-feature
/xp-review-feature-plan
/xp-update-feature-status
```

The base skills are intentionally not XP-prefixed:

```text
/remind-me
/start-worktree
/clean-worktree
```

## Install Globally

Install the package once at user scope and deploy its skills to the shared
agent-skills location:

```bash
apm install pablougaz/ai-workflows#v0.3.0 --global --target agent-skills
```

This makes the skills available from `~/.agents/skills/` to harnesses that
support the shared Agent Skills convention. Use APM to update the installation
rather than copying files between Claude, Codex, Cursor, or other harness
directories.

See [docs/workflow-usage.md](docs/workflow-usage.md) for the workflow diagram and Trada pilot guidance.

For local testing before publishing, run from this package:

```bash
apm pack --dry-run --verbose
apm audit --ci --no-policy
```
