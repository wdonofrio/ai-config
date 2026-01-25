---
name: planning-workflow
description: Create structured, language-agnostic implementation plans with risks, tests, and approvals. Use when the user asks for a plan or design before coding, especially for large new features or brand new projects where SDLC phases should be explicit.
metadata:
  short-description: Planning workflow
---

# Planning Workflow

Use this for design and planning requests. Keep plans concise, ordered, and aligned with repo context.

## Steps

1. Clarify goals, constraints, and success criteria. Ask for missing details.
2. Skim relevant repo docs and code to ground assumptions.
3. Propose an ordered plan with concrete steps and impacted areas.
4. For large new features or new projects, structure the plan around SDLC phases (requirements, design, implementation, testing, deployment, maintenance).
5. Call out risks, alternatives, and decisions needed from the user.
6. Include a test/verification plan and note any docs to update.
7. Ask for approval before implementation.

## Reminders

- Stay language-agnostic unless the repo dictates otherwise.
- Use SDLC phases explicitly for large new features or brand new projects.
- In the test plan, include running any tests you write or change.
- Use `/rules/*.md` checklists for security, testing, and git hygiene.
