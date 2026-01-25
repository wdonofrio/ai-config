# Coding Style Guidelines (Language-Agnostic)

## Readability First

- **Small, focused functions**: Each function should do one thing well. If you need to scroll to read it, it's too long.
- **Avoid deep nesting**: Prefer early returns and guard clauses over nested conditionals.
- **Descriptive names**: Variables, functions, and classes should reveal intent. Avoid abbreviations unless universally understood.
- **Consistent formatting**: Follow the project's existing style. When in doubt, match surrounding code.

## Data Flow

- **Prefer pure functions**: Functions that take inputs and return outputs without side effects are easier to test and reason about.
- **Explicit over implicit**: Pass dependencies explicitly rather than relying on global state or hidden context.
- **Immutability when practical**: Avoid mutating data unless performance requires it. Make mutations obvious when needed.

## Error Handling

- **Handle errors intentionally**: Never silently swallow errors. Either handle them, propagate them, or log and fail clearly.
- **Fail fast**: Validate inputs early. Return or throw immediately when preconditions aren't met.
- **Meaningful error messages**: Include context about what failed and why. Avoid generic messages.

## Code Organization

- **Group related code**: Keep related functions and types together. Separate concerns into modules.
- **Minimize dependencies**: Each module should have a clear, minimal interface. Avoid circular dependencies.
- **Delete dead code**: Remove unused functions, variables, and imports. Don't comment out code "for later."

## Comments and Documentation

- **Code should be self-documenting**: If you need a comment to explain what code does, consider rewriting the code.
- **Comments explain why, not what**: Document non-obvious decisions, workarounds, and business rules.
- **Keep comments current**: Outdated comments are worse than no comments.

## Before Committing

- Remove debug logging and temporary code.
- Verify no hardcoded values that should be configurable.
- Check for any TODO/FIXME comments that should be addressed.
