# Testing Guidelines (Language-Agnostic)

## Test Pyramid

- **Unit tests**: Fast, isolated tests for individual functions and classes. These should be the majority.
- **Integration tests**: Test interactions between components, databases, APIs. Slower but catch interface issues.
- **End-to-end tests**: Test complete user flows. Slowest but verify the system works as a whole.

## Writing Good Tests

### Structure

- **Arrange-Act-Assert**: Set up preconditions, perform the action, verify the result.
- **One assertion per concept**: Each test should verify one behavior. Multiple assertions are fine if they test the same thing.
- **Descriptive test names**: Name should describe the scenario and expected outcome.

### Test Quality

- **Test behavior, not implementation**: Tests should pass if the behavior is correct, regardless of how it's implemented.
- **Deterministic tests**: No flaky tests. Mock time, randomness, and external dependencies.
- **Fast tests**: Unit tests should run in milliseconds. Slow tests get skipped.
- **Independent tests**: Tests should not depend on execution order or shared state.

### Test Data

- **Use meaningful test data**: Values should be obvious in purpose (e.g., `"valid@email.com"` vs `"test123"`).
- **Use factories or builders**: Don't repeat complex object construction across tests.
- **Clean up after tests**: Reset databases, clear caches, remove temp files.

## What to Test

### Always Test

- **Happy path**: The main success scenario works correctly.
- **Edge cases**: Empty inputs, boundary values, maximum sizes.
- **Error handling**: Invalid inputs produce appropriate errors.
- **Security-sensitive code**: Authentication, authorization, input validation.

### Consider Testing

- **Race conditions**: Concurrent access to shared resources.
- **Failure modes**: Network timeouts, disk full, service unavailable.
- **Performance characteristics**: Response times, memory usage (for critical paths).

### Avoid Testing

- **Third-party code**: Trust libraries to test themselves. Test your integration with them.
- **Trivial code**: Getters, setters, simple delegators usually don't need tests.
- **Implementation details**: Don't test private methods directly.

## Test Coverage

- **Coverage is a guide, not a goal**: 100% coverage doesn't mean bug-free. Focus on meaningful coverage.
- **Cover critical paths first**: Authentication, payment processing, data validation.
- **New code should have tests**: Don't add to technical debt.

## Mocking and Stubbing

- **Mock external dependencies**: APIs, databases, file systems, time.
- **Don't over-mock**: If you mock too much, you're not testing anything real.
- **Prefer fakes over mocks**: In-memory implementations are often clearer than mock expectations.

## Running Tests

- **Run tests before committing**: At minimum, run tests related to your changes.
- **Run full suite in CI**: Ensure all tests pass before merging.
- **Fix broken tests immediately**: A failing test suite is useless.

## When Tests Are Not Run

If you cannot run tests, explicitly state:
- Why tests weren't run (missing dependencies, environment issues, etc.)
- What manual verification was done instead
- What command should be run to verify the change
