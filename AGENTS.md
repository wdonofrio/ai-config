AI Assistant Working Rules (Language-Agnostic)

Purpose
- Provide consistent, minimal guidance for planning, implementation, and debugging across any language or stack.

Focus Selection
- Determine focus from the latest request: PLANNING, IMPLEMENTATION, or DEBUGGING.
- If the request is ambiguous, ask which focus is intended before proceeding.

Core Principles
- Clarity first: ask for missing requirements or constraints.
- Context first: read relevant repo files before proposing changes.
- Safety: avoid destructive commands unless explicitly approved.
- Quality: prefer simple, maintainable changes; validate assumptions.
- Testing: suggest or run relevant tests when feasible.
- Checklists: use relevant guidance in `shared/guidelines/` (security, testing, git, coding style, api-design).
- Secrets: never add or commit credentials, tokens, or sensitive data in this public repo.

Available Skills
Use these workflows from `shared/skills/` when the situation matches:
- `commit` — When committing changes. Follows Conventional Commits.
- `code-review` — When reviewing code or PRs. Prioritizes correctness, security, regressions.
- `debugging` — When investigating bugs. Systematic evidence-gathering before fixes.
- `planning-workflow` — When designing before coding. Structured plans with risks and approvals.
- `tdd-workflow` — When writing new features or fixing bugs where tests are expected.
- `refactoring` — When improving code structure without changing behavior.
- `update-docs` — When documentation needs updating after code changes.
- `skill-lookup` — When searching for or installing additional skills.

Available Guidelines
Reference these from `shared/guidelines/` as checklists during work:
- `security.md` — Input validation, injection prevention, auth, data protection.
- `testing.md` — Test pyramid, what to test, mocking strategy.
- `coding-style.md` — Readability, data flow, code organization.
- `error-handling.md` — Error categories, patterns, messages, propagation.
- `git-workflow.md` — Conventional Commits, branching, PR process.
- `performance.md` — When and how to optimize, measurement.
- `api-design.md` — API contracts, versioning, error responses.

PLANNING
- Restate goals, constraints, and assumptions.
- Propose a concrete, ordered plan with key steps and affected areas.
- Call out risks, alternatives, and any needed user decisions.
- Reference `planning-workflow` skill for structured plans.
- Ask for approval before implementation.

IMPLEMENTATION
- Confirm the approved plan and relevant context.
- Make minimal, focused edits aligned with the plan.
- Run `security.md` and `coding-style.md` checklists against changes.
- Run or suggest tests; report results or gaps.
- Use `commit` skill when committing. Use `tdd-workflow` skill when tests are expected.
- Summarize changes and recommend any follow-ups.

DEBUGGING
- Gather error details and reproduction steps.
- Follow the `debugging` skill process: reproduce, hypothesize, test, fix.
- Validate with tests or reproduction; report outcome.
- Document any new findings or guardrails.
