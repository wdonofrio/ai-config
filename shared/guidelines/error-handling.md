# Error Handling Guidelines (Language-Agnostic)

## Core Principles

- **Errors are not exceptional**: Expect and handle errors as part of normal control flow.
- **Fail fast**: Detect and report errors as early as possible.
- **Fail loudly**: Make errors visible. Silent failures are debugging nightmares.
- **Fail gracefully**: Provide meaningful feedback and recover when possible.

## Error Categories

### Expected Errors

Errors that are part of normal operation:
- User input validation failures
- Resource not found
- Permission denied
- Network timeouts

**Handle these explicitly** with appropriate user feedback.

### Unexpected Errors

Errors that indicate bugs or system failures:
- Null pointer exceptions
- Out of memory
- Assertion failures
- Database connection lost

**Log these, alert if needed, and fail safely.**

## Error Handling Patterns

### Validate Early, Handle Once

```
# Bad: Checking throughout the code
function process(data)
  if data is null → handle error
  do_something(data)
  if data.field is invalid → handle error
  do_more(data)

# Good: Validate at the boundary
function process(data)
  validated = validate(data)  # All checks here, fails fast
  do_something(validated)
  do_more(validated)
```

### Use Appropriate Error Types

- **Return values**: For expected, recoverable errors (e.g., `Result<T, E>`, `Option<T>`)
- **Exceptions/panics**: For unexpected errors that should propagate
- **Error codes**: When crossing language/system boundaries

### Avoid Silent Failures

```
# Bad
try:
  risky_operation()
except:
  pass  # Silent failure

# Good
try:
  risky_operation()
except SpecificError as e:
  log.warning(f"Operation failed: {e}, using fallback")
  use_fallback()
```

### Don't Catch Too Broadly

```
# Bad: Catches everything, hides bugs
try:
  complex_operation()
except Exception:
  return default_value

# Good: Catch specific, expected errors
try:
  complex_operation()
except NetworkTimeout:
  return cached_value
except ValidationError as e:
  raise UserError(f"Invalid input: {e}")
```

## Error Messages

### For Users

- **Be helpful**: Explain what happened and what they can do
- **Be specific**: "Email format is invalid" not "Validation error"
- **Be actionable**: "Please enter a valid email address"
- **Don't expose internals**: No stack traces, SQL errors, or file paths

### For Developers (Logs)

- **Include context**: What operation? What input? What state?
- **Include identifiers**: Request ID, user ID, transaction ID
- **Include timing**: When did it happen?
- **Be structured**: Use structured logging for searchability

## Error Propagation

### Add Context When Re-throwing

```
# Bad: Loses context
try:
  parse_config(file)
except ParseError:
  raise ConfigError("Config error")

# Good: Preserves and adds context
try:
  parse_config(file)
except ParseError as e:
  raise ConfigError(f"Failed to parse config file {file}") from e
```

### Don't Swallow and Re-throw Generic

```
# Bad
try:
  operation()
except Exception as e:
  raise Exception("Something went wrong")  # Lost all context

# Good: Let it propagate or add meaningful context
operation()  # Let exceptions propagate naturally
# or
try:
  operation()
except SpecificError as e:
  raise OperationFailed(f"Context: {details}") from e
```

## Cleanup and Resources

### Always Clean Up

Use language-appropriate patterns:
- `try/finally`
- `with` statements / RAII
- `defer` statements

```
# Ensure cleanup happens regardless of errors
resource = acquire_resource()
try:
  use_resource(resource)
finally:
  release_resource(resource)
```

### Partial Failure Handling

When an operation has multiple steps:
- **Atomic**: All succeed or all fail (use transactions)
- **Idempotent**: Safe to retry without side effects
- **Compensating**: Undo completed steps on failure

## Testing Error Handling

- **Test error paths**: Don't just test the happy path
- **Test error messages**: Verify they're helpful and don't leak info
- **Test cleanup**: Verify resources are released on error
- **Test recovery**: Verify the system can recover from errors
