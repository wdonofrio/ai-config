---
name: code-review
description: Perform language-agnostic code reviews focusing on correctness, regressions, security, and tests. Use when the user asks for a review.
metadata:
  short-description: Code review workflow
---

# Code Review Workflow

Focus on defects, regressions, and risks first. Be specific and evidence-based.

## Steps

1. Identify behavioral changes and critical paths.
2. Surface bugs, edge cases, and security risks by severity.
3. Check tests: coverage of new behavior, missing cases, flaky risks.
4. Note performance or reliability concerns only if meaningful.
5. Ask targeted questions for unclear intent or requirements.

## Output Expectations

- Cite file paths and line references when possible.
- Separate findings from questions.
- Suggest follow-up tests if gaps exist.

## Reminders

- Use `/rules/security.md` and `/rules/testing.md` for checklists.
- Flag missing test runs when tests are added or changed.
