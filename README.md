# xp-agent-workflow

Reusable agent workflow package for XP-style planning and implementation.

This package contains shared, repo-agnostic agent context:

- XP/TDD development discipline
- Pensieve feature planning conventions
- Feature brainstorming, planning, status update, and plan review skills

Keep repo-specific commands, architecture, ports, services, and test names in each repo's own `AGENTS.md` or equivalent harness file.

## Install Into A Repo

After this package is published to GitHub, consume it from a project `apm.yml`:

```yaml
dependencies:
  apm:
    - pabloper/xp-agent-workflow#v0.1.0
```

Then run:

```bash
apm install
```

Skills install to APM's shared `.agents/skills/` location by default. Instruction files are staged for compilation; run this when you want APM to merge them into the harness context file:

```bash
apm compile --target codex
```

For local testing before publishing, run from this package:

```bash
apm pack --dry-run --verbose
apm audit --ci --no-policy
```
