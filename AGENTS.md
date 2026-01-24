Codex Working Rules (Language-Agnostic)

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
- Checklists: use relevant guidance in `/rules/*.md` (security, testing, git, coding style).

PLANNING
- Restate goals, constraints, and assumptions.
- Propose a concrete, ordered plan with key steps and affected areas.
- Call out risks, alternatives, and any needed user decisions.
- Ask for approval before implementation.

IMPLEMENTATION
- Confirm the approved plan and relevant context.
- Make minimal, focused edits aligned with the plan.
- Run or suggest tests; report results or gaps.
- Summarize changes and recommend any follow-ups.

DEBUGGING
- Gather error details and reproduction steps.
- Form a hypothesis, verify with evidence, then fix.
- Validate with tests or reproduction; report outcome.
- Document any new findings or guardrails.
