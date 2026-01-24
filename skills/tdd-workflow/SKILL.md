---
name: tdd-workflow
description: Apply a language-agnostic test-driven development workflow. Use for new features or bug fixes where tests are expected.
metadata:
  short-description: TDD workflow
---

# Test-Driven Development Workflow

Use when implementing new behavior or fixing bugs with tests.

## Steps

1. Confirm the test framework and test location. Ask if unclear.
2. Write a failing test for the smallest behavior change (RED).
3. Implement the minimal change to pass (GREEN).
4. Refactor for clarity and resilience (IMPROVE).
5. Run or suggest the exact test command and any related suites.

## Reminders

- Keep tests deterministic and focused on behavior.
- Run tests you write or change. If not run, explain why and suggest verification.
- Use `/rules/testing.md` for checklist items.
