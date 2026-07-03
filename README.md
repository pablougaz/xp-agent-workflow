# xp-agent-workflow

Reusable agent workflow package for XP-style planning and implementation.

This package contains shared, repo-agnostic agent context:

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
    - pablougaz/xp-agent-workflow#v0.2.0
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

For local testing before publishing, run from this package:

```bash
apm pack --dry-run --verbose
apm audit --ci --no-policy
```
