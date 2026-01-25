# Git Workflow Checklist

Before pushing:
- Review full diff against base branch.
- Summarize changes and list tests run or omitted.
- Run tests you write or change.
- Use Conventional Commits format: `type(scope)!: subject`.
- Common types: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `ci`, `build`, `perf`, `revert`.

For larger changes:
- Plan first; break work into reviewable steps.
- Prefer small, focused commits over one large commit.
