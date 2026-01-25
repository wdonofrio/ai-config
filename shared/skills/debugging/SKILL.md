---
name: debugging
description: Systematic debugging workflow for tracking down and fixing bugs. Use when the user reports a bug, error, or unexpected behavior.
metadata:
  short-description: Debugging workflow
---

# Debugging Workflow

A systematic approach to finding and fixing bugs. Resist the urge to guess—gather evidence first.

## Debugging Process

### Step 1: Reproduce the Problem

Before debugging, ensure you can reproduce the issue:

- **Get exact steps**: What actions trigger the bug?
- **Get environment details**: OS, versions, configuration
- **Get error output**: Full error messages, stack traces, logs
- **Identify scope**: Does it always happen or only sometimes?

If you can't reproduce it, you can't verify the fix.

### Step 2: Understand Expected vs Actual

Clearly define:
- **Expected behavior**: What should happen?
- **Actual behavior**: What is happening?
- **The gap**: What's the specific difference?

### Step 3: Gather Evidence

Collect information before forming hypotheses:

**Read error messages carefully**
- Full stack traces, not just the first line
- Error codes and error types
- Timestamps and context

**Check logs**
- Application logs
- System logs
- Recent changes in version control

**Inspect state**
- Variable values at failure point
- Database state
- Request/response data
- Configuration values

### Step 4: Form Hypotheses

Based on evidence, list possible causes:

1. Most likely cause (based on evidence)
2. Second most likely
3. Other possibilities

For each hypothesis, identify:
- How to test it
- What evidence would confirm or refute it

### Step 5: Test Hypotheses Systematically

**Binary search the problem space**
- Narrow down: which component? which function? which line?
- Eliminate possibilities methodically

**Change one thing at a time**
- Don't change multiple variables at once
- Revert changes that don't help

**Use debugging tools**
- Debuggers for stepping through code
- Print/log statements for state inspection
- Profilers for performance issues
- Network inspectors for API issues

### Step 6: Fix the Root Cause

Once found:
- **Fix the root cause, not the symptom**
- **Understand why the bug existed**: Missing validation? Race condition? Wrong assumption?
- **Check for similar bugs**: Are there other places with the same pattern?

### Step 7: Verify the Fix

- **Reproduce the original issue**: Confirm it's gone
- **Run existing tests**: Ensure no regressions
- **Add a test**: Prevent recurrence
- **Test edge cases**: Does the fix handle related scenarios?

### Step 8: Document and Clean Up

- Remove debugging code (print statements, etc.)
- Write a clear commit message explaining the fix
- Update documentation if behavior changed
- Consider if this bug category needs prevention

## Common Bug Categories

### Logic Errors
- Off-by-one errors
- Wrong operator (< vs <=, && vs ||)
- Incorrect condition ordering
- Missing or wrong return statements

### State Issues
- Race conditions
- Stale cached data
- Uninitialized variables
- Mutation of shared state

### Integration Issues
- API contract mismatches
- Encoding/format differences
- Timeout and retry issues
- Authentication/authorization

### Environment Issues
- Missing dependencies
- Configuration differences
- File paths and permissions
- Resource limits

## Debugging Techniques

### Rubber Duck Debugging
Explain the problem out loud, step by step. Often you'll spot the issue while explaining.

### Binary Search
If a bug appeared recently, use git bisect to find the breaking commit.

### Minimal Reproduction
Strip away everything unrelated until you have the smallest case that still shows the bug.

### Reading Before Writing
Read the code carefully before adding debug output. Often the bug is visible in the code.

## When You're Stuck

- Take a break—fresh eyes help
- Explain the problem to someone else
- Question your assumptions
- Check the obvious things you "know" are correct
- Look at recent changes in version control

## Reminders

- Don't guess—gather evidence
- One change at a time
- Keep notes on what you've tried
- Reference `shared/guidelines/error-handling.md` for patterns
